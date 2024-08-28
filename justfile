RAYLIB_SRC := "./thirdparty/raylib/src"

build_raylib:
  make -C {{RAYLIB_SRC}} all
  cp -v {{RAYLIB_SRC}}/libraylib.a ./linux-x64/

run_example MODULE TARGET:
	c3c build {{TARGET}} && ./examples/{{MODULE}}/{{TARGET}}

debug_example MODULE TARGET:
	c3c build {{TARGET}} && gdb ./examples/{{MODULE}}/{{TARGET}}
