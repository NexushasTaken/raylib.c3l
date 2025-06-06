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
extern fn bool Image.isValid(Image image) @extern("IsImageValid");
alias isImageValid = Image.isValid;

<*
 Unload image from CPU memory (RAM)
*>
extern fn void Image.unload(Image image) @extern("UnloadImage");
alias unloadImage = Image.unload;

<*
 Export image data to file, returns true on success
*>
extern fn bool Image.export(Image image, ZString file_name) @extern("ExportImage");
alias exportImage = Image.export;

<*
 Export image to memory buffer
*>
fn char[] Image.exportToMemory(Image image, ZString file_type) @inline {
    int len = 0;
    char *ptr = __export_image_to_memory(image, file_type, &len);
    return ptr[:len];
}
alias exportImageToMemory = Image.exportToMemory;

<*
 Export image as code file defining an array of bytes, returns true on success
*>
extern fn bool Image.exportAsCode(Image image, ZString file_name) @extern("ExportImageAsCode");
alias exportImageAsCode = Image.exportAsCode;

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
extern fn Image Image.copy(Image image) @extern("ImageCopy");
alias imageCopy = Image.copy;

<*
 Create an image from another image piece
*>
extern fn Image Image.fromImage(Image image, Rectangle rec) @extern("ImageFromImage");
alias imageFromImage = Image.fromImage;

// TODO: do something
<*
 Create an image from a selected channel of another image (GRAYSCALE)
*>
extern fn Image Image.fromChannel(Image image, int selected_channel) @extern("ImageFromChannel");
alias imageFromChannel = Image.fromChannel;

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
extern fn void Image.toFormat(Image* image, PixelFormat new_format) @extern("ImageFormat");
alias imageFormat = Image.toFormat;

<*
 Convert image to POT (power-of-two)
*>
extern fn void Image.toPot(Image* image, Color fill) @extern("ImageToPOT");
alias imageToPot = Image.toPot;

<*
 Crop an image to a defined rectangle
*>
extern fn void Image.crop(Image* image, Rectangle crop) @extern("ImageCrop");
alias imageCrop = Image.crop;

<*
 Crop image depending on alpha value
*>
extern fn void Image.alphaCrop(Image* image, float threshold) @extern("ImageAlphaCrop");
alias imageAlphaCrop = Image.alphaCrop;

<*
 Clear alpha channel to desired color
*>
extern fn void Image.alphaClear(Image* image, Color color, float threshold) @extern("ImageAlphaClear");
alias imageAlphaClear = Image.alphaClear;

<*
 Apply alpha mask to image
*>
extern fn void Image.alphaMask(Image* image, Image alpha_mask) @extern("ImageAlphaMask");
alias imageAlphaMask = Image.alphaMask;

<*
 Premultiply alpha channel
*>
extern fn void Image.alphaPremultiply(Image* image) @extern("ImageAlphaPremultiply");
alias imageAlphaPremultiply = Image.alphaPremultiply;

<*
 Apply Gaussian blur using a box blur approximation
*>
extern fn void Image.blurGaussian(Image* image, int blur_size) @extern("ImageBlurGaussian");
alias imageBlurGaussian = Image.blurGaussian;

// TODO: do something
<*
 Apply custom square convolution kernel to image
*>
extern fn void Image.kernelConvolution(Image* image, float *kernel, int kernelSize) @extern("ImageKernelConvolution");
alias imageKernelConvolution = Image.kernelConvolution;

<*
 Resize image (Bicubic scaling algorithm)
*>
extern fn void Image.resize(Image* image, int new_width, int new_height) @extern("ImageResize");
alias imageResize = Image.resize;

<*
 Resize image (Nearest-Neighbor scaling algorithm)
*>
extern fn void Image.resizeNN(Image* image, int new_width,int new_height) @extern("ImageResizeNN");
alias imageResizeNN = Image.resizeNN;

<*
 Resize canvas and fill with color
*>
extern fn void Image.resizeCanvas(Image* image, int new_width, int new_height, int offset_x, int offset_y, Color fill) @extern("ImageResizeCanvas");
alias imageResizeCanvas = Image.resizeCanvas;

<*
 Compute all mipmap levels for a provided image
*>
extern fn void Image.computeMipmaps(Image* image) @extern("ImageMipmaps");
alias imageMipmaps = Image.computeMipmaps;

<*
 Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
*>
extern fn void Image.dither(Image* image, int r_bpp, int g_bpp, int b_bpp, int a_bpp) @extern("ImageDither");
alias imageDither = Image.dither;

<*
 Flip image vertically
*>
extern fn void Image.flipVertical(Image* image) @extern("ImageFlipVertical");
alias flipVertical = Image.flipVertical;

<*
 Flip image horizontally
*>
extern fn void Image.flipHorizontal(Image* image) @extern("ImageFlipHorizontal");
alias flipHorizontal = Image.flipHorizontal;

<*
 Rotate image by input angle in degrees (-359 to 359)
*>
extern fn void Image.rotate(Image* image, int degrees) @extern("ImageRotate");
alias rotate = Image.rotate;

<*
 Rotate image clockwise 90deg
*>
extern fn void Image.rotateCW(Image* image) @extern("ImageRotateCW");
alias rotateCW = Image.rotateCW;

<*
 Rotate image counter-clockwise 90deg
*>
extern fn void Image.rotateCCW(Image* image) @extern("ImageRotateCCW");
alias rotateCCW = Image.rotateCCW;

<*
 Modify image color: tint
*>
extern fn void Image.colorTint(Image* image, Color color) @extern("ImageColorTint");
alias imageColorTint = Image.colorTint;

<*
 Modify image color: invert
*>
extern fn void Image.colorInvert(Image* image) @extern("ImageColorInvert");
alias imageColorInvert = Image.colorInvert;

<*
 Modify image color: grayscale
*>
extern fn void Image.colorGrayscale(Image* image) @extern("ImageColorGrayscale");
alias imageColorGrayscale = Image.colorGrayscale;

<*
 Modify image color: contrast (-100 to 100)
*>
extern fn void Image.colorContrast(Image* image, float contrast) @extern("ImageColorContrast");
alias imageColorContrast = Image.colorContrast;

<*
 Modify image color: brightness (-255 to 255)
*>
extern fn void Image.colorBrightness(Image* image, int brightness) @extern("ImageColorBrightness");
alias imageColorBrightness = Image.colorBrightness;

<*
 Modify image color: replace color
*>
extern fn void Image.colorReplace(Image* image, Color color, Color replace) @extern("ImageColorReplace");
alias imageColorReplace = Image.colorReplace;

<*
 Load color data from image as a Color array (RGBA - 32bit)
*>
fn Color[] Image.loadColors(Image image) @inline {
    usz len = (usz)(image.width * image.height);
    Color* ptr = __load_image_colors(image);
    return ptr[:len];
}
alias loadImageColors = Image.loadColors;

<*
 Load colors palette from image as a Color array (RGBA - 32bit)
*>
fn Color[] Image.loadPalette(Image image, int max_palette_size) @inline {
    int len = 0;
    Color* ptr = __load_image_palette(image, max_palette_size, &len);
    return ptr[:len];
}
alias loadImagePalette = Image.loadPalette;

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
extern fn Rectangle Image.getAlphaBorder(Image image, float threshold) @extern("GetImageAlphaBorder");
alias getImageAlphaBorder = Image.getAlphaBorder;

<*
 Get image pixel color at (x, y) position
*>
extern fn Color Image.getColor(Image image, int x, int y) @extern("GetImageColor");
alias getImageColor = Image.getColor;

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
//------------------------------------------------------------------------------------

<*
 Clear image background with given color
*>
extern fn void Image.clearBackground(Image* dst, Color color) @extern("ImageClearBackground");
alias imageClearBackground = Image.clearBackground;

<*
 Draw pixel within an image
*>
extern fn void Image.drawPixel(Image* dst, int pos_x, int pos_y, Color color) @extern("ImageDrawPixel");
alias imageDrawPixel = Image.drawPixel;

<*
 Draw pixel within an image (Vector version)
*>
extern fn void Image.drawPixelV(Image* dst, Vector2 position, Color color) @extern("ImageDrawPixelV");
alias imageDrawPixelV = Image.drawPixelV;

<*
 Draw line within an image
*>
extern fn void Image.drawLine(Image* dst, int start_pos_x, int start_pos_y, int end_pos_x, int end_pos_y, Color color) @extern("ImageDrawLine");
alias imageDrawLine = Image.drawLine;

<*
 Draw a line defining thickness within an image
*>
extern fn void Image.drawLineEx(Image* dst, Vector2 start, Vector2 end, int thick, Color color) @extern("ImageDrawLineEx");
alias imageDrawLineEx = Image.drawLineEx;

<*
 Draw line within an image (Vector version)
*>
extern fn void Image.drawLineV(Image* dst, Vector2 start, Vector2 end, Color color) @extern("ImageDrawLineV");
alias imageDrawLineV = Image.drawLineV;

<*
 Draw a filled circle within an image
*>
extern fn void Image.drawCircle(Image* dst, int center_x, int center_y, int radius, Color color) @extern("ImageDrawCircle");
alias imageDrawCircle = Image.drawCircle;

<*
 Draw a filled circle within an image (Vector version)
*>
extern fn void Image.drawCircleV(Image* dst, Vector2 center, int radius, Color color) @extern("ImageDrawCircleV");
alias imageDrawCircleV = Image.drawCircleV;

<*
 Draw circle outline within an image
*>
extern fn void Image.drawCircleLines(Image* dst, int center_x, int center_y, int radius, Color color) @extern("ImageDrawCircleLines");
alias imageDrawCircleLines = Image.drawCircleLines;

<*
 Draw circle outline within an image (Vector version)
*>
extern fn void Image.drawCircleLinesV(Image* dst, Vector2 center, int radius, Color color) @extern("ImageDrawCircleLinesV");
alias imageDrawCircleLinesV = Image.drawCircleLinesV;

<*
 Draw rectangle within an image
*>
extern fn void Image.drawRectangle(Image* dst, int pos_x, int pos_y, int width, int height, Color color) @extern("ImageDrawRectangle");
alias imageDrawRectangle = Image.drawRectangle;

<*
 Draw rectangle within an image (Vector version)
*>
extern fn void Image.drawRectangleV(Image* dst, Vector2 position, Vector2 size, Color color) @extern("ImageDrawRectangleV");
alias imageDrawRectangleV = Image.drawRectangleV;

<*
 Draw rectangle within an image
*>
extern fn void Image.drawRectangleRec(Image* dst, Rectangle rec, Color color) @extern("ImageDrawRectangleRec");
alias imageDrawRectangleRec = Image.drawRectangleRec;

<*
 Draw rectangle lines within an image
*>
extern fn void Image.drawRectangleLines(Image* dst, Rectangle rec, int thick, Color color) @extern("ImageDrawRectangleLines");
alias imageDrawRectangleLines = Image.drawRectangleLines;

<*
 Draw triangle within an image
*>
extern fn void Image.drawTriangle(Image* dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("ImageDrawTriangle");
alias imageDrawTriangle = Image.drawTriangle;

<*
 Draw triangle with interpolated colors within an image
*>
extern fn void Image.drawTriangleEx(Image* dst, Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3) @extern("ImageDrawTriangleEx");
alias imageDrawTriangleEx = Image.drawTriangleEx;

<*
 Draw triangle outline within an image
*>
extern fn void Image.drawTriangleLines(Image* dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("ImageDrawTriangleLines");
alias imageDrawTriangleLines = Image.drawTriangleLines;

<*
 Draw a triangle fan defined by points within an image (first vertex is the center)
 @require points.len <= int.max
*>
fn void Image.drawTriangleFan(Image* dst, Vector2[] points, Color color) @inline {
	__image_draw_triangle_fan(dst, points.ptr, (int)points.len, color);
}
alias imageDrawTriangleFan = Image.drawTriangleFan;

<*
 Draw a triangle strip defined by points within an image
 @require points.len <= int.max
*>
fn void Image.drawTriangleStrip(Image* dst, Vector2[] points, Color color) @inline {
	__image_draw_triangle_strip(dst, points.ptr, (int)points.len, color);
}
alias imageDrawTriangleStrip = Image.drawTriangleStrip;

<*
 Draw a source image within a destination image (tint applied to source)
*>
extern fn void Image.draw(Image* dst, Image src, Rectangle src_rec, Rectangle dst_rec, Color tint) @extern("ImageDraw");
alias imageDraw = Image.draw;

<*
 Draw text (using default font) within an image (destination)
*>
extern fn void Image.drawText(Image* dst, ZString text, int pos_x, int pos_y, int font_size, Color color) @extern("ImageDrawText");
alias imageDrawText = Image.drawText;

<*
 Draw text (custom sprite font) within an image (destination)
*>
extern fn void Image.drawTextEx(Image* dst, Font font, ZString text, Vector2 position, float font_size, float spacing, Color tint) @extern("ImageDrawTextEx");
alias imageDrawTextEx = Image.drawTextEx;

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
extern fn bool Texture2D.isValid(Texture2D texture) @extern("IsTextureValid");
alias isTextureValid = Texture2D.isValid;

<*
 Unload texture from GPU memory (VRAM)
*>
extern fn void Texture2D.unload(Texture2D texture) @extern("UnloadTexture");
alias unloadTexture = Texture2D.unload;

<*
 Check if a render texture is valid (loaded in GPU)
*>
extern fn bool RenderTexture2D.isValid(RenderTexture2D target) @extern("IsRenderTextureValid");
alias isRenderTextureValid = RenderTexture2D.isValid;

<*
 Unload render texture from GPU memory (VRAM)
*>
extern fn void RenderTexture2D.unload(RenderTexture2D target) @extern("UnloadRenderTexture");
alias unloadRenderTexture = RenderTexture2D.unload;

<*
 Update GPU texture with new data
*>
extern fn void Texture2D.update(Texture2D texture, void* pixels) @extern("UpdateTexture");
alias updateTexture = Texture2D.update;

<*
 Update GPU texture rectangle with new data
*>
extern fn void Texture2D.updateRec(Texture2D texture, Rectangle rec, void* pixels) @extern("UpdateTextureRec");
alias updateTextureRec = Texture2D.updateRec;

// Texture configuration functions
//------------------------------------------------------------------------------------

<*
 Generate GPU mipmaps for a texture
*>
extern fn void Texture2D.genMipmaps(Texture2D* texture) @extern("GenTextureMipmaps");
alias genTextureMipmaps = Texture2D.genMipmaps;

<*
 Set texture scaling filter mode
*>
extern fn void Texture2D.setFilter(Texture2D texture, TextureFilter filter) @extern("SetTextureFilter");
alias setTextureFilter = Texture2D.setFilter;

<*
 Set texture wrapping mode
*>
extern fn void Texture2D.setWrap(Texture2D texture, TextureWrap wrap) @extern("SetTextureWrap");
alias setTextureWrap = Texture2D.setWrap;

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
extern fn Color Color.fade(Color color, float alpha) @extern("Fade");
alias fade = Color.fade;

<*
 Get hexadecimal value for a Color
*>
extern fn int Color.toInt(Color color) @extern("ColorToInt");
alias colorToInt = Color.toInt;

<*
 Get Color normalized as float [0..1]
 @ensure return.x >= 0.0f && return.x <= 1.0f
 @ensure return.y >= 0.0f && return.y <= 1.0f
 @ensure return.z >= 0.0f && return.z <= 1.0f
 @ensure return.w >= 0.0f && return.w <= 1.0f
*>
extern fn Vector4 Color.normalize(Color color) @extern("ColorNormalize");
alias colorNormalize = Color.normalize;

<*
 Get Color from normalized values [0..1]
 @require normalized.x >= 0.0f && normalized.x <= 1.0f
 @require normalized.y >= 0.0f && normalized.y <= 1.0f
 @require normalized.z >= 0.0f && normalized.z <= 1.0f
 @require normalized.w >= 0.0f && normalized.w <= 1.0f
*>
extern fn Color colorfromNormalized(Vector4 normalized) @extern("ColorFromNormalized");

<*
 Get HSV values for a Color, hue [0..360], saturation/value [0..1]
 @ensure return.x >= 0.0f && return.x <= 360.0f
 @ensure return.y >= 0.0f && return.y <= 1.0f
 @ensure return.x >= 0.0f && return.x <= 1.0f
*>
extern fn Vector3 Color.toHSV(Color color) @extern("ColorToHSV");
alias colorToHSV = Color.toHSV;

<*
 Get a Color from HSV values, hue [0..360], saturation/value [0..1]
 @require hue >= 0.0f && hue <= 360.0f
 @require saturation >= 0.0f && saturation <= 1.0f
 @require value >= 0.0f && value <= 1.0f
*>
extern fn Color colorfromHSV(float hue, float saturation, float value) @extern("ColorFromHSV");

<*
 Get color multiplied with another color
*>
extern fn Color Color.tint(Color color, Color tint) @extern("ColorTint");
alias colorTint = Color.tint;

<*
 Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
 @require factor >= -1.0f && factor <= 1.0f
*>
extern fn Color Color.brightness(Color color, float factor) @extern("ColorBrightness");
alias colorBrightness = Color.brightness;

<*
 Get color with contrast correction, contrast values between -1.0f and 1.0f
 @require contrast >= -1.0f && contrast <= 1.0f
*>
extern fn Color Color.contrast(Color color, float contrast) @extern("ColorContrast");
alias colorContrast = Color.contrast;

<*
 Get color with alpha applied, alpha goes from 0.0f to 1.0f
 @require alpha >= 0.0f && alpha <= 1.0f
*>
extern fn Color Color.alpha(Color color, float alpha) @extern("ColorAlpha");
alias colorAlpha = Color.alpha;

<*
 Get src alpha-blended into dst color with tint
*>
extern fn Color Color.alphaBlend(Color dst, Color src, Color tint) @extern("ColorAlphaBlend");
alias colorAlphaBlend = Color.alphaBlend;

<*
 Get color lerp interpolation between two colors, factor [0.0f..1.0f]
 @require factor >= 0.0f && factor <= 1.0f
*>
extern fn Color Color.lerp(Color color1, Color color2, float factor) @extern("ColorLerp");
alias colorLerp = Color.lerp;

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
