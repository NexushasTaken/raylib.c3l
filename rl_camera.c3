// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Camera System Functions (Module: rcamera)
//------------------------------------------------------------------------------------

/**
 * Update camera position for selected mode
 */
extern fn void Camera.update_camera(Camera* camera, CameraMode mode) @extern("UpdateCamera");

/**
 * Update camera movement/rotation
 */
extern fn void update_camera_pro(Camera* camera, Vector3 movement, Vector3 rotation, float zoom) @extern("UpdateCameraPro");

