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
extern fn void initWindow(int width, int height, ZString title) @cname("InitWindow");

<*
 Close window and unload OpenGL context
*>
extern fn void closeWindow() @cname("CloseWindow");

<*
 Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
*>
extern fn bool windowShouldClose() @cname("WindowShouldClose");

<*
 Check if window has been initialized successfully
*>
extern fn bool isWindowReady() @cname("IsWindowReady");

<*
 Check if window is currently fullscreen
*>
extern fn bool isWindowFullscreen() @cname("IsWindowFullscreen");

<*
 Check if window is currently hidden
*>
extern fn bool isWindowHidden() @cname("IsWindowHidden");

<*
 Check if window is currently minimized
*>
extern fn bool isWindowMinimized() @cname("IsWindowMinimized");

<*
 Check if window is currently maximized
*>
extern fn bool isWindowMaximized() @cname("IsWindowMaximized");

<*
 Check if window is currently focused
*>
extern fn bool isWindowFocused() @cname("IsWindowFocused");

<*
 Check if window has been resized last frame
*>
extern fn bool isWindowResized() @cname("IsWindowResized");

<*
 Check if one specific window flag is enabled
*>
extern fn bool isWindowState(ConfigFlags flag) @cname("IsWindowState");

<*
 Set window configuration state using flags
*>
extern fn void setWindowState(ConfigFlags flags) @cname("SetWindowState");

<*
 Clear window configuration state flags
*>
extern fn void clearWindowState(ConfigFlags flags) @cname("ClearWindowState");

<*
 Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
*>
extern fn void toggleFullscreen() @cname("ToggleFullscreen");

<*
 Toggle window state: borderless windowed, resizes window to match monitor resolution
*>
extern fn void toggleBorderlessWindowed() @cname("ToggleBorderlessWindowed");

<*
 Set window state: maximized, if resizable
*>
extern fn void maximizeWindow() @cname("MaximizeWindow");

<*
 Set window state: minimized, if resizable
*>
extern fn void minimizeWindow() @cname("MinimizeWindow");

<*
 Restore window from being minimized/maximized
*>
extern fn void restoreWindow() @cname("RestoreWindow");

<*
 Set icon for window (single image, RGBA 32bit)
*>
extern fn void setWindowIcon(Image image) @cname("SetWindowIcon");

<*
 Set icon for window (multiple images, RGBA 32bit)
 @require images.len <= int::max
*>
fn void setWindowIcons(Image[] images) @inline {
    __set_window_icons(images.ptr, (int)images.len);
}

<*
 Set title for window
*>
extern fn void setWindowTitle(ZString title) @cname("SetWindowTitle");

<*
 Set window position on screen
*>
extern fn void setWindowPosition(int x, int y) @cname("SetWindowPosition");

<*
 Set monitor for the current window
*>
extern fn void setWindowMonitor(int monitor) @cname("SetWindowMonitor");

<*
 Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
*>
extern fn void setWindowMinSize(int width, int height) @cname("SetWindowMinSize");

<*
 Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
*>
extern fn void setWindowMaxSize(int width, int height) @cname("SetWindowMaxSize");

<*
 Set window dimensions
*>
extern fn void setWindowSize(int width, int height) @cname("SetWindowSize");

<*
 Set window opacity [0.0f..1.0f]
 @require opacity >= 0.0f && opacity <= 1.0f
*>
extern fn void setWindowOpacity(float opacity) @cname("SetWindowOpacity");

<*
 Set window focused
*>
extern fn void setWindowFocused() @cname("SetWindowFocused");

<*
 Get native window handle
*>
extern fn void* getWindowHandle() @cname("GetWindowHandle");

<*
 Get current screen width
*>
extern fn int getScreenWidth() @cname("GetScreenWidth");

<*
 Get current screen height
*>
extern fn int getScreenHeight() @cname("GetScreenHeight");

<*
 Get current render width (it considers HiDPI)
*>
extern fn int getRenderWidth() @cname("GetRenderWidth");

<*
 Get current render height (it considers HiDPI)
*>
extern fn int getRenderHeight() @cname("GetRenderHeight");

<*
 Get number of connected monitors
*>
extern fn int getMonitorCount() @cname("GetMonitorCount");

<*
 Get current monitor where window is placed
*>
extern fn int getCurrentMonitor() @cname("GetCurrentMonitor");

<*
 Get specified monitor position
*>
extern fn Vector2 getMonitorPosition(int monitor) @cname("GetMonitorPosition");

<*
 Get specified monitor width (current video mode used by monitor)
*>
extern fn int getMonitorWidth(int monitor) @cname("GetMonitorWidth");

<*
 Get specified monitor height (current video mode used by monitor)
*>
extern fn int getMonitorHeight(int monitor) @cname("GetMonitorHeight");

<*
 Get specified monitor physical width in millimetres
*>
extern fn int getMonitorPhysicalWidth(int monitor) @cname("GetMonitorPhysicalWidth");

<*
 Get specified monitor physical height in millimetres
*>
extern fn int getMonitorPhysicalHeight(int monitor) @cname("GetMonitorPhysicalHeight");

<*
 Get specified monitor refresh rate
*>
extern fn int getMonitorRefreshRate(int monitor) @cname("GetMonitorRefreshRate");

<*
 Get window position XY on monitor
*>
extern fn Vector2 getWindowPosition() @cname("GetWindowPosition");

<*
 Get window scale DPI factor
*>
extern fn Vector2 getWindowScaleDpi() @cname("GetWindowScaleDPI");

<*
 Get the human-readable, UTF-8 encoded name of the specified monitor
*>
extern fn ZString getMonitorName(int monitor) @cname("GetMonitorName");

<*
 Set clipboard text content
*>
extern fn void setClipboardText(ZString text) @cname("SetClipboardText");

<*
 Get clipboard text content
*>
extern fn ZString getClipboardText() @cname("GetClipboardText");

<*
 Get clipboard image content
*>
extern fn Image getClipboardImage() @cname("GetClipboardImage");

<*
 Enable waiting for events on EndDrawing(), no automatic event polling
*>
extern fn void enableEventWaiting() @cname("EnableEventWaiting");

<*
 Disable waiting for events on EndDrawing(), automatic events polling
*>
extern fn void disableEventWaiting() @cname("DisableEventWaiting");

//------------------------------------------------------------------------------------
// Cursor-related functions
//------------------------------------------------------------------------------------

<*
 Show cursor
*>
extern fn void showCursor() @cname("ShowCursor");

<*
 Hide cursor
*>
extern fn void hideCursor() @cname("HideCursor");

<*
 Check if cursor is not visible
*>
extern fn bool isCursorHidden() @cname("IsCursorHidden");

<*
 Enable cursor (unlock cursor)
*>
extern fn void enableCursor() @cname("EnableCursor");

<*
 Disable cursor (lock cursor)
*>
extern fn void disableCursor() @cname("DisableCursor");

<*
 Check if cursor is on the screen
*>
extern fn bool isCursorOnScreen() @cname("IsCursorOnScreen");

//------------------------------------------------------------------------------------
// Drawing-related functions
//------------------------------------------------------------------------------------

<*
 Clear background (framebuffer) to color
*>
extern fn void clearBackground(Color color) @cname("ClearBackground");

<*
 Begin canvas (framebuffer) drawing
*>
extern fn void beginDrawing() @cname("BeginDrawing");

<*
 End canvas (framebuffer) drawing and swap buffers (double buffering)
*>
extern fn void endDrawing() @cname("EndDrawing");

<*
 Begin 2D mode with custom camera (2D)
*>
extern fn void beginMode2D(Camera2D camera) @cname("BeginMode2D");

<*
 End 2D mode with custom camera
*>
extern fn void endMode2D() @cname("EndMode2D");

<*
 Begin 3D mode with custom camera (3D)
*>
extern fn void beginMode3D(Camera3D camera) @cname("BeginMode3D");

<*
 End 3D mode and returns to default 2D orthographic mode
*>
extern fn void endMode3D() @cname("EndMode3D");

<*
 Begin drawing to render texture
*>
extern fn void beginTextureMode(RenderTexture2D target) @cname("BeginTextureMode");

<*
 End drawing to render texture
*>
extern fn void endTextureMode() @cname("EndTextureMode");

<*
 Begin custom shader drawing
*>
extern fn void beginShaderMode(Shader shader) @cname("BeginShaderMode");

<*
 End custom shader drawing (use default shader)
*>
extern fn void endShaderMode() @cname("EndShaderMode");

<*
 Begin blending mode (alpha, additive, multiplied, subtract, custom)
*>
extern fn void beginBlendMode(BlendMode mode) @cname("BeginBlendMode");

<*
 End blending mode (reset to default: alpha blending)
*>
extern fn void endBlendMode() @cname("EndBlendMode");

<*
 Begin scissor mode (define screen area for following drawing)
*>
extern fn void beginScissorMode(int x, int y, int width, int height) @cname("BeginScissorMode");

<*
 End scissor mode
*>
extern fn void endScissorMode() @cname("EndScissorMode");

<*
 Begin stereo rendering (requires VR simulator)
*>
extern fn void beginVrStereoMode(VrStereoConfig config) @cname("BeginVrStereoMode");

<*
 End stereo rendering (requires VR simulator)
*>
extern fn void endVrStereoMode() @cname("EndVrStereoMode");

//------------------------------------------------------------------------------------
// VR stereo config functions for VR simulator
//------------------------------------------------------------------------------------

<*
 Load VR stereo config for VR simulator device parameters
*>
extern fn VrStereoConfig loadVrStereoConfig(VrDeviceInfo device) @cname("LoadVrStereoConfig");

<*
 Unload VR stereo config
*>
extern fn void VrStereoConfig.unload(VrStereoConfig config) @cname("UnloadVrStereoConfig");
alias unloadVrStereoConfig = VrStereoConfig.unload;

//------------------------------------------------------------------------------------
// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
//------------------------------------------------------------------------------------

<*
 Load shader from files and bind default locations
*>
extern fn Shader loadShader(ZString vs_file_name, ZString fs_file_name) @cname("LoadShader");

<*
 Load shader from code strings and bind default locations
*>
extern fn Shader loadShaderFromMemory(ZString vs_code, ZString fs_code) @cname("LoadShaderFromMemory");

<*
 Check if shader is valid (loaded on GPU)
*>
extern fn bool Shader.isValid(Shader shader) @cname("IsShaderValid");
alias isShaderValid = Shader.isValid;

<*
 Get shader uniform location
*>
fn int Shader.getLocation(Shader shader, ZString uniform_name) @inline {
	return __get_shader_location(shader, uniform_name);
}
alias getShaderLocation = Shader.getLocation;

<*
 Get shader attribute location
*>
fn int Shader.getLocationAttrib(Shader shader, ZString attrib_name) @inline {
	return __get_shader_location_attrib(shader, attrib_name);
}
alias getShaderLocationAttrib = Shader.getLocationAttrib;

<*
 Set shader uniform value
*>
extern fn void Shader.setValue(Shader shader, int loc_index, void* value, ShaderUniformDataType uniform_type) @cname("SetShaderValue");
alias setShaderValue = Shader.setValue;

<*
 Set shader uniform value vector
*>
extern fn void Shader.setValueV(Shader shader, int locIndex, void* value, ShaderUniformDataType uniform_type, int count) @cname("SetShaderValueV");
alias setShaderValueV = Shader.setValueV;

<*
 Set shader uniform value (matrix 4x4)
*>
extern fn void Shader.setValueMatrix(Shader shader, int locIndex, Matrix mat) @cname("SetShaderValueMatrix");
alias setShaderValueMatrix = Shader.setValueMatrix;

<*
 Set shader uniform value and bind the texture (sampler2d)
*>
extern fn void Shader.setValueTexture(Shader shader, int locIndex, Texture2D texture) @cname("SetShaderValueTexture");
alias setShaderValueTexture = Shader.setValueTexture;

<*
 Unload shader from GPU memory (VRAM)
*>
extern fn void Shader.unload(Shader shader) @cname("UnloadShader");
alias unloadShader = Shader.unload;

//------------------------------------------------------------------------------------
// Screen-space-related functions
//------------------------------------------------------------------------------------

<*
 Compatibility hack for previous raylib versions
*>
alias getMouseRay = getScreenToWorldRay;

<*
 Get a ray trace from screen position (i.e mouse)
*>
extern fn Ray getScreenToWorldRay(Vector2 position, Camera camera) @cname("GetScreenToWorldRay");

<*
 Get a ray trace from screen position (i.e mouse) in a viewport
*>
extern fn Ray getScreenToWorldRayEx(Vector2 position, Camera camera, int width, int height) @cname("GetScreenToWorldRayEx");

<*
 Get screen space position for a 3d world space position
*>
extern fn Vector2 getWorldToScreen(Vector3 position, Camera camera) @cname("GetWorldToScreen");

<*
 Get sized screen space position for a 3d world space position
*>
extern fn Vector2 getWorldToScreenEx(Vector3 position, Camera camera, int width, int height) @cname("GetWorldToScreenEx");

<*
 Get screen space position for a 2d camera world space position
*>
extern fn Vector2 getWorldToScreen2D(Vector2 position, Camera2D camera) @cname("GetWorldToScreen2D");

<*
 Get world space position for a 2d camera screen space position
*>
extern fn Vector2 getScreenToWorld2D(Vector2 position, Camera2D camera) @cname("GetScreenToWorld2D");

<*
 Get camera transform matrix (view matrix)
*>
extern fn Matrix getCameraMatrix(Camera camera) @cname("GetCameraMatrix");

<*
 Get camera 2d transform matrix
*>
extern fn Matrix getCameraMatrix2D(Camera2D camera) @cname("GetCameraMatrix2D");


//------------------------------------------------------------------------------------
// Timing-related functions
//------------------------------------------------------------------------------------

<*
 Set target FPS (maximum)
*>
extern fn void setTargetFPS(int fps) @cname("SetTargetFPS");

<*
 Get time in seconds for last frame drawn (delta time)
*>
extern fn float getFrameTime() @cname("GetFrameTime");

<*
 Get elapsed time in seconds since InitWindow()
*>
extern fn double getTime() @cname("GetTime");

<*
 Get current FPS
*>
extern fn int getFPS() @cname("GetFPS");

//------------------------------------------------------------------------------------
// Custom frame control functions
// NOTE: Those functions are intended for advanced users that want full control over the frame processing
// By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
// To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
//------------------------------------------------------------------------------------

<*
 Swap back buffer with front buffer (screen drawing)
*>
extern fn void swapScreenBuffer() @cname("SwapScreenBuffer");

<*
 Register all input events
*>
extern fn void pollInputEvents() @cname("PollInputEvents");

<*
 Wait for some time (halt program execution)
*>
extern fn void waitTime(double seconds) @cname("WaitTime");

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

//------------------------------------------------------------------------------------
// Misc. functions
//------------------------------------------------------------------------------------

<*
 Takes a screenshot of current screen (filename extension defines format)
*>
extern fn void takeScreenshot(ZString file_name) @cname("TakeScreenshot");

<*
 Set init configuration flags (view FLAGS)
*>
extern fn void setConfigFlags(uint flags) @cname("SetConfigFlags");

<*
 Open URL with default system browser (if available)
*>
extern fn void openUrl(ZString url) @cname("OpenURL");

//------------------------------------------------------------------
// NOTE: Following functions implemented in module [utils]
//------------------------------------------------------------------

<*
 Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
*>
extern fn void traceLog(TraceLogLevel logLevel, ZString text, ...) @cname("TraceLog");

<*
 Set the current threshold (minimum) log level
*>
extern fn void setTraceLogLevel(TraceLogLevel logLevel) @cname("SetTraceLogLevel");

<*
 Internal memory allocator
*>
extern fn void* memAlloc(uint size) @cname("MemAlloc");

<*
 Internal memory reallocator
*>
extern fn void* memRealloc(void* ptr, uint size) @cname("MemRealloc");

<*
 Internal memory free
*>
extern fn void memFree(void* ptr) @cname("MemFree");

//------------------------------------------------------------------------------------
// Set custom callbacks
// WARNING: Callbacks setup is intended for advanced users
//------------------------------------------------------------------------------------

<*
 Set custom file binary data loader
*>
extern fn void setLoadFileDataCallback(LoadFileDataCallback callback) @cname("SetLoadFileDataCallback");

<*
 Set custom file binary data saver
*>
extern fn void setSaveFileDataCallback(SaveFileDataCallback callback) @cname("SetSaveFileDataCallback");

<*
 Set custom file text data loader
*>
extern fn void setLoadFileTextCallback(LoadFileTextCallback callback) @cname("SetLoadFileTextCallback");

<*
 Set custom file text data saver
*>
extern fn void setSaveFileTextCallback(SaveFileTextCallback callback) @cname("SetSaveFileTextCallback");

//------------------------------------------------------------------------------------
// Files management functions
//------------------------------------------------------------------------------------

<*
 Load file data as byte array (read)
 @ensure return.len <= int::max
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
extern fn bool saveFileData(ZString file_name, void* data, int data_size) @cname("SaveFileData");

// TODO: review
<*
 Export data to code (.h), returns true on success
 @require data.len <= int::max
*>
macro bool exportDataAsCode(ZString file_name, char[] data) {
    return __export_data_as_code(data.ptr, data.len, file_name);
}

<*
 Load text data from file (read), returns a '\0' terminated string
*>
fn ZString? loadFileText(ZString file_name) @inline {
    char* zstr = __load_file_text(file_name);
    return zstr == null ? io::UNKNOWN_ERROR~ : (ZString)zstr;
}

<*
 Unload file text data allocated by LoadFileText()
*>
extern fn void unloadFileText(ZString text) @cname("UnloadFileText");

<*
 Save text data to file (write), string must be '\0' terminated, returns true on success
*>
extern fn bool saveFileText(ZString file_name, ZString text) @cname("SaveFileText");

//------------------------------------------------------------------------------------
// File system functions
//------------------------------------------------------------------------------------

<*
 Rename file (if exists), returns 0 on success
*>
extern fn int fileRename(ZString file_name, ZString file_rename) @cname("FileRename");

<*
 Remove file (if exists), returns 0 on success
*>
extern fn int fileRemove(ZString file_name) @cname("FileRemove");

<*
 Copy file from one path to another, dstPath created if it doesn't exist, returns 0 on success
*>
extern fn int fileCopy(ZString src_path, ZString dst_path) @cname("FileCopy");

<*
 Move file from one directory to another, dstPath created if it doesn't exist, returns 0 on success
*>
extern fn int fileMove(ZString src_path, ZString dst_path) @cname("FileMove");

<*
 Replace text in an existing file, returns 0 on success
*>
extern fn int fileTextReplace(ZString file_name, ZString search, ZString replacement) @cname("FileTextReplace");

<*
 Find text in existing file, returns -1 if index not found or index otherwise
*>
extern fn int fileTextFindIndex(ZString file_name, ZString search) @cname("FileTextFindIndex");

<*
 Check if file exists
*>
extern fn bool fileExists(ZString file_name) @cname("FileExists");

<*
 Check if directory path exists
*>
extern fn bool directoryExists(ZString dir_path) @cname("DirectoryExists");

<*
 Check file extension (recommended include point: .png, .wav)
*>
extern fn bool isFileExtension(ZString file_name, ZString ext) @cname("IsFileExtension");

<*
 Check if file path (file or directory) is hidden by OS
*>
extern fn bool isFileHidden(ZString file_path) @cname("IsFileHidden");

<*
 Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
*>
extern fn int getFileLength(ZString file_name) @cname("GetFileLength");

<*
 Get pointer to extension for a filename string (includes dot: '.png')
*>
extern fn ZString getFileExtension(ZString file_name) @cname("GetFileExtension");

<*
 Get pointer to filename for a path string
*>
extern fn ZString getFileName(ZString file_path) @cname("GetFileName");

<*
 Get filename string without extension (uses static string)
*>
extern fn ZString getFileNameWithoutExt(ZString file_path) @cname("GetFileNameWithoutExt");

<*
 Get full path for a provided fileName with path (uses static string)
*>
extern fn ZString getDirectoryPath(ZString file_path) @cname("GetDirectoryPath");

<*
 Get previous directory path for a provided path (uses static string)
*>
extern fn ZString getPrevDirectoryPath(ZString dir_path) @cname("GetPrevDirectoryPath");

<*
 Get current working directory (uses static string)
*>
extern fn ZString getWorkingDirectory() @cname("GetWorkingDirectory");

<*
 Get the directory of the running application (uses static string)
*>
extern fn ZString getApplicationDirectory() @cname("GetApplicationDirectory");

<*
 Create directories (including full path requested), returns 0 on success
*>
extern fn int makeDirectory(ZString dir_path) @cname("MakeDirectory");

<*
 Change working directory, returns 0 on success
*>
extern fn int changeDirectory(ZString dir_path) @cname("ChangeDirectory");

<*
 Check if provided path points to a file
*>
extern fn bool isPathFile(ZString path) @cname("IsPathFile");

<*
 Check if provided path points to a directory
*>
extern fn bool isPathDirectory(ZString path) @cname("IsPathDirectory");

<*
 Check if provided path is an absolute path
*>
extern fn bool isPathAbsolute(ZString path) @cname("IsPathAbsolute");

<*
 Check if fileName is valid for the platform/OS
*>
extern fn bool isFileNameValid(ZString file_name) @cname("IsFileNameValid");

<*
 Load directory filepaths, files and directories, no subdirs scan
*>
extern fn FilePathList loadDirectoryFiles(ZString dir_path) @cname("LoadDirectoryFiles");

<*
 Load directory filepaths with extension filtering and subdir scan; some filters available: '*.*','FILES*','DIRS*'
*>
extern fn FilePathList loadDirectoryFilesEx(ZString base_path, ZString filter, bool scan_subdirs) @cname("LoadDirectoryFilesEx");

<*
 Unload filepaths
*>
extern fn void FilePathList.unload(FilePathList files) @cname("UnloadDirectoryFiles");
alias unloadDirectoryFiles = FilePathList.unload;

<*
 Check if file has been dropped into window
*>
extern fn bool isFileDropped() @cname("IsFileDropped");

<*
 Load dropped filepaths
*>
extern fn FilePathList loadDroppedFiles() @cname("LoadDroppedFiles");

<*
 Unload dropped filepaths
*>
extern fn void unloadDroppedFiles(FilePathList files) @cname("UnloadDroppedFiles");

<*
 Get the file count in a directory
*>
extern fn uint getDirectoryFileCount(ZString dir_path) @cname("GetDirectoryFileCount");

<*
 Get the file count in a directory with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result
*>
extern fn uint getDirectoryFileCountEx(ZString base_path, ZString filter, bool scan_subdirs) @cname("GetDirectoryFileCountEx");

<*
 Get file modification time (last write time)
*>
extern fn long getFileModTime(ZString file_name) @cname("GetFileModTime");

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
 Encode data to Base64 string (includes NULL terminator), memory must be MemFree()
*>
macro char[] encodeDataBase64(char[] data) {
    int size = 0;
    char* encoded_data = __encode_data_base64(data.ptr, data.len, &size);
    return encoded_data[:(usz)size - 1]; // size counts the NULL terminator
}

<*
 Decode Base64 string (expected NULL terminated), memory must be MemFree()
*>
macro char[] decodeDataBase64(char[] data) {
    int size = 0;
    char* decoded_data = __decode_data_base64(data.ptr, &size);
    return decoded_data[:(usz)size];
}


<*
 Compute CRC32 hash code
*>
extern fn uint computeCRC32(ZString data, int data_size) @cname("ComputeCRC32");

// TODO: convert return value to uint[4]
<*
 Compute MD5 hash code, returns static int[4] (16 bytes)
*>
extern fn uint* computeMD5(ZString data, int data_size) @cname("ComputeMD5");

// TODO: convert return value to uint[5]
<*
 Compute SHA1 hash code, returns static int[5] (20 bytes)
*>
extern fn uint* computeSHA1(ZString data, int data_size) @cname("ComputeSHA1");

// TODO: convert return value to uint[8]
<*
 Compute SHA256 hash code, returns static int[8] (32 bytes)
*>
extern fn uint* computeSHA256(ZString data, int data_size) @cname("ComputeSHA256");

//------------------------------------------------------------------------------------
// Automation events functionality
//------------------------------------------------------------------------------------

<*
 Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
*>
extern fn AutomationEventList loadAutomationEventList(ZString file_name) @cname("LoadAutomationEventList");

<*
 Unload automation events list from file
*>
extern fn void AutomationEventList.unload(AutomationEventList list) @cname("UnloadAutomationEventList");
alias unloadAutomationEventList = AutomationEventList.unload;

<*
 Export automation events list as text file
*>
extern fn bool AutomationEventList.export(AutomationEventList list, ZString file_name) @cname("ExportAutomationEventList");
alias exportAutomationEventList = AutomationEventList.export;

<*
 Set automation event list to record to
*>
extern fn void AutomationEventList.set(AutomationEventList* list) @cname("SetAutomationEventList");
alias setAutomationEventList = AutomationEventList.set;

<*
 Set automation event internal base frame to start recording
*>
extern fn void setAutomationEventBaseFrame(int frame) @cname("SetAutomationEventBaseFrame");

<*
 Start recording automation events (AutomationEventList must be set)
*>
extern fn void startAutomationEventRecording() @cname("StartAutomationEventRecording");

<*
 Stop recording automation events
*>
extern fn void stopAutomationEventRecording() @cname("StopAutomationEventRecording");

<*
 Play a recorded automation event
*>
extern fn void playAutomationEvent(AutomationEvent event) @cname("PlayAutomationEvent");

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
//------------------------------------------------------------------------------------

<*
 Check if key has been pressed once
*>
extern fn bool isKeyPressed(KeyboardKey key) @cname("IsKeyPressed");

<*
 Check if key has been pressed again
*>
extern fn bool isKeyPressedRepeat(KeyboardKey key) @cname("IsKeyPressedRepeat");

<*
 Check if key is being pressed
*>
extern fn bool isKeyDown(KeyboardKey key) @cname("IsKeyDown");

<*
 Check if key has been released once
*>
extern fn bool isKeyReleased(KeyboardKey key) @cname("IsKeyReleased");

<*
 Check if key is NOT being pressed
*>
extern fn bool isKeyUp(KeyboardKey key) @cname("IsKeyUp");

<*
 Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
*>
extern fn KeyboardKey getKeyPressed() @cname("GetKeyPressed");

<*
 Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
*>
extern fn KeyboardKey getCharPressed() @cname("GetCharPressed");

<*
 Get name of a QWERTY key on the current keyboard layout (eg returns string 'q' for KEY_A on an AZERTY keyboard)
*>
extern fn ZString getKeyName(KeyboardKey key) @cname("GetKeyName");

<*
 Set a custom key to exit program (default is ESC)
*>
extern fn void setExitKey(KeyboardKey key) @cname("SetExitKey");

// Input-related functions: gamepads
//------------------------------------------------------------------------------------

<*
 Check if gamepad is available
*>
extern fn bool isGamepadAvailable(int gamepad) @cname("IsGamepadAvailable");

<*
 Get gamepad internal name id
*>
extern fn ZString getGamepadName(int gamepad) @cname("GetGamepadName");

<*
 Check if gamepad button has been pressed once
*>
extern fn bool isGamepadButtonPressed(int gamepad, GamepadButton button) @cname("IsGamepadButtonPressed");

<*
 Check if gamepad button is being pressed
*>
extern fn bool isGamepadButtonDown(int gamepad, GamepadButton button) @cname("IsGamepadButtonDown");

<*
 Check if gamepad button has been released once
*>
extern fn bool isGamepadButtonReleased(int gamepad, GamepadButton button) @cname("IsGamepadButtonReleased");

<*
 Check if gamepad button is NOT being pressed
*>
extern fn bool isGamepadButtonUp(int gamepad, GamepadButton button) @cname("IsGamepadButtonUp");

<*
 Get the last gamepad button pressed
*>
extern fn int getGamepadButtonPressed() @cname("GetGamepadButtonPressed");

<*
 Get axis count for a gamepad
*>
extern fn int getGamepadAxisCount(int gamepad) @cname("GetGamepadAxisCount");

<*
 Get movement value for a gamepad axis
*>
extern fn float getGamepadAxisMovement(int gamepad, GamepadAxis axis) @cname("GetGamepadAxisMovement");

<*
 Set internal gamepad mappings (SDL_GameControllerDB)
*>
extern fn int setGamepadMappings(ZString mappings) @cname("SetGamepadMappings");

<*
 Set gamepad vibration for both motors (duration in seconds)
*>
extern fn void setGamepadVibration(int gamepad, float left_motor, float right_motor, float duration) @cname("SetGamepadVibration");

// Input-related functions: mouse
//------------------------------------------------------------------------------------

<*
 Check if mouse button has been pressed once
*>
extern fn bool isMouseButtonPressed(MouseButton button) @cname("IsMouseButtonPressed");

<*
 Check if mouse button is being pressed
*>
extern fn bool isMouseButtonDown(MouseButton button) @cname("IsMouseButtonDown");

<*
 Check if mouse button has been released once
*>
extern fn bool isMouseButtonReleased(MouseButton button) @cname("IsMouseButtonReleased");

<*
 Check if mouse button is NOT being pressed
*>
extern fn bool isMouseButtonUp(MouseButton button) @cname("IsMouseButtonUp");

<*
 Get mouse position X
*>
extern fn int getMouseX() @cname("GetMouseX");

<*
 Get mouse position Y
*>
extern fn int getMouseY() @cname("GetMouseY");

<*
 Get mouse position XY
*>
extern fn Vector2 getMousePosition() @cname("GetMousePosition");

<*
 Get mouse delta between frames
*>
extern fn Vector2 getMouseDelta() @cname("GetMouseDelta");

<*
 Set mouse position XY
*>
extern fn void setMousePosition(int x, int y) @cname("SetMousePosition");

<*
 Set mouse offset
*>
extern fn void setMouseOffset(int offset_x, int offset_y) @cname("SetMouseOffset");

<*
 Set mouse scaling
*>
extern fn void setMouseScale(float scale_x, float scale_y) @cname("SetMouseScale");

<*
 Get mouse wheel movement for X or Y, whichever is larger
*>
extern fn float getMouseWheelMove() @cname("GetMouseWheelMove");

<*
 Get mouse wheel movement for both X and Y
*>
extern fn Vector2 getMouseWheelMoveV() @cname("GetMouseWheelMoveV");

<*
 Set mouse cursor
*>
extern fn void setMouseCursor(MouseCursor cursor) @cname("SetMouseCursor");

// Input-related functions: touch
//------------------------------------------------------------------------------------

<*
 Get touch position X for touch point 0 (relative to screen size)
*>
extern fn int getTouchX() @cname("GetTouchX");

<*
 Get touch position Y for touch point 0 (relative to screen size)
*>
extern fn int getTouchY() @cname("GetTouchY");

<*
 Get touch position XY for a touch point index (relative to screen size)
*>
extern fn Vector2 getTouchPosition(int index) @cname("GetTouchPosition");

<*
 Get touch point identifier for provided index
*>
extern fn int getTouchPointId(int index) @cname("GetTouchPointId");

<*
 Get number of touch points
*>
extern fn int getTouchPointCount() @cname("GetTouchPointCount");

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: rgestures)
//------------------------------------------------------------------------------------

<*
 Enable a set of gestures using flags
*>
extern fn void setGesturesEnabled(Gesture flags) @cname("SetGesturesEnabled");

<*
 Check if gesture has been detected
*>
extern fn bool isGestureDetected(Gesture gesture) @cname("IsGestureDetected");

<*
 Get latest detected gesture
*>
extern fn int getGestureDetected() @cname("GetGestureDetected");

<*
 Get gesture hold time in seconds
*>
extern fn float getGestureHoldDuration() @cname("GetGestureHoldDuration");

<*
 Get gesture drag vector
*>
extern fn Vector2 getGestureDragVector() @cname("GetGestureDragVector");

<*
 Get gesture drag angle
*>
extern fn float getGestureDragAngle() @cname("GetGestureDragAngle");

<*
 Get gesture pinch delta
*>
extern fn Vector2 getGesturePinchVector() @cname("GetGesturePinchVector");

<*
 Get gesture pinch angle
*>
extern fn float getGesturePinchAngle() @cname("GetGesturePinchAngle");

//------------------------------------------------------------------------------------
// Camera System Functions (Module: rcamera)
//------------------------------------------------------------------------------------

<*
 Update camera position for selected mode
*>
extern fn void Camera.update(Camera* camera, CameraMode mode) @cname("UpdateCamera");
alias updateCamera = Camera.update;

<*
 Update camera movement/rotation
*>
extern fn void Camera.updatePro(Camera* camera, Vector3 movement, Vector3 rotation, float zoom) @cname("UpdateCameraPro");
alias updateCameraPro = Camera.updatePro;

<*
 Rotates the camera around its up vector
 Yaw is "looking left and right"
 If rotateAroundTarget is false, the camera rotates around its position
 Note: angle must be provided in radians
*>
extern fn void Camera.yaw(Camera* camera, float angle, bool rotate_around_target) @cname("CameraYaw");
alias cameraYaw = Camera.yaw;

<*
 Rotates the camera around its right vector, pitch is "looking up and down"
 - lockView prevents camera overrotation (aka "somersaults")
 - rotateAroundTarget defines if rotation is around target or around its position
 - rotateUp rotates the up direction as well (typically only usefull in CAMERA_FREE)
 NOTE: angle must be provided in radians
*>
extern fn void Camera.pitch(Camera* camera, float angle, bool lock_view, bool rotate_around_target, bool rotate_up) @cname("CameraPitch");
alias cameraPitch = Camera.pitch;

<*
 Returns the cameras forward vector (normalized)
*>
extern fn Vector3 Camera.getForward(Camera* camera) @cname("GetCameraForward");
alias getCameraForward = Camera.getForward;

<*
 Returns the cameras up vector (normalized)
 Note: The up vector might not be perpendicular to the forward vector
*>
extern fn Vector3 Camera.getUp(Camera* camera) @cname("GetCameraUp");
alias getCameraUp = Camera.getUp;

<*
 Returns the cameras right vector (normalized)
*>
extern fn Vector3 Camera.getRight(Camera* camera) @cname("GetCameraRight");
alias getCameraRight = Camera.getRight;

<*
 Moves the camera in its forward direction
*>
extern fn void Camera.moveForward(Camera* camera, float distance, bool move_in_world_plane) @cname("CameraMoveForward");
alias cameraMoveForward = Camera.moveForward;

<*
 Moves the camera in its up direction
*>
extern fn void Camera.moveUp(Camera* camera, float distance) @cname("CameraMoveUp");
alias cameraMoveUp = Camera.moveUp;

<*
 Moves the camera target in its current right direction
*>
extern fn void Camera.moveRight(Camera* camera, float distance, bool move_in_world_plane) @cname("CameraMoveRight");
alias cameraMoveRight = Camera.moveRight;

<*
 Moves the camera position closer/farther to/from the camera target
*>
extern fn void Camera.moveToTarget(Camera* camera, float delta) @cname("CameraMoveToTarget");
alias cameraMoveToTarget = Camera.moveToTarget;

<*
 Rotates the camera around its forward vector
 Roll is "turning your head sideways to the left or right"
 Note: angle must be provided in radians
*>
extern fn void Camera.roll(Camera* camera, float angle) @cname("CameraRoll");
alias cameraRoll = Camera.roll;

<*
 Returns the camera view matrix
*>
extern fn Matrix Camera.getViewMatrix(Camera* camera) @cname("GetCameraViewMatrix");
alias getCameraViewMatrix = Camera.getViewMatrix;

<*
 Returns the camera projection matrix
*>
extern fn Matrix Camera.getProjectionMatrix(Camera* camera, float aspect) @cname("GetCameraProjectionMatrix");
alias getCameraProjectionMatrix = Camera.getProjectionMatrix;
