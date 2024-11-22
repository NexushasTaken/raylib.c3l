/******************************************************************************************
*
*   raygui v4.0 - A simple and easy-to-use immediate-mode gui library
*
*   DESCRIPTION:
*       raygui is a tools-dev-focused immediate-mode-gui library based on raylib but also
*       available as a standalone library, as long as input and drawing functions are provided.
*
*   FEATURES:
*       - Immediate-mode gui, minimal retained data
*       - +25 controls provided (basic and advanced)
*       - Styling system for colors, font and metrics
*       - Icons supported, embedded as a 1-bit icons pack
*       - Standalone mode option (custom input/graphics backend)
*       - Multiple support tools provided for raygui development
*
*   POSSIBLE IMPROVEMENTS:
*       - Better standalone mode API for easy plug of custom backends
*       - Externalize required inputs, allow user easier customization
*
*   LIMITATIONS:
*       - No editable multi-line word-wraped text box supported
*       - No auto-layout mechanism, up to the user to define controls position and size
*       - Standalone mode requires library modification and some user work to plug another backend
*
*   NOTES:
*       - WARNING: GuiLoadStyle() and GuiLoadStyle{Custom}() functions, allocate memory for
*         font atlas recs and glyphs, freeing that memory is (usually) up to the user,
*         no unload function is explicitly provided... but note that GuiLoadStyleDefaulf() unloads
*         by default any previously loaded font (texture, recs, glyphs).
*       - Global UI alpha (guiAlpha) is applied inside GuiDrawRectangle() and GuiDrawText() functions
*
*   CONTROLS PROVIDED:
*     # Container/separators Controls
*       - WindowBox     --> StatusBar, Panel
*       - GroupBox      --> Line
*       - Line
*       - Panel         --> StatusBar
*       - ScrollPanel   --> StatusBar
*       - TabBar        --> Button
*
*     # Basic Controls
*       - Label
*       - LabelButton   --> Label
*       - Button
*       - Toggle
*       - ToggleGroup   --> Toggle
*       - ToggleSlider
*       - CheckBox
*       - ComboBox
*       - DropdownBox
*       - TextBox
*       - ValueBox      --> TextBox
*       - Spinner       --> Button, ValueBox
*       - Slider
*       - SliderBar     --> Slider
*       - ProgressBar
*       - StatusBar
*       - DummyRec
*       - Grid
*
*     # Advance Controls
*       - ListView
*       - ColorPicker   --> ColorPanel, ColorBarHue
*       - MessageBox    --> Window, Label, Button
*       - TextInputBox  --> Window, Label, TextBox, Button
*
*     It also provides a set of functions for styling the controls based on its properties (size, color).
*
*
*   RAYGUI STYLE (guiStyle):
*       raygui uses a global data array for all gui style properties (allocated on data segment by default),
*       when a new style is loaded, it is loaded over the global style... but a default gui style could always be
*       recovered with GuiLoadStyleDefault() function, that overwrites the current style to the default one
*
*       The global style array size is fixed and depends on the number of controls and properties:
*
*           static unsigned int guiStyle[RAYGUI_MAX_CONTROLS*(RAYGUI_MAX_PROPS_BASE + RAYGUI_MAX_PROPS_EXTENDED)];
*
*       guiStyle size is by default: 16*(16 + 8) = 384*4 = 1536 bytes = 1.5 KB
*
*       Note that the first set of BASE properties (by default guiStyle[0..15]) belong to the generic style
*       used for all controls, when any of those base values is set, it is automatically populated to all
*       controls, so, specific control values overwriting generic style should be set after base values.
*
*       After the first BASE set we have the EXTENDED properties (by default guiStyle[16..23]), those
*       properties are actually common to all controls and can not be overwritten individually (like BASE ones)
*       Some of those properties are: TEXT_SIZE, TEXT_SPACING, LINE_COLOR, BACKGROUND_COLOR
*
*       Custom control properties can be defined using the EXTENDED properties for each independent control.
*
*       TOOL: rGuiStyler is a visual tool to customize raygui style: github.com/raysan5/rguistyler
*
*
*   RAYGUI ICONS (guiIcons):
*       raygui could use a global array containing icons data (allocated on data segment by default),
*       a custom icons set could be loaded over this array using GuiLoadIcons(), but loaded icons set
*       must be same RAYGUI_ICON_SIZE and no more than RAYGUI_ICON_MAX_ICONS will be loaded
*
*       Every icon is codified in binary form, using 1 bit per pixel, so, every 16x16 icon
*       requires 8 integers (16*16/32) to be stored in memory.
*
*       When the icon is draw, actually one quad per pixel is drawn if the bit for that pixel is set.
*
*       The global icons array size is fixed and depends on the number of icons and size:
*
*           static unsigned int guiIcons[RAYGUI_ICON_MAX_ICONS*RAYGUI_ICON_DATA_ELEMENTS];
*
*       guiIcons size is by default: 256*(16*16/32) = 2048*4 = 8192 bytes = 8 KB
*
*       TOOL: rGuiIcons is a visual tool to customize/create raygui icons: github.com/raysan5/rguiicons
*
*   RAYGUI LAYOUT:
*       raygui currently does not provide an auto-layout mechanism like other libraries,
*       layouts must be defined manually on controls drawing, providing the right bounds Rectangle for it.
*
*       TOOL: rGuiLayout is a visual tool to create raygui layouts: github.com/raysan5/rguilayout
*
*   CONFIGURATION:
*       #define RAYGUI_IMPLEMENTATION
*           Generates the implementation of the library into the included file.
*           If not defined, the library is in header only mode and can be included in other headers
*           or source files without problems. But only ONE file should hold the implementation.
*
*       #define RAYGUI_STANDALONE
*           Avoid raylib.h header inclusion in this file. Data types defined on raylib are defined
*           internally in the library and input management and drawing functions must be provided by
*           the user (check library implementation for further details).
*
*       #define RAYGUI_NO_ICONS
*           Avoid including embedded ricons data (256 icons, 16x16 pixels, 1-bit per pixel, 2KB)
*
*       #define RAYGUI_CUSTOM_ICONS
*           Includes custom ricons.h header defining a set of custom icons,
*           this file can be generated using rGuiIcons tool
*
*       #define RAYGUI_DEBUG_RECS_BOUNDS
*           Draw control bounds rectangles for debug
* 
*       #define RAYGUI_DEBUG_TEXT_BOUNDS
*           Draw text bounds rectangles for debug
*
*   VERSIONS HISTORY:
*       4.0 (12-Sep-2023) ADDED: GuiToggleSlider()
*                         ADDED: GuiColorPickerHSV() and GuiColorPanelHSV()
*                         ADDED: Multiple new icons, mostly compiler related
*                         ADDED: New DEFAULT properties: TEXT_LINE_SPACING, TEXT_ALIGNMENT_VERTICAL, TEXT_WRAP_MODE
*                         ADDED: New enum values: GuiTextAlignment, GuiTextAlignmentVertical, GuiTextWrapMode
*                         ADDED: Support loading styles with custom font charset from external file
*                         REDESIGNED: GuiTextBox(), support mouse cursor positioning
*                         REDESIGNED: GuiDrawText(), support multiline and word-wrap modes (read only)
*                         REDESIGNED: GuiProgressBar() to be more visual, progress affects border color
*                         REDESIGNED: Global alpha consideration moved to GuiDrawRectangle() and GuiDrawText()
*                         REDESIGNED: GuiScrollPanel(), get parameters by reference and return result value
*                         REDESIGNED: GuiToggleGroup(), get parameters by reference and return result value
*                         REDESIGNED: GuiComboBox(), get parameters by reference and return result value
*                         REDESIGNED: GuiCheckBox(), get parameters by reference and return result value
*                         REDESIGNED: GuiSlider(), get parameters by reference and return result value
*                         REDESIGNED: GuiSliderBar(), get parameters by reference and return result value
*                         REDESIGNED: GuiProgressBar(), get parameters by reference and return result value
*                         REDESIGNED: GuiListView(), get parameters by reference and return result value
*                         REDESIGNED: GuiColorPicker(), get parameters by reference and return result value
*                         REDESIGNED: GuiColorPanel(), get parameters by reference and return result value
*                         REDESIGNED: GuiColorBarAlpha(), get parameters by reference and return result value
*                         REDESIGNED: GuiColorBarHue(), get parameters by reference and return result value
*                         REDESIGNED: GuiGrid(), get parameters by reference and return result value
*                         REDESIGNED: GuiGrid(), added extra parameter
*                         REDESIGNED: GuiListViewEx(), change parameters order
*                         REDESIGNED: All controls return result as int value
*                         REVIEWED: GuiScrollPanel() to avoid smallish scroll-bars
*                         REVIEWED: All examples and specially controls_test_suite
*                         RENAMED: gui_file_dialog module to gui_window_file_dialog
*                         UPDATED: All styles to include ISO-8859-15 charset (as much as possible)
*
*       3.6 (10-May-2023) ADDED: New icon: SAND_TIMER
*                         ADDED: GuiLoadStyleFromMemory() (binary only)
*                         REVIEWED: GuiScrollBar() horizontal movement key
*                         REVIEWED: GuiTextBox() crash on cursor movement
*                         REVIEWED: GuiTextBox(), additional inputs support
*                         REVIEWED: GuiLabelButton(), avoid text cut
*                         REVIEWED: GuiTextInputBox(), password input
*                         REVIEWED: Local GetCodepointNext(), aligned with raylib
*                         REDESIGNED: GuiSlider*()/GuiScrollBar() to support out-of-bounds
*
*       3.5 (20-Apr-2023) ADDED: GuiTabBar(), based on GuiToggle()
*                         ADDED: Helper functions to split text in separate lines
*                         ADDED: Multiple new icons, useful for code editing tools
*                         REMOVED: Unneeded icon editing functions
*                         REMOVED: GuiTextBoxMulti(), very limited and broken
*                         REMOVED: MeasureTextEx() dependency, logic directly implemented
*                         REMOVED: DrawTextEx() dependency, logic directly implemented
*                         REVIEWED: GuiScrollBar(), improve mouse-click behaviour
*                         REVIEWED: Library header info, more info, better organized
*                         REDESIGNED: GuiTextBox() to support cursor movement
*                         REDESIGNED: GuiDrawText() to divide drawing by lines
*
*       3.2 (22-May-2022) RENAMED: Some enum values, for unification, avoiding prefixes
*                         REMOVED: GuiScrollBar(), only internal
*                         REDESIGNED: GuiPanel() to support text parameter
*                         REDESIGNED: GuiScrollPanel() to support text parameter
*                         REDESIGNED: GuiColorPicker() to support text parameter
*                         REDESIGNED: GuiColorPanel() to support text parameter
*                         REDESIGNED: GuiColorBarAlpha() to support text parameter
*                         REDESIGNED: GuiColorBarHue() to support text parameter
*                         REDESIGNED: GuiTextInputBox() to support password
*
*       3.1 (12-Jan-2022) REVIEWED: Default style for consistency (aligned with rGuiLayout v2.5 tool)
*                         REVIEWED: GuiLoadStyle() to support compressed font atlas image data and unload previous textures
*                         REVIEWED: External icons usage logic
*                         REVIEWED: GuiLine() for centered alignment when including text
*                         RENAMED: Multiple controls properties definitions to prepend RAYGUI_
*                         RENAMED: RICON_ references to RAYGUI_ICON_ for library consistency
*                         Projects updated and multiple tweaks
*
*       3.0 (04-Nov-2021) Integrated ricons data to avoid external file
*                         REDESIGNED: GuiTextBoxMulti()
*                         REMOVED: GuiImageButton*()
*                         Multiple minor tweaks and bugs corrected
*
*       2.9 (17-Mar-2021) REMOVED: Tooltip API
*       2.8 (03-May-2020) Centralized rectangles drawing to GuiDrawRectangle()
*       2.7 (20-Feb-2020) ADDED: Possible tooltips API
*       2.6 (09-Sep-2019) ADDED: GuiTextInputBox()
*                         REDESIGNED: GuiListView*(), GuiDropdownBox(), GuiSlider*(), GuiProgressBar(), GuiMessageBox()
*                         REVIEWED: GuiTextBox(), GuiSpinner(), GuiValueBox(), GuiLoadStyle()
*                         Replaced property INNER_PADDING by TEXT_PADDING, renamed some properties
*                         ADDED: 8 new custom styles ready to use
*                         Multiple minor tweaks and bugs corrected
*
*       2.5 (28-May-2019) Implemented extended GuiTextBox(), GuiValueBox(), GuiSpinner()
*       2.3 (29-Apr-2019) ADDED: rIcons auxiliar library and support for it, multiple controls reviewed
*                         Refactor all controls drawing mechanism to use control state
*       2.2 (05-Feb-2019) ADDED: GuiScrollBar(), GuiScrollPanel(), reviewed GuiListView(), removed Gui*Ex() controls
*       2.1 (26-Dec-2018) REDESIGNED: GuiCheckBox(), GuiComboBox(), GuiDropdownBox(), GuiToggleGroup() > Use combined text string
*                         REDESIGNED: Style system (breaking change)
*       2.0 (08-Nov-2018) ADDED: Support controls guiLock and custom fonts
*                         REVIEWED: GuiComboBox(), GuiListView()...
*       1.9 (09-Oct-2018) REVIEWED: GuiGrid(), GuiTextBox(), GuiTextBoxMulti(), GuiValueBox()...
*       1.8 (01-May-2018) Lot of rework and redesign to align with rGuiStyler and rGuiLayout
*       1.5 (21-Jun-2017) Working in an improved styles system
*       1.4 (15-Jun-2017) Rewritten all GUI functions (removed useless ones)
*       1.3 (12-Jun-2017) Complete redesign of style system
*       1.1 (01-Jun-2017) Complete review of the library
*       1.0 (07-Jun-2016) Converted to header-only by Ramon Santamaria.
*       0.9 (07-Mar-2016) Reviewed and tested by Albert Martos, Ian Eito, Sergio Martinez and Ramon Santamaria.
*       0.8 (27-Aug-2015) Initial release. Implemented by Kevin Gato, Daniel Nicolás and Ramon Santamaria.
*
*   DEPENDENCIES:
*       raylib 4.6-dev      Inputs reading (keyboard/mouse), shapes drawing, font loading and text drawing
*
*   STANDALONE MODE:
*       By default raygui depends on raylib mostly for the inputs and the drawing functionality but that dependency can be disabled
*       with the config flag RAYGUI_STANDALONE. In that case is up to the user to provide another backend to cover library needs.
*
*       The following functions should be redefined for a custom backend:
*
*           - Vector2 GetMousePosition();
*           - float GetMouseWheelMove();
*           - bool IsMouseButtonDown(int button);
*           - bool IsMouseButtonPressed(int button);
*           - bool IsMouseButtonReleased(int button);
*           - bool IsKeyDown(int key);
*           - bool IsKeyPressed(int key);
*           - int GetCharPressed();         // -- GuiTextBox(), GuiValueBox()
*
*           - void DrawRectangle(int x, int y, int width, int height, Color color); // -- GuiDrawRectangle()
*           - void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4); // -- GuiColorPicker()
*
*           - Font GetFontDefault();                            // -- GuiLoadStyleDefault()
*           - Font LoadFontEx(const char *fileName, int fontSize, int *codepoints, int codepointCount); // -- GuiLoadStyle()
*           - Texture2D LoadTextureFromImage(Image image);          // -- GuiLoadStyle(), required to load texture from embedded font atlas image
*           - void SetShapesTexture(Texture2D tex, Rectangle rec);  // -- GuiLoadStyle(), required to set shapes rec to font white rec (optimization)
*           - char *LoadFileText(const char *fileName);             // -- GuiLoadStyle(), required to load charset data
*           - void UnloadFileText(char *text);                      // -- GuiLoadStyle(), required to unload charset data
*           - const char *GetDirectoryPath(const char *filePath);   // -- GuiLoadStyle(), required to find charset/font file from text .rgs
*           - int *LoadCodepoints(const char *text, int *count);    // -- GuiLoadStyle(), required to load required font codepoints list
*           - void UnloadCodepoints(int *codepoints);               // -- GuiLoadStyle(), required to unload codepoints list
*           - unsigned char *DecompressData(const unsigned char *compData, int compDataSize, int *dataSize); // -- GuiLoadStyle()
*
*   CONTRIBUTORS:
*       Ramon Santamaria:   Supervision, review, redesign, update and maintenance
*       Vlad Adrian:        Complete rewrite of GuiTextBox() to support extended features (2019)
*       Sergio Martinez:    Review, testing (2015) and redesign of multiple controls (2018)
*       Adria Arranz:       Testing and implementation of additional controls (2018)
*       Jordi Jorba:        Testing and implementation of additional controls (2018)
*       Albert Martos:      Review and testing of the library (2015)
*       Ian Eito:           Review and testing of the library (2015)
*       Kevin Gato:         Initial implementation of basic components (2014)
*       Daniel Nicolas:     Initial implementation of basic components (2014)
*
*
*   LICENSE: zlib/libpng
*
*   Copyright (c) 2014-2023 Ramon Santamaria (@raysan5)
*
*   This software is provided "as-is", without any express or implied warranty. In no event
*   will the authors be held liable for any damages arising from the use of this software.
*
*   Permission is granted to anyone to use this software for any purpose, including commercial
*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
*
*     1. The origin of this software must not be misrepresented; you must not claim that you
*     wrote the original software. If you use this software in a product, an acknowledgment
*     in the product documentation would be appreciated but is not required.
*
*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
*     as being the original software.
*
*     3. This notice may not be removed or altered from any source distribution.
*
**********************************************************************************************/
module raygui @if($feature(ENABLE_RAYGUI));
import rl;

const RAYGUI_VERSION_MAJOR = 4;
const RAYGUI_VERSION_MINOR = 0;
const RAYGUI_VERSION_PATCH = 0;
const RAYGUI_VERSION = "4.0";

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------

// Style property
// NOTE: Used when exporting style as code for convenience
struct GuiStyleProp {
	ushort control_id;  // Control identifier
	ushort property_id; // Property identifier
	int property_value; // Property value
}

// Gui control state
def GuiState = int;
const GuiState STATE_NORMAL   = 0;
const GuiState STATE_FOCUSED  = 1;
const GuiState STATE_PRESSED  = 2;
const GuiState STATE_DISABLED = 3;

// Gui control text alignment
def GuiTextAlignment = int;
const GuiTextAlignment TEXT_ALIGN_LEFT   = 0;
const GuiTextAlignment TEXT_ALIGN_CENTER = 1;
const GuiTextAlignment TEXT_ALIGN_RIGHT  = 2;

// Gui control text alignment vertical
// NOTE: Text vertical position inside the text bounds
def GuiTextAlignmentVertical = int;
const GuiTextAlignmentVertical TEXT_ALIGN_TOP    = 0;
const GuiTextAlignmentVertical TEXT_ALIGN_MIDDLE = 1;
const GuiTextAlignmentVertical TEXT_ALIGN_BOTTOM = 2;

// Gui control text wrap mode
// NOTE: Useful for multiline text
def GuiTextWrapMode = int;
const GuiTextWrapMode TEXT_WRAP_NONE = 0;
const GuiTextWrapMode TEXT_WRAP_CHAR = 1;
const GuiTextWrapMode TEXT_WRAP_WORD = 2;

// Gui controls
def GuiControl = int;
// Default -> populates to all controls when set
const GuiControl DEFAULT     = 0;
// Basic controls
const GuiControl LABEL       = 1;  // Used also for: LABELBUTTON
const GuiControl BUTTON      = 2;
const GuiControl TOGGLE      = 3;  // Used also for: TOGGLEGROUP
const GuiControl SLIDER      = 4;  // Used also for: SLIDERBAR, TOGGLESLIDER
const GuiControl PROGRESSBAR = 5;
const GuiControl CHECKBOX    = 6;
const GuiControl COMBOBOX    = 7;
const GuiControl DROPDOWNBOX = 8;
const GuiControl TEXTBOX     = 9;  // Used also for: TEXTBOXMULTI
const GuiControl VALUEBOX    = 10;
const GuiControl SPINNER     = 11; // Uses: BUTTON, VALUEBOX
const GuiControl LISTVIEW    = 12;
const GuiControl COLORPICKER = 13;
const GuiControl SCROLLBAR   = 14;
const GuiControl STATUSBAR   = 15;

// Gui base properties for every control
// NOTE: RAYGUI_MAX_PROPS_BASE properties (by default 16 properties)
def GuiControlProperty = int;
const GuiControlProperty BORDER_COLOR_NORMAL   = 0;      // Control border color in STATE_NORMAL
const GuiControlProperty BASE_COLOR_NORMAL     = 1;      // Control base color in STATE_NORMAL
const GuiControlProperty TEXT_COLOR_NORMAL     = 2;      // Control text color in STATE_NORMAL
const GuiControlProperty BORDER_COLOR_FOCUSED  = 3;      // Control border color in STATE_FOCUSED
const GuiControlProperty BASE_COLOR_FOCUSED    = 4;      // Control base color in STATE_FOCUSED
const GuiControlProperty TEXT_COLOR_FOCUSED    = 5;      // Control text color in STATE_FOCUSED
const GuiControlProperty BORDER_COLOR_PRESSED  = 6;      // Control border color in STATE_PRESSED
const GuiControlProperty BASE_COLOR_PRESSED    = 7;      // Control base color in STATE_PRESSED
const GuiControlProperty TEXT_COLOR_PRESSED    = 8;      // Control text color in STATE_PRESSED
const GuiControlProperty BORDER_COLOR_DISABLED = 9;      // Control border color in STATE_DISABLED
const GuiControlProperty BASE_COLOR_DISABLED   = 10;     // Control base color in STATE_DISABLED
const GuiControlProperty TEXT_COLOR_DISABLED   = 11;     // Control text color in STATE_DISABLED
const GuiControlProperty BORDER_WIDTH          = 12;     // Control border size, 0 for no border
//const GuiControlProperty TEXT_SIZE;                      // Control text size (glyphs max height) -> GLOBAL for all controls
//const GuiControlProperty TEXT_SPACING;                   // Control text spacing between glyphs -> GLOBAL for all controls
//const GuiControlProperty TEXT_LINE_SPACING;              // Control text spacing between lines -> GLOBAL for all controls
const GuiControlProperty TEXT_PADDING          = 13;     // Control text padding, not considering border
const GuiControlProperty TEXT_ALIGNMENT        = 14;     // Control text horizontal alignment inside control text bound (after border and padding)

// Gui extended properties depend on control
// NOTE: RAYGUI_MAX_PROPS_EXTENDED properties (by default, max 8 properties)
//----------------------------------------------------------------------------------
// DEFAULT extended properties
// NOTE: Those properties are common to all controls or global
// WARNING: We only have 8 slots for those properties by default!!! -> New global control: TEXT?
def GuiDefaultProperty = int;
const GuiDefaultProperty TEXT_SIZE               = 16; // Text size (glyphs max height)
const GuiDefaultProperty TEXT_SPACING            = 17; // Text spacing between glyphs
const GuiDefaultProperty LINE_COLOR              = 18; // Line control color
const GuiDefaultProperty BACKGROUND_COLOR        = 19; // Background color
const GuiDefaultProperty TEXT_LINE_SPACING       = 20; // Text spacing between lines
const GuiDefaultProperty TEXT_ALIGNMENT_VERTICAL = 21; // Text vertical alignment inside text bounds (after border and padding)
const GuiDefaultProperty TEXT_WRAP_MODE          = 22; // Text wrap-mode inside text bounds
//const GuiDefaultProperty TEXT_DECORATION;              // Text decoration: 0-None, 1-Underline, 2-Line-through, 3-Overline
//const GuiDefaultProperty TEXT_DECORATION_THICK;        // Text decoration line thikness

// Toggle/ToggleGroup
def GuiToggleProperty = int;
const GuiToggleProperty GROUP_PADDING = 16; // ToggleGroup separation between toggles

// Slider/SliderBar
def GuiSliderProperty = int;
const GuiSliderProperty SLIDER_WIDTH   = 16; // Slider size of internal bar
const GuiSliderProperty SLIDER_PADDING = 17; // Slider/SliderBar internal bar padding

// ProgressBar
def GuiProgressBarProperty = int;
const GuiProgressBarProperty PROGRESS_PADDING = 16; // ProgressBar internal padding

// ScrollBar
def GuiScrollBarProperty = int;
const GuiScrollBarProperty ARROWS_SIZE           = 16; // ScrollBar arrows size
const GuiScrollBarProperty ARROWS_VISIBLE        = 17; // ScrollBar arrows visible
const GuiScrollBarProperty SCROLL_SLIDER_PADDING = 18; // ScrollBar slider internal padding
const GuiScrollBarProperty SCROLL_SLIDER_SIZE    = 19; // ScrollBar slider size
const GuiScrollBarProperty SCROLL_PADDING        = 20; // ScrollBar scroll padding from arrows
const GuiScrollBarProperty SCROLL_SPEED          = 21; // ScrollBar scrolling speed

// CheckBox
def GuiCheckBoxProperty = int;
const GuiCheckBoxProperty CHECK_PADDING = 16; // CheckBox internal check padding

// ComboBox
def GuiComboBoxProperty = int;
const GuiComboBoxProperty COMBO_BUTTON_WIDTH   = 16; // ComboBox right button width
const GuiComboBoxProperty COMBO_BUTTON_SPACING = 17; // ComboBox button separation

// DropdownBox
def GuiDropdownBoxProperty = int;
const GuiDropdownBoxProperty ARROW_PADDING = 16;          // DropdownBox arrow separation from border and items
const GuiDropdownBoxProperty DROPDOWN_ITEMS_SPACING = 17; // DropdownBox items separation

// TextBox/TextBoxMulti/ValueBox/Spinner
def GuiTextBoxProperty = int;
const GuiTextBoxProperty TEXT_READONLY = 16; // TextBox in read-only mode: 0-text editable, 1-text no-editable

// Spinner
def GuiSpinnerProperty = int;
const GuiSpinnerProperty SPIN_BUTTON_WIDTH   = 16; // Spinner left/right buttons width
const GuiSpinnerProperty SPIN_BUTTON_SPACING = 17; // Spinner buttons separation

// ListView
def GuiListViewProperty = int;
const GuiListViewProperty LIST_ITEMS_HEIGHT  = 16; // ListView items height
const GuiListViewProperty LIST_ITEMS_SPACING = 17; // ListView items separation
const GuiListViewProperty SCROLLBAR_WIDTH    = 18; // ListView scrollbar size (usually width)
const GuiListViewProperty SCROLLBAR_SIDE     = 19; // ListView scrollbar side (0-SCROLLBAR_LEFT_SIDE, 1-SCROLLBAR_RIGHT_SIDE)

// ColorPicker
def GuiColorPickerProperty = int;
const GuiColorPickerProperty COLOR_SELECTOR_SIZE      = 16;
const GuiColorPickerProperty HUEBAR_WIDTH             = 17; // ColorPicker right hue bar width
const GuiColorPickerProperty HUEBAR_PADDING           = 18; // ColorPicker right hue bar separation from panel
const GuiColorPickerProperty HUEBAR_SELECTOR_HEIGHT   = 19; // ColorPicker right hue bar selector height
const GuiColorPickerProperty HUEBAR_SELECTOR_OVERFLOW = 20; // ColorPicker right hue bar selector overflow

const SCROLLBAR_LEFT_SIDE  = 0;
const SCROLLBAR_RIGHT_SIDE = 1;

// TODO: remove functions name 'gui_' prefix?
//------------------------------------------------------------------------------------
// Global gui state control functions
//------------------------------------------------------------------------------------

<*
 Enable gui controls (global state)
*>
extern fn void enable() @extern("GuiEnable");

<*
 Disable gui controls (global state)
*>
extern fn void disable() @extern("GuiDisable");

<*
 Lock gui controls (global state)
*>
extern fn void lock() @extern("GuiLock");

<*
 Unlock gui controls (global state)
*>
extern fn void unlock() @extern("GuiUnlock");

<*
 Check if gui is locked (global state)
*>
extern fn bool isLocked() @extern("GuiIsLocked");

<*
 Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
 @require alpha >= 0.0f && alpha <= 1.0f
*>
extern fn void setAlpha(float alpha) @extern("GuiSetAlpha");

<*
 Set gui state (global state)
*>
extern fn void setState(GuiState state) @extern("GuiSetState");

<*
 Get gui state (global state)
*>
extern fn int getState() @extern("GuiGetState");

//------------------------------------------------------------------------------------
// Font set/get functions
//------------------------------------------------------------------------------------

<*
 Set gui custom font (global state)
*>
extern fn void setFont(rl::Font font) @extern("GuiSetFont");

<*
 Get gui custom font (global state)
*>
extern fn Font getFont() @extern("GuiGetFont");

//------------------------------------------------------------------------------------
// Style set/get functions
//------------------------------------------------------------------------------------

<*
 Set one style property
*>
extern fn void setStyle(int control, int property, int value) @extern("GuiSetStyle");

<*
 Get one style property
*>
extern fn int getStyle(int control, int property) @extern("GuiGetStyle");

//------------------------------------------------------------------------------------
// Styles loading functions
//------------------------------------------------------------------------------------

<*
 Load style file over global style variable (.rgs)
*>
extern fn void loadStyle(ZString file_name) @extern("GuiLoadStyle");

<*
 Load style default over global style
*>
extern fn void loadStyleDefault() @extern("GuiLoadStyleDefault");

//------------------------------------------------------------------------------------
// Tooltips management functions
//------------------------------------------------------------------------------------

<*
 Enable gui tooltips (global state)
*>
extern fn void enableTooltip() @extern("GuiEnableTooltip");

<*
 Disable gui tooltips (global state)
*>
extern fn void disableTooltip() @extern("GuiDisableTooltip");

<*
 Set tooltip string
*>
extern fn void setTooltip(ZString tooltip) @extern("GuiSetTooltip");

//------------------------------------------------------------------------------------
// Icons functionality
//------------------------------------------------------------------------------------

<*
 Get text with icon id prepended (if supported)
*>
extern fn ZString iconText(GuiIconName icon_id, ZString text) @extern("GuiIconText");

<*
 Set default icon drawing size
*>
extern fn void setIconScale(int scale) @extern("GuiSetIconScale") @if(!$feature(RAYGUI_NO_ICONS));

<*
 Get raygui icons data pointer
*>
extern fn uint* getIcons() @extern("GuiGetIcons") @if(!$feature(RAYGUI_NO_ICONS));

<*
 Load raygui icons file (.rgi) into internal icons data
*>
extern fn char** loadIcons(ZString file_name, bool load_icons_name) @extern("GuiLoadIcons") @if(!$feature(RAYGUI_NO_ICONS));

<*
 Draw icon using pixel size at specified position
*>
extern fn void drawIcon(GuiIconName icon_id, int pos_x, int pos_y, int pixel_size, rl::Color color) @extern("GuiDrawIcon") @if(!$feature(RAYGUI_NO_ICONS));

//------------------------------------------------------------------------------------
// Controls
//------------------------------------------------------------------------------------
// Container/separator controls, useful for controls organization
//------------------------------------------------------------------------------------

<*
 Window Box control, shows a window that can be closed
*>
extern fn int windowBox(rl::Rectangle bounds, ZString title) @extern("GuiWindowBox");

<*
 Group Box control with text name
*>
extern fn int groupBox(rl::Rectangle bounds, ZString text) @extern("GuiGroupBox");

<*
 Line separator control, could contain text
*>
extern fn int line(rl::Rectangle bounds, ZString text) @extern("GuiLine");

<*
 Panel control, useful to group controls
*>
extern fn int panel(rl::Rectangle bounds, ZString text) @extern("GuiPanel");

<*
 Tab Bar control, returns TAB to be closed or -1
 @require text.len <= int.max
 @param [&inout] active
*>
fn int tabBar(rl::Rectangle bounds, ZString[] text, int* active) @inline {
  return raygui::__gui_tab_bar(bounds, text.ptr, (int)text.len, active);
}

<*
 Scroll Panel control
 @param [inout] scroll
 @param [&inout] view
*>
extern fn int scrollPanel(rl::Rectangle bounds, ZString text, rl::Rectangle content, rl::Vector2* scroll, rl::Rectangle* view) @extern("GuiScrollPanel");

//------------------------------------------------------------------------------------
// Basic controls set
//------------------------------------------------------------------------------------

<*
 Label control, shows text
*>
extern fn int label(rl::Rectangle bounds, ZString text) @extern("GuiLabel");

<*
 Button control, returns true when clicked
*>
extern fn int button(rl::Rectangle bounds, ZString text) @extern("GuiButton");

<*
 Label button control, show true when clicked
*>
extern fn int labelButton(rl::Rectangle bounds, ZString text) @extern("GuiLabelButton");

<*
 Toggle Button control, returns true when active
 @param [&inout] active
*>
extern fn int toggle(rl::Rectangle bounds, ZString text, bool* active) @extern("GuiToggle");

<*
 Toggle Group control, returns active toggle index
 @param [&inout] active
*>
extern fn int toggleGroup(rl::Rectangle bounds, ZString text, int* active) @extern("GuiToggleGroup");

<*
 Toggle Slider control, returns true when clicked
 @param [&inout] active
*>
extern fn int toggleSlider(rl::Rectangle bounds, ZString text, int* active) @extern("GuiToggleSlider");

<*
 Check Box control, returns true when active
 @param [&inout] checked
*>
extern fn int checkBox(rl::Rectangle bounds, ZString text, bool* checked) @extern("GuiCheckBox");

<*
 Combo Box control, returns selected item index
 @param [&inout] active
*>
extern fn int comboBox(rl::Rectangle bounds, ZString text, int* active) @extern("GuiComboBox");

<*
 Dropdown Box control, returns selected item
 @param [&inout] active
*>
extern fn int dropdownBox(rl::Rectangle bounds, ZString text, int* active, bool edit_mode) @extern("GuiDropdownBox");

<*
 Spinner control, returns selected value
 @param [&inout] value
*>
extern fn int spinner(rl::Rectangle bounds, ZString text, int* value, int min_value, int max_value, bool edit_mode) @extern("GuiSpinner");

<*
 Value Box control, updates input text with numbers
 @param [&inout] value
*>
extern fn int valueBox(rl::Rectangle bounds, ZString text, int* value, int min_value, int max_value, bool edit_mode) @extern("GuiValueBox");

<*
 Text Box control, updates input text
 @require text.len <= int.max
*>
fn int textBox(rl::Rectangle bounds, char[] text, bool edit_mode) @inline {
    return raygui::__gui_text_box(bounds, text.ptr, (int)text.len, edit_mode);
}

<*
 Slider control, returns selected value
 @param [&inout] value
*>
extern fn int slider(rl::Rectangle bounds, ZString text_left, ZString text_right, float* value, float min_value, float max_value) @extern("GuiSlider");

<*
 Slider Bar control, returns selected value
 @param [&inout] value
*>
extern fn int sliderBar(rl::Rectangle bounds, ZString text_left, ZString text_right, float* value, float min_value, float max_value) @extern("GuiSliderBar");

<*
 Progress Bar control, shows current progress value
 @param [&inout] value
*>
extern fn int progressBar(rl::Rectangle bounds, ZString text_left, ZString text_right, float* value, float min_value, float max_value) @extern("GuiProgressBar");

<*
 Status Bar control, shows info text
*>
extern fn int statusBar(rl::Rectangle bounds, ZString text) @extern("GuiStatusBar");

<*
 Dummy control for placeholders
*>
extern fn int dummyRec(rl::Rectangle bounds, ZString text) @extern("GuiDummyRec");

<*
 Grid control, returns mouse cell position
 @param [out] mouse_cell
*>
extern fn int grid(rl::Rectangle bounds, ZString text, float spacing, int subdivs, rl::Vector2* mouse_cell) @extern("GuiGrid");

//------------------------------------------------------------------------------------
// Advance controls set
//------------------------------------------------------------------------------------

<*
 List View control, returns selected list item index
 @param [&inout] scroll_index
 @param [&inout] active
*>
extern fn int listView(rl::Rectangle bounds, ZString text, int* scroll_index, int* active) @extern("GuiListView");

<*
 List View with extended parameters
 @require text.len <= int.max
 @param [&inout] scroll_index
 @param [&inout] active
 @param [&inout] focus
*>
fn int listViewEx(rl::Rectangle bounds, ZString[] text, int* scroll_index, int* active, int* focus) @inline {
    return raygui::__gui_list_view_ex(bounds, text.ptr, (int)text.len, scroll_index, active, focus);
}

<*
 Message Box control, displays a message
*>
extern fn int messageBox(rl::Rectangle bounds, ZString title, ZString message, ZString buttons) @extern("GuiMessageBox");

// TODO: find a better type for param 'text'
<*
 Text Input Box control, ask for text, supports secret
 @require text.len <= int.max
 @param [in] secret_view_active
*>
fn int textInputBox(rl::Rectangle bounds, ZString title, ZString message, ZString buttons, char[] text, bool* secret_view_active) @inline {
    return raygui::__gui_text_input_box(bounds, title, message, buttons, text.ptr, (int)text.len, secret_view_active);
}

<*
 Color Picker control (multiple color controls)
 @param [inout] color
*>
extern fn int colorPicker(rl::Rectangle bounds, ZString text, Color* color) @extern("GuiColorPicker");

<*
 Color Panel control
 @param [&inout] color
*>
extern fn int colorPanel(rl::Rectangle bounds, ZString text, Color* color) @extern("GuiColorPanel");

<*
 Color Bar Alpha control
 @param [&inout] alpha
*>
extern fn int colorBarAlpha(rl::Rectangle bounds, ZString text, float* alpha) @extern("GuiColorBarAlpha");

<*
 Color Bar Hue control
 @param [&inout] value
*>
extern fn int colorBarHue(rl::Rectangle bounds, ZString text, float* value) @extern("GuiColorBarHue");

<*
 Color Picker control that avoids conversion to RGB on each call (multiple color controls)
 @param [&inout] color_hsv
*>
extern fn int colorPickerHsv(rl::Rectangle bounds, ZString text, rl::Vector3* color_hsv) @extern("GuiColorPickerHSV");

<*
 Color Panel control that returns HSV color value, used by GuiColorPickerHSV()
 @param [&inout] color_hsv
*>
extern fn int colorPanelHsv(rl::Rectangle bounds, ZString text, rl::Vector3* color_hsv) @extern("GuiColorPanelHSV");

//----------------------------------------------------------------------------------------------------------

module raygui @if(!$feature(RAYGUI_NO_ICONS) && !$feature(RAYGUI_CUSTOM_ICONS));

enum GuiIconName : int {
    ICON_NONE,
    ICON_FOLDER_FILE_OPEN,
    ICON_FILE_SAVE_CLASSIC,
    ICON_FOLDER_OPEN,
    ICON_FOLDER_SAVE,
    ICON_FILE_OPEN,
    ICON_FILE_SAVE,
    ICON_FILE_EXPORT,
    ICON_FILE_ADD,
    ICON_FILE_DELETE,
    ICON_FILETYPE_TEXT,
    ICON_FILETYPE_AUDIO,
    ICON_FILETYPE_IMAGE,
    ICON_FILETYPE_PLAY,
    ICON_FILETYPE_VIDEO,
    ICON_FILETYPE_INFO,
    ICON_FILE_COPY,
    ICON_FILE_CUT,
    ICON_FILE_PASTE,
    ICON_CURSOR_HAND,
    ICON_CURSOR_POINTER,
    ICON_CURSOR_CLASSIC,
    ICON_PENCIL,
    ICON_PENCIL_BIG,
    ICON_BRUSH_CLASSIC,
    ICON_BRUSH_PAINTER,
    ICON_WATER_DROP,
    ICON_COLOR_PICKER,
    ICON_RUBBER,
    ICON_COLOR_BUCKET,
    ICON_TEXT_T,
    ICON_TEXT_A,
    ICON_SCALE,
    ICON_RESIZE,
    ICON_FILTER_POINT,
    ICON_FILTER_BILINEAR,
    ICON_CROP,
    ICON_CROP_ALPHA,
    ICON_SQUARE_TOGGLE,
    ICON_SYMMETRY,
    ICON_SYMMETRY_HORIZONTAL,
    ICON_SYMMETRY_VERTICAL,
    ICON_LENS,
    ICON_LENS_BIG,
    ICON_EYE_ON,
    ICON_EYE_OFF,
    ICON_FILTER_TOP,
    ICON_FILTER,
    ICON_TARGET_POINT,
    ICON_TARGET_SMALL,
    ICON_TARGET_BIG,
    ICON_TARGET_MOVE,
    ICON_CURSOR_MOVE,
    ICON_CURSOR_SCALE,
    ICON_CURSOR_SCALE_RIGHT,
    ICON_CURSOR_SCALE_LEFT,
    ICON_UNDO,
    ICON_REDO,
    ICON_REREDO,
    ICON_MUTATE,
    ICON_ROTATE,
    ICON_REPEAT,
    ICON_SHUFFLE,
    ICON_EMPTYBOX,
    ICON_TARGET,
    ICON_TARGET_SMALL_FILL,
    ICON_TARGET_BIG_FILL,
    ICON_TARGET_MOVE_FILL,
    ICON_CURSOR_MOVE_FILL,
    ICON_CURSOR_SCALE_FILL,
    ICON_CURSOR_SCALE_RIGHT_FILL,
    ICON_CURSOR_SCALE_LEFT_FILL,
    ICON_UNDO_FILL,
    ICON_REDO_FILL,
    ICON_REREDO_FILL,
    ICON_MUTATE_FILL,
    ICON_ROTATE_FILL,
    ICON_REPEAT_FILL,
    ICON_SHUFFLE_FILL,
    ICON_EMPTYBOX_SMALL,
    ICON_BOX,
    ICON_BOX_TOP,
    ICON_BOX_TOP_RIGHT,
    ICON_BOX_RIGHT,
    ICON_BOX_BOTTOM_RIGHT,
    ICON_BOX_BOTTOM,
    ICON_BOX_BOTTOM_LEFT,
    ICON_BOX_LEFT,
    ICON_BOX_TOP_LEFT,
    ICON_BOX_CENTER,
    ICON_BOX_CIRCLE_MASK,
    ICON_POT,
    ICON_ALPHA_MULTIPLY,
    ICON_ALPHA_CLEAR,
    ICON_DITHERING,
    ICON_MIPMAPS,
    ICON_BOX_GRID,
    ICON_GRID,
    ICON_BOX_CORNERS_SMALL,
    ICON_BOX_CORNERS_BIG,
    ICON_FOUR_BOXES,
    ICON_GRID_FILL,
    ICON_BOX_MULTISIZE,
    ICON_ZOOM_SMALL,
    ICON_ZOOM_MEDIUM,
    ICON_ZOOM_BIG,
    ICON_ZOOM_ALL,
    ICON_ZOOM_CENTER,
    ICON_BOX_DOTS_SMALL,
    ICON_BOX_DOTS_BIG,
    ICON_BOX_CONCENTRIC,
    ICON_BOX_GRID_BIG,
    ICON_OK_TICK,
    ICON_CROSS,
    ICON_ARROW_LEFT,
    ICON_ARROW_RIGHT,
    ICON_ARROW_DOWN,
    ICON_ARROW_UP,
    ICON_ARROW_LEFT_FILL,
    ICON_ARROW_RIGHT_FILL,
    ICON_ARROW_DOWN_FILL,
    ICON_ARROW_UP_FILL,
    ICON_AUDIO,
    ICON_FX,
    ICON_WAVE,
    ICON_WAVE_SINUS,
    ICON_WAVE_SQUARE,
    ICON_WAVE_TRIANGULAR,
    ICON_CROSS_SMALL,
    ICON_PLAYER_PREVIOUS,
    ICON_PLAYER_PLAY_BACK,
    ICON_PLAYER_PLAY,
    ICON_PLAYER_PAUSE,
    ICON_PLAYER_STOP,
    ICON_PLAYER_NEXT,
    ICON_PLAYER_RECORD,
    ICON_MAGNET,
    ICON_LOCK_CLOSE,
    ICON_LOCK_OPEN,
    ICON_CLOCK,
    ICON_TOOLS,
    ICON_GEAR,
    ICON_GEAR_BIG,
    ICON_BIN,
    ICON_HAND_POINTER,
    ICON_LASER,
    ICON_COIN,
    ICON_EXPLOSION,
    ICON_1UP,
    ICON_PLAYER,
    ICON_PLAYER_JUMP,
    ICON_KEY,
    ICON_DEMON,
    ICON_TEXT_POPUP,
    ICON_GEAR_EX,
    ICON_CRACK,
    ICON_CRACK_POINTS,
    ICON_STAR,
    ICON_DOOR,
    ICON_EXIT,
    ICON_MODE_2D,
    ICON_MODE_3D,
    ICON_CUBE,
    ICON_CUBE_FACE_TOP,
    ICON_CUBE_FACE_LEFT,
    ICON_CUBE_FACE_FRONT,
    ICON_CUBE_FACE_BOTTOM,
    ICON_CUBE_FACE_RIGHT,
    ICON_CUBE_FACE_BACK,
    ICON_CAMERA,
    ICON_SPECIAL,
    ICON_LINK_NET,
    ICON_LINK_BOXES,
    ICON_LINK_MULTI,
    ICON_LINK,
    ICON_LINK_BROKE,
    ICON_TEXT_NOTES,
    ICON_NOTEBOOK,
    ICON_SUITCASE,
    ICON_SUITCASE_ZIP,
    ICON_MAILBOX,
    ICON_MONITOR,
    ICON_PRINTER,
    ICON_PHOTO_CAMERA,
    ICON_PHOTO_CAMERA_FLASH,
    ICON_HOUSE,
    ICON_HEART,
    ICON_CORNER,
    ICON_VERTICAL_BARS,
    ICON_VERTICAL_BARS_FILL,
    ICON_LIFE_BARS,
    ICON_INFO,
    ICON_CROSSLINE,
    ICON_HELP,
    ICON_FILETYPE_ALPHA,
    ICON_FILETYPE_HOME,
    ICON_LAYERS_VISIBLE,
    ICON_LAYERS,
    ICON_WINDOW,
    ICON_HIDPI,
    ICON_FILETYPE_BINARY,
    ICON_HEX,
    ICON_SHIELD,
    ICON_FILE_NEW,
    ICON_FOLDER_ADD,
    ICON_ALARM,
    ICON_CPU,
    ICON_ROM,
    ICON_STEP_OVER,
    ICON_STEP_INTO,
    ICON_STEP_OUT,
    ICON_RESTART,
    ICON_BREAKPOINT_ON,
    ICON_BREAKPOINT_OFF,
    ICON_BURGER_MENU,
    ICON_CASE_SENSITIVE,
    ICON_REG_EXP,
    ICON_FOLDER,
    ICON_FILE,
    ICON_SAND_TIMER,
    ICON_220,
    ICON_221,
    ICON_222,
    ICON_223,
    ICON_224,
    ICON_225,
    ICON_226,
    ICON_227,
    ICON_228,
    ICON_229,
    ICON_230,
    ICON_231,
    ICON_232,
    ICON_233,
    ICON_234,
    ICON_235,
    ICON_236,
    ICON_237,
    ICON_238,
    ICON_239,
    ICON_240,
    ICON_241,
    ICON_242,
    ICON_243,
    ICON_244,
    ICON_245,
    ICON_246,
    ICON_247,
    ICON_248,
    ICON_249,
    ICON_250,
    ICON_251,
    ICON_252,
    ICON_253,
    ICON_254,
    ICON_255,
}

// TODO: find a way to make this work
//$assert((int)GuiIconName.ICON_NONE == 0);
//$assert((int)GuiIconName.ICON_255 == 255);
