// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Window and Graphics Device Functions (Module: core)
//------------------------------------------------------------------------------------

// Window-related functions
//------------------------------------------------------------------------------------
// Initialize window and OpenGL context
fn void init_window(int width, int height, ZString title) @extern("InitWindow");
// Close window and unload OpenGL context
fn void close_window() @extern("CloseWindow");
// Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
fn bool window_should_close() @extern("WindowShouldClose");
// Check if window has been initialized successfully
fn bool is_window_ready() @extern("IsWindowReady");
// Check if window is currently fullscreen
fn bool is_window_fullscreen() @extern("IsWindowFullscreen");
// Check if window is currently hidden (only PLATFORM_DESKTOP)
fn bool is_window_hidden() @extern("IsWindowHidden");
// Check if window is currently minimized (only PLATFORM_DESKTOP)
fn bool is_window_minimized() @extern("IsWindowMinimized");
// Check if window is currently maximized (only PLATFORM_DESKTOP)
fn bool is_window_maximized() @extern("IsWindowMaximized");
// Check if window is currently focused (only PLATFORM_DESKTOP)
fn bool is_window_focused() @extern("IsWindowFocused");
// Check if window has been resized last frame
fn bool is_window_resized() @extern("IsWindowResized");
// Check if one specific window flag is enabled
fn bool is_window_state(ConfigFlags flag) @extern("IsWindowState");
// Set window configuration state using flags (only PLATFORM_DESKTOP)
fn void set_window_state(ConfigFlags flags) @extern("SetWindowState");
// Clear window configuration state flags
fn void clear_window_state(ConfigFlags flags) @extern("ClearWindowState");
// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
fn void toggle_fullscreen() @extern("ToggleFullscreen");
// Toggle window state: borderless windowed (only PLATFORM_DESKTOP)
fn void toggle_borderless_windowed() @extern("ToggleBorderlessWindowed");
// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
fn void maximize_window() @extern("MaximizeWindow");
// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
fn void minimize_window() @extern("MinimizeWindow");
// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
fn void restore_window() @extern("RestoreWindow");
// Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
fn void set_window_icon(Image image) @extern("SetWindowIcon");
// Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
fn void set_window_icons(Image* images, int count) @extern("SetWindowIcons");
// Set title for window (only PLATFORM_DESKTOP and PLATFORM_WEB)
fn void set_window_title(ZString title) @extern("SetWindowTitle");
// Set window position on screen (only PLATFORM_DESKTOP)
fn void set_window_position(int x, int y) @extern("SetWindowPosition");
// Set monitor for the current window
fn void set_window_monitor(int monitor) @extern("SetWindowMonitor");
// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
fn void set_window_min_size(int width, int height) @extern("SetWindowMinSize");
// Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
fn void set_window_max_size(int width, int height) @extern("SetWindowMaxSize");
// Set window dimensions
fn void set_window_size(int width, int height) @extern("SetWindowSize");
// Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
fn void set_window_opacity(float opacity) @extern("SetWindowOpacity");
// Set window focused (only PLATFORM_DESKTOP)
fn void set_window_focused() @extern("SetWindowFocused");
// Get native window handle
fn void* get_window_handle() @extern("GetWindowHandle");
// Get current screen width
fn int get_screen_width() @extern("GetScreenWidth");
// Get current screen height
fn int get_screen_height() @extern("GetScreenHeight");
// Get current render width (it considers HiDPI)
fn int get_render_width() @extern("GetRenderWidth");
// Get current render height (it considers HiDPI)
fn int get_render_height() @extern("GetRenderHeight");
// Get number of connected monitors
fn int get_monitor_count() @extern("GetMonitorCount");
// Get current connected monitor
fn int get_current_monitor() @extern("GetCurrentMonitor");
// Get specified monitor position
fn Vector2 get_monitor_position(int monitor) @extern("GetMonitorPosition");
// Get specified monitor width (current video mode used by monitor)
fn int get_monitor_width(int monitor) @extern("GetMonitorWidth");
// Get specified monitor height (current video mode used by monitor)
fn int get_monitor_height(int monitor) @extern("GetMonitorHeight");
// Get specified monitor physical width in millimetres
fn int get_monitor_physical_width(int monitor) @extern("GetMonitorPhysicalWidth");
// Get specified monitor physical height in millimetres
fn int get_monitor_physical_height(int monitor) @extern("GetMonitorPhysicalHeight");
// Get specified monitor refresh rate
fn int get_monitor_refresh_rate(int monitor) @extern("GetMonitorRefreshRate");
// Get window position XY on monitor
fn Vector2 get_window_position() @extern("GetWindowPosition");
// Get window scale DPI factor
fn Vector2 get_window_scale_dpi() @extern("GetWindowScaleDPI");
// Get the human-readable, UTF-8 encoded name of the specified monitor
fn ZString get_monitor_name(int monitor) @extern("GetMonitorName");
// Set clipboard text content
fn void set_clipboard_text(ZString text) @extern("SetClipboardText");
// Get clipboard text content
fn ZString get_clipboard_text() @extern("GetClipboardText");
// Enable waiting for events on EndDrawing(), no automatic event polling
fn void enable_event_waiting() @extern("EnableEventWaiting");
// Disable waiting for events on EndDrawing(), automatic events polling
fn void disable_event_waiting() @extern("DisableEventWaiting");

// Cursor-related functions
//------------------------------------------------------------------------------------
// Shows cursor
fn void show_cursor() @extern("ShowCursor");
// Hides cursor
fn void hide_cursor() @extern("HideCursor");
// Check if cursor is not visible
fn bool is_cursor_hidden() @extern("IsCursorHidden");
// Enables cursor (unlock cursor)
fn void enable_cursor() @extern("EnableCursor");
// Disables cursor (lock cursor)
fn void disable_cursor() @extern("DisableCursor");
// Check if cursor is on the screen
fn bool is_cursor_on_screen() @extern("IsCursorOnScreen");

// Drawing-related functions
//------------------------------------------------------------------------------------
// Set background color (framebuffer clear color)
fn void clear_background(Color color) @extern("ClearBackground");
// Setup canvas (framebuffer) to start drawing
fn void begin_drawing() @extern("BeginDrawing");
// End canvas drawing and swap buffers (double buffering)
fn void end_drawing() @extern("EndDrawing");
// Begin 2D mode with custom camera (2D)
fn void begin_mode2_d(Camera2D camera) @extern("BeginMode2D");
// Ends 2D mode with custom camera
fn void end_mode2_d() @extern("EndMode2D");
// Begin 3D mode with custom camera (3D)
fn void begin_mode3_d(Camera3D camera) @extern("BeginMode3D");
// Ends 3D mode and returns to default 2D orthographic mode
fn void end_mode3_d() @extern("EndMode3D");
// Begin drawing to render texture
fn void begin_texture_mode(RenderTexture2D target) @extern("BeginTextureMode");
// Ends drawing to render texture
fn void end_texture_mode() @extern("EndTextureMode");
// Begin custom shader drawing
fn void begin_shader_mode(Shader shader) @extern("BeginShaderMode");
// End custom shader drawing (use default shader)
fn void end_shader_mode() @extern("EndShaderMode");
// Begin blending mode (alpha, additive, multiplied, subtract, custom)
fn void begin_blend_mode(int mode) @extern("BeginBlendMode");
// End blending mode (reset to default: alpha blending)
fn void end_blend_mode() @extern("EndBlendMode");
// Begin scissor mode (define screen area for following drawing)
fn void begin_scissor_mode(int x, int y, int width, int height) @extern("BeginScissorMode");
// End scissor mode
fn void end_scissor_mode() @extern("EndScissorMode");
// Begin stereo rendering (requires VR simulator)
fn void begin_vr_stereo_mode(VrStereoConfig config) @extern("BeginVrStereoMode");
// End stereo rendering (requires VR simulator)
fn void end_vr_stereo_mode() @extern("EndVrStereoMode");

// VR stereo config functions for VR simulator
//------------------------------------------------------------------------------------
// Load VR stereo config for VR simulator device parameters
fn VrStereoConfig load_vr_stereo_config(VrDeviceInfo device) @extern("LoadVrStereoConfig");
// Unload VR stereo config
fn void unload_vr_stereo_config(VrStereoConfig config) @extern("UnloadVrStereoConfig");

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
//------------------------------------------------------------------------------------
// Load shader from files and bind default locations
fn Shader load_shader(ZString vs_file_name, ZString fs_file_name) @extern("LoadShader");
// Load shader from code strings and bind default locations
fn Shader load_shader_from_memory(ZString vs_code, ZString fs_code) @extern("LoadShaderFromMemory");
// Check if a shader is ready
fn bool is_shader_ready(Shader shader) @extern("IsShaderReady");
// Get shader uniform location
fn int get_shader_location(Shader shader, ZString uniform_name) @extern("GetShaderLocation");
// Get shader attribute location
fn int get_shader_location_attrib(Shader shader, ZString attrib_name) @extern("GetShaderLocationAttrib");
// Set shader uniform value
fn void set_shader_value(Shader shader, int loc_index, void* value, int uniform_type) @extern("SetShaderValue");
// Set shader uniform value vector
fn void set_shader_value_v(Shader shader, int locIndex, void* value, int uniform_type, int count) @extern("SetShaderValueV");
// Set shader uniform value (matrix 4x4)
fn void set_shader_value_matrix(Shader shader, int locIndex, Matrix mat) @extern("SetShaderValueMatrix");
// Set shader uniform value for texture (sampler2d)
fn void set_shader_value_texture(Shader shader, int locIndex, Texture2D texture) @extern("SetShaderValueTexture");
// Unload shader from GPU memory (VRAM)
fn void unload_shader(Shader shader) @extern("UnloadShader");

// Screen-space-related functions
//------------------------------------------------------------------------------------
// Get a ray trace from mouse position
fn Ray get_mouse_ray(Vector2 mousePosition, Camera camera) @extern("GetMouseRay");
// Get camera transform matrix (view matrix)
fn Matrix get_camera_matrix(Camera camera) @extern("GetCameraMatrix");
// Get camera 2d transform matrix
fn Matrix get_camera_matrix2_d(Camera2D camera) @extern("GetCameraMatrix2D");
// Get the screen space position for a 3d world space position
fn Vector2 get_world_to_screen(Vector3 position, Camera camera) @extern("GetWorldToScreen");
// Get the world space position for a 2d camera screen space position
fn Vector2 get_screen_to_world2_d(Vector2 position, Camera2D camera) @extern("GetScreenToWorld2D");
// Get size position for a 3d world space position
fn Vector2 get_world_to_screen_ex(Vector3 position, Camera camera, int width, int height) @extern("GetWorldToScreenEx");
// Get the screen space position for a 2d camera world space position
fn Vector2 get_world_to_screen2_d(Vector2 position, Camera2D camera) @extern("GetWorldToScreen2D");

// Timing-related functions
//------------------------------------------------------------------------------------
// Set target FPS (maximum)
fn void set_target_fps(int fps) @extern("SetTargetFPS");
// Get time in seconds for last frame drawn (delta time)
fn float get_frame_time() @extern("GetFrameTime");
// Get elapsed time in seconds since InitWindow()
fn double get_time() @extern("GetTime");
// Get current FPS
fn int get_fps() @extern("GetFPS");

// Custom frame control functions
// NOTE: Those functions are intended for advance users that want full control over the frame processing
// By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
// To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
//------------------------------------------------------------------------------------
// Swap back buffer with front buffer (screen drawing)
fn void swap_screen_buffer() @extern("SwapScreenBuffer");
// Register all input events
fn void poll_input_events() @extern("PollInputEvents");
// Wait for some time (halt program execution)
fn void wait_time(double seconds) @extern("WaitTime");

// Random values generation functions
//------------------------------------------------------------------------------------
// Set the seed for the random number generator
fn void set_random_seed(uint seed) @extern("SetRandomSeed");
// Get a random value between min and max (both included)
fn int get_random_value(int min, int max) @extern("GetRandomValue");
// Load random values sequence, no values repeated
fn int* load_random_sequence(uint count, int min, int max) @extern("LoadRandomSequence");
// Unload random values sequence
fn void unload_random_sequence(int* sequence) @extern("UnloadRandomSequence");

// Misc. functions
//------------------------------------------------------------------------------------
// Takes a screenshot of current screen (filename extension defines format)
fn void take_screenshot(ZString file_name) @extern("TakeScreenshot");
// Setup init configuration flags (view FLAGS)
fn void set_config_flags(uint flags) @extern("SetConfigFlags");
// Open URL with default system browser (if available)
fn void open_url(ZString url) @extern("OpenURL");

// NOTE: Following functions implemented in module [utils]
//------------------------------------------------------------------
// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
fn void trace_log(TraceLogLevel logLevel, ZString text, ...) @extern("TraceLog");
// Set the current threshold (minimum) log level
fn void set_trace_log_level(TraceLogLevel logLevel) @extern("SetTraceLogLevel");
// Internal memory allocator
fn void* mem_alloc(uint size) @extern("MemAlloc");
// Internal memory reallocator
fn void* mem_realloc(void* ptr, uint size) @extern("MemRealloc");
// Internal memory free
fn void mem_free(void* ptr) @extern("MemFree");

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
//------------------------------------------------------------------------------------
// Set custom file binary data loader
fn void set_load_file_data_callback(LoadFileDataCallback callback) @extern("SetLoadFileDataCallback");
// Set custom file binary data saver
fn void set_save_file_data_callback(SaveFileDataCallback callback) @extern("SetSaveFileDataCallback");
// Set custom file text data loader
fn void set_load_file_text_callback(LoadFileTextCallback callback) @extern("SetLoadFileTextCallback");
// Set custom file text data saver
fn void set_save_file_text_callback(SaveFileTextCallback callback) @extern("SetSaveFileTextCallback");

// Files management functions
//------------------------------------------------------------------------------------
// Load file data as byte array (read)
fn char* load_file_data(ZString file_name, int* data_size) @extern("LoadFileData");
// Unload file data allocated by LoadFileData()
fn void unload_file_data(ZString data) @extern("UnloadFileData");
// Save data to file from byte array (write), returns true on success
fn bool save_file_data(ZString file_name, void* data, int data_size) @extern("SaveFileData");
// Export data to code (.h), returns true on success
fn bool export_data_as_code(ZString data, int data_size, ZString file_name) @extern("ExportDataAsCode");
// Load text data from file (read), returns a '\0' terminated string
fn char* load_file_text(ZString file_name) @extern("LoadFileText");
// Unload file text data allocated by LoadFileText()
fn void unload_file_text(ZString text) @extern("UnloadFileText");
// Save text data to file (write), string must be '\0' terminated, returns true on success
fn bool save_file_text(ZString file_name, ZString text) @extern("SaveFileText");
//------------------------------------------------------------------

// File system functions
//------------------------------------------------------------------------------------
// Check if file exists
fn bool file_exists(ZString file_name) @extern("FileExists");
// Check if a directory path exists
fn bool directory_exists(ZString dir_path) @extern("DirectoryExists");
// Check file extension (including point: .png, .wav)
fn bool is_file_extension(ZString file_name, ZString ext) @extern("IsFileExtension");
// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
fn int get_file_length(ZString file_name) @extern("GetFileLength");
// Get pointer to extension for a filename string (includes dot: '.png')
fn ZString get_file_extension(ZString file_name) @extern("GetFileExtension");
// Get pointer to filename for a path string
fn ZString get_file_name(ZString file_path) @extern("GetFileName");
// Get filename string without extension (uses static string)
fn ZString get_file_name_without_ext(ZString file_path) @extern("GetFileNameWithoutExt");
// Get full path for a given fileName with path (uses static string)
fn ZString get_directory_path(ZString file_path) @extern("GetDirectoryPath");
// Get previous directory path for a given path (uses static string)
fn ZString get_prev_directory_path(ZString dir_path) @extern("GetPrevDirectoryPath");
// Get current working directory (uses static string)
fn ZString get_working_directory() @extern("GetWorkingDirectory");
// Get the directory of the running application (uses static string)
fn ZString get_application_directory() @extern("GetApplicationDirectory");
// Change working directory, return true on success
fn bool change_directory(ZString dir) @extern("ChangeDirectory");
// Check if a given path is a file or a directory
fn bool is_path_file(ZString path) @extern("IsPathFile");
// Load directory filepaths
fn FilePathList load_directory_files(ZString  dir_path) @extern("LoadDirectoryFiles");
// Load directory filepaths with extension filtering and recursive directory scan
fn FilePathList load_directory_files_ex(ZString base_path, ZString filter, bool scan_subdirs) @extern("LoadDirectoryFilesEx");
// Unload filepaths
fn void unload_directory_files(FilePathList files) @extern("UnloadDirectoryFiles");
// Check if a file has been dropped into window
fn bool is_file_dropped() @extern("IsFileDropped");
// Load dropped filepaths
fn FilePathList load_dropped_files() @extern("LoadDroppedFiles");
// Unload dropped filepaths
fn void unload_dropped_files(FilePathList files) @extern("UnloadDroppedFiles");
// Get file modification time (last write time)
fn long get_file_mod_time(ZString file_name) @extern("GetFileModTime");

// Compression/Encoding functionality
//------------------------------------------------------------------------------------
// Compress data (DEFLATE algorithm), memory must be MemFree()
fn char* compress_data(ZString data, int dataSize, int *comp_data_size) @extern("CompressData");
// Decompress data (DEFLATE algorithm), memory must be MemFree()
fn char* decompress_data(ZString comp_data, int comp_data_size, int *data_size) @extern("DecompressData");
// Encode data to Base64 string, memory must be MemFree()
fn char* encode_data_base64(ZString data, int data_size, int *outputSize) @extern("EncodeDataBase64");
// Decode Base64 string data, memory must be MemFree()
fn char* decode_data_base64(ZString data, int *output_size) @extern("DecodeDataBase64");

// Automation events functionality
//------------------------------------------------------------------------------------
// Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
fn AutomationEventList load_automation_event_list(ZString file_name) @extern("LoadAutomationEventList");
// Unload automation events list from file
fn void unload_automation_event_list(AutomationEventList* list) @extern("UnloadAutomationEventList");
// Export automation events list as text file
fn bool export_automation_event_list(AutomationEventList list, ZString file_name) @extern("ExportAutomationEventList");
// Set automation event list to record to
fn void set_automation_event_list(AutomationEventList* list) @extern("SetAutomationEventList");
// Set automation event internal base frame to start recording
fn void set_automation_event_base_frame(int frame) @extern("SetAutomationEventBaseFrame");
// Start recording automation events (AutomationEventList must be set)
fn void start_automation_event_recording() @extern("StartAutomationEventRecording");
// Stop recording automation events
fn void stop_automation_event_recording() @extern("StopAutomationEventRecording");
// Play a recorded automation event
fn void play_automation_event(AutomationEvent event) @extern("PlayAutomationEvent");

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
//------------------------------------------------------------------------------------
// Check if a key has been pressed once
fn bool is_key_pressed(KeyboardKey key) @extern("IsKeyPressed");
// Check if a key has been pressed again (Only PLATFORM_DESKTOP)
fn bool is_key_pressed_repeat(KeyboardKey key) @extern("IsKeyPressedRepeat");
// Check if a key is being pressed
fn bool is_key_down(KeyboardKey key) @extern("IsKeyDown");
// Check if a key has been released once
fn bool is_key_released(KeyboardKey key) @extern("IsKeyReleased");
// Check if a key is NOT being pressed
fn bool is_key_up(KeyboardKey key) @extern("IsKeyUp");
// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
fn KeyboardKey get_key_pressed() @extern("GetKeyPressed");
// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
fn KeyboardKey get_char_pressed() @extern("GetCharPressed");
// Set a custom key to exit program (default is ESC)
fn void set_exit_key(KeyboardKey key) @extern("SetExitKey");

// Input-related functions: gamepads
//------------------------------------------------------------------------------------
// Check if a gamepad is available
fn bool is_gamepad_available(int gamepad) @extern("IsGamepadAvailable");
// Get gamepad internal name id
fn ZString get_gamepad_name(int gamepad) @extern("GetGamepadName");
// Check if a gamepad button has been pressed once
fn bool is_gamepad_button_pressed(int gamepad, GamepadButton button) @extern("IsGamepadButtonPressed");
// Check if a gamepad button is being pressed
fn bool is_gamepad_button_down(int gamepad, GamepadButton button) @extern("IsGamepadButtonDown");
// Check if a gamepad button has been released once
fn bool is_gamepad_button_released(int gamepad, GamepadButton button) @extern("IsGamepadButtonReleased");
// Check if a gamepad button is NOT being pressed
fn bool is_gamepad_button_up(int gamepad, GamepadButton button) @extern("IsGamepadButtonUp");
// Get the last gamepad button pressed
fn int get_gamepad_button_pressed() @extern("GetGamepadButtonPressed");
// Get gamepad axis count for a gamepad
fn int get_gamepad_axis_count(int gamepad) @extern("GetGamepadAxisCount");
// Get axis movement value for a gamepad axis
fn float get_gamepad_axis_movement(int gamepad, int axis) @extern("GetGamepadAxisMovement");
// Set internal gamepad mappings (SDL_GameControllerDB)
fn int set_gamepad_mappings(ZString mappings) @extern("SetGamepadMappings");

// Input-related functions: mouse
//------------------------------------------------------------------------------------
// Check if a mouse button has been pressed once
fn bool is_mouse_button_pressed(MouseButton button) @extern("IsMouseButtonPressed");
// Check if a mouse button is being pressed
fn bool is_mouse_button_down(MouseButton button) @extern("IsMouseButtonDown");
// Check if a mouse button has been released once
fn bool is_mouse_button_released(MouseButton button) @extern("IsMouseButtonReleased");
// Check if a mouse button is NOT being pressed
fn bool is_mouse_button_up(MouseButton button) @extern("IsMouseButtonUp");
// Get mouse position X
fn int get_mouse_x() @extern("GetMouseX");
// Get mouse position Y
fn int get_mouse_y() @extern("GetMouseY");
// Get mouse position XY
fn Vector2 get_mouse_position() @extern("GetMousePosition");
// Get mouse delta between frames
fn Vector2 get_mouse_delta() @extern("GetMouseDelta");
// Set mouse position XY
fn void set_mouse_position(int x, int y) @extern("SetMousePosition");
// Set mouse offset
fn void set_mouse_offset(int offset_x, int offset_y) @extern("SetMouseOffset");
// Set mouse scaling
fn void set_mouse_scale(float scale_x, float scale_y) @extern("SetMouseScale");
// Get mouse wheel movement for X or Y, whichever is larger
fn float get_mouse_wheel_move() @extern("GetMouseWheelMove");
// Get mouse wheel movement for both X and Y
fn Vector2 get_mouse_wheel_move_v() @extern("GetMouseWheelMoveV");
// Set mouse cursor
fn void set_mouse_cursor(int cursor) @extern("SetMouseCursor");

// Input-related functions: touch
//------------------------------------------------------------------------------------
// Get touch position X for touch point 0 (relative to screen size)
fn int get_touch_x() @extern("GetTouchX");
// Get touch position Y for touch point 0 (relative to screen size)
fn int get_touch_y() @extern("GetTouchY");
// Get touch position XY for a touch point index (relative to screen size)
fn Vector2 get_touch_position(int index) @extern("GetTouchPosition");
// Get touch point identifier for given index
fn int get_touch_point_id(int index) @extern("GetTouchPointId");
// Get number of touch points
fn int get_touch_point_count() @extern("GetTouchPointCount");

