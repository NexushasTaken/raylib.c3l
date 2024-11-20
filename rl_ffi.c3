module rl;

//------------------------------------------------------------------------------------
// A functions will be used to their corresponding wrappers
//------------------------------------------------------------------------------------

// rcore.c3
//------------------------------------------------------------------------------------
extern fn void __set_window_icons(Image* images, int count) @extern("SetWindowIcons") @private;
extern fn int __get_shader_location(Shader shader, ZString uniform_name) @extern("GetShaderLocation") @private;
extern fn int __get_shader_location_attrib(Shader shader, ZString attrib_name) @extern("GetShaderLocationAttrib") @private;

module rl @if($feature(SUPPORT_RANDOM_GENERATION));

extern fn void __set_random_seed(uint seed) @extern("SetRandomSeed");
extern fn int __get_random_value(int min, int max) @extern("GetRandomValue") @private;
extern fn int* __load_random_sequence(uint count, int min, int max) @extern("LoadRandomSequence") @private;
extern fn void __unload_random_sequence(int* sequence) @extern("UnloadRandomSequence") @private;

module rl @if($feature(SUPPORT_STANDARD_FILEIO));

extern fn char* __load_file_data(ZString file_name, int* data_size) @extern("LoadFileData");
extern fn void __unload_file_data(char* data) @extern("UnloadFileData") @private;
extern fn bool __export_data_as_code(char* data, int data_size, ZString file_name) @extern("ExportDataAsCode") @private;
extern fn ZString __load_file_text(ZString file_name) @extern("LoadFileText") @private;

module rl;

extern fn char* __compress_data(char* data, int dataSize, int *comp_data_size) @extern("CompressData") @private;
extern fn char* __decompress_data(char* comp_data, int comp_data_size, int *data_size) @extern("DecompressData") @private;
extern fn char* __encode_data_base64(char* data, int data_size, int *outputSize) @extern("EncodeDataBase64") @private @if($feature(SUPPORT_DATA_ENCODER));
extern fn char* __decode_data_base64(char* data, int *output_size) @extern("DecodeDataBase64") @private @if($feature(SUPPORT_DATA_ENCODER));
//------------------------------------------------------------------------------------

// raudio.c3
//------------------------------------------------------------------------------------
extern fn Wave __load_wave_from_memory(ZString file_type, char* file_data, int data_size) @extern("LoadWaveFromMemory") @private;
//------------------------------------------------------------------------------------

// rmodels.c3
//------------------------------------------------------------------------------------
extern fn void __draw_triangle_strip3d(Vector3* points, int point_count, Color color) @extern("DrawTriangleStrip3D") @private;
extern fn void __draw_mesh_instanced(Mesh mesh, Material material, Matrix* transforms, int instances) @extern("DrawMeshInstanced");
extern fn Material* __load_materials(ZString file_name, int* material_count) @extern("LoadMaterials") @private;
extern fn ModelAnimation* __load_model_animations(ZString file_name, int *anim_count) @extern("LoadModelAnimations") @private;
extern fn void __unload_model_animations(ModelAnimation* animations, int anim_count) @extern("UnloadModelAnimations") @private;
//------------------------------------------------------------------------------------

// rshapes.c3
//------------------------------------------------------------------------------------
extern fn void __draw_line_strip(Vector2* points, int point_count, Color color) @extern("DrawLineStrip");
extern fn void __draw_triangle_fan(Vector2* points, int point_count, Color color) @extern("DrawTriangleFan") @private;
extern fn void __draw_triangle_strip(Vector2* points, int point_count, Color color) @extern("DrawTriangleStrip") @private;
extern fn void __draw_spline_linear(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineLinear") @private;
extern fn void __draw_spline_basis(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineBasis") @private;
extern fn void __draw_spline_catmull_rom(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineCatmullRom") @private;
extern fn void __draw_spline_bezier_quadratic(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineBezierQuadratic") @private;
extern fn void __draw_spline_bezier_cubic(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineBezierCubic") @private;
extern fn bool __check_collision_point_poly(Vector2 point, Vector2* points, int point_count) @extern("CheckCollisionPointPoly") @private;
//------------------------------------------------------------------------------------

// text.c3
//------------------------------------------------------------------------------------
extern fn void __unload_font_data(GlyphInfo* glyphs, int glyph_count) @extern("UnloadFontData");
//------------------------------------------------------------------------------------

// text.c3
//------------------------------------------------------------------------------------
extern fn char* __export_image_to_memory(Image image, ZString file_type, int *file_size) @extern("ExportImageToMemory") @private;
extern fn Color* __load_image_colors(Image image) @extern("LoadImageColors") @private;
extern fn Color* __load_image_palette(Image image, int max_palette_size, int *color_count) @extern("LoadImagePalette") @private;
extern fn void __unload_image_colors(Color* colors) @extern("UnloadImageColors") @private;
extern fn void __unload_image_palette(Color* colors) @extern("UnloadImagePalette") @private;
//------------------------------------------------------------------------------------
