/*******************************************************************************************
*
*   raylib [core] example - Initialize 3d camera free
*
*   Example originally created with raylib 1.3, last time updated with raylib 1.3
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/
module core_3d_camera_free;
import rl;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn int main(String[] args)
{
    // Initialization
    //--------------------------------------------------------------------------------------
    int screenWidth = 800;
    int screenHeight = 450;

    rl::init_window(screenWidth, screenHeight, "raylib [core] example - 3d camera free");

    // Define the camera to look into our 3d world
    rl::Camera3D camera;
    camera.position = rl::Vector3 { 10.0f, 10.0f, 10.0f }; // Camera position
    camera.target = rl::Vector3 { 0.0f, 0.0f, 0.0f };      // Camera looking at point
    camera.up = rl::Vector3 { 0.0f, 1.0f, 0.0f };          // Camera up vector (rotation towards target)
    camera.fovy = 45.0f;                               // Camera field-of-view Y
    camera.projection = rl::CAMERA_PERSPECTIVE;        // Camera projection type

    rl::Vector3 cubePosition = { 0.0f, 0.0f, 0.0f };

    rl::disable_cursor();                    // Limit cursor to relative movement inside the window

    rl::set_target_fps(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl::window_should_close())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        rl::update_camera(&camera, rl::CAMERA_FREE);

        if (rl::is_key_pressed('Z')) { camera.target = rl::Vector3 { 0.0f, 0.0f, 0.0f }; }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
		rl::@drawing()
		{
            rl::clear_background(rl::RAYWHITE);

            rl::@mode3d(camera)
			{
                rl::draw_cube(cubePosition, 2.0f, 2.0f, 2.0f, rl::RED);
                rl::draw_cube_wires(cubePosition, 2.0f, 2.0f, 2.0f, rl::MAROON);

                rl::draw_grid(10, 1.0f);
			};

            rl::draw_rectangle(10, 10, 320, 93, rl::fade(rl::SKYBLUE, 0.5f));
            rl::draw_rectangle_lines(10, 10, 320, 93, rl::BLUE);

            rl::draw_text("Free camera default controls:", 20, 20, 10, rl::BLACK);
            rl::draw_text("- Mouse Wheel to Zoom in-out", 40, 40, 10, rl::DARKGRAY);
            rl::draw_text("- Mouse Wheel Pressed to Pan", 40, 60, 10, rl::DARKGRAY);
            rl::draw_text("- Z to zoom to (0, 0, 0)", 40, 80, 10, rl::DARKGRAY);
		};
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl::close_window();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}

