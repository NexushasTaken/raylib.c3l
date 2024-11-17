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
// Input-related functions: touch
// Gestures and Touch Handling Functions (Module: rgestures)

*/

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
extern fn void setMouseCursor(int cursor) @extern("SetMouseCursor");

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
