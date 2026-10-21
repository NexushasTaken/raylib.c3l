module rl;

//------------------------------------------------------------------------------------
// Font Loading and Text Drawing Functions (Module: text)
//------------------------------------------------------------------------------------

// Font loading/unloading functions
//------------------------------------------------------------------------------------

<*
 Get the default Font
*>
extern fn Font getFontDefault() @cname("GetFontDefault");

<*
 Load font from file into GPU memory (VRAM)
*>
extern fn Font loadFont(ZString file_name) @cname("LoadFont");

<*
 Load font from file with defined codepoints and generation size, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
*>
extern fn Font loadFontEx(ZString file_name, int font_size, int* codepoints, int codepoint_count) @cname("LoadFontEx");

<*
 Load font from Image (XNA style)
*>
extern fn Font loadFontFromImage(Image image, Color key, int first_char) @cname("LoadFontFromImage");

<*
 Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
*>
extern fn Font loadFontFromMemory(ZString file_type, ZString file_data, int data_size, int fontSize, int *codepoints, int codepoint_count) @cname("LoadFontFromMemory");

<*
 Check if font is valid (font data loaded, WARNING: GPU texture not checked)
*>
extern fn bool Font.isValid(Font font) @cname("IsFontValid");
alias isFontValid = Font.isValid;

// TODO: review
<*
 Load font data for further use
*>
extern fn GlyphInfo* loadFontData(ZString file_data, int data_size, int font_size, int *codepoints, int codepoint_count, FontType type, int* glyph_count) @cname("LoadFontData");

// TODO: glyphs/glyph_count as GlyphInfo[]
<*
 Generate image font atlas using chars info
*>
extern fn Image genImageFontAtlas(GlyphInfo* glyphs, Rectangle **glyph_recs, int glyph_count, int fontSize, int padding, int pack_method) @cname("GenImageFontAtlas");

<*
 Unload font chars info data (RAM)
 @require glyphs.len <= int::max
*>
fn void unloadFontData(GlyphInfo[] glyphs) @inline {
    __unload_font_data(glyphs.ptr, (int)glyphs.len);
}

<*
 Unload font from GPU memory (VRAM)
*>
extern fn void Font.unload(Font font) @cname("UnloadFont");
alias unloadFont = Font.unload;

<*
 Export font as code file, returns true on success
*>
extern fn bool Font.exportAsCode(Font font, ZString file_name) @cname("ExportFontAsCode");
alias exportFontAsCode = Font.exportAsCode;

// Text drawing functions
//------------------------------------------------------------------------------------

<*
 Draw current FPS
*>
extern fn void drawFps(int pos_x, int pos_y) @cname("DrawFPS");

<*
 Draw text (using default font)
*>
extern fn void drawText(ZString text, int pos_x, int pos_y, int font_size, Color color) @cname("DrawText");

<*
 Draw text using font and additional parameters
*>
extern fn void drawTextEx(Font font, ZString text, Vector2 position, float font_size, float spacing, Color tint) @cname("DrawTextEx");

<*
 Draw text using Font and pro parameters (rotation)
*>
extern fn void drawTextPro(Font font, ZString text, Vector2 position, Vector2 origin, float rotation, float font_size, float spacing, Color tint) @cname("DrawTextPro");

<*
 Draw one character (codepoint)
*>
extern fn void drawTextCodepoint(Font font, int codepoint, Vector2 position, float font_size, Color tint) @cname("DrawTextCodepoint");

<*
 Draw multiple characters (codepoint)
*>
extern fn void drawTextCodepoints(Font font, int* codepoints, int codepoint_count, Vector2 position, float font_size, float spacing, Color tint) @cname("DrawTextCodepoints");

// Text font info functions
//------------------------------------------------------------------------------------

<*
 Set vertical line spacing when drawing with line-breaks
*>
extern fn void setTextLineSpacing(int spacing) @cname("SetTextLineSpacing");

<*
 Measure string width for default font
*>
extern fn int measureText(ZString text, int font_size) @cname("MeasureText");

<*
 Measure string size for Font
*>
extern fn Vector2 measureTextEx(Font font, ZString text, float font_size, float spacing) @cname("MeasureTextEx");

<*
 Measure string size for an existing array of codepoints for Font
*>
extern fn Vector2 measureTextCodepoints(Font font, int* codepoints, int length, float font_size, float spacing) @cname("MeasureTextCodepoints");

<*
 Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
*>
extern fn int getGlyphIndex(Font font, int codepoint) @cname("GetGlyphIndex");

<*
 Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
*>
extern fn GlyphInfo getGlyphInfo(Font font, int codepoint) @cname("GetGlyphInfo");

<*
 Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
*>
extern fn Rectangle getGlyphAtlasRec(Font font, int codepoint) @cname("GetGlyphAtlasRec");

// Text codepoints management functions (unicode characters)
//------------------------------------------------------------------------------------

<*
 Load UTF-8 text encoded from codepoints array
*>
extern fn char* loadUTF8(int *codepoints, int length) @cname("LoadUTF8");

<*
 Unload UTF-8 text encoded from codepoints array
*>
extern fn void unloadUTF8(char* text) @cname("UnloadUTF8");

<*
 Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
*>
extern fn int* loadCodepoints(ZString text, int *count) @cname("LoadCodepoints");

<*
 Unload codepoints data from memory
*>
extern fn void unloadCodepoints(int* codepoints) @cname("UnloadCodepoints");

<*
 Get total number of codepoints in a UTF-8 encoded string
*>
extern fn int getCodepointCount(ZString text) @cname("GetCodepointCount");

<*
 Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
*>
extern fn int getCodepoint(ZString text, int *codepoint_size) @cname("GetCodepoint");

<*
 Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
*>
extern fn int getCodepointNext(ZString text, int *codepoint_size) @cname("GetCodepointNext");

<*
 Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
*>
extern fn int getCodepointPrevious(ZString text, int *codepoint_size) @cname("GetCodepointPrevious");

<*
 Encode one codepoint into UTF-8 byte array (array length returned as parameter)
*>
extern fn ZString codepointToUTF8(int codepoint, int *utf8_size) @cname("CodepointToUTF8");

// Text strings management functions (no UTF-8 strings, only byte chars)
// WARNING 1: Most of these functions use internal static buffers[], it's recommended to store returned data on user-side for re-use
// WARNING 2: Some functions allocate memory internally for the returned strings, those strings must be freed by user using MemFree()
//------------------------------------------------------------------------------------

<*
 Copy one string to another, returns bytes copied
*>
extern fn int textCopy(ZString dst, ZString src) @cname("TextCopy");

<*
 Load text as separate lines ('\n')
*>
extern fn ZString* loadTextLines(ZString text, int* count) @cname("LoadTextLines");

<*
 Unload text lines
*>
extern fn void unloadTextLines(ZString* text, int line_count) @cname("UnloadTextLines");

<*
 Check if two text strings are equal
*>
extern fn bool textIsEqual(ZString text1, ZString text2) @cname("TextIsEqual");

<*
 Get text length, checks for '\0' ending
*>
extern fn uint textLength(ZString text) @cname("TextLength");

<*
 Text formatting with variables (sprintf() style)
*>
extern fn ZString textFormat(ZString text, ...) @cname("TextFormat");

<*
 Get a piece of a text string
*>
extern fn ZString textSubtext(ZString text, int position, int length) @cname("TextSubtext");

<*
 Remove text spaces, concat words
*>
extern fn ZString textRemoveSpaces(ZString text) @cname("TextRemoveSpaces");

<*
 Get text between two strings
*>
extern fn ZString getTextBetween(ZString text, ZString begin, ZString end) @cname("GetTextBetween");

<*
 Replace text string with new string
*>
extern fn char *textReplace(ZString text, ZString search, ZString replacement) @cname("TextReplace");

<*
 Replace text string with new string, memory must be MemFree()
*>
extern fn char* textReplaceAlloc(ZString text, ZString search, ZString replacement) @cname("TextReplaceAlloc");

<*
 Replace text between two specific strings
*>
extern fn char* textReplaceBetween(ZString text, ZString begin, ZString end, ZString replacement) @cname("TextReplaceBetween");

<*
 Replace text between two specific strings, memory must be MemFree()
*>
extern fn char* textReplaceBetweenAlloc(ZString text, ZString begin, ZString end, ZString replacement) @cname("TextReplaceBetweenAlloc");

<*
 Insert text in a defined byte position
*>
extern fn char* textInsert(ZString text, ZString insert, int position) @cname("TextInsert");

<*
 Insert text in a defined byte position, memory must be MemFree()
*>
extern fn char* textInsertAlloc(ZString text, ZString insert, int position) @cname("TextInsertAlloc");

<*
 Join text strings with delimiter
*>
extern fn ZString textJoin(ZString* text_list, int count, ZString delimiter) @cname("TextJoin");

<*
 Split text into multiple strings, using MAX_TEXTSPLIT_COUNT static strings
*>
extern fn ZString *textSplit(ZString text, char delimiter, int* count) @cname("TextSplit");

<*
 Append text at specific position and move cursor
*>
extern fn void textAppend(char* text, ZString append, int* position) @cname("TextAppend");

<*
 Find first text occurrence within a string, -1 if not found
*>
extern fn int textFindIndex(ZString text, ZString search) @cname("TextFindIndex");

<*
 Get upper case version of provided string
*>
extern fn ZString textToUpper(ZString text) @cname("TextToUpper");

<*
 Get lower case version of provided string
*>
extern fn ZString textToLower(ZString text) @cname("TextToLower");

<*
 Get Pascal case notation version of provided string
*>
extern fn ZString textToPascal(ZString text) @cname("TextToPascal");

<*
 Get Snake case notation version of provided string
*>
extern fn ZString textToSnake(ZString text) @cname("TextToSnake");

<*
 Get Camel case notation version of provided string
*>
extern fn ZString textToCamel(ZString text) @cname("TextToCamel");

<*
 Get integer value from text
*>
extern fn int textToInteger(ZString text) @cname("TextToInteger");

<*
 Get float value from text
*>
extern fn float textToFloat(ZString text) @cname("TextToFloat");
