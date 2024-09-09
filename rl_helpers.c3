module rl;

//----------------------------------------------------------------------------------
// Additional Raylib.c3 Mode helper macros
// ref: https://github.com/c3lang/vendor/blob/main/libraries/raylib5.c3l/raylib.c3i#L1823
//----------------------------------------------------------------------------------

/**
 * Setup canvas (framebuffer) to start drawing, then calls [block].
 * Drawing will end after [block] has finished.
 */
macro void @drawing(; @body) {
  begin_drawing();
  defer end_drawing();
  @body();
}

/**
 * Setup 2D mode with custom camera to start 2D Mode, then calls [block].
 * Mode2D will end after [block] has finished.
 */
macro void @mode2d(Camera2D camera; @body) {
  begin_mode2d(camera);
  defer end_mode2d();
  @body();
}

/**
 * Setup 3D mode with custom camera to start 2D Mode, then calls [block].
 * Mode2D will end after [block] has finished.
 */
macro void @mode3d(Camera3D camera; @body) {
  begin_mode3d(camera);
  defer end_mode3d();
  @body();
}

/**
 * Setup texture mode to draw to render texture, then calls [block].
 * texture mode will end after [block] has finished.
 */
macro void @textureMode(RenderTexture2D texture; @body) {
  begin_texture_mode(texture);
  defer end_texture_mode();
  @body();
}


/**
 * Setup custom shqder mode then calls [block].
 * shader mode will end after [block] has finished.
 */
macro void @shaderMode(Shader shader; @body) {
  begin_shader_mode(shader);
  defer end_shader_mode();
  @body();
}

/**
 * Setup blending mode, then calls [block].
 * blend mode will end after [block] has finished.
 */
macro void @blendMode(BlendMode mode; @body) {
  begin_shader_mode(mode);
  defer end_shader_mode();
  @body();
}

/**
 * Setup scissor mode then calls [block].
 * scissor mode will end after [block] has finished.
 */
macro void @scissorMode(int x, int y, int width, int height;@body) {
  begin_scissor_mode(x, y, width, height);
  defer end_scissor_mode();
  @body();
}

/**
 * Setup stereo rendering mode, then calls [block].
 * stereo rendering mode will end after [block] has finished.
 */
macro void @vrMode(VrStereoConfig config ;@body) {
  begin_vr_stereo_mode(config);
  defer end_vr_stereo_mode();
  @body();
}

