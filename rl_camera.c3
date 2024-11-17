module rl;

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
