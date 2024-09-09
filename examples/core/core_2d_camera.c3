// vi: ts=4 sw=4 noet
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
import std::math::random;
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

	rl::init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib [core] example - 2d camera");

	rl::Rectangle player = { 400, 280, 40, 40 };
	rl::Rectangle[MAX_BUILDINGS] buildings;
	Color[MAX_BUILDINGS] buildColors;

	int spacing = 0;

    foreach (i, &building : buildings)
	{
		building.width = (float)rl::get_random_value(50, 200);
		building.height = (float)rl::get_random_value(100, 800);
		building.y = SCREEN_HEIGHT - 130.0f - building.height;
		building.x = -6000.0f + spacing;

		spacing += (int)building.width;

		buildColors[i] = Color {
                (char)rl::get_random_value(200, 240),
                (char)rl::get_random_value(200, 240),
                (char)rl::get_random_value(200, 250),
                255
            };
	}

	rl::Camera2D camera = {
			.target = rl::Vector2 { player.x + 20.0f, player.y + 20.0f },
			.offset = rl::Vector2 { SCREEN_WIDTH/2.0f, SCREEN_HEIGHT/2.0f },
			.rotation = 0.0f,
			.zoom = 1.0f,
		};

	rl::set_target_fps(60);                 // Set our game to run at 60 frames-per-second
	//--------------------------------------------------------------------------------------

	// Main game loop
	while (!rl::window_should_close())      // Detect window close button or ESC key
	{
		// Update
		//----------------------------------------------------------------------------------
		// Player movement
		if (rl::is_key_down(rl::KEY_RIGHT)) { player.x += 2; }
		else if (rl::is_key_down(rl::KEY_LEFT)) { player.x -= 2; }

		// Camera target follows player
		camera.target = Vector2 { player.x + 20, player.y + 20 };

		// Camera rotation controls
		if (rl::is_key_down(rl::KEY_A)) { camera.rotation--; }
		else if (rl::is_key_down(rl::KEY_S)) { camera.rotation++; }

		// Limit camera rotation to 80 degrees (-40 to 40)
		if (camera.rotation > 40) { camera.rotation = 40; }
		else if (camera.rotation < -40) { camera.rotation = -40; }

		// Camera zoom controls
		camera.zoom += ((float)rl::get_mouse_wheel_move()*0.05f);

		if (camera.zoom > 3.0f) { camera.zoom = 3.0f; }
		else if (camera.zoom < 0.1f) { camera.zoom = 0.1f; }

		// Camera reset (zoom and rotation)
		if (rl::is_key_pressed(rl::KEY_R))
		{
			camera.zoom = 1.0f;
			camera.rotation = 0.0f;
		}
		//----------------------------------------------------------------------------------

		// Draw
		//----------------------------------------------------------------------------------
		rl::@drawing()
		{
			rl::clear_background(rl::RAYWHITE);

			rl::@mode2d(camera)
			{
				rl::draw_rectangle(-6000, 320, 13000, 8000, rl::DARKGRAY);

				for (int i = 0; i < MAX_BUILDINGS; i++) { rl::draw_rectangle_rec(buildings[i], buildColors[i]); }

				rl::draw_rectangle_rec(player, rl::RED);

				rl::draw_line((int)camera.target.x, -SCREEN_HEIGHT*10, (int)camera.target.x, SCREEN_HEIGHT*10, rl::GREEN);
				rl::draw_line(-SCREEN_WIDTH*10, (int)camera.target.y, SCREEN_WIDTH*10, (int)camera.target.y, rl::GREEN);
			};

			rl::draw_text("SCREEN AREA", 640, 10, 20, rl::RED);

			rl::draw_rectangle(0, 0, SCREEN_WIDTH, 5, rl::RED);
			rl::draw_rectangle(0, 5, 5, SCREEN_HEIGHT - 10, rl::RED);
			rl::draw_rectangle(SCREEN_WIDTH - 5, 5, 5, SCREEN_HEIGHT - 10, rl::RED);
			rl::draw_rectangle(0, SCREEN_HEIGHT - 5, SCREEN_WIDTH, 5, rl::RED);

			rl::draw_rectangle( 10, 10, 250, 113, rl::fade(rl::SKYBLUE, 0.5f));
			rl::draw_rectangle_lines( 10, 10, 250, 113, rl::BLUE);

			rl::draw_text("Free 2d camera controls:", 20, 20, 10, rl::BLACK);
			rl::draw_text("- Right/Left to move Offset", 40, 40, 10, rl::DARKGRAY);
			rl::draw_text("- Mouse Wheel to Zoom in-out", 40, 60, 10, rl::DARKGRAY);
			rl::draw_text("- A / S to Rotate", 40, 80, 10, rl::DARKGRAY);
			rl::draw_text("- R to reset Zoom and Rotation", 40, 100, 10, rl::DARKGRAY);
		};
		//----------------------------------------------------------------------------------
	}

	// De-Initialization
	//--------------------------------------------------------------------------------------
	rl::close_window(); // Close window and OpenGL context
	//--------------------------------------------------------------------------------------

	return 0;
}
