/*******************************************************************************************
*
*   raylib [core] example - 2D Camera system
*
*   Example originally created with raylib 1.5, last time updated with raylib 3.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2016-2023 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

module core_2d_camera;
import rl;

const MAX_BUILDINGS = 100;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn int main(String[] args)
{
	// Initialization
	//--------------------------------------------------------------------------------------
	const int SCREEN_WIDTH = 800;
	const int SCREEN_HEIGHT = 450;

	rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 2d camera");

	rl::Rectangle player = { 400, 280, 40, 40 };
	rl::Rectangle[MAX_BUILDINGS] buildings;
	Color[MAX_BUILDINGS] buildColors;

	int spacing = 0;

	foreach (i, &building : buildings) {
		building.width = (float)rl::getRandomValue(50, 200);
		building.height = (float)rl::getRandomValue(100, 800);
		building.y = SCREEN_HEIGHT - 130.0f - building.height;
		building.x = -6000.0f + spacing;

		spacing += (int)building.width;

		buildColors[i] = Color {
				(char)rl::getRandomValue(200, 240),
				(char)rl::getRandomValue(200, 240),
				(char)rl::getRandomValue(200, 250),
				255
			};
	}

	rl::Camera2D camera = {
			.target = rl::Vector2 { player.x + 20.0f, player.y + 20.0f },
			.offset = rl::Vector2 { SCREEN_WIDTH/2.0f, SCREEN_HEIGHT/2.0f },
			.rotation = 0.0f,
			.zoom = 1.0f,
		};

	rl::setTargetFPS(60);                   // Set our game to run at 60 frames-per-second
	//--------------------------------------------------------------------------------------

	// Main game loop
	while (!rl::windowShouldClose())        // Detect window close button or ESC key
	{
		// Update
		//----------------------------------------------------------------------------------
		// Player movement
		if (rl::isKeyDown(rl::KEY_RIGHT)) { player.x += 2; }
		else if (rl::isKeyDown(rl::KEY_LEFT)) { player.x -= 2; }

		// Camera target follows player
		camera.target = Vector2 { player.x + 20, player.y + 20 };

		// Camera rotation controls
		if (rl::isKeyDown(rl::KEY_A)) { camera.rotation--; }
		else if (rl::isKeyDown(rl::KEY_S)) { camera.rotation++; }

		// Limit camera rotation to 80 degrees (-40 to 40)
		if (camera.rotation > 40) { camera.rotation = 40; }
		else if (camera.rotation < -40) { camera.rotation = -40; }

		// Camera zoom controls
		camera.zoom += ((float)rl::getMouseWheelMove()*0.05f);

		if (camera.zoom > 3.0f) { camera.zoom = 3.0f; }
		else if (camera.zoom < 0.1f) { camera.zoom = 0.1f; }

		// Camera reset (zoom and rotation)
		if (rl::isKeyPressed(rl::KEY_R))
		{
			camera.zoom = 1.0f;
			camera.rotation = 0.0f;
		}
		//----------------------------------------------------------------------------------

		// Draw
		//----------------------------------------------------------------------------------
		rl::@drawing() {
			rl::clearBackground(rl::RAYWHITE);

			rl::@mode2D(camera) {
				rl::drawRectangle(-6000, 320, 13000, 8000, rl::DARKGRAY);

				for (int i = 0; i < MAX_BUILDINGS; i++) { rl::drawRectangleRec(buildings[i], buildColors[i]); }

				rl::drawRectangleRec(player, rl::RED);

				rl::drawLine((int)camera.target.x, -SCREEN_HEIGHT*10, (int)camera.target.x, SCREEN_HEIGHT*10, rl::GREEN);
				rl::drawLine(-SCREEN_WIDTH*10, (int)camera.target.y, SCREEN_WIDTH*10, (int)camera.target.y, rl::GREEN);
			};

			rl::drawText("SCREEN AREA", 640, 10, 20, rl::RED);

			rl::drawRectangle(0, 0, SCREEN_WIDTH, 5, rl::RED);
			rl::drawRectangle(0, 5, 5, SCREEN_HEIGHT - 10, rl::RED);
			rl::drawRectangle(SCREEN_WIDTH - 5, 5, 5, SCREEN_HEIGHT - 10, rl::RED);
			rl::drawRectangle(0, SCREEN_HEIGHT - 5, SCREEN_WIDTH, 5, rl::RED);

			rl::drawRectangle( 10, 10, 250, 113, rl::fade(rl::SKYBLUE, 0.5f));
			rl::drawRectangleLines( 10, 10, 250, 113, rl::BLUE);

			rl::drawText("Free 2d camera controls:", 20, 20, 10, rl::BLACK);
			rl::drawText("- Right/Left to move Offset", 40, 40, 10, rl::DARKGRAY);
			rl::drawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, rl::DARKGRAY);
			rl::drawText("- A / S to Rotate", 40, 80, 10, rl::DARKGRAY);
			rl::drawText("- R to reset Zoom and Rotation", 40, 100, 10, rl::DARKGRAY);
		};
		//----------------------------------------------------------------------------------
	}

	// De-Initialization
	//--------------------------------------------------------------------------------------
	rl::closeWindow();        // Close window and OpenGL context
	//--------------------------------------------------------------------------------------

	return 0;
}
