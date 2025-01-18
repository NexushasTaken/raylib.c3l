# raylib.c3l

raylib.c3l is a C3 bindings for [raylib](http://www.raylib.com/) 5.5.

Though, C Libraries can be easily ported to C3, this binding supposed to use the C3 features for easier usage.
- Since C3 has builtin vector support such as Vec2f, Vec3f, etc...; Vector helpers are added to convert raylib Vectors to C3 vectors and vice versa. (See [rl_vector](./helpers.c3)).
- This bindings uses `features` to disable some raylib functions such as RLGL, RAYGUI and so on...
- Some raylib functions returns an error, this bindings replaced that using Optionals (under construction).
- For function that required a array/object pointer and its length, is replaced by `Object[]`.

**Disclaimer: I created this binding to learn C3 more in depth, ive also borrow some inspiration from [official raylib bindings](https://github.com/c3lang/vendor) in order to make this binding. These are some things this binding can improved, specially the documentation. So feel free to make suggestions!**

## Supported Platforms

 | API    | Windows            | Linux              | macOS | Web | Android | Raspberry Pi |
 | ------ | ------------------ | ------------------ | ----- | --- | ------- | ------------ |
 | core   | :heavy_check_mark: | :heavy_check_mark: |       |     |         |              |
 | rgui   | :heavy_check_mark: | :heavy_check_mark: |       |     |         |              |
 | physac | :x:                | :x:                |       |     |         |              |
 | rlgl   | :heavy_check_mark: | :heavy_check_mark: |       |     |         |              |

# Installation

Download the `raylib.c3l` library from [releases page](https://github.com/NexushasTaken/raylib.c3l/releases), and copy it to your project `lib` folder.

Add this to your `project.json`; you can uncomment some features that are listed if you want to use those functions.

```json
"dependencies": [ "raylib" ],
"features": [
	//"ENABLE_RLGL",
	//"ENABLE_RAYGUI",
	//"RAYGUI_NO_ICONS",
	//"RAYGUI_CUSTOM_ICONS",
],
```

Use this code as your template.
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

For more examples see [Examples](./examples/).

# Future goals
- Better documentation and the README itself.
- Testing on different platforms
- Port every raylib examples to C3
- Use C3 allocators to handle raylib allocations? (for easier resource management, seems imposible)
- Add physac port.
- Provide user to configure and compile raylib and raygui?
