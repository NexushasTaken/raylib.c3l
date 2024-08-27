module rl;

//------------------------------------------------------------------------------------
// A functions will be used to their corresponding wrappers
//------------------------------------------------------------------------------------

extern fn void __set_window_icons(Image* images, int count) @extern("SetWindowIcons");
extern fn int* __load_random_sequence(uint count, int min, int max) @extern("LoadRandomSequence");
extern fn void __unload_random_sequence(int* sequence) @extern("UnloadRandomSequence");
extern fn char* __load_file_data(ZString file_name, int* data_size) @extern("LoadFileData");
extern fn void __unload_file_data(char* data) @extern("UnloadFileData");

extern fn void __draw_triangle_strip3d(Vector3* points, int point_count, Color color) @extern("DrawTriangleStrip3D");
extern fn Material* __load_materials(ZString file_name, int* material_count) @extern("LoadMaterials");
extern fn ModelAnimation* __load_model_animations(ZString file_name, int *anim_count) @extern("LoadModelAnimations");
extern fn void __unload_model_animations(ModelAnimation* animations, int anim_count) @extern("UnloadModelAnimations");

extern fn void __draw_triangle_fan(Vector2* points, int point_count, Color color) @extern("DrawTriangleFan");
extern fn void __draw_triangle_strip(Vector2* points, int point_count, Color color) @extern("DrawTriangleStrip");
extern fn void __draw_spline_linear(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineLinear");
extern fn void __draw_spline_basis(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineBasis");
extern fn void __draw_spline_catmull_rom(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineCatmullRom");
extern fn void __draw_spline_bezier_quadratic(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineBezierQuadratic");
extern fn void __draw_spline_bezier_cubic(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineBezierCubic");
extern fn bool __check_collision_point_poly(Vector2 point, Vector2* points, int point_count) @extern("CheckCollisionPointPoly");

extern fn char* __export_image_to_memory(Image image, ZString file_type, int *file_size) @extern("ExportImageToMemory");
extern fn Color* __load_image_colors(Image image) @extern("LoadImageColors");
extern fn Color* __load_image_palette(Image image, int max_palette_size, int *color_count) @extern("LoadImagePalette");
extern fn void __unload_image_colors(Color* colors) @extern("UnloadImageColors");
extern fn void __unload_image_palette(Color* colors) @extern("UnloadImagePalette");
