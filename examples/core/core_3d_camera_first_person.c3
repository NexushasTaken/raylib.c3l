/*******************************************************************************************
*
*   raylib [core] example - 3d camera first person
*
*   Example originally created with raylib 1.3, last time updated with raylib 1.3
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2015-2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/
module core_3d_first_person;
import rl;

const MAX_COLUMNS = 20;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn int main(String[] args)
{
    // Initialization
    //--------------------------------------------------------------------------------------
    int screenWidth = 800;
    int screenHeight = 450;

    rl::initWindow(screenWidth, screenHeight, "raylib [core] example - 3d camera first person");

    // Define the camera to look into our 3d world (position, target, up vector)
    rl::Camera camera;
    camera.position = (rl::Vector3) { 0.0f, 2.0f, 4.0f };    // Camera position
    camera.target = (rl::Vector3) { 0.0f, 2.0f, 0.0f };      // Camera looking at point
    camera.up = (rl::Vector3) { 0.0f, 1.0f, 0.0f };          // Camera up vector (rotation towards target)
    camera.fovy = 60.0f;                                // Camera field-of-view Y
    camera.projection = rl::CAMERA_PERSPECTIVE;             // Camera projection type

    int cameraMode = rl::CAMERA_FIRST_PERSON;

    // Generates some random columns
    float[MAX_COLUMNS] heights;
    rl::Vector3[MAX_COLUMNS] positions;
    rl::Color[MAX_COLUMNS] colors;

    for (int i = 0; i < MAX_COLUMNS; i++)
    {
        heights[i] = (float)rl::getRandomValue(1, 12);
        positions[i] = (Vector3) { (float)rl::getRandomValue(-15, 15), heights[i]/2.0f, (float)rl::getRandomValue(-15, 15) };
        colors[i] = (Color) { (char)rl::getRandomValue(20, 255), (char)rl::getRandomValue(10, 55), 30, 255 };
    }

    rl::disableCursor();                    // Limit cursor to relative movement inside the window

    rl::setTargetFPS(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl::windowShouldClose())        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // Switch camera mode
        if (rl::isKeyPressed(rl::KEY_ONE))
        {
            cameraMode = rl::CAMERA_FREE;
            camera.up = (rl::Vector3) { 0.0f, 1.0f, 0.0f }; // Reset roll
        }

        if (rl::isKeyPressed(rl::KEY_TWO))
        {
            cameraMode = rl::CAMERA_FIRST_PERSON;
            camera.up = (rl::Vector3) { 0.0f, 1.0f, 0.0f }; // Reset roll
        }

        if (rl::isKeyPressed(rl::KEY_THREE))
        {
            cameraMode = rl::CAMERA_THIRD_PERSON;
            camera.up = (rl::Vector3) { 0.0f, 1.0f, 0.0f }; // Reset roll
        }

        if (rl::isKeyPressed(rl::KEY_FOUR))
        {
            cameraMode = rl::CAMERA_ORBITAL;
            camera.up = (rl::Vector3) { 0.0f, 1.0f, 0.0f }; // Reset roll
        }

        // Switch camera projection
        if (rl::isKeyPressed(rl::KEY_P))
        {
            if (camera.projection == rl::CAMERA_PERSPECTIVE)
            {
                // Create isometric view
                cameraMode = rl::CAMERA_THIRD_PERSON;
                // Note: The target distance is related to the render distance in the orthographic projection
                camera.position = (rl::Vector3) { 0.0f, 2.0f, -100.0f };
                camera.target = (rl::Vector3) { 0.0f, 2.0f, 0.0f };
                camera.up = (rl::Vector3) { 0.0f, 1.0f, 0.0f };
                camera.projection = rl::CAMERA_ORTHOGRAPHIC;
                camera.fovy = 20.0f; // near plane width in CAMERA_ORTHOGRAPHIC
                rl::cameraYaw(&camera, -135 * rl::DEG2RAD, true);
                rl::cameraPitch(&camera, -45 * rl::DEG2RAD, true, true, false);
            }
            else if (camera.projection == rl::CAMERA_ORTHOGRAPHIC)
            {
                // Reset to default view
                cameraMode = rl::CAMERA_THIRD_PERSON;
                camera.position = (rl::Vector3) { 0.0f, 2.0f, 10.0f };
                camera.target = (rl::Vector3) { 0.0f, 2.0f, 0.0f };
                camera.up = (rl::Vector3) { 0.0f, 1.0f, 0.0f };
                camera.projection = rl::CAMERA_PERSPECTIVE;
                camera.fovy = 60.0f;
            }
        }

        // Update camera computes movement internally depending on the camera mode
        // Some default standard keyboard/mouse inputs are hardcoded to simplify use
        // For advance camera controls, it's reecommended to compute camera movement manually
        rl::updateCamera(&camera, cameraMode);                  // Update camera

        // Camera PRO usage example (EXPERIMENTAL)
        // This new camera function allows custom movement/rotation values to be directly provided
        // as input parameters, with this approach, rcamera module is internally independent of raylib inputs
		/*
        rl::updateCameraPro(&camera,
            (rl::Vector3) {
				(float)(rl::isKeyDown(rl::KEY_W) || rl::isKeyDown(rl::KEY_UP))*0.1f -      // Move forward-backward
				(float)(rl::isKeyDown(rl::KEY_S) || rl::isKeyDown(rl::KEY_DOWN))*0.1f,
				(float)(rl::isKeyDown(rl::KEY_D) || rl::isKeyDown(rl::KEY_RIGHT))*0.1f -   // Move right-left
				(float)(rl::isKeyDown(rl::KEY_A) || rl::isKeyDown(rl::KEY_LEFT))*0.1f,
                0.0f                                                // Move up-down
            },
            (rl::Vector3) {
                rl::getMouseDelta().x*0.05f,                      // Rotation: yaw
                rl::getMouseDelta().y*0.05f,                      // Rotation: pitch
                0.0f                                                // Rotation: roll
            },
            rl::getMouseWheelMove()*2.0f);                              // Move to target (zoom)
		*/
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
		rl::@drawing()
		{
            rl::clearBackground(rl::RAYWHITE);

			rl::@mode3D(camera)
			{
                rl::drawPlane((rl::Vector3) { 0.0f, 0.0f, 0.0f }, (rl::Vector2) { 32.0f, 32.0f }, rl::LIGHTGRAY); // Draw ground
                rl::drawCube((rl::Vector3) { -16.0f, 2.5f, 0.0f }, 1.0f, 5.0f, 32.0f, rl::BLUE);     // Draw a blue wall
                rl::drawCube((rl::Vector3) { 16.0f, 2.5f, 0.0f }, 1.0f, 5.0f, 32.0f, rl::LIME);      // Draw a green wall
                rl::drawCube((rl::Vector3) { 0.0f, 2.5f, 16.0f }, 32.0f, 5.0f, 1.0f, rl::GOLD);      // Draw a yellow wall

                // Draw some cubes around
                for (int i = 0; i < MAX_COLUMNS; i++)
                {
                    rl::drawCube(positions[i], 2.0f, heights[i], 2.0f, colors[i]);
                    rl::drawCubeWires(positions[i], 2.0f, heights[i], 2.0f, rl::MAROON);
                }

                // Draw player cube
                if (cameraMode == rl::CAMERA_THIRD_PERSON)
                {
                    rl::drawCube(camera.target, 0.5f, 0.5f, 0.5f, rl::PURPLE);
                    rl::drawCubeWires(camera.target, 0.5f, 0.5f, 0.5f, rl::DARKPURPLE);
                }
			};

            // Draw info boxes
            rl::drawRectangle(5, 5, 330, 100, rl::fade(rl::SKYBLUE, 0.5f));
            rl::drawRectangleLines(5, 5, 330, 100, rl::BLUE);

            rl::drawText("Camera controls:", 15, 15, 10, rl::BLACK);
            rl::drawText("- Move keys: W, A, S, D, Space, Left-Ctrl", 15, 30, 10, rl::BLACK);
            rl::drawText("- Look around: arrow keys or mouse", 15, 45, 10, rl::BLACK);
            rl::drawText("- Camera mode keys: 1, 2, 3, 4", 15, 60, 10, rl::BLACK);
            rl::drawText("- Zoom keys: num-plus, num-minus or mouse scroll", 15, 75, 10, rl::BLACK);
            rl::drawText("- Camera projection key: P", 15, 90, 10, rl::BLACK);

            rl::drawRectangle(600, 5, 195, 100, rl::fade(rl::SKYBLUE, 0.5f));
            rl::drawRectangleLines(600, 5, 195, 100, rl::BLUE);

            rl::drawText("Camera status:", 610, 15, 10, rl::BLACK);
			@pool()
			{
				rl::drawText(rl::textFormat("- Mode: %s", (cameraMode == rl::CAMERA_FREE) ? "FREE" :
															(cameraMode == rl::CAMERA_FIRST_PERSON) ? "FIRST_PERSON" :
															(cameraMode == rl::CAMERA_THIRD_PERSON) ? "THIRD_PERSON" :
															(cameraMode == rl::CAMERA_ORBITAL) ? "ORBITAL" : "CUSTOM"), 610, 30, 10, rl::BLACK);
				rl::drawText(rl::textFormat("- Projection: %s", (camera.projection == rl::CAMERA_PERSPECTIVE) ? "PERSPECTIVE" :
															(camera.projection == rl::CAMERA_ORTHOGRAPHIC) ? "ORTHOGRAPHIC" : "CUSTOM"), 610, 45, 10, rl::BLACK);
				rl::drawText(rl::textFormat("- Position: (%06.3f, %06.3f, %06.3f)", camera.position.x, camera.position.y, camera.position.z), 610, 60, 10, rl::BLACK);
				rl::drawText(rl::textFormat("- Target: (%06.3f, %06.3f, %06.3f)", camera.target.x, camera.target.y, camera.target.z), 610, 75, 10, rl::BLACK);
				rl::drawText(rl::textFormat("- Up: (%06.3f, %06.3f, %06.3f)", camera.up.x, camera.up.y, camera.up.z), 610, 90, 10, rl::BLACK);
			};
		};
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl::closeWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}

