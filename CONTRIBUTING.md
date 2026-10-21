# Contributing

This file explains how the project is put together and how to change it. It is written for contributors, and as a refresher for the maintainer after time away from the project.

## Setup

You need:
- [C3](https://c3-lang.org/) 0.8.5 (`c3c`)
- [just](https://github.com/casey/just)
- `curl`, `tar`, `unzip` and `sha256sum` (or `shasum` on macOS), used by `just fetch_libs`
- `make` and a C compiler, only if you build raylib yourself (`just build_raylib`)

```sh
git clone https://github.com/NexushasTaken/raylib.c3l
cd raylib.c3l
git submodule update --init    # thirdparty/raylib (6.2) and thirdparty/raygui (5.0)
c3c test                       # should pass
just run_example core core_2d_camera
```

`project.json` sets `"dependency-search-paths": [ ".." ]` and depends on `raylib`, so examples and tests load this repo as a library, the same way a user's project would.

## How the project is laid out

```
manifest.json     what C3 reads when the library is used: sources, c-sources, linked libraries per target
src/rl/           module rl: raylib (rcore, rshapes, rtextures, text, rmodels, raudio, rcamera)
src/math/         module rl too: rmath.c3, bindings to raymath
src/gl/           module rlgl, behind the ENABLE_RLGL feature
src/gui/          module raygui, behind the ENABLE_RAYGUI feature
c-src/            C files shipped in the package: raylib.h and raygui.h (copied from thirdparty), raygui.c
libs/<target>/    prebuilt raylib static libraries, one folder per C3 target
thirdparty/       git submodules: raylib 6.2 and raygui 5.0 sources (not shipped)
scripts/          fetch_libs.sh
examples/         C3 ports of raylib/raygui examples, each one a target in project.json
test/unit/        unit tests, run with `c3c test`
```

Where each piece comes from at link time:

| Piece  | Comes from                                                                                                    |
| ------ | ------------------------------------------------------------------------------------------------------------- |
| raylib | `libs/<target>/libraylib.a` (`raylib.lib` on windows-x64), the official release build                       |
| raymath | the same library. `rcore.c` defines `RAYMATH_IMPLEMENTATION`, so every raylib build exports all raymath functions |
| rlgl   | the same library                                                                                              |
| raygui | `c-src/raygui.c`, compiled by c3c when the user builds. It is **not** inside `libraylib.a`, so it must never be added there (it would be linked twice) |

## Code conventions

### Naming

C names become camelCase without the library prefix:

| C                | C3                    |
| ---------------- | --------------------- |
| `InitWindow`     | `rl::initWindow`      |
| `Vector3Add`     | `rl::vector3Add`      |
| `rlPushMatrix`   | `rlgl::pushMatrix`    |
| `GuiButton`      | `raygui::button`      |
| `RL_TRIANGLES`   | `rlgl::TRIANGLES`     |

Three older names break this rule: `vector2_min`, `vector2_max` and `quaternionFromvector3ToVector3`. Renaming them is a breaking change, so do it only with a "Breaking Changes" entry in the changelog.

### Docs

Every function's doc is the comment raylib's C header has for it, word for word:
- in `raylib.h`, `rlgl.h` and `raygui.h`, the comment after the declaration
- in `raymath.h` and `rcamera.h`, the comment block above the definition

Use C3 doc comments (`<* ... *>`), not `/** */`. Contracts like `@require` go inside the same block, after the text. If C has no comment, write a short one in the same style.

```c3
<*
 Generate trefoil knot mesh
*>
extern fn Mesh genMeshKnot(float radius, float size, int radSegs, int sides) @cname("GenMeshKnot");
```

### Binding a function

**1. Plain binding.** Use this when the C signature is fine as it is:

```c3
extern fn void initWindow(int width, int height, ZString title) @cname("InitWindow");
```

**2. Wrapped binding.** Use this when C3 can do better: a pointer + length becomes a slice, an error return becomes an optional, and so on. Declare the raw C function as a private extern named `__snake_case`, then write the public wrapper next to the other functions:

```c3
// src/rl/raylib.c3i
extern fn void __set_window_icons(Image* images, int count) @cname("SetWindowIcons") @private;

// src/rl/rcore.c3
<*
 Set icon for window (multiple images, RGBA 32bit)
*>
fn void setWindowIcons(Image[] images) @inline {
    __set_window_icons(images.ptr, (int)images.len);
}
```

Private externs for `rl` and `raygui` all live in `src/rl/raylib.c3i`, grouped by the C file they come from. rlgl has no wrappers yet: `src/gl/rlgl.c3i` is an interface file, where `fn ... @cname(...);` with no body is already an extern. Tests can still call them with `import rl @public;`.

**3. Methods.** A function whose first parameter is a raylib type becomes a method, with an alias that keeps the C-style name:

```c3
fn Color[] Image.loadColors(Image image) @inline { ... }
alias loadImageColors = Image.loadColors;
```

**4. Mode macros.** Each `Begin*`/`End*` pair also gets a macro in `src/rl/helpers.c3` that runs a body and calls `end*()` with `defer`, for example `@drawing`, `@mode2D` and `@shaderMode`.

### ABI rules (where bugs hide)

The C3 side must match the C side exactly. The compiler can't check this, so a mistake shows up as a crash or garbage values at runtime.

- **Structs** must have the same fields, order and types as raylib 6.2. If raylib changes a struct, compare it against `c-src/raylib.h` or `rlgl.h`.
- **C `bool` vs `int`:** when C returns `int` but means a boolean (raymath's `*Equals`, most raygui controls), bind it as `int` in a private extern and wrap it, for example `fn bool floatEquals(...) => __float_equals(...) != 0;`. Binding it straight as `bool` can break on wasm.
- **`float16` (raymath's `MatrixToFloatV`)** is a struct holding `float[16]`. C3's `float[<16>]` is a SIMD vector, which is a different ABI. That is why `matrixToFloatV` is written in C3 instead of bound.
- **Enums and flags:** check the value type and the numbers against the C header.
- **Features:** anything for rlgl or raygui goes in modules marked `@feat(ENABLE_RLGL)` or `@feat(ENABLE_RAYGUI)`. Icon functions also use `@feat(!RAYGUI_NO_ICONS)`. Features only reach C3 code: c3c compiles a library's C sources with the manifest's `cflags` alone, so `c-src/raygui.c` is always built with the default icons. raygui 5.0 also fails to compile with `-DRAYGUI_NO_ICONS` (`GuiFontIconBaking()` is not guarded), so don't add that define to the manifest.

## Checking a change

There is no CI, so run these before committing:

```sh
# every example builds, with all features on
for t in examples_template core_2d_camera core_3d_camera_free core_3d_camera_first_person controls_test_suite; do
    c3c build $t -D ENABLE_RLGL -D ENABLE_RAYGUI || break
done

c3c test

# GUI examples: should stay open until killed. Exit code 124 means it was still running, which is good.
timeout 3 ./examples/core/core_3d_camera_free; echo $?
timeout 3 ./examples/controls_test_suite/controls_test_suite; echo $?
```

To try a binding quickly without adding an example, put a small program next to the repo and compile it against the library:

```sh
c3c compile --libdir .. --lib raylib scratch.c3 -o scratch
```

Only linux-x64 is tested. Building for other targets is useful but not proof that they work. Also, c3c compiles `c-src/raygui.c` with the host `cc`, so cross-compiling with `ENABLE_RAYGUI` will probably fail.

When you add a wrapper with real logic (slices, lengths, allocations), add a test in `test/unit/` that compares it with the raw `__` extern. See `test_data_compression.c3` for an example.

## The prebuilt libraries

`just fetch_libs` downloads the raylib release builds into `libs/`. It checks pinned sha256 hashes and skips libraries that are already up to date. `just fetch_libs linux-x64` fetches one target.

| C3 target                   | Source                                                   |
| --------------------------- | -------------------------------------------------------- |
| linux-x64                   | `raylib-6.2_linux_amd64.tar.gz`                          |
| linux-aarch64               | `raylib-6.2_linux_arm64.tar.gz`                          |
| macos-x64, macos-aarch64    | `raylib-6.2_macos.tar.gz` (one universal library for both) |
| windows-x64                 | `raylib-6.2_win64_msvc16.zip` (`raylib.lib`)             |
| windows-aarch64             | `raylib-6.2_winarm64_msvc16.zip` (`raylib.lib`)          |
| mingw-x64                   | `raylib-6.2_win64_mingw-w64.zip`                         |
| wasm32                      | `raylib-6.2_webassembly.zip` (`libraylib.web.a`, installed as `libraylib.a`) |
| freebsd-x64                 | no official release. Built by hand and committed as is (still raylib 5.5) |

Skipped release assets: `win32_*` (C3 has no 32-bit Windows target), `linux_i386` (c3c reports linux-x86 as unsupported).

### Building freebsd-x64

raylib has no FreeBSD release, so the library has to be built on FreeBSD itself (a VM works). raylib's Makefile detects FreeBSD, uses `clang`, and looks for X11 headers in `/usr/local/include`. These steps follow that Makefile but have not been tried for 6.2 yet:

```sh
pkg install git gmake xorg-libraries mesa-libs   # raylib's Makefile needs GNU make
git clone --depth 1 --branch 6.2 https://github.com/raysan5/raylib
gmake -C raylib/src PLATFORM=PLATFORM_DESKTOP RAYLIB_MODULE_RAYGUI=FALSE
```

Copy `raylib/src/libraylib.a` to `libs/freebsd-x64/` and commit it. Keep `RAYLIB_MODULE_RAYGUI=FALSE`, because raygui is compiled from `c-src/raygui.c` (see the table at the top).

`just build_raylib` builds linux-x64 from `thirdparty/raylib` instead. Use it only for a custom build. Run `just fetch_libs linux-x64` afterwards to go back to the release build.

## Updating raylib or raygui

1. Move the submodule to the new tag:
   ```sh
   git -C thirdparty/raylib fetch --depth 1 origin tag <version>
   git -C thirdparty/raylib checkout <version>
   ```
   Do the same for raygui, then update `branch` in `.gitmodules`.
2. `just sync_c_src` copies the new `raylib.h` and `raygui.h` into `c-src/`.
3. Diff the old and new headers and apply every change to the bindings: new and removed functions, changed signatures, struct layouts, enum values, and doc comments.
   ```sh
   git diff HEAD -- c-src/raylib.h
   ```
   For `rlgl.h`, `raymath.h` and `rcamera.h`, diff them between the two tags inside `thirdparty/raylib`.
4. In `scripts/fetch_libs.sh`, set `VERSION` and replace every hash. Check the library file names too: if a release renames one (6.2 ships `libraylib.web.a` for wasm), set the "installed as" column so it still lands under the name `manifest.json` links. Get the hashes by downloading each asset once and running `sha256sum` on the archive and on the library inside it. GitHub publishes no digests for these assets.
5. `just fetch_libs`, then run all the checks in [Checking a change](#checking-a-change).
6. Rebuild freebsd-x64 by hand, or write in the changelog that it is still on the old version.
7. Update the version numbers in `README.md`.

## Releasing

1. Add a section to `changelog.md`, with "Breaking Changes" listed before "Changes".
2. Package the library:
   ```sh
   rm -f dist/raylib.c3l    # zip -r adds to an existing archive, so start fresh
   just dist
   ```
3. Tag it (`git tag v1.3.0`), push the commits and the tag, and attach `dist/raylib.c3l` to a GitHub release.

## Commits

Commit messages use [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `docs:`, `build:`, `refactor:`, `chore:`, plus an optional scope like `fix(examples):`. Keep each commit to one change, and add a changelog line for anything a user would notice.
