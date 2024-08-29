module rgui_ffi @if(config::SUPPORT_RAYGUI);
import rl;

// Style set/get functions


// Controls
extern fn int __gui_tab_bar(rl::Rectangle bounds, char** text, int count, int* active) @extern("GuiTabBar") @private;

// Basic controls set
extern fn int __gui_text_box(rl::Rectangle bounds, char* text, int text_size, bool edit_mode) @extern("GuiTextBox");

// Advance controls set
extern fn int __gui_list_view_ex(rl::Rectangle bounds, char** text, int count, int *scroll_index, int *active, int *focus) @extern("GuiListViewEx") @private;
extern fn int __gui_text_input_box(rl::Rectangle bounds, ZString title, ZString message, ZString buttons, char *text, int text_max_size, bool *secret_view_active) @extern("GuiTextInputBox") @private;
