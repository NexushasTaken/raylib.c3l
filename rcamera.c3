// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Camera System Functions (Module: rcamera)
//------------------------------------------------------------------------------------
// Update camera position for selected mode
fn void update_camera(Camera* camera, int mode) @extern("UpdateCamera");
// Update camera movement/rotation
fn void update_camera_pro(Camera* camera, Vector3 movement, Vector3 rotation, float zoom) @extern("UpdateCameraPro");

