module style_loader;
import rl;
import rgui;

fn void load_style(
    rgui::GuiStyleProp[] props,
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
        rgui::set_style(
            prop.control_id,
            prop.property_id,
            prop.property_value
        );
    }

    im_font.data = (void*)rl::decompress_data(font_data).ptr;

    // Load texture from image
    font.texture = rl::load_texture_from_image(im_font);
    defer rl::unload_image(im_font);  // Uncompressed data can be unloaded from memory

    // Copy char recs data from global fontRecs
    // NOTE: Required to avoid issues if trying to free font
    font.recs = mem::new_array(rl::Rectangle, font.glyph_count).ptr;
    mem::copy(font.recs, recs.ptr, font.glyph_count * rl::Rectangle.sizeof);

    // Copy font char info data from global fontChars
    // NOTE: Required to avoid issues if trying to free font
    font.glyphs = mem::new_array(rl::GlyphInfo, font.glyph_count).ptr;
    mem::copy(font.glyphs, chars.ptr, font.glyph_count * rl::GlyphInfo.sizeof);

    rgui::set_font(font);

    // Setup a white rectangle on the font to be used on shapes drawing,
    // this way we make sure all gui can be drawn on a single pass because no texture change is required
    // NOTE: Setting up this rectangle is a manual process (for the moment)
    rl::set_shapes_texture(font.texture, white_char);
}
