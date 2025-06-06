module rl;

//------------------------------------------------------------------------------------
// Font Loading and Text Drawing Functions (Module: text)
//------------------------------------------------------------------------------------

// Font loading/unloading functions
//------------------------------------------------------------------------------------

<*
 Get the default Font
*>
extern fn Font getFontDefault() @extern("GetFontDefault");

<*
 Load font from file into GPU memory (VRAM)
*>
extern fn Font loadFont(ZString file_name) @extern("LoadFont");

<*
 Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
*>
extern fn Font loadFontEx(ZString file_name, int font_size, int* codepoints, int codepoint_count) @extern("LoadFontEx");

<*
 Load font from Image (XNA style)
*>
extern fn Font loadFontFromImage(Image image, Color key, int first_char) @extern("LoadFontFromImage");

<*
 Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
*>
extern fn Font loadFontFromMemory(ZString file_type, ZString file_data, int data_size, int fontSize, int *codepoints, int codepoint_count) @extern("LoadFontFromMemory");

<*
 Check if a font is valid (font data loaded, WARNING: GPU texture not checked)
*>
extern fn bool Font.isValid(Font font) @extern("IsFontValid");
alias isFontValid = Font.isValid;

// TODO: review
<*
 Load font data for further use
*>
extern fn GlyphInfo* loadFontData(ZString file_data, int data_size, int font_size, int *codepoints, int codepoint_count, FontType type) @extern("LoadFontData");

// TODO: glyphs/glyph_count as GlyphInfo[]
<*
 Generate image font atlas using chars info
*>
extern fn Image genImageFontAtlas(GlyphInfo* glyphs, Rectangle **glyph_recs, int glyph_count, int fontSize, int padding, int pack_method) @extern("GenImageFontAtlas");

<*
 Unload font chars info data (RAM)
 @require glyphs.len <= int.max
*>
fn void unloadFontData(GlyphInfo[] glyphs) @inline {
    __unload_font_data(glyphs.ptr, (int)glyphs.len);
}

<*
 Unload font from GPU memory (VRAM)
*>
extern fn void Font.unload(Font font) @extern("UnloadFont");
alias unloadFont = Font.unload;

<*
 Export font as code file, returns true on success
*>
extern fn bool Font.exportAsCode(Font font, ZString file_name) @extern("ExportFontAsCode");
alias exportFontAsCode = Font.exportAsCode;

// Text drawing functions
//------------------------------------------------------------------------------------

<*
 Draw current FPS
*>
extern fn void drawFps(int pos_x, int pos_y) @extern("DrawFPS");

<*
 Draw text (using default font)
*>
extern fn void drawText(ZString text, int pos_x, int pos_y, int font_size, Color color) @extern("DrawText");

<*
 Draw text using font and additional parameters
*>
extern fn void drawTextEx(Font font, ZString text, Vector2 position, float font_size, float spacing, Color tint) @extern("DrawTextEx");

<*
 Draw text using Font and pro parameters (rotation)
*>
extern fn void drawTextPro(Font font, ZString text, Vector2 position, Vector2 origin, float rotation, float font_size, float spacing, Color tint) @extern("DrawTextPro");

<*
 Draw one character (codepoint)
*>
extern fn void drawTextCodepoint(Font font, int codepoint, Vector2 position, float font_size, Color tint) @extern("DrawTextCodepoint");

<*
 Draw multiple character (codepoint)
*>
extern fn void drawTextCodepoints(Font font, int* codepoints, int codepoint_count, Vector2 position, float font_size, float spacing, Color tint) @extern("DrawTextCodepoints");

// Text font info functions
//------------------------------------------------------------------------------------

<*
 Set vertical line spacing when drawing with line-breaks
*>
extern fn void setTextLineSpacing(int spacing) @extern("SetTextLineSpacing");

<*
 Measure string width for default font
*>
extern fn int measureText(ZString text, int font_size) @extern("MeasureText");

<*
 Measure string size for Font
*>
extern fn Vector2 measureTextEx(Font font, ZString text, float font_size, float spacing) @extern("MeasureTextEx");

<*
 Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
*>
extern fn int getGlyphIndex(Font font, int codepoint) @extern("GetGlyphIndex");

<*
 Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
*>
extern fn GlyphInfo getGlyphInfo(Font font, int codepoint) @extern("GetGlyphInfo");

<*
 Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
*>
extern fn Rectangle getGlyphAtlasRec(Font font, int codepoint) @extern("GetGlyphAtlasRec");

// Text codepoints management functions (unicode characters)
//------------------------------------------------------------------------------------

<*
 Load UTF-8 text encoded from codepoints array
*>
extern fn char* loadUTF8(int *codepoints, int length) @extern("LoadUTF8");

<*
 Unload UTF-8 text encoded from codepoints array
*>
extern fn void unloadUTF8(char* text) @extern("UnloadUTF8");

<*
 Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
*>
extern fn int* loadCodepoints(ZString text, int *count) @extern("LoadCodepoints");

<*
 Unload codepoints data from memory
*>
extern fn void unloadCodepoints(int* codepoints) @extern("UnloadCodepoints");

<*
 Get total number of codepoints in a UTF-8 encoded string
*>
extern fn int getCodepointCount(ZString text) @extern("GetCodepointCount");

<*
 Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
*>
extern fn int getCodepoint(ZString text, int *codepoint_size) @extern("GetCodepoint");

<*
 Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
*>
extern fn int getCodepointNext(ZString text, int *codepoint_size) @extern("GetCodepointNext");

<*
 Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
*>
extern fn int getCodepointPrevious(ZString text, int *codepoint_size) @extern("GetCodepointPrevious");

<*
 Encode one codepoint into UTF-8 byte array (array length returned as parameter)
*>
extern fn ZString codepointToUTF8(int codepoint, int *utf8_size) @extern("CodepointToUTF8");

// Text strings management functions (no UTF-8 strings, only byte chars)
// NOTE: Some strings allocate memory internally for returned strings, just be careful!
//------------------------------------------------------------------------------------

<*
 Copy one string to another, returns bytes copied
*>
extern fn int textCopy(ZString dst, ZString src) @extern("TextCopy");

<*
 Check if two text string are equal
*>
extern fn bool textIsEqual(ZString text1, ZString text2) @extern("TextIsEqual");

<*
 Get text length, checks for '\0' ending
*>
extern fn uint textLength(ZString text) @extern("TextLength");

<*
 Text formatting with variables (sprintf() style)
*>
extern fn ZString textFormat(ZString text, ...) @extern("TextFormat");

<*
 Get a piece of a text string
*>
extern fn ZString textSubtext(ZString text, int position, int length) @extern("TextSubtext");

<*
 Replace text string (WARNING: memory must be freed!)
*>
extern fn char *textReplace(ZString text, ZString replace, ZString by) @extern("TextReplace");

<*
 Insert text in a position (WARNING: memory must be freed!)
*>
extern fn char* textInsert(ZString text, ZString insert, int position) @extern("TextInsert");

<*
 Join text strings with delimiter
*>
extern fn ZString textJoin(ZString* text_list, int count, ZString delimiter) @extern("TextJoin");

<*
 Split text into multiple strings
*>
extern fn ZString *textSplit(ZString text, char delimiter, int* count) @extern("TextSplit");

<*
 Append text at specific position and move cursor!
*>
extern fn void textAppend(char* text, ZString append, int* position) @extern("TextAppend");

<*
 Find first text occurrence within a string
*>
extern fn int textFindIndex(ZString text, ZString find) @extern("TextFindIndex");

<*
 Get upper case version of provided string
*>
extern fn ZString textToUpper(ZString text) @extern("TextToUpper");

<*
 Get lower case version of provided string
*>
extern fn ZString textToLower(ZString text) @extern("TextToLower");

<*
 Get Pascal case notation version of provided string
*>
extern fn ZString textToPascal(ZString text) @extern("TextToPascal");

<*
 Get Snake case notation version of provided string
*>
extern fn ZString textToSnake(ZString text) @extern("TextToSnake");

<*
 Get Camel case notation version of provided string
*>
extern fn ZString textToCamel(ZString text) @extern("TextToCamel");

<*
 Get integer value from text (negative values not supported)
*>
extern fn int textToInteger(ZString text) @extern("TextToInteger");

<*
 Get float value from text (negative values not supported)
*>
extern fn float textToFloat(ZString text) @extern("TextToFloat");
