// vi: ts=4 sw=4
module rl @if(config::SUPPORT_TEXT_CODEPOINTS_MANAGEMENT);

// Text codepoints management functions (unicode characters)
//------------------------------------------------------------------------------------

/**
 * Load UTF-8 text encoded from codepoints array
 */
extern fn char* load_utf8(int *codepoints, int length) @extern("LoadUTF8");

/**
 * Unload UTF-8 text encoded from codepoints array
 */
extern fn void unload_utf8(char* text) @extern("UnloadUTF8");

/**
 * Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
 */
extern fn int* load_codepoints(ZString text, int *count) @extern("LoadCodepoints");

/**
 * Unload codepoints data from memory
 */
extern fn void unload_codepoints(int* codepoints) @extern("UnloadCodepoints");

/**
 * Get total number of codepoints in a UTF-8 encoded string
 */
extern fn int get_codepoint_count(ZString text) @extern("GetCodepointCount");

/**
 * Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
 */
extern fn int get_codepoint(ZString text, int *codepoint_size) @extern("GetCodepoint");

/**
 * Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
 */
extern fn int get_codepoint_next(ZString text, int *codepoint_size) @extern("GetCodepointNext");

/**
 * Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
 */
extern fn int get_codepoint_previous(ZString text, int *codepoint_size) @extern("GetCodepointPrevious");

/**
 * Encode one codepoint into UTF-8 byte array (array length returned as parameter)
 */
extern fn ZString codepoint_to_utf8(int codepoint, int *utf8_size) @extern("CodepointToUTF8");

