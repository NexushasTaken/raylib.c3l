module rl;

//----------------------------------------------------------------------------------
// Additional Raylib.c3 Mode helper macros
//----------------------------------------------------------------------------------

<*
 Setup canvas (framebuffer) to start drawing, then runs the body.
 Calls endDrawing() after the body has finished.
*>
macro void @drawing(;@body)
{
  beginDrawing();
  defer endDrawing();
  @body();
}

<*
 Begin 2D mode with custom camera (2D), then runs the body.
 Calls endMode2D() after the body has finished.
*>
macro void @mode2D(Camera2D camera ;@body)
{
  beginMode2D(camera);
  defer endMode2D();
  @body();
}

<*
 Begin 3D mode with custom camera (3D), then runs the body.
 Calls endMode3D() after the body has finished.
*>
macro void @mode3D(Camera3D camera ;@body)
{
  beginMode3D(camera);
  defer endMode3D();
  @body();
}

<*
 Begin drawing to render texture, then runs the body.
 Calls endTextureMode() after the body has finished.
*>
macro void @textureMode(RenderTexture2D texture ;@body)
{
  beginTextureMode(texture);
  defer endTextureMode();
  @body();
}

<*
 Begin custom shader drawing, then runs the body.
 Calls endShaderMode() after the body has finished.
*>
macro void @shaderMode(Shader shader ;@body)
{
  beginShaderMode(shader);
  defer endShaderMode();
  @body();
}

<*
 Begin blending mode (alpha, additive, multiplied, subtract, custom), then runs the body.
 Calls endBlendMode() after the body has finished.
*>
macro void @blendMode(BlendMode mode ;@body)
{
  beginBlendMode(mode);
  defer endBlendMode();
  @body();
}

<*
 Begin scissor mode (define screen area for following drawing), then runs the body.
 Calls endScissorMode() after the body has finished.
*>
macro void @scissorMode(int x, int y, int width, int height ;@body)
{
  beginScissorMode(x, y, width, height);
  defer endScissorMode();
  @body();
}

<*
 Begin stereo rendering (requires VR simulator), then runs the body.
 Calls endVrStereoMode() after the body has finished.
*>
macro void @vrMode(VrStereoConfig config ;@body)
{
  beginVrStereoMode(config);
  defer endVrStereoMode();
  @body();
}

import std::math::vector;
// TODO: find a better way to convert math::vector types to raylib Vector types and vice versa? and think a better name...
// Vector conversion functions

<*
 Convert a C3 float[<2>] vector to a raylib Vector2
*>
macro Vector2 float[<2>].to_rl(&self) => { self.x, self.y };

<*
 Convert a C3 float[<3>] vector to a raylib Vector3
*>
macro Vector3 float[<3>].to_rl(&self) => { self.x, self.y, self.z };

<*
 Convert a C3 float[<4>] vector to a raylib Vector4
*>
macro Vector4 float[<4>].to_rl(&self) => { self.x, self.y, self.z, self.w };

<*
 Convert a raylib Vector2 to a C3 float[<2>] vector
*>
macro float[<2>] Vector2.to_vecf(&self) => { self.x, self.y };

<*
 Convert a raylib Vector3 to a C3 float[<3>] vector
*>
macro float[<3>] Vector3.to_vecf(&self) => { self.x, self.y, self.z };

<*
 Convert a raylib Vector4 to a C3 float[<4>] vector
*>
macro float[<4>] Vector4.to_vecf(&self) => { self.x, self.y, self.z, self.w };
