// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

/*

Index of this module:
// Input-related functions: keyboard
// Input-related functions: gamepads
// Input-related functions: mouse
// Input-related functions: touch

*/

// Input-related functions: keyboard
//------------------------------------------------------------------------------------

/**
 * Check if a key has been pressed once
 */
extern fn bool is_key_pressed(KeyboardKey key) @extern("IsKeyPressed");

/**
 * Check if a key has been pressed again (Only PLATFORM_DESKTOP)
 */
extern fn bool is_key_pressed_repeat(KeyboardKey key) @extern("IsKeyPressedRepeat");

/**
 * Check if a key is being pressed
 */
extern fn bool is_key_down(KeyboardKey key) @extern("IsKeyDown");

/**
 * Check if a key has been released once
 */
extern fn bool is_key_released(KeyboardKey key) @extern("IsKeyReleased");

/**
 * Check if a key is NOT being pressed
 */
extern fn bool is_key_up(KeyboardKey key) @extern("IsKeyUp");

/**
 * Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
 */
extern fn KeyboardKey get_key_pressed() @extern("GetKeyPressed");

/**
 * Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
 */
extern fn KeyboardKey get_char_pressed() @extern("GetCharPressed");

/**
 * Set a custom key to exit program (default is ESC)
 */
extern fn void set_exit_key(KeyboardKey key) @extern("SetExitKey");

// Input-related functions: gamepads
//------------------------------------------------------------------------------------

/**
 * Check if a gamepad is available
 */
extern fn bool is_gamepad_available(int gamepad) @extern("IsGamepadAvailable");

/**
 * Get gamepad internal name id
 */
extern fn ZString get_gamepad_name(int gamepad) @extern("GetGamepadName");

/**
 * Check if a gamepad button has been pressed once
 */
extern fn bool is_gamepad_button_pressed(int gamepad, GamepadButton button) @extern("IsGamepadButtonPressed");

/**
 * Check if a gamepad button is being pressed
 */
extern fn bool is_gamepad_button_down(int gamepad, GamepadButton button) @extern("IsGamepadButtonDown");

/**
 * Check if a gamepad button has been released once
 */
extern fn bool is_gamepad_button_released(int gamepad, GamepadButton button) @extern("IsGamepadButtonReleased");

/**
 * Check if a gamepad button is NOT being pressed
 */
extern fn bool is_gamepad_button_up(int gamepad, GamepadButton button) @extern("IsGamepadButtonUp");

/**
 * Get the last gamepad button pressed
 */
extern fn int get_gamepad_button_pressed() @extern("GetGamepadButtonPressed");

/**
 * Get gamepad axis count for a gamepad
 */
extern fn int get_gamepad_axis_count(int gamepad) @extern("GetGamepadAxisCount");

/**
 * Get axis movement value for a gamepad axis
 */
extern fn float get_gamepad_axis_movement(int gamepad, GamepadAxis axis) @extern("GetGamepadAxisMovement");

/**
 * Set internal gamepad mappings (SDL_GameControllerDB)
 */
extern fn int set_gamepad_mappings(ZString mappings) @extern("SetGamepadMappings");

// Input-related functions: mouse
//------------------------------------------------------------------------------------

/**
 * Check if a mouse button has been pressed once
 */
extern fn bool is_mouse_button_pressed(MouseButton button) @extern("IsMouseButtonPressed");

/**
 * Check if a mouse button is being pressed
 */
extern fn bool is_mouse_button_down(MouseButton button) @extern("IsMouseButtonDown");

/**
 * Check if a mouse button has been released once
 */
extern fn bool is_mouse_button_released(MouseButton button) @extern("IsMouseButtonReleased");

/**
 * Check if a mouse button is NOT being pressed
 */
extern fn bool is_mouse_button_up(MouseButton button) @extern("IsMouseButtonUp");

/**
 * Get mouse position X
 */
extern fn int get_mouse_x() @extern("GetMouseX");

/**
 * Get mouse position Y
 */
extern fn int get_mouse_y() @extern("GetMouseY");

/**
 * Get mouse position XY
 */
extern fn Vector2 get_mouse_position() @extern("GetMousePosition");

/**
 * Get mouse delta between frames
 */
extern fn Vector2 get_mouse_delta() @extern("GetMouseDelta");

/**
 * Set mouse position XY
 */
extern fn void set_mouse_position(int x, int y) @extern("SetMousePosition");

/**
 * Set mouse offset
 */
extern fn void set_mouse_offset(int offset_x, int offset_y) @extern("SetMouseOffset");

/**
 * Set mouse scaling
 */
extern fn void set_mouse_scale(float scale_x, float scale_y) @extern("SetMouseScale");

/**
 * Get mouse wheel movement for X or Y, whichever is larger
 */
extern fn float get_mouse_wheel_move() @extern("GetMouseWheelMove");

/**
 * Get mouse wheel movement for both X and Y
 */
extern fn Vector2 get_mouse_wheel_move_v() @extern("GetMouseWheelMoveV");

/**
 * Set mouse cursor
 */
extern fn void set_mouse_cursor(int cursor) @extern("SetMouseCursor");

// Input-related functions: touch
//------------------------------------------------------------------------------------

/**
 * Get touch position X for touch point 0 (relative to screen size)
 */
extern fn int get_touch_x() @extern("GetTouchX");

/**
 * Get touch position Y for touch point 0 (relative to screen size)
 */
extern fn int get_touch_y() @extern("GetTouchY");

/**
 * Get touch position XY for a touch point index (relative to screen size)
 */
extern fn Vector2 get_touch_position(int index) @extern("GetTouchPosition");

/**
 * Get touch point identifier for given index
 */
extern fn int get_touch_point_id(int index) @extern("GetTouchPointId");

/**
 * Get number of touch points
 */
extern fn int get_touch_point_count() @extern("GetTouchPointCount");

