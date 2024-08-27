// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Texture Loading and Drawing Functions (Module: textures)
//------------------------------------------------------------------------------------

// Image loading functions
// NOTE: These functions do not require GPU access
//------------------------------------------------------------------------------------

/**
 * Load image from file into CPU memory (RAM)
 */
extern fn Image load_image(ZString file_name) @extern("LoadImage");

/**
 * Load image from RAW file data
 */
extern fn Image load_image_raw(ZString file_name, int width, int height, int format, int header_size) @extern("LoadImageRaw");

/**
 * Load image from SVG file data or string with specified size
 */
extern fn Image load_image_svg(ZString file_name_or_string, int width, int height) @extern("LoadImageSvg");

/**
 * Load image sequence from file (frames appended to image.data)
 * @param [out] frames
 */
extern fn Image load_image_anim(ZString file_name, int *frames) @extern("LoadImageAnim");

/**
 * Load image from memory buffer, fileType refers to extension: i.e. '.png'
 */
extern fn Image load_image_from_memory(ZString file_type, ZString file_data, int data_size) @extern("LoadImageFromMemory");

/**
 * Load image from GPU texture data
 */
extern fn Image load_image_from_texture(Texture2D texture) @extern("LoadImageFromTexture");

/**
 * Load image from screen buffer and (screenshot)
 */
extern fn Image load_image_from_screen() @extern("LoadImageFromScreen");

/**
 * Check if an image is ready
 */
extern fn bool is_image_ready(Image image) @extern("IsImageReady");

/**
 * Unload image from CPU memory (RAM)
 */
extern fn void unload_image(Image image) @extern("UnloadImage");

/**
 * Export image data to file, returns true on success
 */
extern fn bool export_image(Image image, ZString file_name) @extern("ExportImage");

/**
 * Export image to memory buffer
 */
fn char[] export_image_to_memory(Image image, ZString file_type) @inline {
    int len = 0;
    char *ptr = __export_image_to_memory(image, file_type, &len);
    return ptr[:len];
}

/**
 * Export image as code file defining an array of bytes, returns true on success
 */
extern fn bool export_image_as_code(Image image, ZString file_name) @extern("ExportImageAsCode");

// Image generation functions
//------------------------------------------------------------------------------------

/**
 * Generate image: plain color
 */
extern fn Image gen_image_color(int width, int height, Color color) @extern("GenImageColor");

/**
 * Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
 */
extern fn Image gen_image_gradient_linear(int width, int height, int direction, Color start, Color end) @extern("GenImageGradientLinear");

/**
 * Generate image: radial gradient
 */
extern fn Image gen_image_gradient_radial(int width, int height, float density, Color inner, Color outer) @extern("GenImageGradientRadial");

/**
 * Generate image: square gradient
 */
extern fn Image gen_image_gradient_square(int width, int height, float density, Color inner, Color outer) @extern("GenImageGradientSquare");

/**
 * Generate image: checked
 */
extern fn Image gen_image_checked(int width, int height, int checks_x, int checks_y, Color col1, Color col2) @extern("GenImageChecked");

/**
 * Generate image: white noise
 */
extern fn Image gen_image_white_noise(int width, int height, float factor) @extern("GenImageWhiteNoise");

/**
 * Generate image: perlin noise
 */
extern fn Image gen_image_perlin_noise(int width, int height, int offset_x, int offset_y, float scale) @extern("GenImagePerlinNoise");

/**
 * Generate image: cellular algorithm, bigger tileSize means bigger cells
 */
extern fn Image gen_image_cellular(int width, int height, int tile_size) @extern("GenImageCellular");

/**
 * Generate image: grayscale image from text data
 */
extern fn Image gen_image_text(int width, int height, ZString text) @extern("GenImageText");

// Image manipulation functions
//------------------------------------------------------------------------------------

/**
 * Create an image duplicate (useful for transformations)
 */
extern fn Image image_copy(Image image) @extern("ImageCopy");

/**
 * Create an image from another image piece
 */
extern fn Image image_from_image(Image image, Rectangle rec) @extern("ImageFromImage");

/**
 * Create an image from text (default font)
 */
extern fn Image image_text(ZString text, int font_size, Color color) @extern("ImageText");

/**
 * Create an image from text (custom sprite font)
 */
extern fn Image image_text_ex(Font font, ZString text, float font_size, float spacing, Color tint) @extern("ImageTextEx");

/**
 * Convert image data to desired format
 */
extern fn void image_format(Image* image, int new_format) @extern("ImageFormat");

/**
 * Convert image to POT (power-of-two)
 */
extern fn void image_to_pot(Image* image, Color fill) @extern("ImageToPOT");

/**
 * Crop an image to a defined rectangle
 */
extern fn void image_crop(Image* image, Rectangle crop) @extern("ImageCrop");

/**
 * Crop image depending on alpha value
 */
extern fn void image_alpha_crop(Image* image, float threshold) @extern("ImageAlphaCrop");

/**
 * Clear alpha channel to desired color
 */
extern fn void image_alpha_clear(Image* image, Color color, float threshold) @extern("ImageAlphaClear");

/**
 * Apply alpha mask to image
 */
extern fn void image_alpha_mask(Image* image, Image alpha_mask) @extern("ImageAlphaMask");

/**
 * Premultiply alpha channel
 */
extern fn void image_alpha_premultiply(Image* image) @extern("ImageAlphaPremultiply");

/**
 * Apply Gaussian blur using a box blur approximation
 */
extern fn void image_blur_gaussian(Image* image, int blur_size) @extern("ImageBlurGaussian");

/**
 * Resize image (Bicubic scaling algorithm)
 */
extern fn void image_resize(Image* image, int new_width, int new_height) @extern("ImageResize");

/**
 * Resize image (Nearest-Neighbor scaling algorithm)
 */
extern fn void image_resize_nn(Image* image, int new_width,int new_height) @extern("ImageResizeNN");

/**
 * Resize canvas and fill with color
 */
extern fn void image_resize_canvas(Image* image, int new_width, int new_height, int offset_x, int offset_y, Color fill) @extern("ImageResizeCanvas");

/**
 * Compute all mipmap levels for a provided image
 */
extern fn void image_mipmaps(Image* image) @extern("ImageMipmaps");

/**
 * Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
 */
extern fn void image_dither(Image* image, int r_bpp, int g_bpp, int b_bpp, int a_bpp) @extern("ImageDither");

/**
 * Flip image vertically
 */
extern fn void image_flip_vertical(Image* image) @extern("ImageFlipVertical");

/**
 * Flip image horizontally
 */
extern fn void image_flip_horizontal(Image* image) @extern("ImageFlipHorizontal");

/**
 * Rotate image by input angle in degrees (-359 to 359)
 */
extern fn void image_rotate(Image* image, int degrees) @extern("ImageRotate");

/**
 * Rotate image clockwise 90deg
 */
extern fn void image_rotate_cw(Image* image) @extern("ImageRotateCW");

/**
 * Rotate image counter-clockwise 90deg
 */
extern fn void image_rotate_ccw(Image* image) @extern("ImageRotateCCW");

/**
 * Modify image color: tint
 */
extern fn void image_color_tint(Image* image, Color color) @extern("ImageColorTint");

/**
 * Modify image color: invert
 */
extern fn void image_color_invert(Image* image) @extern("ImageColorInvert");

/**
 * Modify image color: grayscale
 */
extern fn void image_color_grayscale(Image* image) @extern("ImageColorGrayscale");

/**
 * Modify image color: contrast (-100 to 100)
 */
extern fn void image_color_contrast(Image* image, float contrast) @extern("ImageColorContrast");

/**
 * Modify image color: brightness (-255 to 255)
 */
extern fn void image_color_brightness(Image* image, int brightness) @extern("ImageColorBrightness");

/**
 * Modify image color: replace color
 */
extern fn void image_color_replace(Image* image, Color color, Color replace) @extern("ImageColorReplace");

/**
 * Load color data from image as a Color array (RGBA - 32bit)
 */
fn Color[] load_image_colors(Image image) @inline {
    usz len = (usz)(image.width * image.height);
    Color* ptr = __load_image_colors(image);
    return ptr[:len];
}

/**
 * Load colors palette from image as a Color array (RGBA - 32bit)
 */
fn Color[] load_image_palette(Image image, int max_palette_size) @inline {
    int len = 0;
    Color* ptr = __load_image_palette(image, max_palette_size, &len);
    return ptr[:len];
}

/**
 * Unload color data loaded with LoadImageColors()
 */
fn void unload_image_colors(Color[] colors) @inline {
    __unload_image_colors(colors.ptr);
}

/**
 * Unload colors palette loaded with LoadImagePalette()
 */
fn void unload_image_palette(Color[] colors) @inline {
    __unload_image_palette(colors.ptr);
}

/**
 * Get image alpha border rectangle
 */
extern fn Rectangle get_image_alpha_border(Image image, float threshold) @extern("GetImageAlphaBorder");

/**
 * Get image pixel color at (x, y) position
 */
extern fn Color get_image_color(Image image, int x, int y) @extern("GetImageColor");

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
//------------------------------------------------------------------------------------

/**
 * Clear image background with given color
 */
extern fn void image_clear_background(Image* dst, Color color) @extern("ImageClearBackground");

/**
 * Draw pixel within an image
 */
extern fn void image_draw_pixel(Image* dst, int pos_x, int pos_y, Color color) @extern("ImageDrawPixel");

/**
 * Draw pixel within an image (Vector version)
 */
extern fn void image_draw_pixel_v(Image* dst, Vector2 position, Color color) @extern("ImageDrawPixelV");

/**
 * Draw line within an image
 */
extern fn void image_draw_line(Image* dst, int start_pos_x, int start_pos_y, int end_pos_x, int end_pos_y, Color color) @extern("ImageDrawLine");

/**
 * Draw line within an image (Vector version)
 */
extern fn void image_draw_line_v(Image* dst, Vector2 start, Vector2 end, Color color) @extern("ImageDrawLineV");

/**
 * Draw a filled circle within an image
 */
extern fn void image_draw_circle(Image* dst, int center_x, int center_y, int radius, Color color) @extern("ImageDrawCircle");

/**
 * Draw a filled circle within an image (Vector version)
 */
extern fn void image_draw_circle_v(Image* dst, Vector2 center, int radius, Color color) @extern("ImageDrawCircleV");

/**
 * Draw circle outline within an image
 */
extern fn void image_draw_circle_lines(Image* dst, int center_x, int center_y, int radius, Color color) @extern("ImageDrawCircleLines");

/**
 * Draw circle outline within an image (Vector version)
 */
extern fn void image_draw_circle_lines_v(Image* dst, Vector2 center, int radius, Color color) @extern("ImageDrawCircleLinesV");

/**
 * Draw rectangle within an image
 */
extern fn void image_draw_rectangle(Image* dst, int pos_x, int pos_y, int width, int height, Color color) @extern("ImageDrawRectangle");

/**
 * Draw rectangle within an image (Vector version)
 */
extern fn void image_draw_rectangle_v(Image* dst, Vector2 position, Vector2 size, Color color) @extern("ImageDrawRectangleV");

/**
 * Draw rectangle within an image
 */
extern fn void image_draw_rectangle_rec(Image* dst, Rectangle rec, Color color) @extern("ImageDrawRectangleRec");

/**
 * Draw rectangle lines within an image
 */
extern fn void image_draw_rectangle_lines(Image* dst, Rectangle rec, int thick, Color color) @extern("ImageDrawRectangleLines");

/**
 * Draw a source image within a destination image (tint applied to source)
 */
extern fn void image_draw(Image* dst, Image src, Rectangle src_rec, Rectangle dst_rec, Color tint) @extern("ImageDraw");

/**
 * Draw text (using default font) within an image (destination)
 */
extern fn void image_draw_text(Image* dst, ZString text, int pos_x, int pos_y, int font_size, Color color) @extern("ImageDrawText");

/**
 * Draw text (custom sprite font) within an image (destination)
 */
extern fn void image_draw_text_ex(Image* dst, Font font, ZString text, Vector2 position, float font_size, float spacing, Color tint) @extern("ImageDrawTextEx");

// Texture loading functions
// NOTE: These functions require GPU access
//------------------------------------------------------------------------------------

/**
 * Load texture from file into GPU memory (VRAM)
 */
extern fn Texture2D load_texture(ZString file_name) @extern("LoadTexture");

/**
 * Load texture from image data
 */
extern fn Texture2D load_texture_from_image(Image image) @extern("LoadTextureFromImage");

/**
 * Load cubemap from image, multiple image cubemap layouts supported
 */
extern fn TextureCubemap load_texture_cubemap(Image image, int layout) @extern("LoadTextureCubemap");

/**
 * Load texture for rendering (framebuffer)
 */
extern fn RenderTexture2D load_render_texture(int width, int height) @extern("LoadRenderTexture");

/**
 * Check if a texture is ready
 */
extern fn bool is_texture_ready(Texture2D texture) @extern("IsTextureReady");

/**
 * Unload texture from GPU memory (VRAM)
 */
extern fn void unload_texture(Texture2D texture) @extern("UnloadTexture");

/**
 * Check if a render texture is ready
 */
extern fn bool is_render_texture_ready(RenderTexture2D target) @extern("IsRenderTextureReady");

/**
 * Unload render texture from GPU memory (VRAM)
 */
extern fn void unload_render_texture(RenderTexture2D target) @extern("UnloadRenderTexture");

/**
 * Update GPU texture with new data
 */
extern fn void update_texture(Texture2D texture, void* pixels) @extern("UpdateTexture");

/**
 * Update GPU texture rectangle with new data
 */
extern fn void update_texture_rec(Texture2D texture, Rectangle rec, void* pixels) @extern("UpdateTextureRec");

// Texture configuration functions
//------------------------------------------------------------------------------------

/**
 * Generate GPU mipmaps for a texture
 */
extern fn void gen_texture_mipmaps(Texture2D* texture) @extern("GenTextureMipmaps");

/**
 * Set texture scaling filter mode
 */
extern fn void set_texture_filter(Texture2D texture, int filter) @extern("SetTextureFilter");

/**
 * Set texture wrapping mode
 */
extern fn void set_texture_wrap(Texture2D texture, int wrap) @extern("SetTextureWrap");

// Texture drawing functions
//------------------------------------------------------------------------------------

/**
 * Draw a Texture2D
 */
extern fn void draw_texture(Texture2D texture, int pos_x, int pos_y, Color tint) @extern("DrawTexture");

/**
 * Draw a Texture2D with position defined as Vector2
 */
extern fn void draw_texture_v(Texture2D texture, Vector2 position, Color tint) @extern("DrawTextureV");

/**
 * Draw a Texture2D with extended parameters
 */
extern fn void draw_texture_ex(Texture2D texture, Vector2 position, float rotation, float scale, Color tint) @extern("DrawTextureEx");

/**
 * Draw a part of a texture defined by a rectangle
 */
extern fn void draw_texture_rec(Texture2D texture, Rectangle source, Vector2 position, Color tint) @extern("DrawTextureRec");

/**
 * Draw a part of a texture defined by a rectangle with 'pro' parameters
 */
extern fn void draw_texture_pro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint) @extern("DrawTexturePro");

/**
 * Draws a texture (or part of it) that stretches or shrinks nicely
 */
extern fn void draw_texture_n_patch(Texture2D texture, NPatchInfo n_patch_info, Rectangle dest, Vector2 origin, float rotation, Color tint) @extern("DrawTextureNPatch");

// Color/pixel related functions
//------------------------------------------------------------------------------------

/**
 * Get color with alpha applied, alpha goes from 0.0f to 1.0f
 */
extern fn Color fade(Color color, float alpha) @extern("Fade");

/**
 * Get hexadecimal value for a Color
 */
extern fn int color_to_int(Color color) @extern("ColorToInt");

/**
 * Get Color normalized as float [0..1]
 */
extern fn Vector4 color_normalize(Color color) @extern("ColorNormalize");

/**
 * Get Color from normalized values [0..1]
 */
extern fn Color color_from_normalized(Vector4 normalized) @extern("ColorFromNormalized");

/**
 * Get HSV values for a Color, hue [0..360], saturation/value [0..1]
 */
extern fn Vector3 color_to_hsv(Color color) @extern("ColorToHSV");

/**
 * Get a Color from HSV values, hue [0..360], saturation/value [0..1]
 */
extern fn Color color_from_hsv(float hue, float saturation, float value) @extern("ColorFromHSV");

/**
 * Get color multiplied with another color
 */
extern fn Color color_tint(Color color, Color tint) @extern("ColorTint");

/**
 * Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
 */
extern fn Color color_brightness(Color color, float factor) @extern("ColorBrightness");

/**
 * Get color with contrast correction, contrast values between -1.0f and 1.0f
 */
extern fn Color color_contrast(Color color, float contrast) @extern("ColorContrast");

/**
 * Get color with alpha applied, alpha goes from 0.0f to 1.0f
 */
extern fn Color color_alpha(Color color, float alpha) @extern("ColorAlpha");

/**
 * Get src alpha-blended into dst color with tint
 */
extern fn Color color_alpha_blend(Color dst, Color src, Color tint) @extern("ColorAlphaBlend");

/**
 * Get Color structure from hexadecimal value
 */
extern fn Color get_color(uint hex_value) @extern("GetColor");

/**
 * Get Color from a source pixel pointer of certain format
 */
extern fn Color get_pixel_color(void* src_ptr, PixelFormat format) @extern("GetPixelColor");

/**
 * Set color formatted into destination pixel pointer
 */
extern fn void set_pixel_color(void* dst_ptr, Color color, PixelFormat format) @extern("SetPixelColor");

/**
 * Get pixel data size in bytes for certain format
 */
extern fn int get_pixel_data_size(int width, int height, PixelFormat format) @extern("GetPixelDataSize");

