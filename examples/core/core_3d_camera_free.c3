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

    rl::initWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera free");

    // Define the camera to look into our 3d world
    rl::Camera3D camera;
    camera.position = (rl::Vector3) { 10.0f, 10.0f, 10.0f }; // Camera position
    camera.target = (rl::Vector3) { 0.0f, 0.0f, 0.0f };      // Camera looking at point
    camera.up = (rl::Vector3) { 0.0f, 1.0f, 0.0f };          // Camera up vector (rotation towards target)
    camera.fovy = 45.0f;                               // Camera field-of-view Y
    camera.projection = rl::CAMERA_PERSPECTIVE;        // Camera projection type

    rl::Vector3 cubePosition = { 0.0f, 0.0f, 0.0f };

    rl::disableCursor();                    // Limit cursor to relative movement inside the window

    rl::setTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl::windowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        rl::updateCamera(&camera, rl::CAMERA_FREE);

        if (rl::isKeyPressed('Z')) { camera.target = (rl::Vector3) { 0.0f, 0.0f, 0.0f }; }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
		rl::@drawing()
		{
            rl::clearBackground(rl::RAYWHITE);

            rl::@mode3D(camera)
			{
                rl::drawCube(cubePosition, 2.0f, 2.0f, 2.0f, rl::RED);
                rl::drawCubeWires(cubePosition, 2.0f, 2.0f, 2.0f, rl::MAROON);

                rl::drawGrid(10, 1.0f);
			};

            rl::drawRectangle(10, 10, 320, 93, rl::fade(rl::SKYBLUE, 0.5f));
            rl::drawRectangleLines(10, 10, 320, 93, rl::BLUE);

            rl::drawText("Free camera default controls:", 20, 20, 10, rl::BLACK);
            rl::drawText("- Mouse Wheel to Zoom in-out", 40, 40, 10, rl::DARKGRAY);
            rl::drawText("- Mouse Wheel Pressed to Pan", 40, 60, 10, rl::DARKGRAY);
            rl::drawText("- Z to zoom to (0, 0, 0)", 40, 80, 10, rl::DARKGRAY);
		};
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl::closeWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}

