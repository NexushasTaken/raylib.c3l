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
- updated to raylib 6.2. Changes that follow raylib's own API changes:
  - `changeDirectory` returns `int` (0 on success) instead of `bool`.
  - `drawCircleGradient` takes a `Vector2 center`. `Image.drawRectangleLines` takes `pos_x, pos_y, width, height` (the old form is now `Image.drawRectangleLinesEx`). `Image.colorContrast` takes an `int`.
  - `loadFontData` takes an extra `int* glyph_count`. `Model.updateAnimation` takes a `float` frame.
  - `drawCapsule`/`drawCapsuleWires` parameter order is now `rings, slices`.
  - renamed `getSplinePointBezierQuad` -> `getSplinePointBezierQuadratic`, `Image.drawTriangleEx` -> `Image.drawTriangleGradient`, `Image.draw` -> `Image.drawImagePro` (now also takes `origin` and `rotation`).
  - removed `drawModelPoints`, `drawModelPointsEx`, `Model.updateAnimationBones` and `ModelAnimation.unload` (use `unloadModelAnimations`).
  - `Mesh`, `Model` and `ModelAnimation` changed layout: bones moved into the new `ModelSkeleton` (`Model.skeleton`), `ModelAnimation.frame_count`/`frame_poses` are now `keyframe_count`/`keyframe_poses`, `Mesh.bone_ids` is now `bone_indices`, and `Mesh.bone_matrices` moved to `Model.bone_matrices`. `FilePathList` has no `capacity` field anymore.
  - `SHADER_UNIFORM_SAMPLER2D` is now 12, and `SHADER_LOC_BONE_MATRICES` is replaced by `SHADER_LOC_MATRIX_BONETRANSFORMS`.
  - rlgl: `loadShaderProgram` now takes the shader code strings (it replaces `loadShaderCode`), the old id version is `loadShaderProgramEx`, `compileShader` -> `loadShader`, `loadComputeShaderProgram` -> `loadShaderProgramCompute`.
- linux-x64 now also links `X11`.
- updated to raygui 5.0. Changes that follow raygui's own API changes:
  - `tabBar` now takes the tabs as one `;`-separated string plus an `int* hscroll`. The old slice version is `tabBarEx`, which also takes `hscroll` and `focus`.
  - `messageBox` takes an extra `int* btn_active` (the pressed button is written there). `textInputBox` parameters are now `(bounds, title, message, text, btn_text, btn_active, secret_view_active)`.
  - control `SPINNER` (11) is replaced by `TABBAR`. `GuiSpinnerProperty`/`SPIN_BUTTON_WIDTH`/`SPIN_BUTTON_SPACING` are now `GuiValueBoxProperty`/`SPINNER_BUTTON_WIDTH`/`SPINNER_BUTTON_SPACING`.
  - icons `ICON_220` to `ICON_255` got real names (e.g. `ICON_WARNING`), and `ICON_FILETYPE_ICON` (256) was added.
- `SaveFileDataCallback` takes `int data_size` (was `uint`) and `LoadFileDataCallback` returns `char*` (was `ZString`), matching the C typedefs.
- rename `isWaveReady`/`Wave.isReady` -> `isWaveValid`/`Wave.isValid` and `isSoundReady`/`Sound.isReady` -> `isSoundValid`/`Sound.isValid` (raylib v5.5 removed `IsWaveReady`/`IsSoundReady`).
- removed `rmath::Quaternionf`, use `math::Quaternionf` instead.
- `rlgl::loadTextureCubemap` now takes `mipmapCount`, `rlgl::loadFramebuffer` takes no arguments, and the last parameter of `rlgl::setVertexAttribute` is now `int offset`, matching raylib v5.5.
- rename `rlgl::disable_color_blend` -> `rlgl::disableColorBlend`.
- bundled libraries moved into [libs](./libs/).

### Changes
- added raylib 6.2 bindings: file functions (`fileRename`, `fileRemove`, `fileCopy`, `fileMove`, `fileTextReplace`, `fileTextFindIndex`, `isFileHidden`, `isPathDirectory`, `isPathAbsolute`, `getDirectoryFileCount`, `getDirectoryFileCountEx`), `computeSHA256`, `getKeyName`, new shapes (`drawLineDashed`, `drawTriangleGradient`, `drawTriangleLinesEx`, `drawCircleSectorLinesEx`, `drawCircleLinesEx`, `drawEllipseV`, `drawEllipseLinesV`, `drawEllipseLinesEx`, `drawRingLinesEx`), new image drawing (`Image.drawLineStrip`, `Image.drawRectanglePro`, `Image.drawRectangleLinesEx`, `Image.drawRectangleGradientEx`, `Image.drawCircleGradient`, `Image.drawImage`, `Image.drawImageEx`, `Image.drawImageRec`, `Image.drawTextPro`), `loadRenderTextureEx`, text functions (`measureTextCodepoints`, `loadTextLines`, `unloadTextLines`, `textRemoveSpaces`, `getTextBetween`, `textReplaceAlloc`, `textReplaceBetween`, `textReplaceBetweenAlloc`, `textInsertAlloc`), `Model.updateAnimationEx`, `vector2CrossProduct`, `matrixMultiplyValue`, `matrixCompose`, `SHADER_UNIFORM_UINT`/`UIVEC2`/`UIVEC3`/`UIVEC4`, `SHADER_LOC_VERTEX_INSTANCETRANSFORM`, and rlgl `disablePointMode`, `setPointSize`, `getPointSize`, `getProcAddress`, `copyFramebuffer`, `resizeFramebuffer`, `unloadShader` and `OPENGL_SOFTWARE`.
- added raygui 5.0 bindings: `loadStyleFromMemory`, `loadIconsFromMemory`, `getTextWidth`, `valueBoxFloat`, `GuiResult`, `GuiTabBarProperty` and the new style properties (`BASEPROP16`, `EXTPROP08`, `GROUP_WIDTH_FULL`, `PROGRESS_SIDE`, `DROPDOWN_ARROW_HIDDEN`, `DROPDOWN_ROLL_UP`, `LIST_ITEMS_BORDER_NORMAL`, `LIST_ITEMS_BORDER_WIDTH`).
- doc comments updated to the raylib 6.2 and raygui 5.0 headers.
- `encodeDataBase64` still returns the string without the NULL terminator (raylib 6.2 now counts it in the output size).
- bundled libraries are the raylib 6.2 release builds. freebsd-x64 is still raylib 5.5.
- added linux-aarch64 and windows-aarch64 targets, using the raylib 6.2 release builds (not tested).
- update bindings for c3 v0.8.5 (`@extern` -> `@cname`, `@if`/`$feature` -> `@feat`).
- fix `rlgl::VertexBuffer` and `rlgl::DrawCall` layouts to match raylib v5.5.
- fix `@blendMode` calling `beginShaderMode`/`endShaderMode` instead of `beginBlendMode`/`endBlendMode`.
- added the remaining rcamera bindings: `Camera.yaw`, `Camera.pitch`, `Camera.roll`, `Camera.moveForward`, `Camera.moveUp`, `Camera.moveRight`, `Camera.moveToTarget`, `Camera.getForward`, `Camera.getUp`, `Camera.getRight`, `Camera.getViewMatrix` and `Camera.getProjectionMatrix` (each with a `camera*`/`getCamera*` alias).
- `rmath` functions are now bindings to raylib's own raymath functions instead of a C3 copy of them. The API is unchanged, except `clamp` now matches raylib when `min > max`.
- added rlgl v5.5 bindings: `setClipPlanes`, `getCullDistanceNear`, `getCullDistanceFar`, `getActiveFramebuffer`, `bindFramebuffer`, `colorMask` and `setUniformMatrices`.
- added freebsd-x64 target to [manifest.json](manifest.json).
- added mingw-x64 target to [manifest.json](manifest.json).
- bundled libraries for linux-x64, macos-x64, macos-aarch64, windows-x64, mingw-x64 and wasm32 are now the official raylib release builds, fetched with `just fetch_libs`.
- `just dist` now includes `c-src`.
- updated examples to the current API.
- unit tests now use `@test`, run them with `c3c test`.
