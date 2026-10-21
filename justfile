RAYLIB_SRC := "./thirdparty/raylib/src"
RAYGUI_SRC := "./thirdparty/raygui/src"
RAYGUI := "FALSE"

# Copy the C headers from thirdparty into c-src, which is what gets packaged
sync_c_src:
  cp -v {{RAYLIB_SRC}}/raylib.h {{RAYGUI_SRC}}/raygui.h ./c-src/

build_raylib: sync_c_src
  make -C {{RAYLIB_SRC}} clean
  make -C {{RAYLIB_SRC}} RAYLIB_MODULE_RAYGUI={{RAYGUI}} all
  mkdir -p ./libs/linux-x64 && cp -v {{RAYLIB_SRC}}/libraylib.a ./libs/linux-x64/libraylib.a

run_example MODULE TARGET:
	c3c build {{TARGET}} && ./examples/{{MODULE}}/{{TARGET}}

dist: sync_c_src
  zip -r dist/raylib.c3l manifest.json src c-src libs

debug_example MODULE TARGET:
	c3c build {{TARGET}} && gdb ./examples/{{MODULE}}/{{TARGET}}
