module rl @if($feature(SUPPORT_TEXT_C_STRING_MANAGEMENT));

// Text strings management functions (no UTF-8 strings, only byte chars)
// NOTE: Some strings allocate memory internally for returned strings, just be careful!
//------------------------------------------------------------------------------------

/**
 * Copy one string to another, returns bytes copied
 */
extern fn int text_copy(ZString dst, ZString src) @extern("TextCopy");

/**
 * Check if two text string are equal
 */
extern fn bool text_is_equal(ZString text1, ZString text2) @extern("TextIsEqual");

/**
 * Get text length, checks for '\0' ending
 */
extern fn uint text_length(ZString text) @extern("TextLength");

/**
 * Text formatting with variables (sprintf() style)
 */
extern fn ZString text_format(ZString text, ...) @extern("TextFormat");

/**
 * Get a piece of a text string
 */
extern fn ZString text_subtext(ZString text, int position, int length) @extern("TextSubtext");

/**
 * Replace text string (WARNING: memory must be freed!)
 */
extern fn char* text_replace(char *text, ZString replace, ZString by) @extern("TextReplace");

/**
 * Insert text in a position (WARNING: memory must be freed!)
 */
extern fn char* text_insert(ZString text, ZString insert, int position) @extern("TextInsert");

/**
 * Join text strings with delimiter
 */
extern fn ZString text_join(ZString *text_list, int count, ZString delimiter) @extern("TextJoin");

/**
 * Split text into multiple strings
 */
extern fn ZString *text_split(ZString text, char delimiter, int *count) @extern("TextSplit");

/**
 * Append text at specific position and move cursor!
 */
extern fn void text_append(char* text, ZString append, int *position) @extern("TextAppend");

/**
 * Find first text occurrence within a string
 */
extern fn int text_find_index(ZString text, ZString find) @extern("TextFindIndex");

/**
 * Get upper case version of provided string
 */
extern fn ZString text_to_upper(ZString text) @extern("TextToUpper");

/**
 * Get lower case version of provided string
 */
extern fn ZString text_to_lower(ZString text) @extern("TextToLower");

/**
 * Get Pascal case notation version of provided string
 */
extern fn ZString text_to_pascal(ZString text) @extern("TextToPascal");

/**
 * Get integer value from text (negative values not supported)
 */
extern fn int text_to_integer(ZString text) @extern("TextToInteger");
