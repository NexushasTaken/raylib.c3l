RAYLIB_SRC := "./thirdparty/raylib/src"
RAYGUI := "TRUE"

build_raylib:
  make -C {{RAYLIB_SRC}} RAYLIB_MODULE_RAYGUI={{RAYGUI}} all
  mkdir -p ./libs/linux-x64 && cp -v {{RAYLIB_SRC}}/libraylib.a ./libs/linux-x64/libraylib.a

run_example MODULE TARGET:
	c3c build {{TARGET}} && ./examples/{{MODULE}}/{{TARGET}}

dist:
  zip -r dist/raylib.c3l manifest.json src c-src libs

debug_example MODULE TARGET:
	c3c build {{TARGET}} && gdb ./examples/{{MODULE}}/{{TARGET}}
