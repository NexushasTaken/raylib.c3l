#!/usr/bin/env python3
"""Check that the C3 bindings match raylib's C ABI.

The C3 side must match the C side exactly, but no compiler can check that,
so this script asks both compilers for the real numbers and compares them:

- structs: the size of every bound struct and the offset of every field
- constants: the value of every enum constant in raylib.h, rlgl.h and
  raygui.h, and of the numeric #defines in rlgl.h and raygui.h

It reads the C headers and the C3 sources, generates one C program and one
C3 program that print those numbers, compiles and runs both, and reports
every difference. It also fails on C enum constants and C structs that have
no C3 binding, unless they are listed in the allowlists below.

Usage: scripts/check_abi.py   (or: just check_abi)
Needs: python3, cc (or $CC), c3c, and the thirdparty/raylib submodule.
"""
import os
import re
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

RAYLIB_H = os.path.join(ROOT, "c-src", "raylib.h")
RAYGUI_H = os.path.join(ROOT, "c-src", "raygui.h")
RLGL_H = os.path.join(ROOT, "thirdparty", "raylib", "src", "rlgl.h")

# C3 module -> C3 source files that belong to it
C3_MODULES = {
    "rl": ["src/rl/structs.c3", "src/rl/constants.c3", "src/rl/raudio.c3", "src/math/rmath.c3"],
    "rlgl": ["src/gl/rlgl.c3i"],
    "raygui": ["src/gui/raygui.c3"],
}

# C3 struct -> C struct, where the names differ
STRUCT_NAMES = {
    ("rlgl", "VertexBuffer"): "rlVertexBuffer",
    ("rlgl", "DrawCall"): "rlDrawCall",
    ("rlgl", "RenderBatch"): "rlRenderBatch",
}

# C structs that are not bound on purpose
UNBOUND_STRUCTS = {
    "rAudioBuffer",     # opaque, only used through pointers
    "rAudioProcessor",  # opaque, only used through pointers
    "GuiTextStyle",     # declared in raygui.h but not used by its API
}

# C constant -> C3 constant, where the names differ
CONST_NAMES = {
    "PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA": "PIXELFORMAT_COMPRESSED_ASTC_4X4_RGBA",
    "PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA": "PIXELFORMAT_COMPRESSED_ASTC_8X8_RGBA",
}

# C constants that are not bound on purpose (exact names or prefixes ending in '_')
UNBOUND_CONSTS = [
    "false", "true",  # C's bool fallback enum
    # rlgl repeats these raylib enums; the bindings use the rl:: versions
    "RL_LOG_", "RL_PIXELFORMAT_", "RL_TEXTURE_FILTER_", "RL_BLEND_",
    "RL_SHADER_LOC_", "RL_SHADER_UNIFORM_", "RL_SHADER_ATTRIB_",
    # rlgl config defaults, not part of the API
    "RL_DEFAULT_", "RL_MAX_", "RL_CULL_DISTANCE_",
    # raygui config defaults, not part of the API
    "RAYGUI_",
]


def read(path):
    with open(path) as f:
        return f.read()


def strip_c_comments(text):
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
    return re.sub(r"//[^\n]*", "", text)


def header_api(path):
    """The declarations part of a single-file header (before its implementation)."""
    text = read(path)
    cut = re.search(r"#if defined\(\w+_IMPLEMENTATION\)", text)
    return text[: cut.start()] if cut else text


def snake_to_camel(name):
    head, *rest = name.split("_")
    return head + "".join(part[:1].upper() + part[1:] for part in rest)


# ---------------------------------------------------------------------------
# C side
# ---------------------------------------------------------------------------

def c_enum_constants(path):
    names = []
    text = strip_c_comments(header_api(path))
    for body in re.findall(r"typedef\s+enum\s*\w*\s*\{(.*?)\}", text, flags=re.S):
        for item in body.split(","):
            name = item.split("=")[0].strip()
            if name:
                names.append(name)
    return names


def c_numeric_defines(path, prefix):
    text = strip_c_comments(header_api(path))
    pattern = r"^\s*#define\s+(" + prefix + r"\w+)\s+(?:0x[0-9A-Fa-f]+|\d+)\s*$"
    return re.findall(pattern, text, flags=re.M)


def c_struct_names(path):
    text = strip_c_comments(header_api(path))
    return set(re.findall(r"typedef\s+struct\s+(\w+)\s*\{", text))


# ---------------------------------------------------------------------------
# C3 side
# ---------------------------------------------------------------------------

def strip_c3_comments(text):
    text = re.sub(r"<\*.*?\*>", "", text, flags=re.S)
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
    return re.sub(r"//[^\n]*", "", text)


def c3_structs(module):
    """{struct name: [field names]} for every struct in a C3 module."""
    structs = {}
    for rel in C3_MODULES[module]:
        text = strip_c3_comments(read(os.path.join(ROOT, rel)))
        for name, body in re.findall(r"\bstruct\s+(\w+)[^{;]*\{(.*?)\}", text, flags=re.S):
            fields = []
            for stmt in body.split(";"):
                stmt = re.sub(r"@\w+(\([^)]*\))?", "", stmt).strip()  # drop @feat(...) etc.
                m = re.search(r"(\w+)$", stmt)
                if m and m.group(1) not in fields:
                    fields.append(m.group(1))
            structs[name] = fields
    return structs


def c3_constants(module):
    """{name: C3 expression} for the integer constants and enum values of a C3 module."""
    consts = {}
    for rel in C3_MODULES[module]:
        text = strip_c3_comments(read(os.path.join(ROOT, rel)))
        for name in re.findall(r"^\s*const\s+(?:\w+\s+)?([A-Z]\w*)\s*=", text, flags=re.M):
            consts[name] = f"{module}::{name}"
        for enum, body in re.findall(r"\benum\s+(\w+)\s*:\s*\w+\s*\{(.*?)\}", text, flags=re.S):
            for value in re.findall(r"\b([A-Z]\w*)\b", body):
                consts[value] = f"{module}::{enum}.{value}"
    return consts


# ---------------------------------------------------------------------------
# Checks
# ---------------------------------------------------------------------------

def is_unbound_on_purpose(name):
    return any(name == u or (u.endswith("_") and name.startswith(u)) for u in UNBOUND_CONSTS)


def plan():
    """What to compare, plus the C items that have no binding."""
    problems = []

    # structs: (label, C type, C3 type, [(C field, C3 field)])
    structs = []
    bound_c_structs = set()
    for module in C3_MODULES:
        for name, fields in c3_structs(module).items():
            c_name = STRUCT_NAMES.get((module, name), name)
            bound_c_structs.add(c_name)
            pairs = [(f if module == "rlgl" else snake_to_camel(f), f) for f in fields]
            structs.append((f"{module}::{name}", c_name, f"{module}::{name}", pairs))

    c_structs = c_struct_names(RAYLIB_H) | c_struct_names(RLGL_H) | c_struct_names(RAYGUI_H)
    for name in sorted(c_structs - bound_c_structs - UNBOUND_STRUCTS):
        problems.append(f"struct {name} has no C3 binding")

    # constants: (C name, C3 expression)
    consts = []
    sources = [
        ("rl", c_enum_constants(RAYLIB_H), ""),
        ("rlgl", c_enum_constants(RLGL_H) + c_numeric_defines(RLGL_H, "RL_"), "RL_"),
        ("raygui", c_enum_constants(RAYGUI_H) + c_numeric_defines(RAYGUI_H, "SCROLLBAR_"), ""),
    ]
    for module, names, prefix in sources:
        available = c3_constants(module)
        for c_name in dict.fromkeys(names):  # keep order, drop duplicates
            if is_unbound_on_purpose(c_name):
                continue
            c3_name = CONST_NAMES.get(c_name, c_name)
            if prefix and c3_name.startswith(prefix):
                c3_name = c3_name[len(prefix):]
            if c3_name not in available:
                problems.append(f"constant {c_name} has no C3 binding in module {module}")
                continue
            consts.append((c_name, available[c3_name]))

    return structs, consts, problems


def c_program(structs, consts):
    out = [
        "#include <stdio.h>",
        "#include <stddef.h>",
        '#include "raylib.h"',
        '#include "rlgl.h"',
        '#include "raygui.h"',
        "int main(void) {",
    ]
    for label, c_type, _, pairs in structs:
        out.append(f'    printf("{label} size %zu\\n", sizeof({c_type}));')
        for c_field, c3_field in pairs:
            out.append(f'    printf("{label}.{c3_field} offset %zu\\n", offsetof({c_type}, {c_field}));')
    for c_name, _ in consts:
        out.append(f'    printf("{c_name} %lld\\n", (long long)({c_name}));')
    out += ["    return 0;", "}"]
    return "\n".join(out) + "\n"


def c3_program(structs, consts):
    out = ["import std::io;", "import rl, rlgl, raygui;", "fn void main() {"]
    for i, (label, _, c3_type, pairs) in enumerate(structs):
        out.append(f'    io::printfn("{label} size %d", {c3_type}::size);')
        if pairs:
            out.append(f"    {c3_type} s{i};")
        for _, c3_field in pairs:
            out.append(f'    io::printfn("{label}.{c3_field} offset %d", (usz)&s{i}.{c3_field} - (usz)&s{i});')
    for c_name, c3_expr in consts:
        out.append(f'    io::printfn("{c_name} %d", (long){c3_expr});')
    out.append("}")
    return "\n".join(out) + "\n"


def run(cmd, cwd):
    result = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True)
    if result.returncode != 0:
        sys.stderr.write(f"command failed: {' '.join(cmd)}\n{result.stdout}{result.stderr}")
        sys.exit(2)
    return result.stdout


def main():
    if not os.path.exists(RLGL_H):
        sys.exit("thirdparty/raylib is missing, run: git submodule update --init")

    structs, consts, problems = plan()

    with tempfile.TemporaryDirectory() as tmp:
        c_src = os.path.join(tmp, "abi.c")
        c3_src = os.path.join(tmp, "abi.c3")
        with open(c_src, "w") as f:
            f.write(c_program(structs, consts))
        with open(c3_src, "w") as f:
            f.write(c3_program(structs, consts))

        cc = os.environ.get("CC", "cc")
        run([cc, "-I", os.path.join(ROOT, "c-src"), "-I", os.path.dirname(RLGL_H),
             c_src, "-o", os.path.join(tmp, "abi_c")], tmp)
        run(["c3c", "compile", "-D", "ENABLE_RLGL", "-D", "ENABLE_RAYGUI",
             "--libdir", os.path.dirname(ROOT), "--lib", "raylib",
             c3_src, "-o", os.path.join(tmp, "abi_c3")], tmp)

        c_lines = run([os.path.join(tmp, "abi_c")], tmp).splitlines()
        c3_lines = run([os.path.join(tmp, "abi_c3")], tmp).splitlines()

    for c_line, c3_line in zip(c_lines, c3_lines):
        if c_line != c3_line:
            key = c_line.rsplit(" ", 1)[0]
            problems.append(f"{key}: C has {c_line.rsplit(' ', 1)[1]}, C3 has {c3_line.rsplit(' ', 1)[1]}")
    if len(c_lines) != len(c3_lines):
        problems.append(f"C printed {len(c_lines)} lines but C3 printed {len(c3_lines)}")

    fields = sum(len(pairs) for _, _, _, pairs in structs)
    print(f"checked {len(structs)} structs, {fields} fields and {len(consts)} constants")
    if problems:
        print(f"\n{len(problems)} problem(s):")
        for p in problems:
            print(f"  {p}")
        sys.exit(1)
    print("ABI matches")


if __name__ == "__main__":
    main()
