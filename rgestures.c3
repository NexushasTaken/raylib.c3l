// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: rgestures)
//------------------------------------------------------------------------------------

/**
 * Enable a set of gestures using flags
 */
extern fn void set_gestures_enabled(Gesture flags) @extern("SetGesturesEnabled");

/**
 * Check if a gesture have been detected
 */
extern fn bool is_gesture_detected(Gesture gesture) @extern("IsGestureDetected");

/**
 * Get latest detected gesture
 */
extern fn int get_gesture_detected() @extern("GetGestureDetected");

/**
 * Get gesture hold time in milliseconds
 */
extern fn float get_gesture_hold_duration() @extern("GetGestureHoldDuration");

/**
 * Get gesture drag vector
 */
extern fn Vector2 get_gesture_drag_vector() @extern("GetGestureDragVector");

/**
 * Get gesture drag angle
 */
extern fn float get_gesture_drag_angle() @extern("GetGestureDragAngle");

/**
 * Get gesture pinch delta
 */
extern fn Vector2 get_gesture_pinch_vector() @extern("GetGesturePinchVector");

/**
 * Get gesture pinch angle
 */
extern fn float get_gesture_pinch_angle() @extern("GetGesturePinchAngle");

