module rl;

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
