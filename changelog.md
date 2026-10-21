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

## v1.3.0

### Breaking Changes
- rename `isWaveReady`/`Wave.isReady` -> `isWaveValid`/`Wave.isValid` and `isSoundReady`/`Sound.isReady` -> `isSoundValid`/`Sound.isValid` (raylib v5.5 removed `IsWaveReady`/`IsSoundReady`).
- removed `rmath::Quaternionf`, use `math::Quaternionf` instead.
- `rlgl::loadTextureCubemap` now takes `mipmapCount`, `rlgl::loadFramebuffer` takes no arguments, and the last parameter of `rlgl::setVertexAttribute` is now `int offset`, matching raylib v5.5.
- bundled libraries moved into [libs](./libs/).

### Changes
- update bindings for c3 v0.8.5 (`@extern` -> `@cname`, `@if`/`$feature` -> `@feat`).
- fix `rlgl::VertexBuffer` and `rlgl::DrawCall` layouts to match raylib v5.5.
- fix `@blendMode` calling `beginShaderMode`/`endShaderMode` instead of `beginBlendMode`/`endBlendMode`.
- added the remaining rcamera bindings: `Camera.yaw`, `Camera.pitch`, `Camera.roll`, `Camera.moveForward`, `Camera.moveUp`, `Camera.moveRight`, `Camera.moveToTarget`, `Camera.getForward`, `Camera.getUp`, `Camera.getRight`, `Camera.getViewMatrix` and `Camera.getProjectionMatrix` (each with a `camera*`/`getCamera*` alias).
- added rlgl v5.5 bindings: `setClipPlanes`, `getCullDistanceNear`, `getCullDistanceFar`, `getActiveFramebuffer`, `bindFramebuffer`, `colorMask` and `setUniformMatrices`.
- added freebsd-x64 target to [manifest.json](manifest.json).
- `just dist` now includes `c-src`.
- updated examples to the current API.
- unit tests now use `@test`, run them with `c3c test`.
