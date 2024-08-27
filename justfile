RAYLIB_SRC := "./thirdparty/raylib/src"

build_raylib:
  make -C {{RAYLIB_SRC}} all
  cp -v {{RAYLIB_SRC}}/libraylib.a ./linux-x64/
