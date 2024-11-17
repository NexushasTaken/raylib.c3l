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
 Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set
*>
extern fn Font loadFontEx(ZString file_name, int font_size, int *codepoints, int codepoint_count) @extern("LoadFontEx");

<*
 Load font from Image (XNA style)
*>
extern fn Font loadFontFromImage(Image image, Color key, int first_char) @extern("LoadFontFromImage");

<*
 Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
*>
extern fn Font loadFontFromMemory(ZString file_type, ZString file_data, int data_size, int fontSize, int *codepoints, int codepoint_count) @extern("LoadFontFromMemory");

<*
 Check if a font is ready
*>
extern fn bool isFontReady(Font font) @extern("IsFontReady");

// TODO: review
<*
 Load font data for further use
*>
extern fn GlyphInfo* loadFontData(ZString file_data, int data_size, int font_size, int *codepoints, int codepoint_count, FontType type) @extern("LoadFontData");

// TODO: glyphs/glyph_count as List(<GlyphInfo>)
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
extern fn void unloadFont(Font font) @extern("UnloadFont");

<*
 Export font as code file, returns true on success
*>
extern fn bool exportFontAsCode(Font font, ZString file_name) @extern("ExportFontAsCode");

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
