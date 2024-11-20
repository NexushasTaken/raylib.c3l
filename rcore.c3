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

//------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------
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

// Random values generation functions (see random.c3)
//------------------------------------------------------------------------------------

module rl @if($feature(SUPPORT_RANDOM_GENERATION));

// Random values generation functions
//------------------------------------------------------------------------------------
tlocal bool is_random_initialized = false; // WARNING: required if raylib was configured with SUPPORT_RPRAND_GENERATOR

<*
 Set the seed for the random number generator
*>
fn void setRandomSeed(uint seed) @inline {
	__set_random_seed(seed);
	$if $defined(is_random_initialized):
		is_random_initialized = true;
	$endif
}

<*
 Get a random value between min and max (both included)
*>
fn int getRandomValue(int min, int max) @inline {
	$if $defined(is_random_initialized):
		if (!is_random_initialized) {
			setRandomSeed(0);
			is_random_initialized = true;
		}
	$endif
	return __get_random_value(min, max);
}

<*
 Load random values sequence, no values repeated
*>
fn int[] loadRandomSequence(uint count, int min, int max) @inline {
	$if $defined(is_random_initialized):
		if (!is_random_initialized) {
			setRandomSeed(0);
			is_random_initialized = true;
		}
	$endif
	return __load_random_sequence(count, min, max)[:(usz)count];
}

<*
 Unload random values sequence
*>
fn void unloadRandomSequence(int[] sequence) @inline {
	return __unload_random_sequence(sequence.ptr);
}

module rl;
import std::io;

//------------------------------------------------------------------------------------
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

//------------------------------------------------------------------
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

<*
 Internal memory allocator
*>
extern fn void* memAlloc(uint size) @extern("MemAlloc");

<*
 Internal memory reallocator
*>
extern fn void* memRealloc(void* ptr, uint size) @extern("MemRealloc");

<*
 Internal memory free
*>
extern fn void memFree(void* ptr) @extern("MemFree");

//------------------------------------------------------------------------------------
// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
//------------------------------------------------------------------------------------

<*
 Set custom file binary data loader
*>
extern fn void setLoadFileDataCallback(LoadFileDataCallback callback) @extern("SetLoadFileDataCallback");

<*
 Set custom file binary data saver
*>
extern fn void setSaveFileDataCallback(SaveFileDataCallback callback) @extern("SetSaveFileDataCallback");

<*
 Set custom file text data loader
*>
extern fn void setLoadFileTextCallback(LoadFileTextCallback callback) @extern("SetLoadFileTextCallback");

<*
 Set custom file text data saver
*>
extern fn void setSaveFileTextCallback(SaveFileTextCallback callback) @extern("SetSaveFileTextCallback");

//------------------------------------------------------------------------------------
// Files management functions
//------------------------------------------------------------------------------------

<*
 Load file data as byte array (read)
 @ensure return.len <= int.max
*>
fn char[] loadFileData(ZString file_name) @inline {
    int len = 0;
    char* ptr = __load_file_data(file_name, &len);
    return ptr[:(usz)len];
}

<*
 Unload file data allocated by LoadFileData()
*>
fn void unloadFileData(char[] data) @inline {
    __unload_file_data(data.ptr);
}

<*
 Save data to file from byte array (write), returns true on success
*>
extern fn bool saveFileData(ZString file_name, void* data, int data_size) @extern("SaveFileData");

// TODO: review
<*
 Export data to code (.h), returns true on success
 @require data.len <= int.max
*>
macro bool exportDataAsCode(ZString file_name, char[] data) {
    return __export_data_as_code(data.ptr, data.len, file_name);
}

<*
 Load text data from file (read), returns a '\0' terminated string
*>
fn ZString! loadFileText(ZString file_name) @inline {
    char* zstr = __load_file_text(file_name);
    return zstr == null ? io::IoError.UNKNOWN_ERROR? : (ZString)zstr;
}

<*
 Unload file text data allocated by LoadFileText()
*>
extern fn void unloadFileText(ZString text) @extern("UnloadFileText");

<*
 Save text data to file (write), string must be '\0' terminated, returns true on success
*>
extern fn bool saveFileText(ZString file_name, ZString text) @extern("SaveFileText");

//------------------------------------------------------------------------------------
// File system functions
//------------------------------------------------------------------------------------

<*
 Check if file exists
*>
extern fn bool fileExists(ZString file_name) @extern("FileExists");

<*
 Check if a directory path exists
*>
extern fn bool directoryExists(ZString dir_path) @extern("DirectoryExists");

<*
 Check file extension (including point: .png, .wav)
*>
extern fn bool isFileExtension(ZString file_name, ZString ext) @extern("IsFileExtension");

<*
 Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
*>
extern fn int getFileLength(ZString file_name) @extern("GetFileLength");

<*
 Get pointer to extension for a filename string (includes dot: '.png')
*>
extern fn ZString getFileExtension(ZString file_name) @extern("GetFileExtension");

<*
 Get pointer to filename for a path string
*>
extern fn ZString getFileName(ZString file_path) @extern("GetFileName");

<*
 Get filename string without extension (uses static string)
*>
extern fn ZString getFileNameWithoutExt(ZString file_path) @extern("GetFileNameWithoutExt");

<*
 Get full path for a given fileName with path (uses static string)
*>
extern fn ZString getDirectoryPath(ZString file_path) @extern("GetDirectoryPath");

<*
 Get previous directory path for a given path (uses static string)
*>
extern fn ZString getPrevDirectoryPath(ZString dir_path) @extern("GetPrevDirectoryPath");

<*
 Get current working directory (uses static string)
*>
extern fn ZString getWorkingDirectory() @extern("GetWorkingDirectory");

<*
 Get the directory of the running application (uses static string)
*>
extern fn ZString getApplicationDirectory() @extern("GetApplicationDirectory");

<*
 Change working directory, return true on success
*>
extern fn bool changeDirectory(ZString dir) @extern("ChangeDirectory");

<*
 Check if a given path is a file or a directory
*>
extern fn bool isPathFile(ZString path) @extern("IsPathFile");

<*
 Load directory filepaths
*>
extern fn FilePathList loadDirectoryFiles(ZString  dir_path) @extern("LoadDirectoryFiles");

<*
 Load directory filepaths with extension filtering and recursive directory scan
*>
extern fn FilePathList loadDirectoryFilesEx(ZString base_path, ZString filter, bool scan_subdirs) @extern("LoadDirectoryFilesEx");

<*
 Unload filepaths
*>
extern fn void unloadDirectoryFiles(FilePathList files) @extern("UnloadDirectoryFiles");

<*
 Check if a file has been dropped into window
*>
extern fn bool isFileDropped() @extern("IsFileDropped");

<*
 Load dropped filepaths
*>
extern fn FilePathList loadDroppedFiles() @extern("LoadDroppedFiles");

<*
 Unload dropped filepaths
*>
extern fn void unloadDroppedFiles(FilePathList files) @extern("UnloadDroppedFiles");

<*
 Get file modification time (last write time)
*>
extern fn long getFileModTime(ZString file_name) @extern("GetFileModTime");

//------------------------------------------------------------------
// Compression/Encoding functionality
//------------------------------------------------------------------------------------
// INFO: add unit tests

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

//------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
//------------------------------------------------------------------------------------

<*
 Check if a key has been pressed once
*>
extern fn bool isKeyPressed(KeyboardKey key) @extern("IsKeyPressed");

<*
 Check if a key has been pressed again (Only PLATFORM_DESKTOP)
*>
extern fn bool isKeyPressedRepeat(KeyboardKey key) @extern("IsKeyPressedRepeat");

<*
 Check if a key is being pressed
*>
extern fn bool isKeyDown(KeyboardKey key) @extern("IsKeyDown");

<*
 Check if a key has been released once
*>
extern fn bool isKeyReleased(KeyboardKey key) @extern("IsKeyReleased");

<*
 Check if a key is NOT being pressed
*>
extern fn bool isKeyUp(KeyboardKey key) @extern("IsKeyUp");

<*
 Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
*>
extern fn KeyboardKey getKeyPressed() @extern("GetKeyPressed");

<*
 Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
*>
extern fn KeyboardKey getCharPressed() @extern("GetCharPressed");

<*
 Set a custom key to exit program (default is ESC)
*>
extern fn void setExitKey(KeyboardKey key) @extern("SetExitKey");

// Input-related functions: gamepads
//------------------------------------------------------------------------------------

<*
 Check if a gamepad is available
*>
extern fn bool isGamepadAvailable(int gamepad) @extern("IsGamepadAvailable");

<*
 Get gamepad internal name id
*>
extern fn ZString getGamepadName(int gamepad) @extern("GetGamepadName");

<*
 Check if a gamepad button has been pressed once
*>
extern fn bool isGamepadButtonPressed(int gamepad, GamepadButton button) @extern("IsGamepadButtonPressed");

<*
 Check if a gamepad button is being pressed
*>
extern fn bool isGamepadButtonDown(int gamepad, GamepadButton button) @extern("IsGamepadButtonDown");

<*
 Check if a gamepad button has been released once
*>
extern fn bool isGamepadButtonReleased(int gamepad, GamepadButton button) @extern("IsGamepadButtonReleased");

<*
 Check if a gamepad button is NOT being pressed
*>
extern fn bool isGamepadButtonUp(int gamepad, GamepadButton button) @extern("IsGamepadButtonUp");

<*
 Get the last gamepad button pressed
*>
extern fn int getGamepadButtonPressed() @extern("GetGamepadButtonPressed");

<*
 Get gamepad axis count for a gamepad
*>
extern fn int getGamepadAxisCount(int gamepad) @extern("GetGamepadAxisCount");

<*
 Get axis movement value for a gamepad axis
*>
extern fn float getGamepadAxisMovement(int gamepad, GamepadAxis axis) @extern("GetGamepadAxisMovement");

<*
 Set internal gamepad mappings (SDL_GameControllerDB)
*>
extern fn int setGamepadMappings(ZString mappings) @extern("SetGamepadMappings");

// Input-related functions: mouse
//------------------------------------------------------------------------------------

<*
 Check if a mouse button has been pressed once
*>
extern fn bool isMouseButtonPressed(MouseButton button) @extern("IsMouseButtonPressed");

<*
 Check if a mouse button is being pressed
*>
extern fn bool isMouseButtonDown(MouseButton button) @extern("IsMouseButtonDown");

<*
 Check if a mouse button has been released once
*>
extern fn bool isMouseButtonReleased(MouseButton button) @extern("IsMouseButtonReleased");

<*
 Check if a mouse button is NOT being pressed
*>
extern fn bool isMouseButtonUp(MouseButton button) @extern("IsMouseButtonUp");

<*
 Get mouse position X
*>
extern fn int getMouseX() @extern("GetMouseX");

<*
 Get mouse position Y
*>
extern fn int getMouseY() @extern("GetMouseY");

<*
 Get mouse position XY
*>
extern fn Vector2 getMousePosition() @extern("GetMousePosition");

<*
 Get mouse delta between frames
*>
extern fn Vector2 getMouseDelta() @extern("GetMouseDelta");

<*
 Set mouse position XY
*>
extern fn void setMousePosition(int x, int y) @extern("SetMousePosition");

<*
 Set mouse offset
*>
extern fn void setMouseOffset(int offset_x, int offset_y) @extern("SetMouseOffset");

<*
 Set mouse scaling
*>
extern fn void setMouseScale(float scale_x, float scale_y) @extern("SetMouseScale");

<*
 Get mouse wheel movement for X or Y, whichever is larger
*>
extern fn float getMouseWheelMove() @extern("GetMouseWheelMove");

<*
 Get mouse wheel movement for both X and Y
*>
extern fn Vector2 getMouseWheelMoveV() @extern("GetMouseWheelMoveV");

<*
 Set mouse cursor
*>
extern fn void setMouseCursor(MouseCursor cursor) @extern("SetMouseCursor");

// Input-related functions: touch
//------------------------------------------------------------------------------------

<*
 Get touch position X for touch point 0 (relative to screen size)
*>
extern fn int getTouchX() @extern("GetTouchX");

<*
 Get touch position Y for touch point 0 (relative to screen size)
*>
extern fn int getTouchY() @extern("GetTouchY");

<*
 Get touch position XY for a touch point index (relative to screen size)
*>
extern fn Vector2 getTouchPosition(int index) @extern("GetTouchPosition");

<*
 Get touch point identifier for given index
*>
extern fn int getTouchPointId(int index) @extern("GetTouchPointId");

<*
 Get number of touch points
*>
extern fn int getTouchPointCount() @extern("GetTouchPointCount");

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: rgestures)
//------------------------------------------------------------------------------------

<*
 Enable a set of gestures using flags
*>
extern fn void setGesturesEnabled(Gesture flags) @extern("SetGesturesEnabled");

<*
 Check if a gesture have been detected
*>
extern fn bool isGestureDetected(Gesture gesture) @extern("IsGestureDetected");

<*
 Get latest detected gesture
*>
extern fn int getGestureDetected() @extern("GetGestureDetected");

<*
 Get gesture hold time in milliseconds
*>
extern fn float getGestureHoldDuration() @extern("GetGestureHoldDuration");

<*
 Get gesture drag vector
*>
extern fn Vector2 getGestureDragVector() @extern("GetGestureDragVector");

<*
 Get gesture drag angle
*>
extern fn float getGestureDragAngle() @extern("GetGestureDragAngle");

<*
 Get gesture pinch delta
*>
extern fn Vector2 getGesturePinchVector() @extern("GetGesturePinchVector");

<*
 Get gesture pinch angle
*>
extern fn float getGesturePinchAngle() @extern("GetGesturePinchAngle");

//------------------------------------------------------------------------------------
// Camera System Functions (Module: rcamera)
//------------------------------------------------------------------------------------

<*
 Update camera position for selected mode
*>
extern fn void updateCamera(Camera* camera, CameraMode mode) @extern("UpdateCamera");

<*
 Update camera movement/rotation
*>
extern fn void updateCameraPro(Camera* camera, Vector3 movement, Vector3 rotation, float zoom) @extern("UpdateCameraPro");
