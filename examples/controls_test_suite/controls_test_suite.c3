// vi: ts=4 sw=4 noet
/*******************************************************************************************
*
*   raygui - controls test suite
*
*   TEST CONTROLS:
*       - rgui::dropdown_box()
*       - rgui::check_box()
*       - rgui::spinner()
*       - rgui::value_box()
*       - rgui::text_box()
*       - rgui::button()
*       - rgui::combo_box()
*       - rgui::list_view()
*       - rgui::toggle_group()
*       - rgui::color_picker()
*       - rgui::slider()
*       - rgui::slider_bar()
*       - rgui::progress_bar()
*       - rgui::color_bar_alpha()
*       - rgui::scroll_panel()
*
*
*   DEPENDENCIES:
*       raylib 4.5          - Windowing/input management and drawing
*       raygui 3.5          - Immediate-mode GUI controls with custom styling and icons
*
*   COMPILATION (Windows - MinGW):
*       gcc -o $(NAME_PART).exe $(FILE_NAME) -I../../src -lraylib -lopengl32 -lgdi32 -std=c99
*
*   LICENSE: zlib/libpng
*
*   Copyright (c) 2016-2023 Ramon Santamaria (@raysan5)
*
**********************************************************************************************/

module controls_test_suite;
import std::io;
import std::collections;
import rl;
import rgui;

// raygui styles
import style_bluish;
import style_cyber;
import style_dark;
import style_jungle;
import style_lavanda;
import style_terminal;

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
fn int main()
{
	// Initialization
	//---------------------------------------------------------------------------------------
	const int SCREEN_WIDTH = 960;
	const int SCREEN_HEIGHT = 560;

	rl::init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "raygui - controls test suite");
	rl::set_exit_key(0);

	// GUI controls initialization
	//----------------------------------------------------------------------------------
	int dropdownBox000Active = 0;
	bool dropDown000EditMode = false;

	int dropdownBox001Active = 0;
	bool dropDown001EditMode = false;

	int spinner001Value = 0;
	bool spinnerEditMode = false;

	int valueBox002Value = 0;
	bool valueBoxEditMode = false;

	char[64] textBoxTextBuffer = "Text box";
	char[] textBoxText = textBoxTextBuffer[:textBoxTextBuffer.len];
	bool textBoxEditMode = true;

	char[1024] textBoxMultiTextBuffer = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	char[] textBoxMultiText = textBoxMultiTextBuffer[:textBoxMultiTextBuffer.len];
	bool textBoxMultiEditMode = false;

	int listViewScrollIndex = 0;
	int listViewActive = -1;

	int listViewExScrollIndex = 0;
	int listViewExActive = 2;
	int listViewExFocus = -1;
	List(<ZString>) listViewExList;
	listViewExList.temp_init_with_array({ "This", "is", "a", "list view", "with", "disable", "elements", "amazing!" });

	char[256] multiTextBoxText = "Multi text box";
	bool multiTextBoxEditMode = false;
	rl::Color colorPickerValue = rl::RED;

	float sliderValue = 50.0f;
	float sliderBarValue = 60;
	float progressValue = 0.1f;

	bool forceSquaredChecked = false;

	float alphaValue = 0.5f;

	//int comboBoxActive = 1;
	int visualStyleActive = 4;
	int prevVisualStyleActive = 0;

	int toggleGroupActive = 0;
	int toggleSliderActive = 0;

	rl::Vector2 viewScroll = { 0, 0 };
	//----------------------------------------------------------------------------------

	// Custom GUI font loading
	//rl::Font font = rl::load_font_ex("fonts/rainyhearts16.ttf", 12, 0, 0);
	//rgui::set_font(font);

	bool exitWindow = false;
	bool showMessageBox = false;


	char[] textInput = mem::temp_new_array(char, 256);
	char[] textInputFileName = mem::temp_new_array(char, 256);
	bool showTextInputBox = false;

	float alpha = 1.0f;

	// DEBUG: Testing how those two properties affect all controls!
	//rgui::set_style(rgui::DEFAULT, rgui::TEXT_PADDING, 0);
	//rgui::set_style(rgui::DEFAULT, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_CENTER);

	rl::set_target_fps(60);
	//--------------------------------------------------------------------------------------

	// Main game loop
	while (!exitWindow) // Detect window close button or ESC key
	{
		// Update
		//----------------------------------------------------------------------------------
		exitWindow = rl::window_should_close();

		if (rl::is_key_pressed(rl::KEY_ESCAPE)) { showMessageBox = !showMessageBox; }

		if (rl::is_key_down(rl::KEY_LEFT_CONTROL) && rl::is_key_pressed(rl::KEY_S)) { showTextInputBox = true; }

		if (rl::is_file_dropped())
		{
			rl::FilePathList droppedFiles = rl::load_dropped_files();

			if ((droppedFiles.count > 0) && rl::is_file_extension((ZString)droppedFiles.paths[0], ".rgs")) { rgui::load_style((ZString)droppedFiles.paths[0]); }

			rl::unload_dropped_files(droppedFiles); // Clear internal buffers
		}

		//alpha -= 0.002f;
		if (alpha < 0.0f) alpha = 0.0f;
		if (rl::is_key_pressed(rl::KEY_SPACE)) alpha = 1.0f;

		rgui::set_alpha(alpha);

		//progressValue += 0.002f;
		if (rl::is_key_pressed(rl::KEY_LEFT)) { progressValue -= 0.1f; }
		else if (rl::is_key_pressed(rl::KEY_RIGHT)) { progressValue += 0.1f; }
		if (progressValue > 1.0f) { progressValue = 1.0f; }
		else if (progressValue < 0.0f) { progressValue = 0.0f; }

		if (visualStyleActive != prevVisualStyleActive)
		{
			rgui::load_style_default();

			switch (visualStyleActive)
			{
				case 0: break; // Default style
				case 1: style_jungle::load_style(); break;
				case 2: style_lavanda::load_style(); break;
				case 3: style_dark::load_style(); break;
				case 4: style_bluish::load_style(); break;
				case 5: style_cyber::load_style(); break;
				case 6: style_terminal::load_style(); break;
				default: break;
			}

			rgui::set_style(rgui::LABEL, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);

			prevVisualStyleActive = visualStyleActive;
		}
		//----------------------------------------------------------------------------------

		// Draw
		//----------------------------------------------------------------------------------
		rl::@drawing()
		{
			rl::clear_background(rl::get_color(rgui::get_style(rgui::DEFAULT, rgui::BACKGROUND_COLOR)));

			// raygui: controls drawing
			//----------------------------------------------------------------------------------
			// Check all possible events that require GuiLock
			if (dropDown000EditMode || dropDown001EditMode) { rgui::lock(); }

			// First GUI column
			//rgui::set_style(rgui::CHECKBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
			rgui::check_box(Rectangle { 25, 108, 15, 15 }, "FORCE CHECK!", &forceSquaredChecked);

			rgui::set_style(rgui::TEXTBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_CENTER);
			//rgui::set_style(rgui::VALUEBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
			if (rgui::spinner(Rectangle { 25, 135, 125, 30 }, null, &spinner001Value, 0, 100, spinnerEditMode)) { spinnerEditMode = !spinnerEditMode; }
			if (rgui::value_box(Rectangle { 25, 175, 125, 30 }, null, &valueBox002Value, 0, 100, valueBoxEditMode)) { valueBoxEditMode = !valueBoxEditMode; }
			rgui::set_style(rgui::TEXTBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
			if (rgui::text_box(Rectangle { 25, 215, 125, 30 }, textBoxText, textBoxEditMode)) { textBoxEditMode = !textBoxEditMode; }

			rgui::set_style(rgui::BUTTON, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_CENTER);

			if (rgui::button(Rectangle { 25, 255, 125, 30 }, rgui::icon_text(rgui::GuiIconName.ICON_FILE_SAVE, "Save File"))) { showTextInputBox = true; }

			rgui::group_box(Rectangle { 25, 310, 125, 150 }, "STATES");
			//rgui::lock();
			rgui::set_state(rgui::STATE_NORMAL); if (rgui::button(Rectangle { 30, 320, 115, 30 }, "NORMAL")) { }
			rgui::set_state(rgui::STATE_FOCUSED); if (rgui::button(Rectangle { 30, 355, 115, 30 }, "FOCUSED")) { }
			rgui::set_state(rgui::STATE_PRESSED); if (rgui::button(Rectangle { 30, 390, 115, 30 }, "#15#PRESSED")) { }
			rgui::set_state(rgui::STATE_DISABLED); if (rgui::button(Rectangle { 30, 425, 115, 30 }, "DISABLED")) { }
			rgui::set_state(rgui::STATE_NORMAL);
			//rgui::unlock();

			rgui::combo_box(Rectangle { 25, 480, 125, 30 }, "default;Jungle;Lavanda;Dark;Bluish;Cyber;Terminal", &visualStyleActive);

			// NOTE: GuiDropdownBox must draw after any other control that can be covered on unfolding
			rgui::unlock();
			rgui::set_style(rgui::DROPDOWNBOX, rgui::TEXT_PADDING, 4);
			rgui::set_style(rgui::DROPDOWNBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
			if (rgui::dropdown_box(Rectangle { 25, 65, 125, 30 }, "#01#ONE;#02#TWO;#03#THREE;#04#FOUR", &dropdownBox001Active, dropDown001EditMode)) dropDown001EditMode = !dropDown001EditMode;
			rgui::set_style(rgui::DROPDOWNBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_CENTER);
			rgui::set_style(rgui::DROPDOWNBOX, rgui::TEXT_PADDING, 0);

			if (rgui::dropdown_box(Rectangle { 25, 25, 125, 30 }, "ONE;TWO;THREE", &dropdownBox000Active, dropDown000EditMode)) dropDown000EditMode = !dropDown000EditMode;

			// Second GUI column
			rgui::list_view(Rectangle { 165, 25, 140, 124 }, "Charmander;Bulbasaur;#18#Squirtel;Pikachu;Eevee;Pidgey", &listViewScrollIndex, &listViewActive);
			rgui::list_view_ex(Rectangle { 165, 162, 140, 184 }, listViewExList, &listViewExScrollIndex, &listViewExActive, &listViewExFocus);

			//rgui::toggle(Rectangle { 165, 400, 140, 25 }, "#1#ONE", &toggleGroupActive);
			rgui::toggle_group(Rectangle { 165, 360, 140, 24 }, "#1#ONE\n#3#TWO\n#8#THREE\n#23#", &toggleGroupActive);
			//rgui::disable();
			rgui::set_style(rgui::SLIDER, rgui::SLIDER_PADDING, 2);
			rgui::toggle_slider(Rectangle { 165, 480, 140, 30 }, "ON;OFF", &toggleSliderActive);
			rgui::set_style(rgui::SLIDER, rgui::SLIDER_PADDING, 0);

			// Third GUI column
			rgui::panel(Rectangle { 320, 25, 225, 140 }, "Panel Info");
			rgui::color_picker(Rectangle { 320, 185, 196, 192 }, null, &colorPickerValue);

			//GuiDisable();
			rgui::slider(Rectangle { 355, 400, 165, 20 }, "TEST", rl::text_format("%2.2f", sliderValue), &sliderValue, -50, 100);
			rgui::slider_bar(Rectangle { 320, 430, 200, 20 }, null, rl::text_format("%i", (int)sliderBarValue), &sliderBarValue, 0, 100);

			rgui::progress_bar(Rectangle { 320, 460, 200, 20 }, null, rl::text_format("%i%%", (int)(progressValue*100)), &progressValue, 0.0f, 1.0f);
			rgui::enable();

			// NOTE: View rectangle could be used to perform some scissor test
			Rectangle view;
			rgui::scroll_panel(Rectangle { 560, 25, 102, 354 }, null, Rectangle { 560, 25, 300, 1200 }, &viewScroll, &view);

			Vector2 mouseCell;
			rgui::grid(Rectangle  { 560, 25 + 180 + 195, 100, 120 }, null, 20, 3, &mouseCell);

			rgui::color_bar_alpha(Rectangle { 320, 490, 200, 30 }, null, &alphaValue);

			rgui::set_style(rgui::DEFAULT, rgui::TEXT_ALIGNMENT_VERTICAL, rgui::TEXT_ALIGN_TOP); // WARNING: Word-wrap does not work as expected in case of no-top alignment
			rgui::set_style(rgui::DEFAULT, rgui::TEXT_WRAP_MODE, rgui::TEXT_WRAP_WORD);          // WARNING: If wrap mode enabled, text editing is not supported
			if (rgui::text_box(Rectangle { 678, 25, 258, 492 }, textBoxMultiText, textBoxMultiEditMode)) { textBoxMultiEditMode = !textBoxMultiEditMode; }
			rgui::set_style(rgui::DEFAULT, rgui::TEXT_WRAP_MODE, rgui::TEXT_WRAP_NONE);
			rgui::set_style(rgui::DEFAULT, rgui::TEXT_ALIGNMENT_VERTICAL, rgui::TEXT_ALIGN_MIDDLE);

			rgui::set_style(rgui::DEFAULT, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
			rgui::status_bar(Rectangle { 0, (float)rl::get_screen_height() - 20, (float)rl::get_screen_width(), 20 }, "This is a status bar");
			rgui::set_style(rgui::DEFAULT, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_CENTER);
			//rgui::set_style(rgui::STATUSBAR, rgui::TEXT_INDENTATION, 20);

			if (showMessageBox)
			{
				rl::draw_rectangle(0, 0, rl::get_screen_width(), rl::get_screen_height(), rl::fade(rl::RAYWHITE, 0.8f));
				int result = rgui::message_box(
				  Rectangle {
					(float)rl::get_screen_width()/2 - 125,
					(float)rl::get_screen_height()/2 - 50,
					250,
					100
				  },
				  rgui::icon_text(ICON_EXIT, "Close Window"),
				  "Do you really want to exit?",
				  "Yes;No"
				);

				if ((result == 0) || (result == 2)) { showMessageBox = false; }
				else if (result == 1) { exitWindow = true; }
			}

			if (showTextInputBox)
			{
				rl::draw_rectangle(0, 0, rl::get_screen_width(), rl::get_screen_height(), rl::fade(rl::RAYWHITE, 0.8f));
				int result = rgui::text_input_box(
				  Rectangle {
					(float)rl::get_screen_width()/2 - 120,
					(float)rl::get_screen_height()/2 - 60,
					240,
					140
				  },
				  rgui::icon_text(rgui::GuiIconName.ICON_FILE_SAVE, "Save file as..."),
				  "Introduce output file name:", "Ok;Cancel", textInput, null);


				if (result == 1)
				{
					// TODO: Validate textInput value and save

					rl::text_copy((ZString)textInputFileName.ptr, (ZString)textInput.ptr);
				}

				if ((result == 0) || (result == 1) || (result == 2))
				{
					showTextInputBox = false;
					rl::text_copy((ZString)textInput.ptr, "\0");
				}
			}
			//----------------------------------------------------------------------------------
		};
		//----------------------------------------------------------------------------------
	}

	// De-Initialization
	//--------------------------------------------------------------------------------------
	rl::close_window(); // Close window and OpenGL context
	//--------------------------------------------------------------------------------------

	return 0;
}
