// vi: ts=4 sw=4
module rl;
import std::collections;
import std::io;

//------------------------------------------------------------------------------------
// Window and Graphics Device Functions (Module: core)
//------------------------------------------------------------------------------------

// Window-related functions
//------------------------------------------------------------------------------------

/**
 * Initialize window and OpenGL context
 */
extern fn void init_window(int width, int height, ZString title) @extern("InitWindow");

/**
 * Close window and unload OpenGL context
 */
extern fn void close_window() @extern("CloseWindow");

/**
 * Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
 */
extern fn bool window_should_close() @extern("WindowShouldClose");

/**
 * Check if window has been initialized successfully
 */
extern fn bool is_window_ready() @extern("IsWindowReady");

/**
 * Check if window is currently fullscreen
 */
extern fn bool is_window_fullscreen() @extern("IsWindowFullscreen");

/**
 * Check if window is currently hidden (only PLATFORM_DESKTOP)
 */
extern fn bool is_window_hidden() @extern("IsWindowHidden");

/**
 * Check if window is currently minimized (only PLATFORM_DESKTOP)
 */
extern fn bool is_window_minimized() @extern("IsWindowMinimized");

/**
 * Check if window is currently maximized (only PLATFORM_DESKTOP)
 */
extern fn bool is_window_maximized() @extern("IsWindowMaximized");

/**
 * Check if window is currently focused (only PLATFORM_DESKTOP)
 */
extern fn bool is_window_focused() @extern("IsWindowFocused");

/**
 * Check if window has been resized last frame
 */
extern fn bool is_window_resized() @extern("IsWindowResized");

/**
 * Check if one specific window flag is enabled
 */
extern fn bool is_window_state(ConfigFlags flag) @extern("IsWindowState");

/**
 * Set window configuration state using flags (only PLATFORM_DESKTOP)
 */
extern fn void set_window_state(ConfigFlags flags) @extern("SetWindowState");

/**
 * Clear window configuration state flags
 */
extern fn void clear_window_state(ConfigFlags flags) @extern("ClearWindowState");

/**
 * Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
 */
extern fn void toggle_fullscreen() @extern("ToggleFullscreen");

/**
 * Toggle window state: borderless windowed (only PLATFORM_DESKTOP)
 */
extern fn void toggle_borderless_windowed() @extern("ToggleBorderlessWindowed");

/**
 * Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
 */
extern fn void maximize_window() @extern("MaximizeWindow");

/**
 * Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
 */
extern fn void minimize_window() @extern("MinimizeWindow");

/**
 * Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
 */
extern fn void restore_window() @extern("RestoreWindow");

/**
 * Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
 */
extern fn void set_window_icon(Image image) @extern("SetWindowIcon");

/**
 * Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
 */
fn void set_window_icons(List(<Image>) images) @inline {
    __set_window_icons(images.entries, (int)images.len());
}

/**
 * Set title for window (only PLATFORM_DESKTOP and PLATFORM_WEB)
 */
extern fn void set_window_title(ZString title) @extern("SetWindowTitle");

/**
 * Set window position on screen (only PLATFORM_DESKTOP)
 */
extern fn void set_window_position(int x, int y) @extern("SetWindowPosition");

/**
 * Set monitor for the current window
 */
extern fn void set_window_monitor(int monitor) @extern("SetWindowMonitor");

/**
 * Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
 */
extern fn void set_window_min_size(int width, int height) @extern("SetWindowMinSize");

/**
 * Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
 */
extern fn void set_window_max_size(int width, int height) @extern("SetWindowMaxSize");

/**
 * Set window dimensions
 */
extern fn void set_window_size(int width, int height) @extern("SetWindowSize");

/**
 * Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
 */
extern fn void set_window_opacity(float opacity) @extern("SetWindowOpacity");

/**
 * Set window focused (only PLATFORM_DESKTOP)
 */
extern fn void set_window_focused() @extern("SetWindowFocused");

/**
 * Get native window handle
 */
extern fn void* get_window_handle() @extern("GetWindowHandle");

/**
 * Get current screen width
 */
extern fn int get_screen_width() @extern("GetScreenWidth");

/**
 * Get current screen height
 */
extern fn int get_screen_height() @extern("GetScreenHeight");

/**
 * Get current render width (it considers HiDPI)
 */
extern fn int get_render_width() @extern("GetRenderWidth");

/**
 * Get current render height (it considers HiDPI)
 */
extern fn int get_render_height() @extern("GetRenderHeight");

/**
 * Get number of connected monitors
 */
extern fn int get_monitor_count() @extern("GetMonitorCount");

/**
 * Get current connected monitor
 */
extern fn int get_current_monitor() @extern("GetCurrentMonitor");

/**
 * Get specified monitor position
 */
extern fn Vector2 get_monitor_position(int monitor) @extern("GetMonitorPosition");

/**
 * Get specified monitor width (current video mode used by monitor)
 */
extern fn int get_monitor_width(int monitor) @extern("GetMonitorWidth");

/**
 * Get specified monitor height (current video mode used by monitor)
 */
extern fn int get_monitor_height(int monitor) @extern("GetMonitorHeight");

/**
 * Get specified monitor physical width in millimetres
 */
extern fn int get_monitor_physical_width(int monitor) @extern("GetMonitorPhysicalWidth");

/**
 * Get specified monitor physical height in millimetres
 */
extern fn int get_monitor_physical_height(int monitor) @extern("GetMonitorPhysicalHeight");

/**
 * Get specified monitor refresh rate
 */
extern fn int get_monitor_refresh_rate(int monitor) @extern("GetMonitorRefreshRate");

/**
 * Get window position XY on monitor
 */
extern fn Vector2 get_window_position() @extern("GetWindowPosition");

/**
 * Get window scale DPI factor
 */
extern fn Vector2 get_window_scale_dpi() @extern("GetWindowScaleDPI");

/**
 * Get the human-readable, UTF-8 encoded name of the specified monitor
 */
extern fn ZString get_monitor_name(int monitor) @extern("GetMonitorName");

/**
 * Set clipboard text content
 */
extern fn void set_clipboard_text(ZString text) @extern("SetClipboardText");

/**
 * Get clipboard text content
 */
extern fn ZString get_clipboard_text() @extern("GetClipboardText");

/**
 * Enable waiting for events on EndDrawing(), no automatic event polling
 */
extern fn void enable_event_waiting() @extern("EnableEventWaiting");

/**
 * Disable waiting for events on EndDrawing(), automatic events polling
 */
extern fn void disable_event_waiting() @extern("DisableEventWaiting");

// Cursor-related functions
//------------------------------------------------------------------------------------

/**
 * Shows cursor
 */
extern fn void show_cursor() @extern("ShowCursor");

/**
 * Hides cursor
 */
extern fn void hide_cursor() @extern("HideCursor");

/**
 * Check if cursor is not visible
 */
extern fn bool is_cursor_hidden() @extern("IsCursorHidden");

/**
 * Enables cursor (unlock cursor)
 */
extern fn void enable_cursor() @extern("EnableCursor");

/**
 * Disables cursor (lock cursor)
 */
extern fn void disable_cursor() @extern("DisableCursor");

/**
 * Check if cursor is on the screen
 */
extern fn bool is_cursor_on_screen() @extern("IsCursorOnScreen");

// Drawing-related functions
//------------------------------------------------------------------------------------

/**
 * Set background color (framebuffer clear color)
 */
extern fn void clear_background(Color color) @extern("ClearBackground");

/**
 * Setup canvas (framebuffer) to start drawing
 */
extern fn void begin_drawing() @extern("BeginDrawing");

/**
 * End canvas drawing and swap buffers (double buffering)
 */
extern fn void end_drawing() @extern("EndDrawing");

/**
 * Begin 2D mode with custom camera (2D)
 */
extern fn void begin_mode2d(Camera2D camera) @extern("BeginMode2D");

/**
 * Ends 2D mode with custom camera
 */
extern fn void end_mode2d() @extern("EndMode2D");

/**
 * Begin 3D mode with custom camera (3D)
 */
extern fn void begin_mode3d(Camera3D camera) @extern("BeginMode3D");

/**
 * Ends 3D mode and returns to default 2D orthographic mode
 */
extern fn void end_mode3d() @extern("EndMode3D");

/**
 * Begin drawing to render texture
 */
extern fn void begin_texture_mode(RenderTexture2D target) @extern("BeginTextureMode");

/**
 * Ends drawing to render texture
 */
extern fn void end_texture_mode() @extern("EndTextureMode");

/**
 * Begin custom shader drawing
 */
extern fn void begin_shader_mode(Shader shader) @extern("BeginShaderMode");

/**
 * End custom shader drawing (use default shader)
 */
extern fn void end_shader_mode() @extern("EndShaderMode");

/**
 * Begin blending mode (alpha, additive, multiplied, subtract, custom)
 */
extern fn void begin_blend_mode(BlendMode mode) @extern("BeginBlendMode");

/**
 * End blending mode (reset to default: alpha blending)
 */
extern fn void end_blend_mode() @extern("EndBlendMode");

/**
 * Begin scissor mode (define screen area for following drawing)
 */
extern fn void begin_scissor_mode(int x, int y, int width, int height) @extern("BeginScissorMode");

/**
 * End scissor mode
 */
extern fn void end_scissor_mode() @extern("EndScissorMode");

/**
 * Begin stereo rendering (requires VR simulator)
 */
extern fn void begin_vr_stereo_mode(VrStereoConfig config) @extern("BeginVrStereoMode");

/**
 * End stereo rendering (requires VR simulator)
 */
extern fn void end_vr_stereo_mode() @extern("EndVrStereoMode");

// VR stereo config functions for VR simulator
//------------------------------------------------------------------------------------

/**
 * Load VR stereo config for VR simulator device parameters
 */
extern fn VrStereoConfig load_vr_stereo_config(VrDeviceInfo device) @extern("LoadVrStereoConfig");

/**
 * Unload VR stereo config
 */
extern fn void unload_vr_stereo_config(VrStereoConfig config) @extern("UnloadVrStereoConfig");

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
//------------------------------------------------------------------------------------

/**
 * Load shader from files and bind default locations
 */
extern fn Shader load_shader(ZString vs_file_name, ZString fs_file_name) @extern("LoadShader");

/**
 * Load shader from code strings and bind default locations
 */
extern fn Shader load_shader_from_memory(ZString vs_code, ZString fs_code) @extern("LoadShaderFromMemory");

/**
 * Check if a shader is ready
 */
extern fn bool is_shader_ready(Shader shader) @extern("IsShaderReady");

/**
 * Get shader uniform location
 */
fn int! get_shader_location(Shader shader, ZString uniform_name) @inline {
    int loc = __get_shader_location(shader, uniform_name);
    return loc == -1 ? SearchResult.MISSING? : loc;
}

/**
 * Get shader attribute location
 */
fn int! get_shader_location_attrib(Shader shader, ZString attrib_name) @inline {
    int loc = __get_shader_location_attrib(shader, attrib_name);
    return loc == -1 ? SearchResult.MISSING? : loc;
}

/**
 * Set shader uniform value
 */
extern fn void set_shader_value(Shader shader, int loc_index, void* value, ShaderUniformDataType uniform_type) @extern("SetShaderValue");

/**
 * Set shader uniform value vector
 */
extern fn void set_shader_value_v(Shader shader, int locIndex, void* value, ShaderUniformDataType uniform_type, int count) @extern("SetShaderValueV");

/**
 * Set shader uniform value (matrix 4x4)
 */
extern fn void set_shader_value_matrix(Shader shader, int locIndex, Matrix mat) @extern("SetShaderValueMatrix");

/**
 * Set shader uniform value for texture (sampler2d)
 */
extern fn void set_shader_value_texture(Shader shader, int locIndex, Texture2D texture) @extern("SetShaderValueTexture");

/**
 * Unload shader from GPU memory (VRAM)
 */
extern fn void unload_shader(Shader shader) @extern("UnloadShader");

// Screen-space-related functions
//------------------------------------------------------------------------------------

/**
 * Get a ray trace from mouse position
 */
extern fn Ray get_mouse_ray(Vector2 mousePosition, Camera camera) @extern("GetMouseRay");

/**
 * Get camera transform matrix (view matrix)
 */
extern fn Matrix get_camera_matrix(Camera camera) @extern("GetCameraMatrix");

/**
 * Get camera 2d transform matrix
 */
extern fn Matrix get_camera_matrix2_d(Camera2D camera) @extern("GetCameraMatrix2D");

/**
 * Get the screen space position for a 3d world space position
 */
extern fn Vector2 get_world_to_screen(Vector3 position, Camera camera) @extern("GetWorldToScreen");

/**
 * Get the world space position for a 2d camera screen space position
 */
extern fn Vector2 get_screen_to_world2_d(Vector2 position, Camera2D camera) @extern("GetScreenToWorld2D");

/**
 * Get size position for a 3d world space position
 */
extern fn Vector2 get_world_to_screen_ex(Vector3 position, Camera camera, int width, int height) @extern("GetWorldToScreenEx");

/**
 * Get the screen space position for a 2d camera world space position
 */
extern fn Vector2 get_world_to_screen2_d(Vector2 position, Camera2D camera) @extern("GetWorldToScreen2D");

// Timing-related functions
//------------------------------------------------------------------------------------

/**
 * Set target FPS (maximum)
 */
extern fn void set_target_fps(int fps) @extern("SetTargetFPS");

/**
 * Get time in seconds for last frame drawn (delta time)
 */
extern fn float get_frame_time() @extern("GetFrameTime");

/**
 * Get elapsed time in seconds since InitWindow()
 */
extern fn double get_time() @extern("GetTime");

/**
 * Get current FPS
 */
extern fn int get_fps() @extern("GetFPS");

// Custom frame control functions
// NOTE: Those functions are intended for advance users that want full control over the frame processing
// By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
// To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
//------------------------------------------------------------------------------------

/**
 * Swap back buffer with front buffer (screen drawing)
 */
extern fn void swap_screen_buffer() @extern("SwapScreenBuffer");

/**
 * Register all input events
 */
extern fn void poll_input_events() @extern("PollInputEvents");

/**
 * Wait for some time (halt program execution)
 */
extern fn void wait_time(double seconds) @extern("WaitTime");

// Random values generation functions
//------------------------------------------------------------------------------------
bool is_random_initialized @local @if($feature(SUPPORT_RANDOM_GENERATION)) = false; // WARNING: required if raylib was configured with SUPPORT_RPRAND_GENERATOR
/**
 * Set the seed for the random number generator
 */
extern fn void set_random_seed(uint seed) @extern("SetRandomSeed") @if($feature(SUPPORT_RANDOM_GENERATION)) ;

/**
 * Get a random value between min and max (both included)
 */
fn int get_random_value(int min, int max) @inline @if($feature(SUPPORT_RANDOM_GENERATION)) {
    $if $defined(is_random_initialized):
        if (!is_random_initialized) {
            set_random_seed(0);
            is_random_initialized = true;
        }
    $endif
    return get_random_value(min, max);
}

/**
 * Load random values sequence, no values repeated
 */
fn int[] load_random_sequence(uint count, int min, int max) @inline @if($feature(SUPPORT_RANDOM_GENERATION)) {
    $if $defined(is_random_initialized):
        if (!is_random_initialized) {
            set_random_seed(0);
            is_random_initialized = true;
        }
    $endif
    return __load_random_sequence(count, min, max)[:(usz)count];
}

/**
 * Unload random values sequence
 */
fn void unload_random_sequence(int[] sequence) @inline @if($feature(SUPPORT_RANDOM_GENERATION)) {
    return __unload_random_sequence(sequence.ptr);
}

// Misc. functions
//------------------------------------------------------------------------------------

/**
 * Takes a screenshot of current screen (filename extension defines format)
 */
extern fn void take_screenshot(ZString file_name) @extern("TakeScreenshot");

/**
 * Setup init configuration flags (view FLAGS)
 */
extern fn void set_config_flags(uint flags) @extern("SetConfigFlags");

/**
 * Open URL with default system browser (if available)
 */
extern fn void open_url(ZString url) @extern("OpenURL");

// NOTE: Following functions implemented in module [utils]
//------------------------------------------------------------------

/**
 * Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
 */
extern fn void trace_log(TraceLogLevel logLevel, ZString text, ...) @extern("TraceLog");

/**
 * Set the current threshold (minimum) log level
 */
extern fn void set_trace_log_level(TraceLogLevel logLevel) @extern("SetTraceLogLevel");

/**
 * Internal memory allocator
 */
extern fn void* mem_alloc(uint size) @extern("MemAlloc") @if($feature(SUPPORT_MEMORY_MANAGEMENT));

/**
 * Internal memory reallocator
 */
extern fn void* mem_realloc(void* ptr, uint size) @extern("MemRealloc") @if($feature(SUPPORT_MEMORY_MANAGEMENT));

/**
 * Internal memory free
 */
extern fn void mem_free(void* ptr) @extern("MemFree") @if($feature(SUPPORT_MEMORY_MANAGEMENT));

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
//------------------------------------------------------------------------------------

/**
 * Set custom file binary data loader
 */
extern fn void set_load_file_data_callback(LoadFileDataCallback callback) @extern("SetLoadFileDataCallback") @if($feature(SUPPORT_STANDARD_FILEIO));

/**
 * Set custom file binary data saver
 */
extern fn void set_save_file_data_callback(SaveFileDataCallback callback) @extern("SetSaveFileDataCallback") @if($feature(SUPPORT_STANDARD_FILEIO));

/**
 * Set custom file text data loader
 */
extern fn void set_load_file_text_callback(LoadFileTextCallback callback) @extern("SetLoadFileTextCallback") @if($feature(SUPPORT_STANDARD_FILEIO));

/**
 * Set custom file text data saver
 */
extern fn void set_save_file_text_callback(SaveFileTextCallback callback) @extern("SetSaveFileTextCallback") @if($feature(SUPPORT_STANDARD_FILEIO));

// Files management functions
//------------------------------------------------------------------------------------

/**
 * Load file data as byte array (read)
 */
fn char[] load_file_data(ZString file_name) @inline @if($feature(SUPPORT_STANDARD_FILEIO)) {
    int len = 0;
    char* ptr = __load_file_data(file_name, &len);
    return ptr[:(usz)len];
}

/**
 * Unload file data allocated by LoadFileData()
 */
fn void unload_file_data(char[] data) @inline @if($feature(SUPPORT_STANDARD_FILEIO)) {
    __unload_file_data(data.ptr);
}

/**
 * Save data to file from byte array (write), returns true on success
 */
extern fn bool save_file_data(ZString file_name, void* data, int data_size) @extern("SaveFileData") @if($feature(SUPPORT_STANDARD_FILEIO));

// TODO: review
/**
 * Export data to code (.h), returns true on success
 */
macro bool export_data_as_code(ZString file_name, char[] data) @if($feature(SUPPORT_STANDARD_FILEIO)) {
    return __export_data_as_code(data.ptr, data.len, file_name);
}

/**
 * Load text data from file (read), returns a '\0' terminated string
 */
fn ZString! load_file_text(ZString file_name) @inline @if($feature(SUPPORT_STANDARD_FILEIO)) {
    char* zstr = __load_file_text(file_name);
    return zstr == null ? io::IoError.UNKNOWN_ERROR? : (ZString)zstr;
}

/**
 * Unload file text data allocated by LoadFileText()
 */
extern fn void unload_file_text(ZString text) @extern("UnloadFileText") @if($feature(SUPPORT_STANDARD_FILEIO));

/**
 * Save text data to file (write), string must be '\0' terminated, returns true on success
 */
extern fn bool save_file_text(ZString file_name, ZString text) @extern("SaveFileText") @if($feature(SUPPORT_STANDARD_FILEIO));
//------------------------------------------------------------------

// File system functions
//------------------------------------------------------------------------------------

/**
 * Check if file exists
 */
extern fn bool file_exists(ZString file_name) @extern("FileExists") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Check if a directory path exists
 */
extern fn bool directory_exists(ZString dir_path) @extern("DirectoryExists") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Check file extension (including point: .png, .wav)
 */
extern fn bool is_file_extension(ZString file_name, ZString ext) @extern("IsFileExtension") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
 */
extern fn int get_file_length(ZString file_name) @extern("GetFileLength") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Get pointer to extension for a filename string (includes dot: '.png')
 */
extern fn ZString get_file_extension(ZString file_name) @extern("GetFileExtension") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Get pointer to filename for a path string
 */
extern fn ZString get_file_name(ZString file_path) @extern("GetFileName") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Get filename string without extension (uses static string)
 */
extern fn ZString get_file_name_without_ext(ZString file_path) @extern("GetFileNameWithoutExt") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Get full path for a given fileName with path (uses static string)
 */
extern fn ZString get_directory_path(ZString file_path) @extern("GetDirectoryPath") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Get previous directory path for a given path (uses static string)
 */
extern fn ZString get_prev_directory_path(ZString dir_path) @extern("GetPrevDirectoryPath") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Get current working directory (uses static string)
 */
extern fn ZString get_working_directory() @extern("GetWorkingDirectory") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Get the directory of the running application (uses static string)
 */
extern fn ZString get_application_directory() @extern("GetApplicationDirectory") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Change working directory, return true on success
 */
extern fn bool change_directory(ZString dir) @extern("ChangeDirectory") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Check if a given path is a file or a directory
 */
extern fn bool is_path_file(ZString path) @extern("IsPathFile") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Load directory filepaths
 */
extern fn FilePathList load_directory_files(ZString  dir_path) @extern("LoadDirectoryFiles") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Load directory filepaths with extension filtering and recursive directory scan
 */
extern fn FilePathList load_directory_files_ex(ZString base_path, ZString filter, bool scan_subdirs) @extern("LoadDirectoryFilesEx") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Unload filepaths
 */
extern fn void unload_directory_files(FilePathList files) @extern("UnloadDirectoryFiles") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Check if a file has been dropped into window
 */
extern fn bool is_file_dropped() @extern("IsFileDropped") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Load dropped filepaths
 */
extern fn FilePathList load_dropped_files() @extern("LoadDroppedFiles") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Unload dropped filepaths
 */
extern fn void unload_dropped_files(FilePathList files) @extern("UnloadDroppedFiles") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

/**
 * Get file modification time (last write time)
 */
extern fn long get_file_mod_time(ZString file_name) @extern("GetFileModTime") @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

// Compression/Encoding functionality
//------------------------------------------------------------------------------------
// INFO: add test units

/**
 * Compress data (DEFLATE algorithm), memory must be MemFree()
 */
fn char[] compress_data(char[] data) @inline {
    int size = 0;
    char* comp_data = __compress_data(data.ptr, data.len, &size);
    return comp_data[:(usz)size];
}

/**
 * Decompress data (DEFLATE algorithm), memory must be MemFree()
 */
fn char[] decompress_data(char[] comp_data) @inline {
    int size = 0;
    char* decomp_data = __decompress_data(comp_data.ptr, comp_data.len, &size);
    return decomp_data[:(usz)size];
}

/**
 * Encode data to Base64 string, memory must be MemFree()
 */
macro char[] encode_data_base64(char[] data) @if($feature(SUPPORT_DATA_ENCODER)) {
    int size = 0;
    char* encoded_data = __encode_data_base64(data.ptr, data.len, &size);
    return encoded_data[:(usz)size];
}

/**
 * Decode Base64 string data, memory must be MemFree()
 */
macro char[] decode_data_base64(char[] data) @if($feature(SUPPORT_DATA_ENCODER)) {
    int size = 0;
    char* decoded_data = __decode_data_base64(data.ptr, &size);
    return decoded_data[:(usz)size];
}

// Automation events functionality
//------------------------------------------------------------------------------------

/**
 * Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
 */
extern fn AutomationEventList load_automation_event_list(ZString file_name) @extern("LoadAutomationEventList");

/**
 * Unload automation events list from file
 */
extern fn void unload_automation_event_list(AutomationEventList* list) @extern("UnloadAutomationEventList");

/**
 * Export automation events list as text file
 */
extern fn bool export_automation_event_list(AutomationEventList list, ZString file_name) @extern("ExportAutomationEventList");

/**
 * Set automation event list to record to
 */
extern fn void set_automation_event_list(AutomationEventList* list) @extern("SetAutomationEventList");

/**
 * Set automation event internal base frame to start recording
 */
extern fn void set_automation_event_base_frame(int frame) @extern("SetAutomationEventBaseFrame");

/**
 * Start recording automation events (AutomationEventList must be set)
 */
extern fn void start_automation_event_recording() @extern("StartAutomationEventRecording");

/**
 * Stop recording automation events
 */
extern fn void stop_automation_event_recording() @extern("StopAutomationEventRecording");

/**
 * Play a recorded automation event
 */
extern fn void play_automation_event(AutomationEvent event) @extern("PlayAutomationEvent");

