// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Font Loading and Text Drawing Functions (Module: text)
//------------------------------------------------------------------------------------

// Font loading/unloading functions
//------------------------------------------------------------------------------------

/**
 * Get the default Font
 */
extern fn Font get_font_default() @extern("GetFontDefault");

/**
 * Load font from file into GPU memory (VRAM)
 */
extern fn Font load_font(ZString file_name) @extern("LoadFont");

/**
 * Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set
 */
extern fn Font load_font_ex(ZString file_name, int font_size, int *codepoints, int codepoint_count) @extern("LoadFontEx");

/**
 * Load font from Image (XNA style)
 */
extern fn Font load_font_from_image(Image image, Color key, int first_char) @extern("LoadFontFromImage");

/**
 * Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
 */
extern fn Font load_font_from_memory(ZString file_type, ZString file_data, int data_size, int fontSize, int *codepoints, int codepoint_count) @extern("LoadFontFromMemory");

/**
 * Check if a font is ready
 */
extern fn bool is_font_ready(Font font) @extern("IsFontReady");

/**
 * Load font data for further use
 */
extern fn GlyphInfo* load_font_data(ZString file_data, int data_size, int font_size, int *codepoints, int codepoint_count, int type) @extern("LoadFontData");

/**
 * Generate image font atlas using chars info
 */
extern fn Image gen_image_font_atlas(GlyphInfo* glyphs, Rectangle **glyph_recs, int glyph_count, int fontSize, int padding, int pack_method) @extern("GenImageFontAtlas");

/**
 * Unload font chars info data (RAM)
 */
extern fn void unload_font_data(GlyphInfo* glyphs, int glyph_count) @extern("UnloadFontData");

/**
 * Unload font from GPU memory (VRAM)
 */
extern fn void unload_font(Font font) @extern("UnloadFont");

/**
 * Export font as code file, returns true on success
 */
extern fn bool export_font_as_code(Font font, ZString file_name) @extern("ExportFontAsCode");

// Text drawing functions
//------------------------------------------------------------------------------------

/**
 * Draw current FPS
 */
extern fn void draw_fps(int pos_x, int pos_y) @extern("DrawFPS");

/**
 * Draw text (using default font)
 */
extern fn void draw_text(ZString text, int pos_x, int pos_y, int font_size, Color color) @extern("DrawText");

/**
 * Draw text using font and additional parameters
 */
extern fn void draw_text_ex(Font font, ZString text, Vector2 position, float font_size, float spacing, Color tint) @extern("DrawTextEx");

/**
 * Draw text using Font and pro parameters (rotation)
 */
extern fn void draw_text_pro(Font font, ZString text, Vector2 position, Vector2 origin, float rotation, float font_size, float spacing, Color tint) @extern("DrawTextPro");

/**
 * Draw one character (codepoint)
 */
extern fn void draw_text_codepoint(Font font, int codepoint, Vector2 position, float font_size, Color tint) @extern("DrawTextCodepoint");

/**
 * Draw multiple character (codepoint)
 */
extern fn void draw_text_codepoints(Font font, int* codepoints, int codepoint_count, Vector2 position, float font_size, float spacing, Color tint) @extern("DrawTextCodepoints");

// Text font info functions
//------------------------------------------------------------------------------------

/**
 * Set vertical line spacing when drawing with line-breaks
 */
extern fn void set_text_line_spacing(int spacing) @extern("SetTextLineSpacing");

/**
 * Measure string width for default font
 */
extern fn int measure_text(ZString text, int font_size) @extern("MeasureText");

/**
 * Measure string size for Font
 */
extern fn Vector2 measure_text_ex(Font font, ZString text, float font_size, float spacing) @extern("MeasureTextEx");

/**
 * Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
 */
extern fn int get_glyph_index(Font font, int codepoint) @extern("GetGlyphIndex");

/**
 * Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
 */
extern fn GlyphInfo get_glyph_info(Font font, int codepoint) @extern("GetGlyphInfo");

/**
 * Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
 */
extern fn Rectangle get_glyph_atlas_rec(Font font, int codepoint) @extern("GetGlyphAtlasRec");

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

