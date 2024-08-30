# raylib.c3l

raylib.c3l is a C3 bindings for [raylib](http://www.raylib.com/) 5.0.

Though, C Libraries can be easily ported to C3, this binding supposed to use the C3 features for easier usage.
- Since C3 has builtin vector support such as Vec2f, Vec3f, etc...; Vector helpers are added to convert raylib Vectors to C3 vectors and vice versa. (See [rl_vector](./rl_vector.c3)).
- This bindings uses `features` to disable some raylib functions such as Memory Management, Standard File IO and so on, are disabled by default because C3 already has its functions(see #Installation).
- Some raylib functions returns an error, this bindings replaced that using Optionals (under construction).
- For function that required a array/object pointer and its length, is replaced by `List(<Object>)` or `Object[]` depending on function usage.

**Disclaimer: I created this binding to learn C3 more in depth, ive also borrow some inspiration from [official raylib bindings](https://github.com/c3lang/vendor) in order to make this binding. These are some things this binding can improved, specially the documentation. So feel free to make suggestions!**

## Supported Platforms

 | API    | Windows | Linux              | macOS | Web | Android | Raspberry Pi |
 | ------ | ------- | ------------------ | ----- | --- | ------- | ------------ |
 | core   |         | :heavy_check_mark: |       |     |         |              |
 | rgui   |         | :heavy_check_mark: |       |     |         |              |
 | physac |         | :x:                |       |     |         |              |
 | rlgl   |         | :x:                |       |     |         |              |

I only have linux running on my pc, so i can't test it on other OS.
You can however compile raylib from source yourself(with raygui enabled) and copy the compiled library to target folder in parent directory of this binding.

# Installation

In your project parent directory, run this command:
```sh
git clone --recurse-submodules https://github.com/NexushasTaken/raylib.c3l ./libs/raylib.c3l
```

Add this to your `project.json`, you can uncomment some features that are listed if you want to use those functions.
```json
"dependencies": [ "raylib" ],
"features": [
  // See rcore.c3
  //"SUPPORT_INTERNAL_MEMORY_MANAGEMENT",
  //"SUPPORT_STANDARD_FILEIO",
  //"SUPPORT_FILE_SYSTEM_FUNCTIONS",
  //"SUPPORT_DATA_ENCODER",
  // See text.c3
  //"SUPPORT_TEXT_CODEPOINTS_MANAGEMENT",
  //"SUPPORT_TEXT_C_STRING_MANAGEMENT",
  //"SUPPORT_RANDOM_GENERATION",

  "SUPPORT_RAYGUI",
  //"RAYGUI_NO_ICONS",
  //"RAYGUI_CUSTOM_ICONS",
],
```

## Linux
You can use `just` package to automatically build raylib and copy to its specific folder.
- [Archlinux](https://www.archlinux.org/)
  ```
  sudo pacman -S just
  ```
- [Debian derivatives](https://en.wikipedia.org/wiki/APT_(software))
  ```
  sudo apt install just
  ```
- [Microsoft Windows (scoop)](https://scoop.sh/)
  ```
  scoop install just
  ```
- [macOS](https://www.macports.org/)
  ```
  port install just
  ```

After you installed `just` package, enter these commands
```
cd libs/raylib.c3l && just build_raylib
```

# Future goals
- Better documentation and the README itself.
- Testing on different platforms
- Port every raylib examples to C3
- Use C3 allocators to handle raylib allocations? (for easier resource management)
- Add physac port?
- Add rlgl port?
- Provide user to configure and compile raylib?
