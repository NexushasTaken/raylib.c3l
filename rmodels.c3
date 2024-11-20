module rl;

//------------------------------------------------------------------------------------
// Basic 3D Shapes Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Basic geometric 3D shapes drawing functions
//------------------------------------------------------------------------------------

<*
 Draw a line in 3D world space
*>
extern fn void drawLine3D(Vector3 start_pos, Vector3 end_pos, Color color) @extern("DrawLine3D");

<*
 Draw a point in 3D space, actually a small line
*>
extern fn void drawPoint3D(Vector3 position, Color color) @extern("DrawPoint3D");

<*
 Draw a circle in 3D world space
*>
extern fn void drawCircle3D(Vector3 center, float radius, Vector3 rotation_axis, float rotation_angle, Color color) @extern("DrawCircle3D");

<*
 Draw a color-filled triangle (vertex in counter-clockwise order!)
*>
extern fn void drawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color) @extern("DrawTriangle3D");

<*
 Draw a triangle strip defined by points
 @require points.len <= int.max
*>
fn void drawTriangleStrip3D(Vector3[] points, Color color) @inline {
    __draw_triangle_strip3d(points.ptr, (int)points.len, color);
}

<*
 Draw cube
*>
extern fn void drawCube(Vector3 position, float width, float height, float length, Color color) @extern("DrawCube");

<*
 Draw cube (Vector version)
*>
extern fn void drawCubeV(Vector3 position, Vector3 size, Color color) @extern("DrawCubeV");

<*
 Draw cube wires
*>
extern fn void drawCubeWires(Vector3 position, float width, float height, float length, Color color) @extern("DrawCubeWires");

<*
 Draw cube wires (Vector version)
*>
extern fn void drawCubeWiresV(Vector3 position, Vector3 size, Color color) @extern("DrawCubeWiresV");

<*
 Draw sphere
*>
extern fn void drawSphere(Vector3 center_pos, float radius, Color color) @extern("DrawSphere");

<*
 Draw sphere with extended parameters
*>
extern fn void drawSphereEx(Vector3 center_pos, float radius, int rings, int slices, Color color) @extern("DrawSphereEx");

<*
 Draw sphere wires
*>
extern fn void drawSphereWires(Vector3 center_pos, float radius, int rings, int slices, Color color) @extern("DrawSphereWires");

<*
 Draw a cylinder/cone
*>
extern fn void drawCylinder(Vector3 position, float radius_top, float radius_bottom, float height, int slices, Color color) @extern("DrawCylinder");

<*
 Draw a cylinder with base at startPos and top at endPos
*>
extern fn void drawCylinderEx(Vector3 start_pos, Vector3 end_pos, float start_radius, float end_radius, int sides, Color color) @extern("DrawCylinderEx");

<*
 Draw a cylinder/cone wires
*>
extern fn void drawCylinderWires(Vector3 position, float radius_top, float radius_bottom, float height, int slices, Color color) @extern("DrawCylinderWires");

<*
 Draw a cylinder wires with base at startPos and top at endPos
*>
extern fn void drawCylinderWiresEx(Vector3 startPos, Vector3 end_pos, float start_radius, float end_radius, int sides, Color color) @extern("DrawCylinderWiresEx");

<*
 Draw a capsule with the center of its sphere caps at startPos and endPos
*>
extern fn void drawCapsule(Vector3 start_pos, Vector3 endPos, float radius, int slices, int rings, Color color) @extern("DrawCapsule");

<*
 Draw capsule wireframe with the center of its sphere caps at startPos and endPos
*>
extern fn void drawCapsuleWires(Vector3 start_pos, Vector3 endPos, float radius, int slices, int rings, Color color) @extern("DrawCapsuleWires");

<*
 Draw a plane XZ
*>
extern fn void drawPlane(Vector3 center_pos, Vector2 size, Color color) @extern("DrawPlane");

<*
 Draw a ray line
*>
extern fn void drawRay(Ray ray, Color color) @extern("DrawRay");

<*
 Draw a grid (centered at (0, 0, 0))
*>
extern fn void drawGrid(int slices, float spacing) @extern("DrawGrid");

//------------------------------------------------------------------------------------
// Model 3D Loading and Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Model management functions
//------------------------------------------------------------------------------------

<*
 Load model from files (meshes and materials)
*>
extern fn Model loadModel(ZString file_name) @extern("LoadModel");

<*
 Load model from generated mesh (default material)
*>
extern fn Model loadModelFromMesh(Mesh mesh) @extern("LoadModelFromMesh");

<*
 Check if a model is ready
*>
extern fn bool isModelReady(Model model) @extern("IsModelReady");

<*
 Unload model (including meshes) from memory (RAM and/or VRAM)
*>
extern fn void unloadModel(Model model) @extern("UnloadModel");

<*
 Compute model bounding box limits (considers all meshes)
*>
extern fn BoundingBox getModelBoundingBox(Model model) @extern("GetModelBoundingBox");

// Model drawing functions
//------------------------------------------------------------------------------------

<*
 Draw a model (with texture if set)
*>
extern fn void drawModel(Model model, Vector3 position, float scale, Color tint) @extern("DrawModel");

<*
 Draw a model with extended parameters
*>
extern fn void drawModelEx(Model model, Vector3 position, Vector3 rotation_axis, float rotation_angle, Vector3 scale, Color tint) @extern("DrawModelEx");

<*
 Draw a model wires (with texture if set)
*>
extern fn void drawModelWires(Model model, Vector3 position, float scale, Color tint) @extern("DrawModelWires");

<*
 Draw a model wires (with texture if set) with extended parameters
*>
extern fn void drawModelWiresEx(Model model, Vector3 position, Vector3 rotation_axis, float rotation_angle, Vector3 scale, Color tint) @extern("DrawModelWiresEx");

<*
 Draw bounding box (wires)
*>
extern fn void drawBoundingBox(BoundingBox box, Color color) @extern("DrawBoundingBox");

<*
 Draw a billboard texture
*>
extern fn void drawBillboard(Camera camera, Texture2D texture, Vector3 position, float size, Color tint) @extern("DrawBillboard");

<*
 Draw a billboard texture defined by source
*>
extern fn void drawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint) @extern("DrawBillboardRec");

<*
 Draw a billboard texture defined by source and rotation
*>
extern fn void drawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint) @extern("DrawBillboardPro");

// Mesh management functions
//------------------------------------------------------------------------------------

<*
 Upload mesh vertex data in GPU and provide VAO/VBO ids
*>
extern fn void uploadMesh(Mesh* mesh, bool dynamic) @extern("UploadMesh");

<*
 Update mesh vertex data in GPU for a specific buffer index
*>
extern fn void updateMeshBuffer(Mesh mesh, int index, void* data, int data_size, int offset) @extern("UpdateMeshBuffer");

<*
 Unload mesh data from CPU and GPU
*>
extern fn void unloadMesh(Mesh mesh) @extern("UnloadMesh");

<*
 Draw a 3D mesh with material and transform
*>
extern fn void drawMesh(Mesh mesh, Material material, Matrix transform) @extern("DrawMesh");

// INFO: is this fine though?
<*
 Draw multiple mesh instances with material and different transforms
 @require transforms.len <= int.max
*>
fn void drawMeshInstanced(Mesh mesh, Material material, Matrix[] transforms) @inline {
		__draw_mesh_instanced(mesh, material, transforms.ptr, (int)transforms.len);
}

<*
 Export mesh data to file, returns true on success
*>
extern fn bool exportMesh(Mesh mesh, ZString file_name) @extern("ExportMesh");

<*
 Compute mesh bounding box limits
*>
extern fn BoundingBox getMeshBoundingBox(Mesh mesh) @extern("GetMeshBoundingBox");

<*
 Compute mesh tangents
*>
extern fn void genMeshTangents(Mesh* mesh) @extern("GenMeshTangents");

// Mesh generation functions
//------------------------------------------------------------------------------------

<*
 Generate polygonal mesh
*>
extern fn Mesh genMeshPoly(int sides, float radius) @extern("GenMeshPoly");

<*
 Generate plane mesh (with subdivisions)
*>
extern fn Mesh genMeshPlane(float width, float length, int res_x, int res_z) @extern("GenMeshPlane");

<*
 Generate cuboid mesh
*>
extern fn Mesh genMeshCube(float width, float height, float length) @extern("GenMeshCube");

<*
 Generate sphere mesh (standard sphere)
*>
extern fn Mesh genMeshSphere(float radius, int rings, int slices) @extern("GenMeshSphere");

<*
 Generate half-sphere mesh (no bottom cap)
*>
extern fn Mesh genMeshHemiSphere(float radius, int rings, int slices) @extern("GenMeshHemiSphere");

<*
 Generate cylinder mesh
*>
extern fn Mesh genMeshCylinder(float radius, float height, int slices) @extern("GenMeshCylinder");

<*
 Generate cone/pyramid mesh
*>
extern fn Mesh genMeshCone(float radius, float height, int slices) @extern("GenMeshCone");

<*
 Generate torus mesh
*>
extern fn Mesh genMeshTorus(float radius, float size, int rad_seg, int sides) @extern("GenMeshTorus");

<*
 Generate trefoil knot mesh
*>
extern fn Mesh genMeshKnot(float radius, float size, int rad_seg, int sides) @extern("GenMeshKnot");

<*
 Generate heightmap mesh from image data
*>
extern fn Mesh genMeshHeightmap(Image heightmap, Vector3 size) @extern("GenMeshHeightmap");

<*
 Generate cubes-based map mesh from image data
*>
extern fn Mesh genMeshCubicmap(Image cubicmap, Vector3 cube_size) @extern("GenMeshCubicmap");

// Material loading/unloading functions
//------------------------------------------------------------------------------------

<*
 Load materials from model file
*>
fn Material[] loadMaterials(ZString file_name) @inline {
    int len = 0;
    Material* ptr = __load_materials(file_name, &len);
    return ptr[:len];
}

<*
 Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
*>
extern fn Material loadMaterialDefault() @extern("LoadMaterialDefault");

<*
 Check if a material is ready
*>
extern fn bool isMaterialReady(Material material) @extern("IsMaterialReady");

<*
 Unload material from GPU memory (VRAM)
*>
extern fn void unloadMaterial(Material material) @extern("UnloadMaterial");

<*
 Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
*>
extern fn void setMaterialTexture(Material* material, MaterialMapIndex map_type, Texture2D texture) @extern("SetMaterialTexture");

<*
 Set material for a mesh
*>
extern fn void setModelMeshMaterial(Model* model, int mesh_id, int material_id) @extern("SetModelMeshMaterial");

// Model animations loading/unloading functions
//------------------------------------------------------------------------------------

<*
 Load model animations from file
 @ensure return.len <= int.max
*>
fn ModelAnimation[] loadModelAnimations(ZString file_name) @inline {
    int len = 0;
    ModelAnimation* ptr = __load_model_animations(file_name, &len);
    return ptr[:len];
}

<*
 Update model animation pose
*>
extern fn void updateModelAnimation(Model model, ModelAnimation anim, int frame) @extern("UpdateModelAnimation");

<*
 Unload animation data
*>
extern fn void unloadModelAnimation(ModelAnimation anim) @extern("UnloadModelAnimation");

<*
 Unload animation array data
*>
fn void unloadModelAnimations(ModelAnimation[] animations) @inline {
    __unload_model_animations(animations.ptr, (int)animations.len);
}

<*
 Check model animation skeleton match
*>
extern fn bool isModelAnimationValid(Model model, ModelAnimation anim) @extern("IsModelAnimationValid");

// Collision detection functions
//------------------------------------------------------------------------------------

<*
 Check collision between two spheres
*>
extern fn bool checkCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2) @extern("CheckCollisionSpheres");

<*
 Check collision between two bounding boxes
*>
extern fn bool checkCollisionBoxes(BoundingBox box1, BoundingBox box2) @extern("CheckCollisionBoxes");

<*
 Check collision between box and sphere
*>
extern fn bool checkCollisionBoxSphere(BoundingBox box, Vector3 center, float radius) @extern("CheckCollisionBoxSphere");

<*
 Get collision info between ray and sphere
*>
extern fn RayCollision getRayCollisionSphere(Ray ray, Vector3 center, float radius) @extern("GetRayCollisionSphere");

<*
 Get collision info between ray and box
*>
extern fn RayCollision getRayCollisionBox(Ray ray, BoundingBox box) @extern("GetRayCollisionBox");

<*
 Get collision info between ray and mesh
*>
extern fn RayCollision getRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform) @extern("GetRayCollisionMesh");

<*
 Get collision info between ray and triangle
*>
extern fn RayCollision getRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3) @extern("GetRayCollisionTriangle");

<*
 Get collision info between ray and quad
*>
extern fn RayCollision getRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) @extern("GetRayCollisionQuad");
