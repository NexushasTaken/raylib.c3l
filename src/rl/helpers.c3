module rl;

//----------------------------------------------------------------------------------
// Additional Raylib.c3 Mode helper macros
//----------------------------------------------------------------------------------

<*
 Setup canvas (framebuffer) to start drawing, then calls [block].
 Drawing will end after [block] has finished.
*>
macro void @drawing(;@body)
{
  beginDrawing();
  defer endDrawing();
  @body();
}

<*
 Setup 2D mode with custom camera to start 2D Mode, then calls [block].
 Mode2D will end after [block] has finished.
*>
macro void @mode2D(Camera2D camera ;@body)
{
  beginMode2D(camera);
  defer endMode2D();
  @body();
}

<*
 Setup 3D mode with custom camera to start 2D Mode, then calls [block].
 Mode2D will end after [block] has finished.
*>
macro void @mode3D(Camera3D camera ;@body)
{
  beginMode3D(camera);
  defer endMode3D();
  @body();
}

<*
 Setup texture mode to draw to render texture, then calls [block].
 texture mode will end after [block] has finished.
*>
macro void @textureMode(RenderTexture2D texture ;@body)
{
  beginTextureMode(texture);
  defer endTextureMode();
  @body();
}


<*
 Setup custom shqder mode then calls [block].
 shader mode will end after [block] has finished.
*>
macro void @shaderMode(Shader shader ;@body)
{
  beginShaderMode(shader);
  defer endShaderMode();
  @body();
}

<*
 Setup blending mode, then calls [block].
 blend mode will end after [block] has finished.
*>
macro void @blendMode(BlendMode mode ;@body)
{
  beginShaderMode(mode);
  defer endShaderMode();
  @body();
}

<*
 Setup scissor mode then calls [block].
 scissor mode will end after [block] has finished.
*>
macro void @scissorMode(int x, int y, int width, int height ;@body)
{
  beginScissorMode(x, y, width, height);
  defer endScissorMode();
  @body();
}

<*
 Setup stereo rendering mode, then calls [block].
 stereo rendering mode will end after [block] has finished.
*>
macro void @vrMode(VrStereoConfig config ;@body)
{
  beginVrStereoMode(config);
  defer endVrStereoMode();
  @body();
}

import std::math::vector;
// TODO: find a better way to convert math::vector types to raylib Vector types and vice versa? and think a better name...
// Vector convertion functions

macro Vector2 float[<2>].to_rl(&self) => { self.x, self.y };
macro Vector3 float[<3>].to_rl(&self) => { self.x, self.y, self.z };
macro Vector4 float[<4>].to_rl(&self) => { self.x, self.y, self.z, self.w };

macro float[<2>] Vector2.to_vecf(&self) => { self.x, self.y };
macro float[<3>] Vector3.to_vecf(&self) => { self.x, self.y, self.z };
macro float[<4>] Vector4.to_vecf(&self) => { self.x, self.y, self.z, self.w };
