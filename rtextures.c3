module rl;

//------------------------------------------------------------------------------------
// Texture Loading and Drawing Functions (Module: textures)
//------------------------------------------------------------------------------------

// Image loading functions
// NOTE: These functions do not require GPU access
//------------------------------------------------------------------------------------

<*
 Load image from file into CPU memory (RAM)
*>
extern fn Image loadImage(ZString file_name) @extern("LoadImage");

<*
 Load image from RAW file data
*>
extern fn Image loadImageRaw(ZString file_name, int width, int height, int format, int header_size) @extern("LoadImageRaw");

<*
 Load image sequence from file (frames appended to image.data)
 @param [out] frames
*>
extern fn Image loadImageAnim(ZString file_name, int *frames) @extern("LoadImageAnim");

// TODO: do something
<*
 Load image sequence from memory buffer
*>
extern fn Image loadImageAnimFromMemory(ZString fileType, char *fileData, int dataSize, int *frames) @extern("LoadImageAnimFromMemory");

<*
 Load image from memory buffer, fileType refers to extension: i.e. '.png'
*>
extern fn Image loadImageFromMemory(ZString file_type, ZString file_data, int data_size) @extern("LoadImageFromMemory");

<*
 Load image from GPU texture data
*>
extern fn Image loadImageFromTexture(Texture2D texture) @extern("LoadImageFromTexture");

<*
 Load image from screen buffer and (screenshot)
*>
extern fn Image loadImageFromScreen() @extern("LoadImageFromScreen");

<*
 Check if an image is valid (data and parameters)
*>
extern fn bool isImageValid(Image image) @extern("IsImageValid");

<*
 Check if an image is ready
*>
extern fn bool isImageReady(Image image) @extern("IsImageReady");

<*
 Unload image from CPU memory (RAM)
*>
extern fn void unloadImage(Image image) @extern("UnloadImage");

<*
 Export image data to file, returns true on success
*>
extern fn bool exportImage(Image image, ZString file_name) @extern("ExportImage");

<*
 Export image to memory buffer
*>
fn char[] exportImageToMemory(Image image, ZString file_type) @inline {
    int len = 0;
    char *ptr = __export_image_to_memory(image, file_type, &len);
    return ptr[:len];
}

<*
 Export image as code file defining an array of bytes, returns true on success
*>
extern fn bool exportImageAsCode(Image image, ZString file_name) @extern("ExportImageAsCode");

// Image generation functions
//------------------------------------------------------------------------------------

<*
 Generate image: plain color
*>
extern fn Image genImageColor(int width, int height, Color color) @extern("GenImageColor");

<*
 Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
*>
extern fn Image genImageGradientLinear(int width, int height, int direction, Color start, Color end) @extern("GenImageGradientLinear");

<*
 Generate image: radial gradient
*>
extern fn Image genImageGradientRadial(int width, int height, float density, Color inner, Color outer) @extern("GenImageGradientRadial");

<*
 Generate image: square gradient
*>
extern fn Image genImageGradientSquare(int width, int height, float density, Color inner, Color outer) @extern("GenImageGradientSquare");

<*
 Generate image: checked
*>
extern fn Image genImageChecked(int width, int height, int checks_x, int checks_y, Color col1, Color col2) @extern("GenImageChecked");

<*
 Generate image: white noise
*>
extern fn Image genImageWhiteNoise(int width, int height, float factor) @extern("GenImageWhiteNoise");

<*
 Generate image: perlin noise
*>
extern fn Image genImagePerlinNoise(int width, int height, int offset_x, int offset_y, float scale) @extern("GenImagePerlinNoise");

<*
 Generate image: cellular algorithm, bigger tileSize means bigger cells
*>
extern fn Image genImageCellular(int width, int height, int tile_size) @extern("GenImageCellular");

<*
 Generate image: grayscale image from text data
*>
extern fn Image genImageText(int width, int height, ZString text) @extern("GenImageText");

// Image manipulation functions
//------------------------------------------------------------------------------------

<*
 Create an image duplicate (useful for transformations)
*>
extern fn Image imageCopy(Image image) @extern("ImageCopy");

<*
 Create an image from another image piece
*>
extern fn Image imageFromImage(Image image, Rectangle rec) @extern("ImageFromImage");

// TODO: do something
<*
 Create an image from a selected channel of another image (GRAYSCALE)
*>
extern fn Image imageFromChannel(Image image, int selected_channel) @extern("ImageFromChannel");

<*
 Create an image from text (default font)
*>
extern fn Image imageText(ZString text, int font_size, Color color) @extern("ImageText");

<*
 Create an image from text (custom sprite font)
*>
extern fn Image imageTextEx(Font font, ZString text, float font_size, float spacing, Color tint) @extern("ImageTextEx");

<*
 Convert image data to desired format
*>
extern fn void imageFormat(Image* image, PixelFormat new_format) @extern("ImageFormat");

<*
 Convert image to POT (power-of-two)
*>
extern fn void imageToPot(Image* image, Color fill) @extern("ImageToPOT");

<*
 Crop an image to a defined rectangle
*>
extern fn void imageCrop(Image* image, Rectangle crop) @extern("ImageCrop");

<*
 Crop image depending on alpha value
*>
extern fn void imageAlphaCrop(Image* image, float threshold) @extern("ImageAlphaCrop");

<*
 Clear alpha channel to desired color
*>
extern fn void imageAlphaClear(Image* image, Color color, float threshold) @extern("ImageAlphaClear");

<*
 Apply alpha mask to image
*>
extern fn void imageAlphaMask(Image* image, Image alpha_mask) @extern("ImageAlphaMask");

<*
 Premultiply alpha channel
*>
extern fn void imageAlphaPremultiply(Image* image) @extern("ImageAlphaPremultiply");

<*
 Apply Gaussian blur using a box blur approximation
*>
extern fn void imageBlurGaussian(Image* image, int blur_size) @extern("ImageBlurGaussian");

// TODO: do something
<*
 Apply custom square convolution kernel to image
*>
extern fn void imageKernelConvolution(Image* image, float *kernel, int kernelSize) @extern("ImageKernelConvolution");

<*
 Resize image (Bicubic scaling algorithm)
*>
extern fn void imageResize(Image* image, int new_width, int new_height) @extern("ImageResize");

<*
 Resize image (Nearest-Neighbor scaling algorithm)
*>
extern fn void imageResizeNn(Image* image, int new_width,int new_height) @extern("ImageResizeNN");

<*
 Resize canvas and fill with color
*>
extern fn void imageResizeCanvas(Image* image, int new_width, int new_height, int offset_x, int offset_y, Color fill) @extern("ImageResizeCanvas");

<*
 Compute all mipmap levels for a provided image
*>
extern fn void imageMipmaps(Image* image) @extern("ImageMipmaps");

<*
 Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
*>
extern fn void imageDither(Image* image, int r_bpp, int g_bpp, int b_bpp, int a_bpp) @extern("ImageDither");

<*
 Flip image vertically
*>
extern fn void imageFlipVertical(Image* image) @extern("ImageFlipVertical");

<*
 Flip image horizontally
*>
extern fn void imageFlipHorizontal(Image* image) @extern("ImageFlipHorizontal");

<*
 Rotate image by input angle in degrees (-359 to 359)
*>
extern fn void imageRotate(Image* image, int degrees) @extern("ImageRotate");

<*
 Rotate image clockwise 90deg
*>
extern fn void imageRotateCW(Image* image) @extern("ImageRotateCW");

<*
 Rotate image counter-clockwise 90deg
*>
extern fn void imageRotateCCW(Image* image) @extern("ImageRotateCCW");

<*
 Modify image color: tint
*>
extern fn void imageColorTint(Image* image, Color color) @extern("ImageColorTint");

<*
 Modify image color: invert
*>
extern fn void imageColorInvert(Image* image) @extern("ImageColorInvert");

<*
 Modify image color: grayscale
*>
extern fn void imageColorGrayscale(Image* image) @extern("ImageColorGrayscale");

<*
 Modify image color: contrast (-100 to 100)
*>
extern fn void imageColorContrast(Image* image, float contrast) @extern("ImageColorContrast");

<*
 Modify image color: brightness (-255 to 255)
*>
extern fn void imageColorBrightness(Image* image, int brightness) @extern("ImageColorBrightness");

<*
 Modify image color: replace color
*>
extern fn void imageColorReplace(Image* image, Color color, Color replace) @extern("ImageColorReplace");

<*
 Load color data from image as a Color array (RGBA - 32bit)
*>
fn Color[] loadImageColors(Image image) @inline {
    usz len = (usz)(image.width * image.height);
    Color* ptr = __load_image_colors(image);
    return ptr[:len];
}

<*
 Load colors palette from image as a Color array (RGBA - 32bit)
*>
fn Color[] loadImagePalette(Image image, int max_palette_size) @inline {
    int len = 0;
    Color* ptr = __load_image_palette(image, max_palette_size, &len);
    return ptr[:len];
}

<*
 Unload color data loaded with LoadImageColors()
*>
fn void unloadImageColors(Color[] colors) @inline {
    __unload_image_colors(colors.ptr);
}

<*
 Unload colors palette loaded with LoadImagePalette()
*>
fn void unloadImagePalette(Color[] colors) @inline {
    __unload_image_palette(colors.ptr);
}

<*
 Get image alpha border rectangle
*>
extern fn Rectangle getImageAlphaBorder(Image image, float threshold) @extern("GetImageAlphaBorder");

<*
 Get image pixel color at (x, y) position
*>
extern fn Color getImageColor(Image image, int x, int y) @extern("GetImageColor");

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
//------------------------------------------------------------------------------------

<*
 Clear image background with given color
*>
extern fn void imageClearBackground(Image* dst, Color color) @extern("ImageClearBackground");

<*
 Draw pixel within an image
*>
extern fn void imageDrawPixel(Image* dst, int pos_x, int pos_y, Color color) @extern("ImageDrawPixel");

<*
 Draw pixel within an image (Vector version)
*>
extern fn void imageDrawPixelV(Image* dst, Vector2 position, Color color) @extern("ImageDrawPixelV");

<*
 Draw line within an image
*>
extern fn void imageDrawLine(Image* dst, int start_pos_x, int start_pos_y, int end_pos_x, int end_pos_y, Color color) @extern("ImageDrawLine");

<*
 Draw a line defining thickness within an image
*>
extern fn void imageDrawLineEx(Image* dst, Vector2 start, Vector2 end, int thick, Color color) @extern("ImageDrawLineEx");

<*
 Draw line within an image (Vector version)
*>
extern fn void imageDrawLineV(Image* dst, Vector2 start, Vector2 end, Color color) @extern("ImageDrawLineV");

<*
 Draw a filled circle within an image
*>
extern fn void imageDrawCircle(Image* dst, int center_x, int center_y, int radius, Color color) @extern("ImageDrawCircle");

<*
 Draw a filled circle within an image (Vector version)
*>
extern fn void imageDrawCircleV(Image* dst, Vector2 center, int radius, Color color) @extern("ImageDrawCircleV");

<*
 Draw circle outline within an image
*>
extern fn void imageDrawCircleLines(Image* dst, int center_x, int center_y, int radius, Color color) @extern("ImageDrawCircleLines");

<*
 Draw circle outline within an image (Vector version)
*>
extern fn void imageDrawCircleLinesV(Image* dst, Vector2 center, int radius, Color color) @extern("ImageDrawCircleLinesV");

<*
 Draw rectangle within an image
*>
extern fn void imageDrawRectangle(Image* dst, int pos_x, int pos_y, int width, int height, Color color) @extern("ImageDrawRectangle");

<*
 Draw rectangle within an image (Vector version)
*>
extern fn void imageDrawRectangleV(Image* dst, Vector2 position, Vector2 size, Color color) @extern("ImageDrawRectangleV");

<*
 Draw rectangle within an image
*>
extern fn void imageDrawRectangleRec(Image* dst, Rectangle rec, Color color) @extern("ImageDrawRectangleRec");

<*
 Draw rectangle lines within an image
*>
extern fn void imageDrawRectangleLines(Image* dst, Rectangle rec, int thick, Color color) @extern("ImageDrawRectangleLines");

<*
 Draw triangle within an image
*>
extern fn void imageDrawTriangle(Image* dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("ImageDrawTriangle");

<*
 Draw triangle with interpolated colors within an image
*>
extern fn void imageDrawTriangleEx(Image* dst, Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3) @extern("ImageDrawTriangleEx");

<*
 Draw triangle outline within an image
*>
extern fn void imageDrawTriangleLines(Image* dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("ImageDrawTriangleLines");

<*
 Draw a triangle fan defined by points within an image (first vertex is the center)
 @require points.len <= int.max
*>
fn void imageDrawTriangleFan(Image* dst, Vector2[] points, Color color) @inline {
	__image_draw_triangle_fan(dst, points.ptr, (int)points.len, color);
}

<*
 Draw a triangle strip defined by points within an image
 @require points.len <= int.max
*>
fn void imageDrawTriangleStrip(Image* dst, Vector2[] points, Color color) @inline {
	__image_draw_triangle_strip(dst, points.ptr, (int)points.len, color);
}

<*
 Draw a source image within a destination image (tint applied to source)
*>
extern fn void imageDraw(Image* dst, Image src, Rectangle src_rec, Rectangle dst_rec, Color tint) @extern("ImageDraw");

<*
 Draw text (using default font) within an image (destination)
*>
extern fn void imageDrawText(Image* dst, ZString text, int pos_x, int pos_y, int font_size, Color color) @extern("ImageDrawText");

<*
 Draw text (custom sprite font) within an image (destination)
*>
extern fn void imageDrawTextEx(Image* dst, Font font, ZString text, Vector2 position, float font_size, float spacing, Color tint) @extern("ImageDrawTextEx");

// Texture loading functions
// NOTE: These functions require GPU access
//------------------------------------------------------------------------------------

<*
 Load texture from file into GPU memory (VRAM)
*>
extern fn Texture2D loadTexture(ZString file_name) @extern("LoadTexture");

<*
 Load texture from image data
*>
extern fn Texture2D loadTextureFromImage(Image image) @extern("LoadTextureFromImage");

<*
 Load cubemap from image, multiple image cubemap layouts supported
*>
extern fn TextureCubemap loadTextureCubemap(Image image, CubemapLayout layout) @extern("LoadTextureCubemap");

<*
 Load texture for rendering (framebuffer)
*>
extern fn RenderTexture2D loadRenderTexture(int width, int height) @extern("LoadRenderTexture");

<*
 Check if a texture is valid (loaded in GPU)
*>
extern fn bool isTextureValid(Texture2D texture) @extern("IsTextureValid");

<*
 Unload texture from GPU memory (VRAM)
*>
extern fn void unloadTexture(Texture2D texture) @extern("UnloadTexture");

<*
 Check if a render texture is valid (loaded in GPU)
*>
extern fn bool isRenderTextureValid(RenderTexture2D target) @extern("IsRenderTextureValid");

<*
 Unload render texture from GPU memory (VRAM)
*>
extern fn void unloadRenderTexture(RenderTexture2D target) @extern("UnloadRenderTexture");

<*
 Update GPU texture with new data
*>
extern fn void updateTexture(Texture2D texture, void* pixels) @extern("UpdateTexture");

<*
 Update GPU texture rectangle with new data
*>
extern fn void updateTextureRec(Texture2D texture, Rectangle rec, void* pixels) @extern("UpdateTextureRec");

// Texture configuration functions
//------------------------------------------------------------------------------------

<*
 Generate GPU mipmaps for a texture
*>
extern fn void genTextureMipmaps(Texture2D* texture) @extern("GenTextureMipmaps");

<*
 Set texture scaling filter mode
*>
extern fn void setTextureFilter(Texture2D texture, TextureFilter filter) @extern("SetTextureFilter");

<*
 Set texture wrapping mode
*>
extern fn void setTextureWrap(Texture2D texture, TextureWrap wrap) @extern("SetTextureWrap");

// Texture drawing functions
//------------------------------------------------------------------------------------

<*
 Draw a Texture2D
*>
extern fn void drawTexture(Texture2D texture, int pos_x, int pos_y, Color tint) @extern("DrawTexture");

<*
 Draw a Texture2D with position defined as Vector2
*>
extern fn void drawTextureV(Texture2D texture, Vector2 position, Color tint) @extern("DrawTextureV");

<*
 Draw a Texture2D with extended parameters
*>
extern fn void drawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint) @extern("DrawTextureEx");

<*
 Draw a part of a texture defined by a rectangle
*>
extern fn void drawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint) @extern("DrawTextureRec");

<*
 Draw a part of a texture defined by a rectangle with 'pro' parameters
*>
extern fn void drawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint) @extern("DrawTexturePro");

<*
 Draws a texture (or part of it) that stretches or shrinks nicely
*>
extern fn void drawTextureNPatch(Texture2D texture, NPatchInfo n_patch_info, Rectangle dest, Vector2 origin, float rotation, Color tint) @extern("DrawTextureNPatch");

// Color/pixel related functions
//------------------------------------------------------------------------------------

<*
 Check if two colors are equal
*>
extern fn bool colorIsEqual(Color col1, Color col2) @extern("ColorIsEqual");

<*
 Get color with alpha applied, alpha goes from 0.0f to 1.0f
 @require alpha >= 0.0f && alpha <= 1.0f
*>
extern fn Color fade(Color color, float alpha) @extern("Fade");

<*
 Get hexadecimal value for a Color
*>
extern fn int colorToInt(Color color) @extern("ColorToInt");

<*
 Get Color normalized as float [0..1]
 @ensure return.x >= 0.0f && return.x <= 1.0f
 @ensure return.y >= 0.0f && return.y <= 1.0f
 @ensure return.z >= 0.0f && return.z <= 1.0f
 @ensure return.w >= 0.0f && return.w <= 1.0f
*>
extern fn Vector4 colorNormalize(Color color) @extern("ColorNormalize");

<*
 Get Color from normalized values [0..1]
 @require normalized.x >= 0.0f && normalized.x <= 1.0f
 @require normalized.y >= 0.0f && normalized.y <= 1.0f
 @require normalized.z >= 0.0f && normalized.z <= 1.0f
 @require normalized.w >= 0.0f && normalized.w <= 1.0f
*>
extern fn Color colorFromNormalized(Vector4 normalized) @extern("ColorFromNormalized");

<*
 Get HSV values for a Color, hue [0..360], saturation/value [0..1]
 @ensure return.x >= 0.0f && return.x <= 360.0f
 @ensure return.y >= 0.0f && return.y <= 1.0f
 @ensure return.x >= 0.0f && return.x <= 1.0f
*>
extern fn Vector3 colorToHSV(Color color) @extern("ColorToHSV");

<*
 Get a Color from HSV values, hue [0..360], saturation/value [0..1]
 @require hue >= 0.0f && hue <= 360.0f
 @require saturation >= 0.0f && saturation <= 1.0f
 @require value >= 0.0f && value <= 1.0f
*>
extern fn Color colorFromHSV(float hue, float saturation, float value) @extern("ColorFromHSV");

<*
 Get color multiplied with another color
*>
extern fn Color colorTint(Color color, Color tint) @extern("ColorTint");

<*
 Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
 @require factor >= -1.0f && factor <= 1.0f
*>
extern fn Color colorBrightness(Color color, float factor) @extern("ColorBrightness");

<*
 Get color with contrast correction, contrast values between -1.0f and 1.0f
 @require contrast >= -1.0f && contrast <= 1.0f
*>
extern fn Color colorContrast(Color color, float contrast) @extern("ColorContrast");

<*
 Get color with alpha applied, alpha goes from 0.0f to 1.0f
 @require alpha >= 0.0f && alpha <= 1.0f
*>
extern fn Color colorAlpha(Color color, float alpha) @extern("ColorAlpha");

<*
 Get src alpha-blended into dst color with tint
*>
extern fn Color colorAlphaBlend(Color dst, Color src, Color tint) @extern("ColorAlphaBlend");

<*
 Get color lerp interpolation between two colors, factor [0.0f..1.0f]
 @require factor >= 0.0f && factor <= 1.0f
*>
extern fn Color colorLerp(Color color1, Color color2, float factor) @extern("ColorLerp");

<*
 Get Color structure from hexadecimal value
*>
extern fn Color getColor(uint hex_value) @extern("GetColor");

<*
 Get Color from a source pixel pointer of certain format
*>
extern fn Color getPixelColor(void* src_ptr, PixelFormat format) @extern("GetPixelColor");

<*
 Set color formatted into destination pixel pointer
*>
extern fn void setPixelColor(void* dst_ptr, Color color, PixelFormat format) @extern("SetPixelColor");

<*
 Get pixel data size in bytes for certain format
*>
extern fn int getPixelDataSize(int width, int height, PixelFormat format) @extern("GetPixelDataSize");
