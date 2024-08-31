RAYLIB_SRC := "./thirdparty/raylib/src"
RAYGUI := "TRUE"

build_raylib:
  make -C {{RAYLIB_SRC}} RAYLIB_MODULE_RAYGUI={{RAYGUI}} all
  mkdir -p ./linux-x86 && cp -v {{RAYLIB_SRC}}/libraylib.a ./linux-x64/libraylib.a

run_example MODULE TARGET:
	c3c build {{TARGET}} && ./examples/{{MODULE}}/{{TARGET}}

debug_example MODULE TARGET:
	c3c build {{TARGET}} && gdb ./examples/{{MODULE}}/{{TARGET}}
