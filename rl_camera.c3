module rl;

//------------------------------------------------------------------------------------
// Camera System Functions (Module: rcamera)
//------------------------------------------------------------------------------------

/**
 * Update camera position for selected mode
 */
extern fn void update_camera(Camera* camera, CameraMode mode) @extern("UpdateCamera");

/**
 * Update camera movement/rotation
 */
extern fn void update_camera_pro(Camera* camera, Vector3 movement, Vector3 rotation, float zoom) @extern("UpdateCameraPro");

// rcamera.h functions
//------------------------------------------------------------------------------------
extern fn Vector3 get_camera_forward(Camera *camera) @extern("GetCameraForward");
extern fn Vector3 get_camera_up(Camera *camera) @extern("GetCameraUp");
extern fn Vector3 get_camera_right(Camera *camera) @extern("GetCameraRight");

// Camera movement
extern fn void camera_move_forward(Camera *camera, float distance, bool move_in_world_plane) @extern("CameraMoveForward");
extern fn void camera_move_up(Camera *camera, float distance) @extern("CameraMoveUp");
extern fn void camera_move_right(Camera *camera, float distance, bool move_in_world_plane) @extern("CameraMoveRight");
extern fn void camera_move_to_target(Camera *camera, float delta) @extern("CameraMoveToTarget");

// Camera rotation
extern fn void camera_yaw(Camera *camera, float angle, bool rotate_around_target) @extern("CameraYaw");
extern fn void camera_pitch(Camera *camera, float angle, bool lock_view, bool rotate_around_target, bool rotateUp) @extern("CameraPitch");
extern fn void camera_roll(Camera *camera, float angle) @extern("CameraRoll");

extern fn Matrix get_camera_view_matrix(Camera *camera) @extern("GetCameraViewMatrix");
extern fn Matrix get_camera_projection_matrix(Camera* camera, float aspect) @extern("GetCameraProjectionMatrix");
//------------------------------------------------------------------------------------
