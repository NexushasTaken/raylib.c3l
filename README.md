# raylib.c3l

raylib.c3l is a set of C3 bindings for [raylib](http://www.raylib.com/) 5.5, with optional [rlgl](https://github.com/raysan5/raylib/blob/master/src/rlgl.h) and [raygui](https://github.com/raysan5/raygui) 4.0 bindings.

C libraries are easy to call from C3 directly, but these bindings also try to use C3 features where they make raylib nicer to use:
- **Methods and aliases**: functions that act on a type are C3 methods, and each one also has a plain alias, so `image.loadColors()` and `rl::loadImageColors(image)` both work.
- **Slices** replace pointer + length pairs, e.g. `rl::setWindowIcons(Image[] images)` or `rl::loadRandomSequence()` returning an `int[]`.
- **Optionals** replace some error returns (still in progress), e.g. `rl::loadFileText()` returns `ZString?`.
- **Mode macros** like `rl::@drawing()`, `rl::@mode2D(camera)` and `rl::@shaderMode(shader)` call the matching `end*()` function for you when the block ends.
- **Vector helpers** convert between raylib vectors and C3's builtin vectors: `float[<2>].to_rl()` and `Vector2.to_vecf()` (see [helpers.c3](./src/rl/helpers.c3)).
- **Features** keep optional parts (rlgl, raygui) out of your build unless you enable them.

Function docs are the same comments as raylib's C headers, so the [raylib cheatsheet](https://www.raylib.com/cheatsheet/cheatsheet.html) and the C examples carry over. Names are camelCase: `InitWindow` becomes `rl::initWindow`, `rlPushMatrix` becomes `rlgl::pushMatrix`, and `GuiButton` becomes `raygui::button`.

**Disclaimer: I created this binding to learn C3 more in depth, and took some inspiration from the [official raylib bindings](https://github.com/c3lang/vendor). Some things in this binding can still be improved, so feel free to make suggestions!**

## Requirements

- C3 compiler 0.8.5
- raylib 5.5 and raygui 4.0 (prebuilt static libraries are bundled in [libs](./libs/), so you don't need to build them)

## Supported Platforms

Bundled libraries exist for these targets. Only Linux has been tested with the current version.

| Target        | Bundled library    | Tested             |
| ------------- | ------------------ | ------------------ |
| linux-x64     | :heavy_check_mark: | :heavy_check_mark: |
| windows-x64   | :heavy_check_mark: |                    |
| mingw-x64     | :heavy_check_mark: |                    |
| macos-x64     | :heavy_check_mark: |                    |
| macos-aarch64 | :heavy_check_mark: |                    |
| freebsd-x64   | :heavy_check_mark: |                    |
| wasm32        | :heavy_check_mark: |                    |

## Modules

| Module   | Contents                                                        | Feature          |
| -------- | --------------------------------------------------------------- | ---------------- |
| `rl`     | raylib: core, shapes, textures, text, models, audio and raymath | always available |
| `rlgl`   | rlgl, raylib's OpenGL abstraction layer                          | `ENABLE_RLGL`    |
| `raygui` | raygui immediate-mode GUI controls                               | `ENABLE_RAYGUI`  |

raygui icons can be turned off with `RAYGUI_NO_ICONS`, or replaced with your own using `RAYGUI_CUSTOM_ICONS`.

# Installation

Download `raylib.c3l` from the [releases page](https://github.com/NexushasTaken/raylib.c3l/releases) and copy it into your project's `lib` folder.

Add this to your `project.json`, and uncomment the features you want to use:

```json
"dependencies": [ "raylib" ],
"features": [
	//"ENABLE_RLGL",
	//"ENABLE_RAYGUI",
	//"RAYGUI_NO_ICONS",
	//"RAYGUI_CUSTOM_ICONS",
],
```

Use this code as your template:
```c3
import rl;

fn int main(String[] args)
{
	rl::initWindow(800, 450, "Raylib in C3!");

	while (!rl::windowShouldClose())
	{
		rl::@drawing() {
			rl::clearBackground(rl::RAYWHITE);
			rl::drawText("Raylib in C3!", 190, 200, 20, rl::LIGHTGRAY);
		};
	}

	rl::closeWindow();
	return 0;
}
```

# Examples

The [examples](./examples/) folder has ports of raylib and raygui examples. Run one with [just](https://github.com/casey/just), passing the folder and the target name from [project.json](./project.json):

```sh
just run_example core core_2d_camera
just run_example controls_test_suite controls_test_suite
```

or build it directly with `c3c build core_2d_camera`.

# Development

- `c3c test` runs the unit tests in [test/unit](./test/unit/).
- `just fetch_libs` downloads the prebuilt libraries from the [raylib 5.5 release](https://github.com/raysan5/raylib/releases/tag/5.5) into [libs](./libs/) (pass target names to fetch only some, e.g. `just fetch_libs linux-x64`). freebsd-x64 has no official release, so its library is kept as is.
- `just build_raylib` builds the linux-x64 `libraylib.a` from `thirdparty/raylib` instead, if you want a custom build.
- `just dist` packages the library into `dist/raylib.c3l`.

See the [changelog](./changelog.md) for changes between versions.

# Future goals
- Testing on more platforms.
- Port every raylib example to C3.
- Use C3 allocators to handle raylib allocations? (for easier resource management, seems impossible)
- Add a physac port.
- Let users configure and compile raylib and raygui themselves?
