// vi: ts=4 sw=4 noet
module rl;
import std::math;

const RAYLIB_VERSION_MAJOR = 5;
const RAYLIB_VERSION_MINOR = 0;
const RAYLIB_VERSION_PATCH = 0;
const RAYLIB_VERSION = "5.0";

//----------------------------------------------------------------------------------
// Some basic Defines
//----------------------------------------------------------------------------------
const PI = math::PI;
const DEG2RAD = (PI/180.0f);
const RAD2DEG = (180.0f/PI);

// Some Basic Colors
// NOTE: Custom raylib color palette for amazing visuals on WHITE background
const LIGHTGRAY  = Color { 200, 200, 200, 255 };   // Light Gray
const GRAY       = Color { 130, 130, 130, 255 };   // Gray
const DARKGRAY   = Color { 80, 80, 80, 255 };      // Dark Gray
const YELLOW     = Color { 253, 249, 0, 255 };     // Yellow
const GOLD       = Color { 255, 203, 0, 255 };     // Gold
const ORANGE     = Color { 255, 161, 0, 255 };     // Orange
const PINK       = Color { 255, 109, 194, 255 };   // Pink
const RED        = Color { 230, 41, 55, 255 };     // Red
const MAROON     = Color { 190, 33, 55, 255 };     // Maroon
const GREEN      = Color { 0, 228, 48, 255 };      // Green
const LIME       = Color { 0, 158, 47, 255 };      // Lime
const DARKGREEN  = Color { 0, 117, 44, 255 };      // Dark Green
const SKYBLUE    = Color { 102, 191, 255, 255 };   // Sky Blue
const BLUE       = Color { 0, 121, 241, 255 };     // Blue
const DARKBLUE   = Color { 0, 82, 172, 255 };      // Dark Blue
const PURPLE     = Color { 200, 122, 255, 255 };   // Purple
const VIOLET     = Color { 135, 60, 190, 255 };    // Violet
const DARKPURPLE = Color { 112, 31, 126, 255 };    // Dark Purple
const BEIGE      = Color { 211, 176, 131, 255 };   // Beige
const BROWN      = Color { 127, 106, 79, 255 };    // Brown
const DARKBROWN  = Color { 76, 63, 47, 255 };      // Dark Brown

const WHITE      = Color { 255, 255, 255, 255 };   // White
const BLACK      = Color { 0, 0, 0, 255 };         // Black
const BLANK      = Color { 0, 0, 0, 0 };           // Blank (Transparent)
const MAGENTA    = Color { 255, 0, 255, 255 };     // Magenta
const RAYWHITE   = Color { 245, 245, 245, 255 };   // My own White (raylib logo)

//----------------------------------------------------------------------------------
// Structures Definition
//----------------------------------------------------------------------------------

// Vector2, 2 components
def Vector2 = vector::Vec2f;
//struct Vector2 {
//	float x;                // Vector x component
//	float y;                // Vector y component
//}

// Vector3, 3 components
def Vector3 = vector::Vec3f;
//struct Vector3 {
//	float x;                // Vector x component
//	float y;                // Vector y component
//	float z;                // Vector z component
//}

// Vector4, 4 components
def Vector4 = vector::Vec4f;
//struct Vector4 {
//	float x;                // Vector x component
//	float y;                // Vector y component
//	float z;                // Vector z component
//	float w;                // Vector w component
//}

// Quaternion, 4 components (Vector4 alias)
//def Quaternion = quaternion::Quaternion(<float>);
struct Quaternion {
	float x;                // Vector x component
	float y;                // Vector y component
	float z;                // Vector z component
	float w;                // Vector w component
}

// Matrix, 4x4 components, column major, OpenGL style, right-handed
struct Matrix {
	float m0, m4, m8, m12;  // Matrix first row (4 components)
	float m1, m5, m9, m13;  // Matrix second row (4 components)
	float m2, m6, m10, m14; // Matrix third row (4 components)
	float m3, m7, m11, m15; // Matrix fourth row (4 components)
}

// Color, 4 components, R8G8B8A8 (32bit)
def Color = char[<4>];
//struct Color {
//	char r;        // Color red value
//	char g;        // Color green value
//	char b;        // Color blue value
//	char a;        // Color alpha value
//}

// Rectangle, 4 components
struct Rectangle {
	float x;                // Rectangle top-left corner position x
	float y;                // Rectangle top-left corner position y
	float width;            // Rectangle width
	float height;           // Rectangle height
}

// Image, pixel data stored in CPU memory (RAM)
struct Image {
	void* data;             // Image raw data
	int width;              // Image base width
	int height;             // Image base height
	int mipmaps;            // Mipmap levels, 1 by default
	PixelFormat format;     // Data format (PixelFormat type)
}

// Texture, tex data stored in GPU memory (VRAM)
struct Texture {
	uint id;                // OpenGL texture id
	int width;              // Texture base width
	int height;             // Texture base height
	int mipmaps;            // Mipmap levels, 1 by default
	PixelFormat format;     // Data format (PixelFormat type)
}

// Texture2D, same as Texture
def Texture2D = Texture;

// TextureCubemap, same as Texture
def TextureCubemap = Texture;

// RenderTexture, fbo for texture rendering
struct RenderTexture {
	uint id;                // OpenGL framebuffer object id
	Texture texture;        // Color buffer attachment texture
	Texture depth;          // Depth buffer attachment texture
}

// RenderTexture2D, same as RenderTexture
def RenderTexture2D = RenderTexture;

// NPatchInfo, n-patch layout info
struct NPatchInfo {
	Rectangle source;       // Texture source rectangle
	int left;               // Left border offset
	int top;                // Top border offset
	int right;              // Right border offset
	int bottom;             // Bottom border offset
	NPatchLayout layout;    // Layout of the n-patch: 3x3, 1x3 or 3x1
}

// GlyphInfo, font characters glyphs info
struct GlyphInfo {
	int value;              // Character value (Unicode)
	int offset_x;           // Character offset X when drawing
	int offset_y;           // Character offset Y when drawing
	int advance_x;          // Character advance position X
	Image image;            // Character image data
}

// Font, font texture and GlyphInfo array data
struct Font {
	int base_size;          // Base size (default chars height)
	int glyph_count;        // Number of glyph characters
	int glyph_padding;      // Padding around the glyph characters
	Texture2D texture;      // Texture atlas containing the glyphs
	Rectangle* recs;        // Rectangles in texture for the glyphs
	GlyphInfo* glyphs;      // Glyphs info data
}

// Camera, defines position/orientation in 3d space
struct Camera3D {
	Vector3 position;       // Camera position
	Vector3 target;         // Camera target it looks-at
	Vector3 up;             // Camera up vector (rotation over its axis)
	float fovy;             // Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
	int projection;         // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
}

def Camera = Camera3D;    // Camera type fallback, defaults to Camera3D

// Camera2D, defines position/orientation in 2d space
struct Camera2D {
	Vector2 offset;         // Camera offset (displacement from target)
	Vector2 target;         // Camera target (rotation and zoom origin)
	float rotation;         // Camera rotation in degrees
	float zoom;             // Camera zoom (scaling), should be 1.0f by default
}

// Mesh, vertex data and vao/vbo
struct Mesh {
	int vertex_count;        // Number of vertices stored in arrays
	int triangle_count;      // Number of triangles stored (indexed or not)

	// Vertex attributes data
	float* vertices;        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
	float* texcoords;       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
	float* texcoords2;      // Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
	float* normals;         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
	float* tangents;        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
	char* colors;           // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
	ushort* indices;        // Vertex indices (in case vertex data comes indexed)

	// Animation vertex data
	float* anim_vertices;    // Animated vertex positions (after bones transformations)
	float* anim_normals;     // Animated normals (after bones transformations)
	char* bone_ids;          // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
	float* bone_weights;     // Vertex bone weight, up to 4 bones influence by vertex (skinning)

	// OpenGL identifiers
	uint vao_id;             // OpenGL Vertex Array Object id
	uint* vbo_id;            // OpenGL Vertex Buffer Objects id (default vertex data)
}

// Shader
struct Shader {
	uint id;                // Shader program id
	int* locs;              // Shader locations array (RL_MAX_SHADER_LOCATIONS)
}

// MaterialMap
struct MaterialMap {
	Texture2D texture;      // Material map texture
	Color color;            // Material map color
	float value;            // Material map value
}

// Material, includes shader and maps
struct Material {
	Shader shader;          // Material shader
	MaterialMap* maps;      // Material maps array (MAX_MATERIAL_MAPS)
	float[4] params;        // Material generic parameters (if required)
}

// Transform, vertex transformation data
struct Transform {
	Vector3 translation;    // Translation
	Quaternion rotation;    // Rotation
	Vector3 scale;          // Scale
}

// Bone, skeletal animation bone
struct BoneInfo {
	char[32] name;          // Bone name
	int parent;             // Bone parent
}

// Model, meshes, materials and animation data
struct Model {
	Matrix transform;     // Local transform matrix

	int mesh_count;       // Number of meshes
	int material_count;   // Number of materials
	Mesh* meshes;         // Meshes array
	Material* materials;  // Materials array
	int* mesh_material;   // Mesh material number

	// Animation data
	int bone_count;       // Number of bones
	BoneInfo* bones;      // Bones information (skeleton)
	Transform* bind_pose; // Bones base transformation (pose)
}

// ModelAnimation
struct ModelAnimation {
	int bone_count;          // Number of bones
	int frame_count;         // Number of animation frames
	BoneInfo* bones;         // Bones information (skeleton)
	Transform** frame_poses; // Poses array by frame
	char[32] name;           // Animation name
}

// Ray, ray for raycasting
struct Ray {
	Vector3 position;  // Ray position (origin)
	Vector3 direction; // Ray direction
}

// RayCollision, ray hit information
struct RayCollision {
	bool hit;       // Did the ray hit something?
	float distance; // Distance to the nearest hit
	Vector3 point;  // Point of the nearest hit
	Vector3 normal; // Surface normal of hit
}

// BoundingBox
struct BoundingBox {
	Vector3 min; // Minimum vertex box-corner
	Vector3 max; // Maximum vertex box-corner
}

// Wave, audio wave data
struct Wave {
	uint frame_count; // Total number of frames (considering channels)
	uint sample_rate; // Frequency (samples per second)
	uint sample_size; // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	uint channels;    // Number of channels (1-mono, 2-stereo, ...)
	void* data;       // Buffer data pointer
}

// Opaque structs declaration
// NOTE: Actual structs are defined internally in raudio module
distinct AudioBufferRef = void*;
distinct AudioProcessorRef = void*;

// AudioStream, custom audio stream
struct AudioStream {
	AudioBufferRef buffer;       // Pointer to internal data used by the audio system
	AudioProcessorRef processor; // Pointer to internal data processor, useful for audio effects

	uint sample_rate;            // Frequency (samples per second)
	uint sample_size;            // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	uint channels;               // Number of channels (1-mono, 2-stereo, ...)
}

// Sound
struct Sound {
	AudioStream stream; // Audio stream
	uint frame_count;   // Total number of frames (considering channels)
}

// Music, audio stream, anything longer than ~10 seconds should be streamed
struct Music {
	AudioStream stream; // Audio stream
	uint frame_count;   // Total number of frames (considering channels)
	bool looping;       // Music looping enable

	int ctx_type;       // Type of music context (audio filetype)
	void* ctx_data;     // Audio context data, depends on type
}

// VrDeviceInfo, Head-Mounted-Display device parameters
struct VrDeviceInfo {
	int h_resolution;                // Horizontal resolution in pixels
	int v_resolution;                // Vertical resolution in pixels
	float h_screen_size;             // Horizontal size in meters
	float v_screen_size;             // Vertical size in meters
	float v_screen_center;           // Screen center in meters
	float eye_to_screen_distance;    // Distance between eye and display in meters
	float lens_separation_distance;  // Lens separation distance in meters
	float interpupillary_distance;   // IPD (distance between pupils) in meters
	float[4] lens_distortion_values; // Lens distortion constant parameters
	float[4] chroma_ab_correction;   // Chromatic aberration correction parameters
}

// VrStereoConfig, VR stereo rendering configuration for simulator
struct VrStereoConfig {
	Matrix[2] projection;         // VR projection matrices (per eye)
	Matrix[2] view_offset;        // VR view offset matrices (per eye)
	float[2] left_lens_center;    // VR left lens center
	float[2] right_lens_center;   // VR right lens center
	float[2] left_screen_center;  // VR left screen center
	float[2] right_screen_center; // VR right screen center
	float[2] scale;               // VR distortion scale
	float[2] scale_in;            // VR distortion scale in
}

// File path list
struct FilePathList {
	uint capacity;        // Filepaths max entries
	uint count;           // Filepaths entries count
	char** paths;         // Filepaths entries
}

// Automation event
struct AutomationEvent {
	uint frame;             // Event frame
	uint type;              // Event type (AutomationEventType)
	int[4] params;          // Event parameters (if required)
}

// Automation event list
struct AutomationEventList {
	uint capacity;           // Events max entries (MAX_AUTOMATION_EVENTS)
	uint count;              // Events entries count
	AutomationEvent* events; // Events entries
}

//----------------------------------------------------------------------------------
// Enumerators Definition
//----------------------------------------------------------------------------------
// System/Window config flags
// NOTE: Every bit registers one state (use it with bit masks)
// By default all flags are set to 0
def ConfigFlags = uint;
const ConfigFlags FLAG_VSYNC_HINT         = 0x00000040;   // Set to try enabling V-Sync on GPU
const ConfigFlags FLAG_FULLSCREEN_MODE    = 0x00000002;   // Set to run program in fullscreen
const ConfigFlags FLAG_WINDOW_RESIZABLE   = 0x00000004;   // Set to allow resizable window
const ConfigFlags FLAG_WINDOW_UNDECORATED = 0x00000008;   // Set to disable window decoration (frame and buttons)
const ConfigFlags FLAG_WINDOW_HIDDEN      = 0x00000080;   // Set to hide window
const ConfigFlags FLAG_WINDOW_MINIMIZED   = 0x00000200;   // Set to minimize window (iconify)
const ConfigFlags FLAG_WINDOW_MAXIMIZED   = 0x00000400;   // Set to maximize window (expanded to monitor)
const ConfigFlags FLAG_WINDOW_UNFOCUSED   = 0x00000800;   // Set to window non focused
const ConfigFlags FLAG_WINDOW_TOPMOST     = 0x00001000;   // Set to window always on top
const ConfigFlags FLAG_WINDOW_ALWAYS_RUN  = 0x00000100;   // Set to allow windows running while minimized
const ConfigFlags FLAG_WINDOW_TRANSPARENT = 0x00000010;   // Set to allow transparent framebuffer
const ConfigFlags FLAG_WINDOW_HIGHDPI     = 0x00002000;   // Set to support HighDPI
const ConfigFlags FLAG_WINDOW_MOUSE_PASSTHROUGH = 0x00004000; // Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
const ConfigFlags FLAG_BORDERLESS_WINDOWED_MODE = 0x00008000; // Set to run program in borderless windowed mode
const ConfigFlags FLAG_MSAA_4X_HINT       = 0x00000020;   // Set to try enabling MSAA 4X
const ConfigFlags FLAG_INTERLACED_HINT    = 0x00010000;   // Set to try enabling interlaced video format (for V3D)

// Trace log level
// NOTE: Organized by priority level
def TraceLogLevel = int;
const LOG_ALL     = 0;         // Display all logs (0)
const LOG_TRACE   = 1;         // Trace logging, intended for internal use only
const LOG_DEBUG   = 2;         // Debug logging, used for internal debugging, it should be disabled on release builds
const LOG_INFO    = 3;         // Info logging, used for program execution info
const LOG_WARNING = 4;         // Warning logging, used on recoverable failures
const LOG_ERROR   = 5;         // Error logging, used on unrecoverable failures
const LOG_FATAL   = 6;         // Fatal logging, used to abort program: exit(EXIT_FAILURE)
const LOG_NONE    = 7;         // Disable logging

// Keyboard keys (US keyboard layout)
// NOTE: Use GetKeyPressed() to allow redefining
// required keys for alternative layouts
def KeyboardKey = int;
const KeyboardKey KEY_NULL            = 0;        // Key: NULL, used for no key pressed
// Alphanumeric keys
const KeyboardKey KEY_APOSTROPHE      = 39;       // Key: '
const KeyboardKey KEY_COMMA           = 44;       // Key: ,
const KeyboardKey KEY_MINUS           = 45;       // Key: -
const KeyboardKey KEY_PERIOD          = 46;       // Key: .
const KeyboardKey KEY_SLASH           = 47;       // Key: /
const KeyboardKey KEY_ZERO            = 48;       // Key: 0
const KeyboardKey KEY_ONE             = 49;       // Key: 1
const KeyboardKey KEY_TWO             = 50;       // Key: 2
const KeyboardKey KEY_THREE           = 51;       // Key: 3
const KeyboardKey KEY_FOUR            = 52;       // Key: 4
const KeyboardKey KEY_FIVE            = 53;       // Key: 5
const KeyboardKey KEY_SIX             = 54;       // Key: 6
const KeyboardKey KEY_SEVEN           = 55;       // Key: 7
const KeyboardKey KEY_EIGHT           = 56;       // Key: 8
const KeyboardKey KEY_NINE            = 57;       // Key: 9
const KeyboardKey KEY_SEMICOLON       = 59;       // Key: ;
const KeyboardKey KEY_EQUAL           = 61;       // Key: =
const KeyboardKey KEY_A               = 65;       // Key: A | a
const KeyboardKey KEY_B               = 66;       // Key: B | b
const KeyboardKey KEY_C               = 67;       // Key: C | c
const KeyboardKey KEY_D               = 68;       // Key: D | d
const KeyboardKey KEY_E               = 69;       // Key: E | e
const KeyboardKey KEY_F               = 70;       // Key: F | f
const KeyboardKey KEY_G               = 71;       // Key: G | g
const KeyboardKey KEY_H               = 72;       // Key: H | h
const KeyboardKey KEY_I               = 73;       // Key: I | i
const KeyboardKey KEY_J               = 74;       // Key: J | j
const KeyboardKey KEY_K               = 75;       // Key: K | k
const KeyboardKey KEY_L               = 76;       // Key: L | l
const KeyboardKey KEY_M               = 77;       // Key: M | m
const KeyboardKey KEY_N               = 78;       // Key: N | n
const KeyboardKey KEY_O               = 79;       // Key: O | o
const KeyboardKey KEY_P               = 80;       // Key: P | p
const KeyboardKey KEY_Q               = 81;       // Key: Q | q
const KeyboardKey KEY_R               = 82;       // Key: R | r
const KeyboardKey KEY_S               = 83;       // Key: S | s
const KeyboardKey KEY_T               = 84;       // Key: T | t
const KeyboardKey KEY_U               = 85;       // Key: U | u
const KeyboardKey KEY_V               = 86;       // Key: V | v
const KeyboardKey KEY_W               = 87;       // Key: W | w
const KeyboardKey KEY_X               = 88;       // Key: X | x
const KeyboardKey KEY_Y               = 89;       // Key: Y | y
const KeyboardKey KEY_Z               = 90;       // Key: Z | z
const KeyboardKey KEY_LEFT_BRACKET    = 91;       // Key: [
const KeyboardKey KEY_BACKSLASH       = 92;       // Key: '\'
const KeyboardKey KEY_RIGHT_BRACKET   = 93;       // Key: ]
const KeyboardKey KEY_GRAVE           = 96;       // Key: `
// Function keys
const KeyboardKey KEY_SPACE           = 32;       // Key: Space
const KeyboardKey KEY_ESCAPE          = 256;      // Key: Esc
const KeyboardKey KEY_ENTER           = 257;      // Key: Enter
const KeyboardKey KEY_TAB             = 258;      // Key: Tab
const KeyboardKey KEY_BACKSPACE       = 259;      // Key: Backspace
const KeyboardKey KEY_INSERT          = 260;      // Key: Ins
const KeyboardKey KEY_DELETE          = 261;      // Key: Del
const KeyboardKey KEY_RIGHT           = 262;      // Key: Cursor right
const KeyboardKey KEY_LEFT            = 263;      // Key: Cursor left
const KeyboardKey KEY_DOWN            = 264;      // Key: Cursor down
const KeyboardKey KEY_UP              = 265;      // Key: Cursor up
const KeyboardKey KEY_PAGE_UP         = 266;      // Key: Page up
const KeyboardKey KEY_PAGE_DOWN       = 267;      // Key: Page down
const KeyboardKey KEY_HOME            = 268;      // Key: Home
const KeyboardKey KEY_END             = 269;      // Key: End
const KeyboardKey KEY_CAPS_LOCK       = 280;      // Key: Caps lock
const KeyboardKey KEY_SCROLL_LOCK     = 281;      // Key: Scroll down
const KeyboardKey KEY_NUM_LOCK        = 282;      // Key: Num lock
const KeyboardKey KEY_PRINT_SCREEN    = 283;      // Key: Print screen
const KeyboardKey KEY_PAUSE           = 284;      // Key: Pause
const KeyboardKey KEY_F1              = 290;      // Key: F1
const KeyboardKey KEY_F2              = 291;      // Key: F2
const KeyboardKey KEY_F3              = 292;      // Key: F3
const KeyboardKey KEY_F4              = 293;      // Key: F4
const KeyboardKey KEY_F5              = 294;      // Key: F5
const KeyboardKey KEY_F6              = 295;      // Key: F6
const KeyboardKey KEY_F7              = 296;      // Key: F7
const KeyboardKey KEY_F8              = 297;      // Key: F8
const KeyboardKey KEY_F9              = 298;      // Key: F9
const KeyboardKey KEY_F10             = 299;      // Key: F10
const KeyboardKey KEY_F11             = 300;      // Key: F11
const KeyboardKey KEY_F12             = 301;      // Key: F12
const KeyboardKey KEY_LEFT_SHIFT      = 340;      // Key: Shift left
const KeyboardKey KEY_LEFT_CONTROL    = 341;      // Key: Control left
const KeyboardKey KEY_LEFT_ALT        = 342;      // Key: Alt left
const KeyboardKey KEY_LEFT_SUPER      = 343;      // Key: Super left
const KeyboardKey KEY_RIGHT_SHIFT     = 344;      // Key: Shift right
const KeyboardKey KEY_RIGHT_CONTROL   = 345;      // Key: Control right
const KeyboardKey KEY_RIGHT_ALT       = 346;      // Key: Alt right
const KeyboardKey KEY_RIGHT_SUPER     = 347;      // Key: Super right
const KeyboardKey KEY_KB_MENU         = 348;      // Key: KB menu
// Keypad keys
const KeyboardKey KEY_KP_0            = 320;      // Key: Keypad 0
const KeyboardKey KEY_KP_1            = 321;      // Key: Keypad 1
const KeyboardKey KEY_KP_2            = 322;      // Key: Keypad 2
const KeyboardKey KEY_KP_3            = 323;      // Key: Keypad 3
const KeyboardKey KEY_KP_4            = 324;      // Key: Keypad 4
const KeyboardKey KEY_KP_5            = 325;      // Key: Keypad 5
const KeyboardKey KEY_KP_6            = 326;      // Key: Keypad 6
const KeyboardKey KEY_KP_7            = 327;      // Key: Keypad 7
const KeyboardKey KEY_KP_8            = 328;      // Key: Keypad 8
const KeyboardKey KEY_KP_9            = 329;      // Key: Keypad 9
const KeyboardKey KEY_KP_DECIMAL      = 330;      // Key: Keypad .
const KeyboardKey KEY_KP_DIVIDE       = 331;      // Key: Keypad /
const KeyboardKey KEY_KP_MULTIPLY     = 332;      // Key: Keypad *
const KeyboardKey KEY_KP_SUBTRACT     = 333;      // Key: Keypad -
const KeyboardKey KEY_KP_ADD          = 334;      // Key: Keypad +
const KeyboardKey KEY_KP_ENTER        = 335;      // Key: Keypad Enter
const KeyboardKey KEY_KP_EQUAL        = 336;      // Key: Keypad =
// Android key buttons
const KeyboardKey KEY_BACK            = 4;        // Key: Android back button
const KeyboardKey KEY_MENU            = 82;       // Key: Android menu button
const KeyboardKey KEY_VOLUME_UP       = 24;       // Key: Android volume up button
const KeyboardKey KEY_VOLUME_DOWN     = 25;       // Key: Android volume down button

// Mouse buttons
def MouseButton = int;
const MOUSE_BUTTON_LEFT    = 0; // Mouse button left
const MOUSE_BUTTON_RIGHT   = 1; // Mouse button right
const MOUSE_BUTTON_MIDDLE  = 2; // Mouse button middle (pressed wheel)
const MOUSE_BUTTON_SIDE    = 3; // Mouse button side (advanced mouse device)
const MOUSE_BUTTON_EXTRA   = 4; // Mouse button extra (advanced mouse device)
const MOUSE_BUTTON_FORWARD = 5; // Mouse button forward (advanced mouse device)
const MOUSE_BUTTON_BACK    = 6; // Mouse button back (advanced mouse device)

// Mouse cursor
def MouseCursor = int;
const MouseCursor MOUSE_CURSOR_DEFAULT       = 0;     // Default pointer shape
const MouseCursor MOUSE_CURSOR_ARROW         = 1;     // Arrow shape
const MouseCursor MOUSE_CURSOR_IBEAM         = 2;     // Text writing cursor shape
const MouseCursor MOUSE_CURSOR_CROSSHAIR     = 3;     // Cross shape
const MouseCursor MOUSE_CURSOR_POINTING_HAND = 4;     // Pointing hand cursor
const MouseCursor MOUSE_CURSOR_RESIZE_EW     = 5;     // Horizontal resize/move arrow shape
const MouseCursor MOUSE_CURSOR_RESIZE_NS     = 6;     // Vertical resize/move arrow shape
const MouseCursor MOUSE_CURSOR_RESIZE_NWSE   = 7;     // Top-left to bottom-right diagonal resize/move arrow shape
const MouseCursor MOUSE_CURSOR_RESIZE_NESW   = 8;     // The top-right to bottom-left diagonal resize/move arrow shape
const MouseCursor MOUSE_CURSOR_RESIZE_ALL    = 9;     // The omnidirectional resize/move cursor shape
const MouseCursor MOUSE_CURSOR_NOT_ALLOWED   = 10;    // The operation-not-allowed shape

// Gamepad buttons
def GamepadButton = int;
const GamepadButton GAMEPAD_BUTTON_UNKNOWN          = 0;  // Unknown button, just for error checking
const GamepadButton GAMEPAD_BUTTON_LEFT_FACE_UP     = 1;  // Gamepad left DPAD up button
const GamepadButton GAMEPAD_BUTTON_LEFT_FACE_RIGHT  = 2;  // Gamepad left DPAD right button
const GamepadButton GAMEPAD_BUTTON_LEFT_FACE_DOWN   = 3;  // Gamepad left DPAD down button
const GamepadButton GAMEPAD_BUTTON_LEFT_FACE_LEFT   = 4;  // Gamepad left DPAD left button
const GamepadButton GAMEPAD_BUTTON_RIGHT_FACE_UP    = 5;  // Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
const GamepadButton GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6;  // Gamepad right button right (i.e. PS3: Square, Xbox: X)
const GamepadButton GAMEPAD_BUTTON_RIGHT_FACE_DOWN  = 7;  // Gamepad right button down (i.e. PS3: Cross, Xbox: A)
const GamepadButton GAMEPAD_BUTTON_RIGHT_FACE_LEFT  = 8;  // Gamepad right button left (i.e. PS3: Circle, Xbox: B)
const GamepadButton GAMEPAD_BUTTON_LEFT_TRIGGER_1   = 9;  // Gamepad top/back trigger left (first), it could be a trailing button
const GamepadButton GAMEPAD_BUTTON_LEFT_TRIGGER_2   = 10; // Gamepad top/back trigger left (second), it could be a trailing button
const GamepadButton GAMEPAD_BUTTON_RIGHT_TRIGGER_1  = 11; // Gamepad top/back trigger right (one), it could be a trailing button
const GamepadButton GAMEPAD_BUTTON_RIGHT_TRIGGER_2  = 12; // Gamepad top/back trigger right (second), it could be a trailing button
const GamepadButton GAMEPAD_BUTTON_MIDDLE_LEFT      = 13; // Gamepad center buttons, left one (i.e. PS3: Select)
const GamepadButton GAMEPAD_BUTTON_MIDDLE           = 14; // Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
const GamepadButton GAMEPAD_BUTTON_MIDDLE_RIGHT     = 15; // Gamepad center buttons, right one (i.e. PS3: Start)
const GamepadButton GAMEPAD_BUTTON_LEFT_THUMB       = 16; // Gamepad joystick pressed button left
const GamepadButton GAMEPAD_BUTTON_RIGHT_THUMB      = 17; // Gamepad joystick pressed button right

// Gamepad axis
def GamepadAxis = int;
const GamepadAxis GAMEPAD_AXIS_LEFT_X        = 0;     // Gamepad left stick X axis
const GamepadAxis GAMEPAD_AXIS_LEFT_Y        = 1;     // Gamepad left stick Y axis
const GamepadAxis GAMEPAD_AXIS_RIGHT_X       = 2;     // Gamepad right stick X axis
const GamepadAxis GAMEPAD_AXIS_RIGHT_Y       = 3;     // Gamepad right stick Y axis
const GamepadAxis GAMEPAD_AXIS_LEFT_TRIGGER  = 4;     // Gamepad back trigger left, pressure level: [1..-1]
const GamepadAxis GAMEPAD_AXIS_RIGHT_TRIGGER = 5;     // Gamepad back trigger right, pressure level: [1..-1]


// Material map index
def MaterialMapIndex = int;
const MaterialMapIndex MATERIAL_MAP_ALBEDO     = 0;    // Albedo material (same as: MATERIAL_MAP_DIFFUSE)
const MaterialMapIndex MATERIAL_MAP_METALNESS  = 1;    // Metalness material (same as: MATERIAL_MAP_SPECULAR)
const MaterialMapIndex MATERIAL_MAP_NORMAL     = 2;    // Normal material
const MaterialMapIndex MATERIAL_MAP_ROUGHNESS  = 3;    // Roughness material
const MaterialMapIndex MATERIAL_MAP_OCCLUSION  = 4;    // Ambient occlusion material
const MaterialMapIndex MATERIAL_MAP_EMISSION   = 5;    // Emission material
const MaterialMapIndex MATERIAL_MAP_HEIGHT     = 6;    // Heightmap material
const MaterialMapIndex MATERIAL_MAP_CUBEMAP    = 7;    // Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
const MaterialMapIndex MATERIAL_MAP_IRRADIANCE = 8;    // Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
const MaterialMapIndex MATERIAL_MAP_PREFILTER  = 9;    // Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
const MaterialMapIndex MATERIAL_MAP_BRDF       = 10;   // Brdf material

// Shader location index
def ShaderLocationIndex = int;
const ShaderLocationIndex SHADER_LOC_VERTEX_POSITION   = 0;  // Shader location: vertex attribute: position
const ShaderLocationIndex SHADER_LOC_VERTEX_TEXCOORD01 = 1;  // Shader location: vertex attribute: texcoord01
const ShaderLocationIndex SHADER_LOC_VERTEX_TEXCOORD02 = 2;  // Shader location: vertex attribute: texcoord02
const ShaderLocationIndex SHADER_LOC_VERTEX_NORMAL     = 3;  // Shader location: vertex attribute: normal
const ShaderLocationIndex SHADER_LOC_VERTEX_TANGENT    = 4;  // Shader location: vertex attribute: tangent
const ShaderLocationIndex SHADER_LOC_VERTEX_COLOR      = 5;  // Shader location: vertex attribute: color
const ShaderLocationIndex SHADER_LOC_MATRIX_MVP        = 6;  // Shader location: matrix uniform: model-view-projection
const ShaderLocationIndex SHADER_LOC_MATRIX_VIEW       = 7;  // Shader location: matrix uniform: view (camera transform)
const ShaderLocationIndex SHADER_LOC_MATRIX_PROJECTION = 8;  // Shader location: matrix uniform: projection
const ShaderLocationIndex SHADER_LOC_MATRIX_MODEL      = 9;  // Shader location: matrix uniform: model (transform)
const ShaderLocationIndex SHADER_LOC_MATRIX_NORMAL     = 10; // Shader location: matrix uniform: normal
const ShaderLocationIndex SHADER_LOC_VECTOR_VIEW       = 11; // Shader location: vector uniform: view
const ShaderLocationIndex SHADER_LOC_COLOR_DIFFUSE     = 12; // Shader location: vector uniform: diffuse color
const ShaderLocationIndex SHADER_LOC_COLOR_SPECULAR    = 13; // Shader location: vector uniform: specular color
const ShaderLocationIndex SHADER_LOC_COLOR_AMBIENT     = 14; // Shader location: vector uniform: ambient color
const ShaderLocationIndex SHADER_LOC_MAP_ALBEDO        = 15; // Shader location: sampler2d texture: albedo (same as: RL_SHADER_LOC_MAP_DIFFUSE)
const ShaderLocationIndex SHADER_LOC_MAP_METALNESS     = 16; // Shader location: sampler2d texture: metalness (same as: RL_SHADER_LOC_MAP_SPECULAR)
const ShaderLocationIndex SHADER_LOC_MAP_NORMAL        = 17; // Shader location: sampler2d texture: normal
const ShaderLocationIndex SHADER_LOC_MAP_ROUGHNESS     = 18; // Shader location: sampler2d texture: roughness
const ShaderLocationIndex SHADER_LOC_MAP_OCCLUSION     = 19; // Shader location: sampler2d texture: occlusion
const ShaderLocationIndex SHADER_LOC_MAP_EMISSION      = 20; // Shader location: sampler2d texture: emission
const ShaderLocationIndex SHADER_LOC_MAP_HEIGHT        = 21; // Shader location: sampler2d texture: height
const ShaderLocationIndex SHADER_LOC_MAP_CUBEMAP       = 22; // Shader location: samplerCube texture: cubemap
const ShaderLocationIndex SHADER_LOC_MAP_IRRADIANCE    = 23; // Shader location: samplerCube texture: irradiance
const ShaderLocationIndex SHADER_LOC_MAP_PREFILTER     = 24; // Shader location: samplerCube texture: prefilter
const ShaderLocationIndex SHADER_LOC_MAP_BRDF          = 25; // Shader location: sampler2d texture: brdf

// Shader uniform data type
def ShaderUniformDataType = int;
const ShaderUniformDataType SHADER_UNIFORM_FLOAT = 0;        // Shader uniform type: float
const ShaderUniformDataType SHADER_UNIFORM_VEC2  = 1;        // Shader uniform type: vec2 (2 float)
const ShaderUniformDataType SHADER_UNIFORM_VEC3  = 2;        // Shader uniform type: vec3 (3 float)
const ShaderUniformDataType SHADER_UNIFORM_VEC4  = 3;        // Shader uniform type: vec4 (4 float)
const ShaderUniformDataType SHADER_UNIFORM_INT   = 4;        // Shader uniform type: int
const ShaderUniformDataType SHADER_UNIFORM_IVEC2 = 5;        // Shader uniform type: ivec2 (2 int)
const ShaderUniformDataType SHADER_UNIFORM_IVEC3 = 6;        // Shader uniform type: ivec3 (3 int)
const ShaderUniformDataType SHADER_UNIFORM_IVEC4 = 7;        // Shader uniform type: ivec4 (4 int)
const ShaderUniformDataType SHADER_UNIFORM_SAMPLER2D = 8;    // Shader uniform type: sampler2d

// Shader attribute data types
def ShaderAttributeDataType = int;
const ShaderAttributeDataType SHADER_ATTRIB_FLOAT = 0;         // Shader attribute type: float
const ShaderAttributeDataType SHADER_ATTRIB_VEC2  = 1;         // Shader attribute type: vec2 (2 float)
const ShaderAttributeDataType SHADER_ATTRIB_VEC3  = 2;         // Shader attribute type: vec3 (3 float)
const ShaderAttributeDataType SHADER_ATTRIB_VEC4  = 3;         // Shader attribute type: vec4 (4 float)

// Pixel formats
// NOTE: Support depends on OpenGL version and platform
def PixelFormat = int;
const PixelFormat PIXELFORMAT_UNCOMPRESSED_GRAYSCALE    = 1;  // 8 bit per pixel (no alpha)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA   = 2;  // 8*2 bpp (2 channels)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R5G6B5       = 3;  // 16 bpp
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R8G8B8       = 4;  // 24 bpp
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R5G5B5A1     = 5;  // 16 bpp (1 bit alpha)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R4G4B4A4     = 6;  // 16 bpp (4 bit alpha)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R8G8B8A8     = 7;  // 32 bpp
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R32          = 8;  // 32 bpp (1 channel - float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R32G32B32    = 9;  // 32*3 bpp (3 channels - float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10; // 32*4 bpp (4 channels - float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R16          = 11; // 16 bpp (1 channel - half float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R16G16B16    = 12; // 16*3 bpp (3 channels - half float)
const PixelFormat PIXELFORMAT_UNCOMPRESSED_R16G16B16A16 = 13; // 16*4 bpp (4 channels - half float)
const PixelFormat PIXELFORMAT_COMPRESSED_DXT1_RGB       = 14; // 4 bpp (no alpha)
const PixelFormat PIXELFORMAT_COMPRESSED_DXT1_RGBA      = 15; // 4 bpp (1 bit alpha)
const PixelFormat PIXELFORMAT_COMPRESSED_DXT3_RGBA      = 16; // 8 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_DXT5_RGBA      = 17; // 8 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ETC1_RGB       = 18; // 4 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ETC2_RGB       = 19; // 4 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA  = 20; // 8 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_PVRT_RGB       = 21; // 4 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_PVRT_RGBA      = 22; // 4 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ASTC_4X4_RGBA  = 23; // 8 bpp
const PixelFormat PIXELFORMAT_COMPRESSED_ASTC_8X8_RGBA  = 24; // 2 bpp

// Texture parameters: filter mode
// NOTE 1: Filtering considers mipmaps if available in the texture
// NOTE 2: Filter is accordingly set for minification and magnification
def TextureFilter = int;
const TextureFilter TEXTURE_FILTER_POINT     = 0;       // No filter, just pixel approximation
const TextureFilter TEXTURE_FILTER_BILINEAR  = 1;       // Linear filtering
const TextureFilter TEXTURE_FILTER_TRILINEAR = 2;       // Trilinear filtering (linear with mipmaps)
const TextureFilter TEXTURE_FILTER_ANISOTROPIC_4X  = 3; // Anisotropic filtering 4x
const TextureFilter TEXTURE_FILTER_ANISOTROPIC_8X  = 4; // Anisotropic filtering 8x
const TextureFilter TEXTURE_FILTER_ANISOTROPIC_16X = 5; // Anisotropic filtering 16x

// Texture parameters: wrap mode
def TextureWrap = int;
const TextureWrap TEXTURE_WRAP_REPEAT = 0;                // Repeats texture in tiled mode
const TextureWrap TEXTURE_WRAP_CLAMP  = 1;                // Clamps texture to edge pixel in tiled mode
const TextureWrap TEXTURE_WRAP_MIRROR_REPEAT = 2;         // Mirrors and repeats the texture in tiled mode
const TextureWrap TEXTURE_WRAP_MIRROR_CLAMP  = 3;         // Mirrors and clamps to border the texture in tiled mode


// Cubemap layouts
def CubemapLayout = int;
const CUBEMAP_LAYOUT_AUTO_DETECT = 0;         // Automatically detect layout type
const CUBEMAP_LAYOUT_LINE_VERTICAL = 1;       // Layout is defined by a vertical line with faces
const CUBEMAP_LAYOUT_LINE_HORIZONTAL = 2;     // Layout is defined by a horizontal line with faces
const CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3; // Layout is defined by a 3x4 cross with cubemap faces
const CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4; // Layout is defined by a 4x3 cross with cubemap faces
const CUBEMAP_LAYOUT_PANORAMA = 5;            // Layout is defined by a panorama image (equirrectangular map)

// Font type, defines generation method
def FontType = int;
const FontType FONT_DEFAULT = 0;               // Default font generation, anti-aliased
const FontType FONT_BITMAP = 1;                // Bitmap font generation, no anti-aliasing
const FontType FONT_SDF = 2;                   // SDF font generation, requires external shader

// Color blending modes (pre-defined)
def BlendMode = int;
const BlendMode BLEND_ALPHA             = 0; // Blend textures considering alpha (default)
const BlendMode BLEND_ADDITIVE          = 1; // Blend textures adding colors
const BlendMode BLEND_MULTIPLIED        = 2; // Blend textures multiplying colors
const BlendMode BLEND_ADD_COLORS        = 3; // Blend textures adding colors (alternative)
const BlendMode BLEND_SUBTRACT_COLORS   = 4; // Blend textures subtracting colors (alternative)
const BlendMode BLEND_ALPHA_PREMULTIPLY = 5; // Blend premultiplied textures considering alpha
const BlendMode BLEND_CUSTOM            = 6; // Blend textures using custom src/dst factors (use rlSetBlendFactors())
const BlendMode BLEND_CUSTOM_SEPARATE   = 7; // Blend textures using custom src/dst factors (use rlSetBlendFactorsSeparate())

// Gesture
// NOTE: Provided as bit-wise flags to enable only desired gestures
def Gesture = uint;
const Gesture GESTURE_NONE        = 0;        // No gesture
const Gesture GESTURE_TAP         = 1;        // Tap gesture
const Gesture GESTURE_DOUBLETAP   = 2;        // Double tap gesture
const Gesture GESTURE_HOLD        = 4;        // Hold gesture
const Gesture GESTURE_DRAG        = 8;        // Drag gesture
const Gesture GESTURE_SWIPE_RIGHT = 16;       // Swipe right gesture
const Gesture GESTURE_SWIPE_LEFT  = 32;       // Swipe left gesture
const Gesture GESTURE_SWIPE_UP    = 64;       // Swipe up gesture
const Gesture GESTURE_SWIPE_DOWN  = 128;      // Swipe down gesture
const Gesture GESTURE_PINCH_IN    = 256;      // Pinch in gesture
const Gesture GESTURE_PINCH_OUT   = 512;      // Pinch out gesture

// Camera system modes
def CameraMode = int;
const CameraMode CAMERA_CUSTOM  = 0;             // Custom camera
const CameraMode CAMERA_FREE    = 1;             // Free camera
const CameraMode CAMERA_ORBITAL = 2;             // Orbital camera
const CameraMode CAMERA_FIRST_PERSON = 3;        // First person camera
const CameraMode CAMERA_THIRD_PERSON = 4;        // Third person camera

// Camera projection
def CameraProjection = int;
const CameraProjection CAMERA_PERSPECTIVE = 0;         // Perspective projection
const CameraProjection CAMERA_ORTHOGRAPHIC = 1;        // Orthographic projection

// N-patch layout
def NPatchLayout = int;
const NPatchLayout NPATCH_NINE_PATCH = 0;             // Npatch layout: 3x3 tiles
const NPatchLayout NPATCH_THREE_PATCH_VERTICAL = 1;   // Npatch layout: 1x3 tiles
const NPatchLayout NPATCH_THREE_PATCH_HORIZONTAL = 2; // Npatch layout: 3x1 tiles


// Callbacks to hook some internal functions
// WARNING: These callbacks are intended for advance users
def LoadFileDataCallback = fn ZString(ZString file_name, int* data_size);          // FileIO: Load binary data
def SaveFileDataCallback = fn bool(ZString file_name, void* data, uint data_size); // FileIO: Save binary data
def LoadFileTextCallback = fn ZString(ZString file_name);                          // FileIO: Load text data
def SaveFileTextCallback = fn bool(ZString file_name, ZString text);               // FileIO: Save text data

