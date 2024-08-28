/*******************************************************************************************
*
*   raygui - controls test suite
*
*   TEST CONTROLS:
*       - GuiDropdownBox()
*       - GuiCheckBox()
*       - GuiSpinner()
*       - GuiValueBox()
*       - GuiTextBox()
*       - GuiButton()
*       - GuiComboBox()
*       - GuiListView()
*       - GuiToggleGroup()
*       - GuiColorPicker()
*       - GuiSlider()
*       - GuiSliderBar()
*       - GuiProgressBar()
*       - GuiColorBarAlpha()
*       - GuiScrollPanel()
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
import rl;
import rgui;

//#define RAYGUI_DEBUG_RECS_BOUNDS
//#define RAYGUI_DEBUG_TEXT_BOUNDS

/*
#define RAYGUI_IMPLEMENTATION
//#define RAYGUI_CUSTOM_ICONS     // It requires providing gui_icons.h in the same directory
//#include "gui_icons.h"          // External icons data provided, it can be generated with rGuiIcons tool
#include "../../src/raygui.h"

// raygui embedded styles
#include "../styles/style_cyber.h"             // raygui style: cyber
#include "../styles/style_jungle.h"            // raygui style: jungle
#include "../styles/style_lavanda.h"           // raygui style: lavanda
#include "../styles/style_dark.h"              // raygui style: dark
#include "../styles/style_bluish.h"            // raygui style: bluish
#include "../styles/style_terminal.h"          // raygui style: terminal
*/

macro ZString to_zstr(arr) {
  return (ZString)((char[])&arr).ptr;
}

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

    char[64] textBoxText = "Text box";
    bool textBoxEditMode = false;

    char[1024] textBoxMultiText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    bool textBoxMultiEditMode = false;

    int listViewScrollIndex = 0;
    int listViewActive = -1;

    int listViewExScrollIndex = 0;
    int listViewExActive = 2;
    int listViewExFocus = -1;
    char*[8] listViewExList = { "This", "is", "a", "list view", "with", "disable", "elements", "amazing!" };

    char[256] multiTextBoxText = "Multi text box";
    bool multiTextBoxEditMode = false;
    rl::Color colorPickerValue = rl::RED;

    float sliderValue = 50.0f;
    float sliderBarValue = 60;
    float progressValue = 0.1f;

    bool forceSquaredChecked = false;

    float alphaValue = 0.5f;

    //int comboBoxActive = 1;
    int visualStyleActive = 0;
    int prevVisualStyleActive = 0;

    int toggleGroupActive = 0;
    int toggleSliderActive = 0;

    rl::Vector2 viewScroll = { 0, 0 };
    //----------------------------------------------------------------------------------

    // Custom GUI font loading
    //Font font = LoadFontEx("fonts/rainyhearts16.ttf", 12, 0, 0);
    //GuiSetFont(font);

    bool exitWindow = false;
    bool showMessageBox = false;

    char[256] textInput;
    char[256] textInputFileName;
    bool showTextInputBox = false;

    float alpha = 1.0f;

    // DEBUG: Testing how those two properties affect all controls!
    //GuiSetStyle(DEFAULT, TEXT_PADDING, 0);
    //GuiSetStyle(DEFAULT, TEXT_ALIGNMENT, TEXT_ALIGN_CENTER);

    rl::set_target_fps(60);
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!exitWindow)    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        exitWindow = rl::window_should_close();

        if (rl::is_key_pressed(rl::KEY_ESCAPE)) { showMessageBox = !showMessageBox; }

        if (rl::is_key_down(rl::KEY_LEFT_CONTROL) && rl::is_key_pressed(rl::KEY_S)) { showTextInputBox = true; }

        if (rl::is_file_dropped())
        {
            rl::FilePathList droppedFiles = rl::load_dropped_files();

            if ((droppedFiles.count > 0) && rl::is_file_extension((ZString)droppedFiles.paths[0], ".rgs")) { rgui::gui_load_style((ZString)droppedFiles.paths[0]); }

            rl::unload_dropped_files(droppedFiles);    // Clear internal buffers
        }

        //alpha -= 0.002f;
        if (alpha < 0.0f) alpha = 0.0f;
        if (rl::is_key_pressed(rl::KEY_SPACE)) alpha = 1.0f;

        rgui::gui_set_alpha(alpha);

        //progressValue += 0.002f;
        if (rl::is_key_pressed(rl::KEY_LEFT)) { progressValue -= 0.1f; }
        else if (rl::is_key_pressed(rl::KEY_RIGHT)) { progressValue += 0.1f; }
        if (progressValue > 1.0f) { progressValue = 1.0f; }
        else if (progressValue < 0.0f) { progressValue = 0.0f; }

        /*
        if (visualStyleActive != prevVisualStyleActive)
        {
            rgui::gui_load_style_default();

            switch (visualStyleActive)
            {
                case 0: break;      // Default style
                case 1: GuiLoadStyleJungle(); break;
                case 2: GuiLoadStyleLavanda(); break;
                case 3: GuiLoadStyleDark(); break;
                case 4: GuiLoadStyleBluish(); break;
                case 5: GuiLoadStyleCyber(); break;
                case 6: GuiLoadStyleTerminal(); break;
                default: break;
            }

            rgui::gui_set_style(LABEL, TEXT_ALIGNMENT, TEXT_ALIGN_LEFT);

            prevVisualStyleActive = visualStyleActive;
        }
        */
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl::begin_drawing();

            rl::clear_background(rl::get_color(rgui::gui_get_style(rgui::DEFAULT, rgui::BACKGROUND_COLOR)));

            // raygui: controls drawing
            //----------------------------------------------------------------------------------
            // Check all possible events that require GuiLock
            if (dropDown000EditMode || dropDown001EditMode) { rgui::gui_lock(); }

            // First GUI column
            //rgui::gui_set_style(rgui::CHECKBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
            rgui::gui_check_box(Rectangle { 25, 108, 15, 15 }, "FORCE CHECK!", &forceSquaredChecked);

            rgui::gui_set_style(rgui::TEXTBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_CENTER);
            //rgui::gui_set_style(rgui::VALUEBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
            if (rgui::gui_spinner(Rectangle { 25, 135, 125, 30 }, null, &spinner001Value, 0, 100, spinnerEditMode)) { spinnerEditMode = !spinnerEditMode; }
            if (rgui::gui_value_box(Rectangle { 25, 175, 125, 30 }, null, &valueBox002Value, 0, 100, valueBoxEditMode)) { valueBoxEditMode = !valueBoxEditMode; }
            rgui::gui_set_style(rgui::TEXTBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
            if (rgui::gui_text_box(Rectangle { 25, 215, 125, 30 }, to_zstr(textBoxText), 64, textBoxEditMode)) { textBoxEditMode = !textBoxEditMode; }

            rgui::gui_set_style(rgui::BUTTON, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_CENTER);

            if (rgui::gui_button(Rectangle { 25, 255, 125, 30 }, rgui::gui_icon_text(rgui::GuiIconName.ICON_FILE_SAVE, "Save File"))) { showTextInputBox = true; }

            rgui::gui_group_box(Rectangle { 25, 310, 125, 150 }, "STATES");
            //rgui::gui_lock();
            rgui::gui_set_state(rgui::STATE_NORMAL); if (rgui::gui_button(Rectangle { 30, 320, 115, 30 }, "NORMAL")) { }
            rgui::gui_set_state(rgui::STATE_FOCUSED); if (rgui::gui_button(Rectangle { 30, 355, 115, 30 }, "FOCUSED")) { }
            rgui::gui_set_state(rgui::STATE_PRESSED); if (rgui::gui_button(Rectangle { 30, 390, 115, 30 }, "#15#PRESSED")) { }
            rgui::gui_set_state(rgui::STATE_DISABLED); if (rgui::gui_button(Rectangle { 30, 425, 115, 30 }, "DISABLED")) { }
            rgui::gui_set_state(rgui::STATE_NORMAL);
            //rgui::gui_unlock();

            rgui::gui_combo_box(Rectangle { 25, 480, 125, 30 }, "default;Jungle;Lavanda;Dark;Bluish;Cyber;Terminal", &visualStyleActive);

            // NOTE: GuiDropdownBox must draw after any other control that can be covered on unfolding
            rgui::gui_unlock();
            rgui::gui_set_style(rgui::DROPDOWNBOX, rgui::TEXT_PADDING, 4);
            rgui::gui_set_style(rgui::DROPDOWNBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
            if (rgui::gui_dropdown_box(Rectangle { 25, 65, 125, 30 }, "#01#ONE;#02#TWO;#03#THREE;#04#FOUR", &dropdownBox001Active, dropDown001EditMode)) dropDown001EditMode = !dropDown001EditMode;
            rgui::gui_set_style(rgui::DROPDOWNBOX, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_CENTER);
            rgui::gui_set_style(rgui::DROPDOWNBOX, rgui::TEXT_PADDING, 0);

            if (rgui::gui_dropdown_box(Rectangle { 25, 25, 125, 30 }, "ONE;TWO;THREE", &dropdownBox000Active, dropDown000EditMode)) dropDown000EditMode = !dropDown000EditMode;

            // Second GUI column
            rgui::gui_list_view(Rectangle { 165, 25, 140, 124 }, "Charmander;Bulbasaur;#18#Squirtel;Pikachu;Eevee;Pidgey", &listViewScrollIndex, &listViewActive);
            rgui::gui_list_view_ex(Rectangle { 165, 162, 140, 184 }, (char**)&listViewExList, 8, &listViewExScrollIndex, &listViewExActive, &listViewExFocus);

            //GuiToggle(Rectangle { 165, 400, 140, 25 }, "#1#ONE", &toggleGroupActive);
            rgui::gui_toggle_group(Rectangle { 165, 360, 140, 24 }, "#1#ONE\n#3#TWO\n#8#THREE\n#23#", &toggleGroupActive);
            //GuiDisable();
            rgui::gui_set_style(rgui::SLIDER, rgui::SLIDER_PADDING, 2);
            rgui::gui_toggle_slider(Rectangle { 165, 480, 140, 30 }, "ON;OFF", &toggleSliderActive);
            rgui::gui_set_style(rgui::SLIDER, rgui::SLIDER_PADDING, 0);

            // Third GUI column
            rgui::gui_panel(Rectangle { 320, 25, 225, 140 }, "Panel Info");
            rgui::gui_color_picker(Rectangle { 320, 185, 196, 192 }, null, &colorPickerValue);

            //GuiDisable();
            rgui::gui_slider(Rectangle { 355, 400, 165, 20 }, "TEST", rl::text_format("%2.2f", sliderValue), &sliderValue, -50, 100);
            rgui::gui_slider_bar(Rectangle { 320, 430, 200, 20 }, null, rl::text_format("%i", (int)sliderBarValue), &sliderBarValue, 0, 100);
            
            rgui::gui_progress_bar(Rectangle { 320, 460, 200, 20 }, null, rl::text_format("%i%%", (int)(progressValue*100)), &progressValue, 0.0f, 1.0f);
            rgui::gui_enable();

            // NOTE: View rectangle could be used to perform some scissor test
            Rectangle view;
            rgui::gui_scroll_panel(Rectangle { 560, 25, 102, 354 }, null, Rectangle { 560, 25, 300, 1200 }, &viewScroll, &view);

            Vector2 mouseCell;
            rgui::gui_grid(Rectangle  { 560, 25 + 180 + 195, 100, 120 }, null, 20, 3, &mouseCell);

            rgui::gui_color_bar_alpha(Rectangle { 320, 490, 200, 30 }, null, &alphaValue);

            rgui::gui_set_style(rgui::DEFAULT, rgui::TEXT_ALIGNMENT_VERTICAL, rgui::TEXT_ALIGN_TOP);   // WARNING: Word-wrap does not work as expected in case of no-top alignment
            rgui::gui_set_style(rgui::DEFAULT, rgui::TEXT_WRAP_MODE, rgui::TEXT_WRAP_WORD);            // WARNING: If wrap mode enabled, text editing is not supported
            if (rgui::gui_text_box(Rectangle { 678, 25, 258, 492 }, to_zstr(textBoxMultiText), textBoxMultiText.len, textBoxMultiEditMode)) { textBoxMultiEditMode = !textBoxMultiEditMode; }
            rgui::gui_set_style(rgui::DEFAULT, rgui::TEXT_WRAP_MODE, rgui::TEXT_WRAP_NONE);
            rgui::gui_set_style(rgui::DEFAULT, rgui::TEXT_ALIGNMENT_VERTICAL, rgui::TEXT_ALIGN_MIDDLE);

            rgui::gui_set_style(rgui::DEFAULT, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_LEFT);
            rgui::gui_status_bar(Rectangle { 0, (float)rl::get_screen_height() - 20, (float)rl::get_screen_width(), 20 }, "This is a status bar");
            rgui::gui_set_style(rgui::DEFAULT, rgui::TEXT_ALIGNMENT, rgui::TEXT_ALIGN_CENTER);
            //gui_set_style(STATUSBAR, TEXT_INDENTATION, 20);

            if (showMessageBox)
            {
                rl::draw_rectangle(0, 0, rl::get_screen_width(), rl::get_screen_height(), rl::fade(rl::RAYWHITE, 0.8f));
                int result = rgui::gui_message_box(
                  Rectangle {
                    (float)rl::get_screen_width()/2 - 125,
                    (float)rl::get_screen_height()/2 - 50,
                    250,
                    100
                  },
                  rgui::gui_icon_text(ICON_EXIT, "Close Window"),
                  "Do you really want to exit?",
                  "Yes;No"
                );

                if ((result == 0) || (result == 2)) { showMessageBox = false; }
                else if (result == 1) { exitWindow = true; }
            }

            if (showTextInputBox)
            {
                rl::draw_rectangle(0, 0, rl::get_screen_width(), rl::get_screen_height(), rl::fade(rl::RAYWHITE, 0.8f));
                int result = rgui::gui_text_input_box(
                  Rectangle {
                    (float)rl::get_screen_width()/2 - 120,
                    (float)rl::get_screen_height()/2 - 60,
                    240,
                    140
                  },
                  rgui::gui_icon_text(rgui::GuiIconName.ICON_FILE_SAVE, "Save file as..."),
                  "Introduce output file name:",
                  "Ok;Cancel",
                  to_zstr(textInput),
                  textInput.len,
                  null
                );

                if (result == 1)
                {
                    // TODO: Validate textInput value and save

                    rl::text_copy(to_zstr(textInputFileName), to_zstr(textInput));
                }

                if ((result == 0) || (result == 1) || (result == 2))
                {
                    showTextInputBox = false;
                    rl::text_copy(to_zstr(textInput), "\0");
                }
            }
            //----------------------------------------------------------------------------------

        rl::end_drawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl::close_window();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}
