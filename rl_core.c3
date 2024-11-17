module rl;
import std::io;

//------------------------------------------------------------------------------------
// Window and Graphics Device Functions (Module: core)
//------------------------------------------------------------------------------------

/*

Index of this module:
// Window-related functions
// Cursor-related functions
// Drawing-related functions
// VR stereo config functions for VR simulator
// Shader management functions
// Screen-space-related functions
// Timing-related functions
// Custom frame control functions
// Misc. functions
// Compression/Encoding functionality
// Automation events functionality
// Additional Raylib.c3 Mode helper macros

*/

// Window-related functions
//------------------------------------------------------------------------------------

<*
 Initialize window and OpenGL context
*>
extern fn void initWindow(int width, int height, ZString title) @extern("InitWindow");

<*
 Close window and unload OpenGL context
*>
extern fn void closeWindow() @extern("CloseWindow");

<*
 Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
*>
extern fn bool windowShouldClose() @extern("WindowShouldClose");

<*
 Check if window has been initialized successfully
*>
extern fn bool isWindowReady() @extern("IsWindowReady");

<*
 Check if window is currently fullscreen
*>
extern fn bool isWindowFullscreen() @extern("IsWindowFullscreen");

<*
 Check if window is currently hidden (only PLATFORM_DESKTOP)
*>
extern fn bool isWindowHidden() @extern("IsWindowHidden");

<*
 Check if window is currently minimized (only PLATFORM_DESKTOP)
*>
extern fn bool isWindowMinimized() @extern("IsWindowMinimized");

<*
 Check if window is currently maximized (only PLATFORM_DESKTOP)
*>
extern fn bool isWindowMaximized() @extern("IsWindowMaximized");

<*
 Check if window is currently focused (only PLATFORM_DESKTOP)
*>
extern fn bool isWindowFocused() @extern("IsWindowFocused");

<*
 Check if window has been resized last frame
*>
extern fn bool isWindowResized() @extern("IsWindowResized");

<*
 Check if one specific window flag is enabled
*>
extern fn bool isWindowState(ConfigFlags flag) @extern("IsWindowState");

<*
 Set window configuration state using flags (only PLATFORM_DESKTOP)
*>
extern fn void setWindowState(ConfigFlags flags) @extern("SetWindowState");

<*
 Clear window configuration state flags
*>
extern fn void clearWindowState(ConfigFlags flags) @extern("ClearWindowState");

<*
 Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
*>
extern fn void toggleFullscreen() @extern("ToggleFullscreen");

<*
 Toggle window state: borderless windowed (only PLATFORM_DESKTOP)
*>
extern fn void toggleBorderlessWindowed() @extern("ToggleBorderlessWindowed");

<*
 Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
*>
extern fn void maximizeWindow() @extern("MaximizeWindow");

<*
 Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
*>
extern fn void minimizeWindow() @extern("MinimizeWindow");

<*
 Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
*>
extern fn void restoreWindow() @extern("RestoreWindow");

<*
 Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
*>
extern fn void setWindowIcon(Image image) @extern("SetWindowIcon");

<*
 Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
 @require images.len <= int.max
*>
fn void setWindowIcons(Image[] images) @inline {
    __set_window_icons(images.ptr, (int)images.len);
}

<*
 Set title for window (only PLATFORM_DESKTOP and PLATFORM_WEB)
*>
extern fn void setWindowTitle(ZString title) @extern("SetWindowTitle");

<*
 Set window position on screen (only PLATFORM_DESKTOP)
*>
extern fn void setWindowPosition(int x, int y) @extern("SetWindowPosition");

<*
 Set monitor for the current window
*>
extern fn void setWindowMonitor(int monitor) @extern("SetWindowMonitor");

<*
 Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
*>
extern fn void setWindowMinSize(int width, int height) @extern("SetWindowMinSize");

<*
 Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
*>
extern fn void setWindowMaxSize(int width, int height) @extern("SetWindowMaxSize");

<*
 Set window dimensions
*>
extern fn void setWindowSize(int width, int height) @extern("SetWindowSize");

<*
 Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
*>
extern fn void setWindowOpacity(float opacity) @extern("SetWindowOpacity");

<*
 Set window focused (only PLATFORM_DESKTOP)
*>
extern fn void setWindowFocused() @extern("SetWindowFocused");

<*
 Get native window handle
*>
extern fn void* getWindowHandle() @extern("GetWindowHandle");

<*
 Get current screen width
*>
extern fn int getScreenWidth() @extern("GetScreenWidth");

<*
 Get current screen height
*>
extern fn int getScreenHeight() @extern("GetScreenHeight");

<*
 Get current render width (it considers HiDPI)
*>
extern fn int getRenderWidth() @extern("GetRenderWidth");

<*
 Get current render height (it considers HiDPI)
*>
extern fn int getRenderHeight() @extern("GetRenderHeight");

<*
 Get number of connected monitors
*>
extern fn int getMonitorCount() @extern("GetMonitorCount");

<*
 Get current connected monitor
*>
extern fn int getCurrentMonitor() @extern("GetCurrentMonitor");

<*
 Get specified monitor position
*>
extern fn Vector2 getMonitorPosition(int monitor) @extern("GetMonitorPosition");

<*
 Get specified monitor width (current video mode used by monitor)
*>
extern fn int getMonitorWidth(int monitor) @extern("GetMonitorWidth");

<*
 Get specified monitor height (current video mode used by monitor)
*>
extern fn int getMonitorHeight(int monitor) @extern("GetMonitorHeight");

<*
 Get specified monitor physical width in millimetres
*>
extern fn int getMonitorPhysicalWidth(int monitor) @extern("GetMonitorPhysicalWidth");

<*
 Get specified monitor physical height in millimetres
*>
extern fn int getMonitorPhysicalHeight(int monitor) @extern("GetMonitorPhysicalHeight");

<*
 Get specified monitor refresh rate
*>
extern fn int getMonitorRefreshRate(int monitor) @extern("GetMonitorRefreshRate");

<*
 Get window position XY on monitor
*>
extern fn Vector2 getWindowPosition() @extern("GetWindowPosition");

<*
 Get window scale DPI factor
*>
extern fn Vector2 getWindowScaleDpi() @extern("GetWindowScaleDPI");

<*
 Get the human-readable, UTF-8 encoded name of the specified monitor
*>
extern fn ZString getMonitorName(int monitor) @extern("GetMonitorName");

<*
 Set clipboard text content
*>
extern fn void setClipboardText(ZString text) @extern("SetClipboardText");

<*
 Get clipboard text content
*>
extern fn ZString getClipboardText() @extern("GetClipboardText");

<*
 Enable waiting for events on EndDrawing(), no automatic event polling
*>
extern fn void enableEventWaiting() @extern("EnableEventWaiting");

<*
 Disable waiting for events on EndDrawing(), automatic events polling
*>
extern fn void disableEventWaiting() @extern("DisableEventWaiting");

// Cursor-related functions
//------------------------------------------------------------------------------------

<*
 Shows cursor
*>
extern fn void showCursor() @extern("ShowCursor");

<*
 Hides cursor
*>
extern fn void hideCursor() @extern("HideCursor");

<*
 Check if cursor is not visible
*>
extern fn bool isCursorHidden() @extern("IsCursorHidden");

<*
 Enables cursor (unlock cursor)
*>
extern fn void enableCursor() @extern("EnableCursor");

<*
 Disables cursor (lock cursor)
*>
extern fn void disableCursor() @extern("DisableCursor");

<*
 Check if cursor is on the screen
*>
extern fn bool isCursorOnScreen() @extern("IsCursorOnScreen");

// Drawing-related functions
//------------------------------------------------------------------------------------

<*
 Set background color (framebuffer clear color)
*>
extern fn void clearBackground(Color color) @extern("ClearBackground");

<*
 Setup canvas (framebuffer) to start drawing
*>
extern fn void beginDrawing() @extern("BeginDrawing");

<*
 End canvas drawing and swap buffers (double buffering)
*>
extern fn void endDrawing() @extern("EndDrawing");

<*
 Begin 2D mode with custom camera (2D)
*>
extern fn void beginMode2D(Camera2D camera) @extern("BeginMode2D");

<*
 Ends 2D mode with custom camera
*>
extern fn void endMode2D() @extern("EndMode2D");

<*
 Begin 3D mode with custom camera (3D)
*>
extern fn void beginMode3D(Camera3D camera) @extern("BeginMode3D");

<*
 Ends 3D mode and returns to default 2D orthographic mode
*>
extern fn void endMode3D() @extern("EndMode3D");

<*
 Begin drawing to render texture
*>
extern fn void beginTextureMode(RenderTexture2D target) @extern("BeginTextureMode");

<*
 Ends drawing to render texture
*>
extern fn void endTextureMode() @extern("EndTextureMode");

<*
 Begin custom shader drawing
*>
extern fn void beginShaderMode(Shader shader) @extern("BeginShaderMode");

<*
 End custom shader drawing (use default shader)
*>
extern fn void endShaderMode() @extern("EndShaderMode");

<*
 Begin blending mode (alpha, additive, multiplied, subtract, custom)
*>
extern fn void beginBlendMode(BlendMode mode) @extern("BeginBlendMode");

<*
 End blending mode (reset to default: alpha blending)
*>
extern fn void endBlendMode() @extern("EndBlendMode");

<*
 Begin scissor mode (define screen area for following drawing)
*>
extern fn void beginScissorMode(int x, int y, int width, int height) @extern("BeginScissorMode");

<*
 End scissor mode
*>
extern fn void endScissorMode() @extern("EndScissorMode");

<*
 Begin stereo rendering (requires VR simulator)
*>
extern fn void beginVrStereoMode(VrStereoConfig config) @extern("BeginVrStereoMode");

<*
 End stereo rendering (requires VR simulator)
*>
extern fn void endVrStereoMode() @extern("EndVrStereoMode");

// VR stereo config functions for VR simulator
//------------------------------------------------------------------------------------

<*
 Load VR stereo config for VR simulator device parameters
*>
extern fn VrStereoConfig loadVrStereoConfig(VrDeviceInfo device) @extern("LoadVrStereoConfig");

<*
 Unload VR stereo config
*>
extern fn void unloadVrStereoConfig(VrStereoConfig config) @extern("UnloadVrStereoConfig");

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
//------------------------------------------------------------------------------------

<*
 Load shader from files and bind default locations
*>
extern fn Shader loadShader(ZString vs_file_name, ZString fs_file_name) @extern("LoadShader");

<*
 Load shader from code strings and bind default locations
*>
extern fn Shader loadShaderFromMemory(ZString vs_code, ZString fs_code) @extern("LoadShaderFromMemory");

<*
 Check if a shader is ready
*>
extern fn bool isShaderReady(Shader shader) @extern("IsShaderReady");

<*
 Get shader uniform location
*>
fn int! getShaderLocation(Shader shader, ZString uniform_name) @inline {
    int loc = __get_shader_location(shader, uniform_name);
    return loc == -1 ? SearchResult.MISSING? : loc;
}

<*
 Get shader attribute location
*>
fn int! getShaderLocationAttrib(Shader shader, ZString attrib_name) @inline {
    int loc = __get_shader_location_attrib(shader, attrib_name);
    return loc == -1 ? SearchResult.MISSING? : loc;
}

<*
 Set shader uniform value
*>
extern fn void setShaderValue(Shader shader, int loc_index, void* value, ShaderUniformDataType uniform_type) @extern("SetShaderValue");

<*
 Set shader uniform value vector
*>
extern fn void setShaderValueV(Shader shader, int locIndex, void* value, ShaderUniformDataType uniform_type, int count) @extern("SetShaderValueV");

<*
 Set shader uniform value (matrix 4x4)
*>
extern fn void setShaderValueMatrix(Shader shader, int locIndex, Matrix mat) @extern("SetShaderValueMatrix");

<*
 Set shader uniform value for texture (sampler2d)
*>
extern fn void setShaderValueTexture(Shader shader, int locIndex, Texture2D texture) @extern("SetShaderValueTexture");

<*
 Unload shader from GPU memory (VRAM)
*>
extern fn void unloadShader(Shader shader) @extern("UnloadShader");

// Screen-space-related functions
//------------------------------------------------------------------------------------

<*
 Get a ray trace from mouse position
*>
extern fn Ray getMouseRay(Vector2 mousePosition, Camera camera) @extern("GetMouseRay");

<*
 Get camera transform matrix (view matrix)
*>
extern fn Matrix getCameraMatrix(Camera camera) @extern("GetCameraMatrix");

<*
 Get camera 2d transform matrix
*>
extern fn Matrix getCameraMatrix2d(Camera2D camera) @extern("GetCameraMatrix2D");

<*
 Get the screen space position for a 3d world space position
*>
extern fn Vector2 getWorldToScreen(Vector3 position, Camera camera) @extern("GetWorldToScreen");

<*
 Get the world space position for a 2d camera screen space position
*>
extern fn Vector2 getScreenToWorld2d(Vector2 position, Camera2D camera) @extern("GetScreenToWorld2D");

<*
 Get size position for a 3d world space position
*>
extern fn Vector2 getWorldToScreenEx(Vector3 position, Camera camera, int width, int height) @extern("GetWorldToScreenEx");

<*
 Get the screen space position for a 2d camera world space position
*>
extern fn Vector2 getWorldToScreen2d(Vector2 position, Camera2D camera) @extern("GetWorldToScreen2D");

// Timing-related functions
//------------------------------------------------------------------------------------

<*
 Set target FPS (maximum)
*>
extern fn void setTargetFPS(int fps) @extern("SetTargetFPS");

<*
 Get time in seconds for last frame drawn (delta time)
*>
extern fn float getFrameTime() @extern("GetFrameTime");

<*
 Get elapsed time in seconds since InitWindow()
*>
extern fn double getTime() @extern("GetTime");

<*
 Get current FPS
*>
extern fn int getFPS() @extern("GetFPS");

// Custom frame control functions
// NOTE: Those functions are intended for advance users that want full control over the frame processing
// By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
// To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
//------------------------------------------------------------------------------------

<*
 Swap back buffer with front buffer (screen drawing)
*>
extern fn void swapScreenBuffer() @extern("SwapScreenBuffer");

<*
 Register all input events
*>
extern fn void pollInputEvents() @extern("PollInputEvents");

<*
 Wait for some time (halt program execution)
*>
extern fn void waitTime(double seconds) @extern("WaitTime");

// Misc. functions
//------------------------------------------------------------------------------------

<*
 Takes a screenshot of current screen (filename extension defines format)
*>
extern fn void takeScreenshot(ZString file_name) @extern("TakeScreenshot");

<*
 Setup init configuration flags (view FLAGS)
*>
extern fn void setConfigFlags(uint flags) @extern("SetConfigFlags");

<*
 Open URL with default system browser (if available)
*>
extern fn void openUrl(ZString url) @extern("OpenURL");

// NOTE: Following functions implemented in module [utils]
//------------------------------------------------------------------

<*
 Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
*>
extern fn void traceLog(TraceLogLevel logLevel, ZString text, ...) @extern("TraceLog");

<*
 Set the current threshold (minimum) log level
*>
extern fn void setTraceLogLevel(TraceLogLevel logLevel) @extern("SetTraceLogLevel");

// Compression/Encoding functionality
//------------------------------------------------------------------------------------
// INFO: add test units

<*
 Compress data (DEFLATE algorithm), memory must be MemFree()
*>
fn char[] compressData(char[] data) @inline {
    int size = 0;
    char* comp_data = __compress_data(data.ptr, data.len, &size);
    return comp_data[:(usz)size];
}

<*
 Decompress data (DEFLATE algorithm), memory must be MemFree()
*>
fn char[] decompressData(char[] comp_data) @inline {
    int size = 0;
    char* decomp_data = __decompress_data(comp_data.ptr, comp_data.len, &size);
    return decomp_data[:(usz)size];
}

<*
 Encode data to Base64 string, memory must be MemFree()
*>
macro char[] encodeDataBase64(char[] data) @if($feature(SUPPORT_DATA_ENCODER)) {
    int size = 0;
    char* encoded_data = __encode_data_base64(data.ptr, data.len, &size);
    return encoded_data[:(usz)size];
}

<*
 Decode Base64 string data, memory must be MemFree()
*>
macro char[] decodeDataBase64(char[] data) @if($feature(SUPPORT_DATA_ENCODER)) {
    int size = 0;
    char* decoded_data = __decode_data_base64(data.ptr, &size);
    return decoded_data[:(usz)size];
}

// Automation events functionality
//------------------------------------------------------------------------------------

<*
 Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
*>
extern fn AutomationEventList loadAutomationEventList(ZString file_name) @extern("LoadAutomationEventList");

<*
 Unload automation events list from file
*>
extern fn void unloadAutomationEventList(AutomationEventList* list) @extern("UnloadAutomationEventList");

<*
 Export automation events list as text file
*>
extern fn bool exportAutomationEventList(AutomationEventList list, ZString file_name) @extern("ExportAutomationEventList");

<*
 Set automation event list to record to
*>
extern fn void setAutomationEventList(AutomationEventList* list) @extern("SetAutomationEventList");

<*
 Set automation event internal base frame to start recording
*>
extern fn void setAutomationEventBaseFrame(int frame) @extern("SetAutomationEventBaseFrame");

<*
 Start recording automation events (AutomationEventList must be set)
*>
extern fn void startAutomationEventRecording() @extern("StartAutomationEventRecording");

<*
 Stop recording automation events
*>
extern fn void stopAutomationEventRecording() @extern("StopAutomationEventRecording");

<*
 Play a recorded automation event
*>
extern fn void playAutomationEvent(AutomationEvent event) @extern("PlayAutomationEvent");

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
