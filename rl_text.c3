// vi: ts=4 sw=4 noet
module rl;
import std::collections;

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

// TODO: review
/**
 * Load font data for further use
 */
extern fn GlyphInfo* load_font_data(ZString file_data, int data_size, int font_size, int *codepoints, int codepoint_count, FontType type) @extern("LoadFontData");

// TODO: glyphs/glyph_count as List(<GlyphInfo>)
/**
 * Generate image font atlas using chars info
 */
extern fn Image gen_image_font_atlas(GlyphInfo* glyphs, Rectangle **glyph_recs, int glyph_count, int fontSize, int padding, int pack_method) @extern("GenImageFontAtlas");

/**
 * Unload font chars info data (RAM)
 */
fn void unload_font_data(List(<GlyphInfo>) glyphs) @inline {
	__unload_font_data(glyphs.entries, (int)glyphs.len());
}

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

