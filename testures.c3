// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Texture Loading and Drawing Functions (Module: textures)
//------------------------------------------------------------------------------------

// Image loading functions
// NOTE: These functions do not require GPU access
//------------------------------------------------------------------------------------
// Load image from file into CPU memory (RAM)
fn Image load_image(ZString file_name) @extern("LoadImage");
// Load image from RAW file data
fn Image load_image_raw(ZString file_name, int width, int height, int format, int header_size) @extern("LoadImageRaw");
// Load image from SVG file data or string with specified size
fn Image load_image_svg(ZString file_name_or_string, int width, int height) @extern("LoadImageSvg");
// Load image sequence from file (frames appended to image.data)
fn Image load_image_anim(ZString file_name, int *frames) @extern("LoadImageAnim");
// Load image from memory buffer, fileType refers to extension: i.e. '.png'
fn Image load_image_from_memory(ZString file_type, ZString file_data, int data_size) @extern("LoadImageFromMemory");
// Load image from GPU texture data
fn Image load_image_from_texture(Texture2D texture) @extern("LoadImageFromTexture");
// Load image from screen buffer and (screenshot)
fn Image load_image_from_screen() @extern("LoadImageFromScreen");
// Check if an image is ready
fn bool is_image_ready(Image image) @extern("IsImageReady");
// Unload image from CPU memory (RAM)
fn void unload_image(Image image) @extern("UnloadImage");
// Export image data to file, returns true on success
fn bool export_image(Image image, ZString file_name) @extern("ExportImage");
// Export image to memory buffer
fn char* export_image_to_memory(Image image, ZString file_type, int *file_size) @extern("ExportImageToMemory");
// Export image as code file defining an array of bytes, returns true on success
fn bool export_image_as_code(Image image, ZString file_name) @extern("ExportImageAsCode");

// Image generation functions
//------------------------------------------------------------------------------------
// Generate image: plain color
fn Image gen_image_color(int width, int height, Color color) @extern("GenImageColor");
// Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
fn Image gen_image_gradient_linear(int width, int height, int direction, Color start, Color end) @extern("GenImageGradientLinear");
// Generate image: radial gradient
fn Image gen_image_gradient_radial(int width, int height, float density, Color inner, Color outer) @extern("GenImageGradientRadial");
// Generate image: square gradient
fn Image gen_image_gradient_square(int width, int height, float density, Color inner, Color outer) @extern("GenImageGradientSquare");
// Generate image: checked
fn Image gen_image_checked(int width, int height, int checks_x, int checks_y, Color col1, Color col2) @extern("GenImageChecked");
// Generate image: white noise
fn Image gen_image_white_noise(int width, int height, float factor) @extern("GenImageWhiteNoise");
// Generate image: perlin noise
fn Image gen_image_perlin_noise(int width, int height, int offset_x, int offset_y, float scale) @extern("GenImagePerlinNoise");
// Generate image: cellular algorithm, bigger tileSize means bigger cells
fn Image gen_image_cellular(int width, int height, int tile_size) @extern("GenImageCellular");
// Generate image: grayscale image from text data
fn Image gen_image_text(int width, int height, ZString text) @extern("GenImageText");

// Image manipulation functions
//------------------------------------------------------------------------------------
// Create an image duplicate (useful for transformations)
fn Image image_copy(Image image) @extern("ImageCopy");
// Create an image from another image piece
fn Image image_from_image(Image image, Rectangle rec) @extern("ImageFromImage");
// Create an image from text (default font)
fn Image image_text(ZString text, int font_size, Color color) @extern("ImageText");
// Create an image from text (custom sprite font)
fn Image image_text_ex(Font font, ZString text, float font_size, float spacing, Color tint) @extern("ImageTextEx");
// Convert image data to desired format
fn void image_format(Image* image, int new_format) @extern("ImageFormat");
// Convert image to POT (power-of-two)
fn void image_to_pot(Image* image, Color fill) @extern("ImageToPOT");
// Crop an image to a defined rectangle
fn void image_crop(Image* image, Rectangle crop) @extern("ImageCrop");
// Crop image depending on alpha value
fn void image_alpha_crop(Image* image, float threshold) @extern("ImageAlphaCrop");
// Clear alpha channel to desired color
fn void image_alpha_clear(Image* image, Color color, float threshold) @extern("ImageAlphaClear");
// Apply alpha mask to image
fn void image_alpha_mask(Image* image, Image alpha_mask) @extern("ImageAlphaMask");
// Premultiply alpha channel
fn void image_alpha_premultiply(Image* image) @extern("ImageAlphaPremultiply");
// Apply Gaussian blur using a box blur approximation
fn void image_blur_gaussian(Image* image, int blur_size) @extern("ImageBlurGaussian");
// Resize image (Bicubic scaling algorithm)
fn void image_resize(Image* image, int new_width, int new_height) @extern("ImageResize");
// Resize image (Nearest-Neighbor scaling algorithm)
fn void image_resize_nn(Image* image, int new_width,int new_height) @extern("ImageResizeNN");
// Resize canvas and fill with color
fn void image_resize_canvas(Image* image, int new_width, int new_height, int offset_x, int offset_y, Color fill) @extern("ImageResizeCanvas");
// Compute all mipmap levels for a provided image
fn void image_mipmaps(Image* image) @extern("ImageMipmaps");
// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
fn void image_dither(Image* image, int r_bpp, int g_bpp, int b_bpp, int a_bpp) @extern("ImageDither");
// Flip image vertically
fn void image_flip_vertical(Image* image) @extern("ImageFlipVertical");
// Flip image horizontally
fn void image_flip_horizontal(Image* image) @extern("ImageFlipHorizontal");
// Rotate image by input angle in degrees (-359 to 359)
fn void image_rotate(Image* image, int degrees) @extern("ImageRotate");
// Rotate image clockwise 90deg
fn void image_rotate_cw(Image* image) @extern("ImageRotateCW");
// Rotate image counter-clockwise 90deg
fn void image_rotate_ccw(Image* image) @extern("ImageRotateCCW");
// Modify image color: tint
fn void image_color_tint(Image* image, Color color) @extern("ImageColorTint");
// Modify image color: invert
fn void image_color_invert(Image* image) @extern("ImageColorInvert");
// Modify image color: grayscale
fn void image_color_grayscale(Image* image) @extern("ImageColorGrayscale");
// Modify image color: contrast (-100 to 100)
fn void image_color_contrast(Image* image, float contrast) @extern("ImageColorContrast");
// Modify image color: brightness (-255 to 255)
fn void image_color_brightness(Image* image, int brightness) @extern("ImageColorBrightness");
// Modify image color: replace color
fn void image_color_replace(Image* image, Color color, Color replace) @extern("ImageColorReplace");
// Load color data from image as a Color array (RGBA - 32bit)
fn Color* load_image_colors(Image image) @extern("LoadImageColors");
// Load colors palette from image as a Color array (RGBA - 32bit)
fn Color* load_image_palette(Image image, int max_palette_size, int *color_count) @extern("LoadImagePalette");
// Unload color data loaded with LoadImageColors()
fn void unload_image_colors(Color* colors) @extern("UnloadImageColors");
// Unload colors palette loaded with LoadImagePalette()
fn void unload_image_palette(Color* colors) @extern("UnloadImagePalette");
// Get image alpha border rectangle
fn Rectangle get_image_alpha_border(Image image, float threshold) @extern("GetImageAlphaBorder");
// Get image pixel color at (x, y) position
fn Color get_image_color(Image image, int x, int y) @extern("GetImageColor");

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
//------------------------------------------------------------------------------------
// Clear image background with given color
fn void image_clear_background(Image* dst, Color color) @extern("ImageClearBackground");
// Draw pixel within an image
fn void image_draw_pixel(Image* dst, int pos_x, int pos_y, Color color) @extern("ImageDrawPixel");
// Draw pixel within an image (Vector version)
fn void image_draw_pixel_v(Image* dst, Vector2 position, Color color) @extern("ImageDrawPixelV");
// Draw line within an image
fn void image_draw_line(Image* dst, int start_pos_x, int start_pos_y, int end_pos_x, int end_pos_y, Color color) @extern("ImageDrawLine");
// Draw line within an image (Vector version)
fn void image_draw_line_v(Image* dst, Vector2 start, Vector2 end, Color color) @extern("ImageDrawLineV");
// Draw a filled circle within an image
fn void image_draw_circle(Image* dst, int center_x, int center_y, int radius, Color color) @extern("ImageDrawCircle");
// Draw a filled circle within an image (Vector version)
fn void image_draw_circle_v(Image* dst, Vector2 center, int radius, Color color) @extern("ImageDrawCircleV");
// Draw circle outline within an image
fn void image_draw_circle_lines(Image* dst, int center_x, int center_y, int radius, Color color) @extern("ImageDrawCircleLines");
// Draw circle outline within an image (Vector version)
fn void image_draw_circle_lines_v(Image* dst, Vector2 center, int radius, Color color) @extern("ImageDrawCircleLinesV");
// Draw rectangle within an image
fn void image_draw_rectangle(Image* dst, int pos_x, int pos_y, int width, int height, Color color) @extern("ImageDrawRectangle");
// Draw rectangle within an image (Vector version)
fn void image_draw_rectangle_v(Image* dst, Vector2 position, Vector2 size, Color color) @extern("ImageDrawRectangleV");
// Draw rectangle within an image
fn void image_draw_rectangle_rec(Image* dst, Rectangle rec, Color color) @extern("ImageDrawRectangleRec");
// Draw rectangle lines within an image
fn void image_draw_rectangle_lines(Image* dst, Rectangle rec, int thick, Color color) @extern("ImageDrawRectangleLines");
// Draw a source image within a destination image (tint applied to source)
fn void image_draw(Image* dst, Image src, Rectangle src_rec, Rectangle dst_rec, Color tint) @extern("ImageDraw");
// Draw text (using default font) within an image (destination)
fn void image_draw_text(Image* dst, ZString text, int pos_x, int pos_y, int font_size, Color color) @extern("ImageDrawText");
// Draw text (custom sprite font) within an image (destination)
fn void image_draw_text_ex(Image* dst, Font font, ZString text, Vector2 position, float font_size, float spacing, Color tint) @extern("ImageDrawTextEx");

// Texture loading functions
// NOTE: These functions require GPU access
//------------------------------------------------------------------------------------
// Load texture from file into GPU memory (VRAM)
fn Texture2D load_texture(ZString file_name) @extern("LoadTexture");
// Load texture from image data
fn Texture2D load_texture_from_image(Image image) @extern("LoadTextureFromImage");
// Load cubemap from image, multiple image cubemap layouts supported
fn TextureCubemap load_texture_cubemap(Image image, int layout) @extern("LoadTextureCubemap");
// Load texture for rendering (framebuffer)
fn RenderTexture2D load_render_texture(int width, int height) @extern("LoadRenderTexture");
// Check if a texture is ready
fn bool is_texture_ready(Texture2D texture) @extern("IsTextureReady");
// Unload texture from GPU memory (VRAM)
fn void unload_texture(Texture2D texture) @extern("UnloadTexture");
// Check if a render texture is ready
fn bool is_render_texture_ready(RenderTexture2D target) @extern("IsRenderTextureReady");
// Unload render texture from GPU memory (VRAM)
fn void unload_render_texture(RenderTexture2D target) @extern("UnloadRenderTexture");
// Update GPU texture with new data
fn void update_texture(Texture2D texture, void* pixels) @extern("UpdateTexture");
// Update GPU texture rectangle with new data
fn void update_texture_rec(Texture2D texture, Rectangle rec, void* pixels) @extern("UpdateTextureRec");

// Texture configuration functions
//------------------------------------------------------------------------------------
// Generate GPU mipmaps for a texture
fn void gen_texture_mipmaps(Texture2D* texture) @extern("GenTextureMipmaps");
// Set texture scaling filter mode
fn void set_texture_filter(Texture2D texture, int filter) @extern("SetTextureFilter");
// Set texture wrapping mode
fn void set_texture_wrap(Texture2D texture, int wrap) @extern("SetTextureWrap");

// Texture drawing functions
//------------------------------------------------------------------------------------
// Draw a Texture2D
fn void draw_texture(Texture2D texture, int pos_x, int pos_y, Color tint) @extern("DrawTexture");
// Draw a Texture2D with position defined as Vector2
fn void draw_texture_v(Texture2D texture, Vector2 position, Color tint) @extern("DrawTextureV");
// Draw a Texture2D with extended parameters
fn void draw_texture_ex(Texture2D texture, Vector2 position, float rotation, float scale, Color tint) @extern("DrawTextureEx");
// Draw a part of a texture defined by a rectangle
fn void draw_texture_rec(Texture2D texture, Rectangle source, Vector2 position, Color tint) @extern("DrawTextureRec");
// Draw a part of a texture defined by a rectangle with 'pro' parameters
fn void draw_texture_pro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint) @extern("DrawTexturePro");
// Draws a texture (or part of it) that stretches or shrinks nicely
fn void draw_texture_n_patch(Texture2D texture, NPatchInfo n_patch_info, Rectangle dest, Vector2 origin, float rotation, Color tint) @extern("DrawTextureNPatch");

// Color/pixel related functions
//------------------------------------------------------------------------------------
// Get color with alpha applied, alpha goes from 0.0f to 1.0f
fn Color fade(Color color, float alpha) @extern("Fade");
// Get hexadecimal value for a Color
fn int color_to_int(Color color) @extern("ColorToInt");
// Get Color normalized as float [0..1]
fn Vector4 color_normalize(Color color) @extern("ColorNormalize");
// Get Color from normalized values [0..1]
fn Color color_from_normalized(Vector4 normalized) @extern("ColorFromNormalized");
// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
fn Vector3 color_to_hsv(Color color) @extern("ColorToHSV");
// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
fn Color color_from_hsv(float hue, float saturation, float value) @extern("ColorFromHSV");
// Get color multiplied with another color
fn Color color_tint(Color color, Color tint) @extern("ColorTint");
// Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
fn Color color_brightness(Color color, float factor) @extern("ColorBrightness");
// Get color with contrast correction, contrast values between -1.0f and 1.0f
fn Color color_contrast(Color color, float contrast) @extern("ColorContrast");
// Get color with alpha applied, alpha goes from 0.0f to 1.0f
fn Color color_alpha(Color color, float alpha) @extern("ColorAlpha");
// Get src alpha-blended into dst color with tint
fn Color color_alpha_blend(Color dst, Color src, Color tint) @extern("ColorAlphaBlend");
// Get Color structure from hexadecimal value
fn Color get_color(uint hex_value) @extern("GetColor");
// Get Color from a source pixel pointer of certain format
fn Color get_pixel_color(void* src_ptr, int format) @extern("GetPixelColor");
// Set color formatted into destination pixel pointer
fn void set_pixel_color(void* dst_ptr, Color color, int format) @extern("SetPixelColor");
// Get pixel data size in bytes for certain format
fn int get_pixel_data_size(int width, int height, int format) @extern("GetPixelDataSize");

