// vi: ts=4 sw=4 noet
/*******************************************************************************************
*
*   raygui - controls test suite
*
*   TEST CONTROLS:
*       - raygui::dropdownBox()
*       - raygui::checkBox()
*       - raygui::spinner()
*       - raygui::valueBox()
*       - raygui::textBox()
*       - raygui::button()
*       - raygui::comboBox()
*       - raygui::listView()
*       - raygui::toggleGroup()
*       - raygui::colorPicker()
*       - raygui::slider()
*       - raygui::sliderBar()
*       - raygui::progressBar()
*       - raygui::colorBarAlpha()
*       - raygui::scrollPanel()
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
import raygui;

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

	rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raygui - controls test suite");
	rl::setExitKey(0);

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
	ZString[] listViewExList = { "This", "is", "a", "list view", "with", "disable", "elements", "amazing!" };

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
	//raygui::set_font(font);

	bool exitWindow = false;
	bool showMessageBox = false;


	char[] textInput = mem::temp_new_array(char, 256);
	char[] textInputFileName = mem::temp_new_array(char, 256);
	bool showTextInputBox = false;

	float alpha = 1.0f;

	// DEBUG: Testing how those two properties affect all controls!
	//raygui::setStyle(raygui::DEFAULT, raygui::TEXT_PADDING, 0);
	//raygui::setStyle(raygui::DEFAULT, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_CENTER);

	rl::setTargetFPS(60);
	//--------------------------------------------------------------------------------------

	// Main game loop
	while (!exitWindow) // Detect window close button or ESC key
	{
		// Update
		//----------------------------------------------------------------------------------
		exitWindow = rl::windowShouldClose();

		if (rl::isKeyPressed(rl::KEY_ESCAPE)) { showMessageBox = !showMessageBox; }

		if (rl::isKeyDown(rl::KEY_LEFT_CONTROL) && rl::isKeyPressed(rl::KEY_S)) { showTextInputBox = true; }

		if (rl::isFileDropped())
		{
			rl::FilePathList droppedFiles = rl::loadDroppedFiles();

			if ((droppedFiles.count > 0) && rl::isFileExtension((ZString)droppedFiles.paths[0], ".rgs")) { raygui::loadStyle((ZString)droppedFiles.paths[0]); }

			rl::unloadDroppedFiles(droppedFiles); // Clear internal buffers
		}

		//alpha -= 0.002f;
		if (alpha < 0.0f) alpha = 0.0f;
		if (rl::isKeyPressed(rl::KEY_SPACE)) alpha = 1.0f;

		raygui::setAlpha(alpha);

		//progressValue += 0.002f;
		if (rl::isKeyPressed(rl::KEY_LEFT)) { progressValue -= 0.1f; }
		else if (rl::isKeyPressed(rl::KEY_RIGHT)) { progressValue += 0.1f; }
		if (progressValue > 1.0f) { progressValue = 1.0f; }
		else if (progressValue < 0.0f) { progressValue = 0.0f; }

		if (visualStyleActive != prevVisualStyleActive)
		{
			raygui::loadStyleDefault();

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

			raygui::setStyle(raygui::LABEL, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_LEFT);

			prevVisualStyleActive = visualStyleActive;
		}
		//----------------------------------------------------------------------------------

		// Draw
		//----------------------------------------------------------------------------------
		rl::@drawing()
		{
			rl::clearBackground(rl::getColor(raygui::getStyle(raygui::DEFAULT, raygui::BACKGROUND_COLOR)));

			// raygui: controls drawing
			//----------------------------------------------------------------------------------
			// Check all possible events that require GuiLock
			if (dropDown000EditMode || dropDown001EditMode) { raygui::lock(); }

			// First GUI column
			//raygui::setStyle(raygui::CHECKBOX, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_LEFT);
			raygui::checkBox(Rectangle { 25, 108, 15, 15 }, "FORCE CHECK!", &forceSquaredChecked);

			raygui::setStyle(raygui::TEXTBOX, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_CENTER);
			//raygui::setStyle(raygui::VALUEBOX, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_LEFT);
			if (raygui::spinner(Rectangle { 25, 135, 125, 30 }, null, &spinner001Value, 0, 100, spinnerEditMode)) { spinnerEditMode = !spinnerEditMode; }
			if (raygui::valueBox(Rectangle { 25, 175, 125, 30 }, null, &valueBox002Value, 0, 100, valueBoxEditMode)) { valueBoxEditMode = !valueBoxEditMode; }
			raygui::setStyle(raygui::TEXTBOX, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_LEFT);
			if (raygui::textBox(Rectangle { 25, 215, 125, 30 }, textBoxText, textBoxEditMode)) { textBoxEditMode = !textBoxEditMode; }

			raygui::setStyle(raygui::BUTTON, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_CENTER);

			if (raygui::button(Rectangle { 25, 255, 125, 30 }, raygui::iconText(raygui::GuiIconName.ICON_FILE_SAVE, "Save File"))) { showTextInputBox = true; }

			raygui::groupBox(Rectangle { 25, 310, 125, 150 }, "STATES");
			//raygui::lock();
			raygui::setState(raygui::STATE_NORMAL); if (raygui::button(Rectangle { 30, 320, 115, 30 }, "NORMAL")) { }
			raygui::setState(raygui::STATE_FOCUSED); if (raygui::button(Rectangle { 30, 355, 115, 30 }, "FOCUSED")) { }
			raygui::setState(raygui::STATE_PRESSED); if (raygui::button(Rectangle { 30, 390, 115, 30 }, "#15#PRESSED")) { }
			raygui::setState(raygui::STATE_DISABLED); if (raygui::button(Rectangle { 30, 425, 115, 30 }, "DISABLED")) { }
			raygui::setState(raygui::STATE_NORMAL);
			//raygui::unlock();

			raygui::comboBox(Rectangle { 25, 480, 125, 30 }, "default;Jungle;Lavanda;Dark;Bluish;Cyber;Terminal", &visualStyleActive);

			// NOTE: GuiDropdownBox must draw after any other control that can be covered on unfolding
			raygui::unlock();
			raygui::setStyle(raygui::DROPDOWNBOX, raygui::TEXT_PADDING, 4);
			raygui::setStyle(raygui::DROPDOWNBOX, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_LEFT);
			if (raygui::dropdownBox(Rectangle { 25, 65, 125, 30 }, "#01#ONE;#02#TWO;#03#THREE;#04#FOUR", &dropdownBox001Active, dropDown001EditMode)) dropDown001EditMode = !dropDown001EditMode;
			raygui::setStyle(raygui::DROPDOWNBOX, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_CENTER);
			raygui::setStyle(raygui::DROPDOWNBOX, raygui::TEXT_PADDING, 0);

			if (raygui::dropdownBox(Rectangle { 25, 25, 125, 30 }, "ONE;TWO;THREE", &dropdownBox000Active, dropDown000EditMode)) dropDown000EditMode = !dropDown000EditMode;

			// Second GUI column
			raygui::listView(Rectangle { 165, 25, 140, 124 }, "Charmander;Bulbasaur;#18#Squirtel;Pikachu;Eevee;Pidgey", &listViewScrollIndex, &listViewActive);
			raygui::listViewEx(Rectangle { 165, 162, 140, 184 }, listViewExList, &listViewExScrollIndex, &listViewExActive, &listViewExFocus);

			//raygui::toggle(Rectangle { 165, 400, 140, 25 }, "#1#ONE", &toggleGroupActive);
			raygui::toggleGroup(Rectangle { 165, 360, 140, 24 }, "#1#ONE\n#3#TWO\n#8#THREE\n#23#", &toggleGroupActive);
			//raygui::disable();
			raygui::setStyle(raygui::SLIDER, raygui::SLIDER_PADDING, 2);
			raygui::toggleSlider(Rectangle { 165, 480, 140, 30 }, "ON;OFF", &toggleSliderActive);
			raygui::setStyle(raygui::SLIDER, raygui::SLIDER_PADDING, 0);

			// Third GUI column
			raygui::panel(Rectangle { 320, 25, 225, 140 }, "Panel Info");
			raygui::colorPicker(Rectangle { 320, 185, 196, 192 }, null, &colorPickerValue);

			//GuiDisable();
			raygui::slider(Rectangle { 355, 400, 165, 20 }, "TEST", rl::textFormat("%2.2f", sliderValue), &sliderValue, -50, 100);
			raygui::sliderBar(Rectangle { 320, 430, 200, 20 }, null, rl::textFormat("%i", (int)sliderBarValue), &sliderBarValue, 0, 100);

			raygui::progressBar(Rectangle { 320, 460, 200, 20 }, null, rl::textFormat("%i%%", (int)(progressValue*100)), &progressValue, 0.0f, 1.0f);
			raygui::enable();

			// NOTE: View rectangle could be used to perform some scissor test
			Rectangle view;
			raygui::scrollPanel(Rectangle { 560, 25, 102, 354 }, null, Rectangle { 560, 25, 300, 1200 }, &viewScroll, &view);

			Vector2 mouseCell;
			raygui::grid(Rectangle  { 560, 25 + 180 + 195, 100, 120 }, null, 20, 3, &mouseCell);

			raygui::colorBarAlpha(Rectangle { 320, 490, 200, 30 }, null, &alphaValue);

			raygui::setStyle(raygui::DEFAULT, raygui::TEXT_ALIGNMENT_VERTICAL, raygui::TEXT_ALIGN_TOP); // WARNING: Word-wrap does not work as expected in case of no-top alignment
			raygui::setStyle(raygui::DEFAULT, raygui::TEXT_WRAP_MODE, raygui::TEXT_WRAP_WORD);          // WARNING: If wrap mode enabled, text editing is not supported
			if (raygui::textBox(Rectangle { 678, 25, 258, 492 }, textBoxMultiText, textBoxMultiEditMode)) { textBoxMultiEditMode = !textBoxMultiEditMode; }
			raygui::setStyle(raygui::DEFAULT, raygui::TEXT_WRAP_MODE, raygui::TEXT_WRAP_NONE);
			raygui::setStyle(raygui::DEFAULT, raygui::TEXT_ALIGNMENT_VERTICAL, raygui::TEXT_ALIGN_MIDDLE);

			raygui::setStyle(raygui::DEFAULT, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_LEFT);
			raygui::statusBar(Rectangle { 0, (float)rl::getScreenHeight() - 20, (float)rl::getScreenWidth(), 20 }, "This is a status bar");
			raygui::setStyle(raygui::DEFAULT, raygui::TEXT_ALIGNMENT, raygui::TEXT_ALIGN_CENTER);
			//raygui::setStyle(raygui::STATUSBAR, raygui::TEXT_INDENTATION, 20);

			if (showMessageBox)
			{
				rl::drawRectangle(0, 0, rl::getScreenWidth(), rl::getScreenHeight(), rl::fade(rl::RAYWHITE, 0.8f));
				int result = raygui::messageBox(
				  Rectangle {
					(float)rl::getScreenWidth()/2 - 125,
					(float)rl::getScreenHeight()/2 - 50,
					250,
					100
				  },
				  raygui::iconText(ICON_EXIT, "Close Window"),
				  "Do you really want to exit?",
				  "Yes;No"
				);

				if ((result == 0) || (result == 2)) { showMessageBox = false; }
				else if (result == 1) { exitWindow = true; }
			}

			if (showTextInputBox)
			{
				rl::drawRectangle(0, 0, rl::getScreenWidth(), rl::getScreenHeight(), rl::fade(rl::RAYWHITE, 0.8f));
				int result = raygui::textInputBox(
				  Rectangle {
					(float)rl::getScreenWidth()/2 - 120,
					(float)rl::getScreenHeight()/2 - 60,
					240,
					140
				  },
				  raygui::iconText(raygui::GuiIconName.ICON_FILE_SAVE, "Save file as..."),
				  "Introduce output file name:", "Ok;Cancel", textInput, null);


				if (result == 1)
				{
					// TODO: Validate textInput value and save

					rl::textCopy((ZString)textInputFileName.ptr, (ZString)textInput.ptr);
				}

				if ((result == 0) || (result == 1) || (result == 2))
				{
					showTextInputBox = false;
					rl::textCopy((ZString)textInput.ptr, "\0");
				}
			}
			//----------------------------------------------------------------------------------
		};
		//----------------------------------------------------------------------------------
	}

	// De-Initialization
	//--------------------------------------------------------------------------------------
	rl::closeWindow(); // Close window and OpenGL context
	//--------------------------------------------------------------------------------------

	return 0;
}
