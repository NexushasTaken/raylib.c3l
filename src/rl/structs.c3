module rl;

//----------------------------------------------------------------------------------
// Structures Definition
//----------------------------------------------------------------------------------

// Vector2, 2 components
struct Vector2 {
	float x;                // Vector x component
	float y;                // Vector y component
}

// Vector3, 3 components
struct Vector3 {
	float x;                // Vector x component
	float y;                // Vector y component
	float z;                // Vector z component
}

// Vector4, 4 components
struct Vector4 {
	float x;                // Vector x component
	float y;                // Vector y component
	float z;                // Vector z component
	float w;                // Vector w component
}

// Quaternion, 4 components (Vector4 alias)
//def Quaternion = quaternion::Quaternion{float};
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
struct Color {
	char r;        // Color red value
	char g;        // Color green value
	char b;        // Color blue value
	char a;        // Color alpha value
}

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
alias Texture2D = Texture;

// TextureCubemap, same as Texture
alias TextureCubemap = Texture;

// RenderTexture, fbo for texture rendering
struct RenderTexture {
	uint id;                // OpenGL framebuffer object id
	Texture texture;        // Color buffer attachment texture
	Texture depth;          // Depth buffer attachment texture
}

// RenderTexture2D, same as RenderTexture
alias RenderTexture2D = RenderTexture;

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
	Vector3 position; // Camera position
	Vector3 target;   // Camera target it looks-at
	Vector3 up;       // Camera up vector (rotation over its axis)
	float fovy;       // Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
	int projection;   // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
}

alias Camera = Camera3D;    // Camera type fallback, defaults to Camera3D

// Camera2D, defines position/orientation in 2d space
struct Camera2D @packed {
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
	char* bone_ids;          // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning) (shader-location = 6)
	float* bone_weights;     // Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)
	Matrix *bone_matrices;   // Bones animated transformation matrices
	int bone_count;          // Number of bones

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
	Vector3 translation; // Translation
	Quaternion rotation;      // Rotation
	Vector3 scale;       // Scale
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
	Vector3 direction; // Ray direction (normalized)
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
typedef AudioBufferRef = void*;
typedef AudioProcessorRef = void*;

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
	ZString* paths;         // Filepaths entries
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

