// vi: ts=4 sw=4
module rl;
import std::collections;

//------------------------------------------------------------------------------------
// Basic 3d Shapes Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Basic geometric 3D shapes drawing functions
//------------------------------------------------------------------------------------

/**
 * Draw a line in 3D world space
 */
extern fn void draw_line3d(Vector3 start_pos, Vector3 end_pos, Color color) @extern("DrawLine3D");

/**
 * Draw a point in 3D space, actually a small line
 */
extern fn void draw_point3d(Vector3 position, Color color) @extern("DrawPoint3D");

/**
 * Draw a circle in 3D world space
 */
extern fn void draw_circle3d(Vector3 center, float radius, Vector3 rotation_axis, float rotation_angle, Color color) @extern("DrawCircle3D");

/**
 * Draw a color-filled triangle (vertex in counter-clockwise order!)
 */
extern fn void draw_triangle3d(Vector3 v1, Vector3 v2, Vector3 v3, Color color) @extern("DrawTriangle3D");

/**
 * Draw a triangle strip defined by points
 */
fn void draw_triangle_strip3d(List(<Vector3>) points, Color color) @inline {
    __draw_triangle_strip3d(points.entries, (int)points.len(), color);
}

/**
 * Draw cube
 */
extern fn void draw_cube(Vector3 position, float width, float height, float length, Color color) @extern("DrawCube");

/**
 * Draw cube (Vector version)
 */
extern fn void draw_cube_v(Vector3 position, Vector3 size, Color color) @extern("DrawCubeV");

/**
 * Draw cube wires
 */
extern fn void draw_cube_wires(Vector3 position, float width, float height, float length, Color color) @extern("DrawCubeWires");

/**
 * Draw cube wires (Vector version)
 */
extern fn void draw_cube_wires_v(Vector3 position, Vector3 size, Color color) @extern("DrawCubeWiresV");

/**
 * Draw sphere
 */
extern fn void draw_sphere(Vector3 center_pos, float radius, Color color) @extern("DrawSphere");

/**
 * Draw sphere with extended parameters
 */
extern fn void draw_sphere_ex(Vector3 center_pos, float radius, int rings, int slices, Color color) @extern("DrawSphereEx");

/**
 * Draw sphere wires
 */
extern fn void draw_sphere_wires(Vector3 center_pos, float radius, int rings, int slices, Color color) @extern("DrawSphereWires");

/**
 * Draw a cylinder/cone
 */
extern fn void draw_cylinder(Vector3 position, float radius_top, float radius_bottom, float height, int slices, Color color) @extern("DrawCylinder");

/**
 * Draw a cylinder with base at startPos and top at endPos
 */
extern fn void draw_cylinder_ex(Vector3 start_pos, Vector3 end_pos, float start_radius, float end_radius, int sides, Color color) @extern("DrawCylinderEx");

/**
 * Draw a cylinder/cone wires
 */
extern fn void draw_cylinder_wires(Vector3 position, float radius_top, float radius_bottom, float height, int slices, Color color) @extern("DrawCylinderWires");

/**
 * Draw a cylinder wires with base at startPos and top at endPos
 */
extern fn void draw_cylinder_wires_ex(Vector3 startPos, Vector3 end_pos, float start_radius, float end_radius, int sides, Color color) @extern("DrawCylinderWiresEx");

/**
 * Draw a capsule with the center of its sphere caps at startPos and endPos
 */
extern fn void draw_capsule(Vector3 start_pos, Vector3 endPos, float radius, int slices, int rings, Color color) @extern("DrawCapsule");

/**
 * Draw capsule wireframe with the center of its sphere caps at startPos and endPos
 */
extern fn void draw_capsule_wires(Vector3 start_pos, Vector3 endPos, float radius, int slices, int rings, Color color) @extern("DrawCapsuleWires");

/**
 * Draw a plane XZ
 */
extern fn void draw_plane(Vector3 center_pos, Vector2 size, Color color) @extern("DrawPlane");

/**
 * Draw a ray line
 */
extern fn void draw_ray(Ray ray, Color color) @extern("DrawRay");

/**
 * Draw a grid (centered at (0, 0, 0))
 */
extern fn void draw_grid(int slices, float spacing) @extern("DrawGrid");

//------------------------------------------------------------------------------------
// Model 3d Loading and Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Model management functions
//------------------------------------------------------------------------------------

/**
 * Load model from files (meshes and materials)
 */
extern fn Model load_model(ZString file_name) @extern("LoadModel");

/**
 * Load model from generated mesh (default material)
 */
extern fn Model load_model_from_mesh(Mesh mesh) @extern("LoadModelFromMesh");

/**
 * Check if a model is ready
 */
extern fn bool is_model_ready(Model model) @extern("IsModelReady");

/**
 * Unload model (including meshes) from memory (RAM and/or VRAM)
 */
extern fn void unload_model(Model model) @extern("UnloadModel");

/**
 * Compute model bounding box limits (considers all meshes)
 */
extern fn BoundingBox get_model_bounding_box(Model model) @extern("GetModelBoundingBox");

// Model drawing functions
//------------------------------------------------------------------------------------

/**
 * Draw a model (with texture if set)
 */
extern fn void draw_model(Model model, Vector3 position, float scale, Color tint) @extern("DrawModel");

/**
 * Draw a model with extended parameters
 */
extern fn void draw_model_ex(Model model, Vector3 position, Vector3 rotation_axis, float rotation_angle, Vector3 scale, Color tint) @extern("DrawModelEx");

/**
 * Draw a model wires (with texture if set)
 */
extern fn void draw_model_wires(Model model, Vector3 position, float scale, Color tint) @extern("DrawModelWires");

/**
 * Draw a model wires (with texture if set) with extended parameters
 */
extern fn void draw_model_wires_ex(Model model, Vector3 position, Vector3 rotation_axis, float rotation_angle, Vector3 scale, Color tint) @extern("DrawModelWiresEx");

/**
 * Draw bounding box (wires)
 */
extern fn void draw_bounding_box(BoundingBox box, Color color) @extern("DrawBoundingBox");

/**
 * Draw a billboard texture
 */
extern fn void draw_billboard(Camera camera, Texture2D texture, Vector3 position, float size, Color tint) @extern("DrawBillboard");

/**
 * Draw a billboard texture defined by source
 */
extern fn void draw_billboard_rec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint) @extern("DrawBillboardRec");

/**
 * Draw a billboard texture defined by source and rotation
 */
extern fn void draw_billboard_pro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint) @extern("DrawBillboardPro");

// Mesh management functions
//------------------------------------------------------------------------------------

/**
 * Upload mesh vertex data in GPU and provide VAO/VBO ids
 */
extern fn void upload_mesh(Mesh* mesh, bool dynamic) @extern("UploadMesh");

/**
 * Update mesh vertex data in GPU for a specific buffer index
 */
extern fn void update_mesh_buffer(Mesh mesh, int index, void* data, int data_size, int offset) @extern("UpdateMeshBuffer");

/**
 * Unload mesh data from CPU and GPU
 */
extern fn void unload_mesh(Mesh mesh) @extern("UnloadMesh");

/**
 * Draw a 3d mesh with material and transform
 */
extern fn void draw_mesh(Mesh mesh, Material material, Matrix transform) @extern("DrawMesh");

/**
 * Draw multiple mesh instances with material and different transforms
 */
extern fn void draw_mesh_instanced(Mesh mesh, Material material, Matrix* transforms, int instances) @extern("DrawMeshInstanced");

/**
 * Export mesh data to file, returns true on success
 */
extern fn bool export_mesh(Mesh mesh, ZString file_name) @extern("ExportMesh");

/**
 * Compute mesh bounding box limits
 */
extern fn BoundingBox get_mesh_bounding_box(Mesh mesh) @extern("GetMeshBoundingBox");

/**
 * Compute mesh tangents
 */
extern fn void gen_mesh_tangents(Mesh* mesh) @extern("GenMeshTangents");

// Mesh generation functions
//------------------------------------------------------------------------------------

/**
 * Generate polygonal mesh
 */
extern fn Mesh gen_mesh_poly(int sides, float radius) @extern("GenMeshPoly");

/**
 * Generate plane mesh (with subdivisions)
 */
extern fn Mesh gen_mesh_plane(float width, float length, int res_x, int res_z) @extern("GenMeshPlane");

/**
 * Generate cuboid mesh
 */
extern fn Mesh gen_mesh_cube(float width, float height, float length) @extern("GenMeshCube");

/**
 * Generate sphere mesh (standard sphere)
 */
extern fn Mesh gen_mesh_sphere(float radius, int rings, int slices) @extern("GenMeshSphere");

/**
 * Generate half-sphere mesh (no bottom cap)
 */
extern fn Mesh gen_mesh_hemi_sphere(float radius, int rings, int slices) @extern("GenMeshHemiSphere");

/**
 * Generate cylinder mesh
 */
extern fn Mesh gen_mesh_cylinder(float radius, float height, int slices) @extern("GenMeshCylinder");

/**
 * Generate cone/pyramid mesh
 */
extern fn Mesh gen_mesh_cone(float radius, float height, int slices) @extern("GenMeshCone");

/**
 * Generate torus mesh
 */
extern fn Mesh gen_mesh_torus(float radius, float size, int rad_seg, int sides) @extern("GenMeshTorus");

/**
 * Generate trefoil knot mesh
 */
extern fn Mesh gen_mesh_knot(float radius, float size, int rad_seg, int sides) @extern("GenMeshKnot");

/**
 * Generate heightmap mesh from image data
 */
extern fn Mesh gen_mesh_heightmap(Image heightmap, Vector3 size) @extern("GenMeshHeightmap");

/**
 * Generate cubes-based map mesh from image data
 */
extern fn Mesh gen_mesh_cubicmap(Image cubicmap, Vector3 cube_size) @extern("GenMeshCubicmap");

// Material loading/unloading functions
//------------------------------------------------------------------------------------

/**
 * Load materials from model file
 */
fn Material[] load_materials(ZString file_name) @inline {
    int len = 0;
    Material* ptr = __load_materials(file_name, &len);
    return ptr[:len];
}

/**
 * Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
 */
extern fn Material load_material_default() @extern("LoadMaterialDefault");

/**
 * Check if a material is ready
 */
extern fn bool is_material_ready(Material material) @extern("IsMaterialReady");

/**
 * Unload material from GPU memory (VRAM)
 */
extern fn void unload_material(Material material) @extern("UnloadMaterial");

/**
 * Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
 */
extern fn void set_material_texture(Material* material, MaterialMapIndex map_type, Texture2D texture) @extern("SetMaterialTexture");

/**
 * Set material for a mesh
 */
extern fn void set_model_mesh_material(Model* model, int mesh_id, int material_id) @extern("SetModelMeshMaterial");

// Model animations loading/unloading functions
//------------------------------------------------------------------------------------

/**
 * Load model animations from file
 */
fn ModelAnimation[] load_model_animations(ZString file_name) @inline {
    int len = 0;
    ModelAnimation* ptr = __load_model_animations(file_name, &len);
    return ptr[:len];
}

/**
 * Update model animation pose
 */
extern fn void update_model_animation(Model model, ModelAnimation anim, int frame) @extern("UpdateModelAnimation");

/**
 * Unload animation data
 */
extern fn void unload_model_animation(ModelAnimation anim) @extern("UnloadModelAnimation");

/**
 * Unload animation array data
 */
fn void unload_model_animations(ModelAnimation[] animations) @inline {
    __unload_model_animations(animations.ptr, (int)animations.len);
}

/**
 * Check model animation skeleton match
 */
extern fn bool is_model_animation_valid(Model model, ModelAnimation anim) @extern("IsModelAnimationValid");

// Collision detection functions
//------------------------------------------------------------------------------------

/**
 * Check collision between two spheres
 */
extern fn bool check_collision_spheres(Vector3 center1, float radius1, Vector3 center2, float radius2) @extern("CheckCollisionSpheres");

/**
 * Check collision between two bounding boxes
 */
extern fn bool check_collision_boxes(BoundingBox box1, BoundingBox box2) @extern("CheckCollisionBoxes");

/**
 * Check collision between box and sphere
 */
extern fn bool check_collision_box_sphere(BoundingBox box, Vector3 center, float radius) @extern("CheckCollisionBoxSphere");

/**
 * Get collision info between ray and sphere
 */
extern fn RayCollision get_ray_collision_sphere(Ray ray, Vector3 center, float radius) @extern("GetRayCollisionSphere");

/**
 * Get collision info between ray and box
 */
extern fn RayCollision get_ray_collision_box(Ray ray, BoundingBox box) @extern("GetRayCollisionBox");

/**
 * Get collision info between ray and mesh
 */
extern fn RayCollision get_ray_collision_mesh(Ray ray, Mesh mesh, Matrix transform) @extern("GetRayCollisionMesh");

/**
 * Get collision info between ray and triangle
 */
extern fn RayCollision get_ray_collision_triangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3) @extern("GetRayCollisionTriangle");

/**
 * Get collision info between ray and quad
 */
extern fn RayCollision get_ray_collision_quad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) @extern("GetRayCollisionQuad");

