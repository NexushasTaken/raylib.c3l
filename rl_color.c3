module rl;

// Color/pixel related functions
//------------------------------------------------------------------------------------

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
