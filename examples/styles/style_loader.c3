// vi: ts=4 sw=4 noet
module style_loader;
import rl;
import raygui;

fn void load_style(
    raygui::GuiStyleProp[] props,
    char[] font_data,
    rl::Rectangle[] recs,
    rl::GlyphInfo[] chars,
    rl::Image im_font,
    rl::Font font,
    rl::Rectangle white_char)
{
    // Load style properties provided
    // NOTE: Default properties are propagated
    foreach (prop : props)
    {
        raygui::setStyle(
            prop.control_id,
            prop.property_id,
            prop.property_value
        );
    }

    im_font.data = (void*)rl::decompressData(font_data).ptr;

    // Load texture from image
    font.texture = rl::loadTextureFromImage(im_font);
    defer rl::unloadImage(im_font);  // Uncompressed data can be unloaded from memory

    // Copy char recs data from global fontRecs
    // NOTE: Required to avoid issues if trying to free font
    // NOTE: raygui frees these with free(), so they must come from raylib's allocator, not a C3 one
    font.recs = rl::memAlloc((uint)(font.glyph_count * rl::Rectangle::size));
    mem::copy(font.recs, recs.ptr, font.glyph_count * rl::Rectangle::size);

    // Copy font char info data from global fontChars
    // NOTE: Required to avoid issues if trying to free font
    font.glyphs = rl::memAlloc((uint)(font.glyph_count * rl::GlyphInfo::size));
    mem::copy(font.glyphs, chars.ptr, font.glyph_count * rl::GlyphInfo::size);

    raygui::setFont(font);

    // Setup a white rectangle on the font to be used on shapes drawing,
    // this way we make sure all gui can be drawn on a single pass because no texture change is required
    // NOTE: Setting up this rectangle is a manual process (for the moment)
    rl::setShapesTexture(font.texture, white_char);
}
