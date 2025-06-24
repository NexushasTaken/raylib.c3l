# Binding Change Logs

## v1.1.0

### Changes
- update [manifest.json](manifest.json) remove unneeded dependencies.
- moved all binding source files to their corresponding modules([gl](./src/gl/), [gui](./src/gui/), [math](./src/math/), [rl](./src/rl/)).
- rename `load_compute_shader_program` -> `loadComputeShaderProgram`.
- fix grammar on [README](README.md).
- added [changelog](changelog.md).

## v1.2.0

### Changes
- updated bundled `libraylib.a` for macos-aarch64 from v5.0 to v5.5.
- added bundled `libraylib.a` for freebsd-x64.
- update bindings for c3 v0.7.2
