module rl;
import std::math; // Required for: Quaternionf

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
const EPSILON = 0.000001f;

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------
// NOTE: Helper types to be used instead of array return types for *ToFloat functions
alias Float3 = float[3];
alias Float16 = float[<16>];

//----------------------------------------------------------------------------------
// Module Functions Definition - Utils math
//----------------------------------------------------------------------------------

<*
 Clamp float value
*>
extern fn float clamp(float value, float min, float max) @cname("Clamp");

<*
 Get min value for each pair of components
*>
extern fn Vector2 vector2_min(Vector2 v1, Vector2 v2) @cname("Vector2Min");

<*
 Get max value for each pair of components
*>
extern fn Vector2 vector2_max(Vector2 v1, Vector2 v2) @cname("Vector2Max");

<*
 Calculate linear interpolation between two floats
*>
extern fn float lerp(float start, float end, float amount) @cname("Lerp");

<*
 Normalize input value within input range
*>
extern fn float normalize(float value, float start, float end) @cname("Normalize");

<*
 Remap input value within input range to output range
*>
extern fn float remap(float value, float inputStart, float inputEnd, float outputStart, float outputEnd) @cname("Remap");

<*
 Wrap input value from min to max
*>
extern fn float wrap(float value, float min, float max) @cname("Wrap");

<*
 Check whether two given floats are almost equal
*>
fn bool floatEquals(float x, float y) @inline => __float_equals(x, y) != 0;

//----------------------------------------------------------------------------------
// Module Functions Definition - Vector2 math
//----------------------------------------------------------------------------------

<*
 Vector with components value 0.0f
*>
extern fn Vector2 vector2Zero() @cname("Vector2Zero");

<*
 Vector with components value 1.0f
*>
extern fn Vector2 vector2One() @cname("Vector2One");

<*
 Add two vectors (v1 + v2)
*>
extern fn Vector2 vector2Add(Vector2 v1, Vector2 v2) @cname("Vector2Add");

<*
 Add vector and float value
*>
extern fn Vector2 vector2AddValue(Vector2 v, float add) @cname("Vector2AddValue");

<*
 Subtract two vectors (v1 - v2)
*>
extern fn Vector2 vector2Subtract(Vector2 v1, Vector2 v2) @cname("Vector2Subtract");

<*
 Subtract vector by float value
*>
extern fn Vector2 vector2SubtractValue(Vector2 v, float sub) @cname("Vector2SubtractValue");

<*
 Calculate vector length
*>
extern fn float vector2Length(Vector2 v) @cname("Vector2Length");

<*
 Calculate vector square length
*>
extern fn float vector2LengthSqr(Vector2 v) @cname("Vector2LengthSqr");

<*
 Calculate two vectors dot product
*>
extern fn float vector2DotProduct(Vector2 v1, Vector2 v2) @cname("Vector2DotProduct");

<*
 Calculate two vectors cross product
*>
extern fn float vector2CrossProduct(Vector2 v1, Vector2 v2) @cname("Vector2CrossProduct");

<*
 Calculate distance between two vectors
*>
extern fn float vector2Distance(Vector2 v1, Vector2 v2) @cname("Vector2Distance");

<*
 Calculate square distance between two vectors
*>
extern fn float vector2DistanceSqr(Vector2 v1, Vector2 v2) @cname("Vector2DistanceSqr");

<*
 Calculate the signed angle from v1 to v2, relative to the origin (0, 0)
 NOTE: Coordinate system convention: positive X right, positive Y down
 positive angles appear clockwise, and negative angles appear counterclockwise
*>
extern fn float vector2Angle(Vector2 v1, Vector2 v2) @cname("Vector2Angle");

<*
 Calculate angle defined by a two vectors line
 NOTE: Parameters need to be normalized
 Current implementation should be aligned with glm::angle
*>
extern fn float vector2LineAngle(Vector2 start, Vector2 end) @cname("Vector2LineAngle");

<*
 Scale vector (multiply by value)
*>
extern fn Vector2 vector2Scale(Vector2 v, float scale) @cname("Vector2Scale");

<*
 Multiply vector by vector
*>
extern fn Vector2 vector2Multiply(Vector2 v1, Vector2 v2) @cname("Vector2Multiply");

<*
 Negate vector
*>
extern fn Vector2 vector2Negate(Vector2 v) @cname("Vector2Negate");

<*
 Divide vector by vector
*>
extern fn Vector2 vector2Divide(Vector2 v1, Vector2 v2) @cname("Vector2Divide");

<*
 Normalize provided vector
*>
extern fn Vector2 vector2Normalize(Vector2 v) @cname("Vector2Normalize");

<*
 Transforms a Vector2 by a given Matrix
*>
extern fn Vector2 vector2Transform(Vector2 v, Matrix mat) @cname("Vector2Transform");

<*
 Calculate linear interpolation between two vectors
*>
extern fn Vector2 vector2Lerp(Vector2 v1, Vector2 v2, float amount) @cname("Vector2Lerp");

<*
 Calculate reflected vector to normal
*>
extern fn Vector2 vector2Reflect(Vector2 v, Vector2 normal) @cname("Vector2Reflect");

<*
 Rotate vector by angle
*>
extern fn Vector2 vector2Rotate(Vector2 v, float angle) @cname("Vector2Rotate");

<*
 Move Vector towards target
*>
extern fn Vector2 vector2MoveTowards(Vector2 v, Vector2 target, float maxDistance) @cname("Vector2MoveTowards");

<*
 Invert the given vector
*>
extern fn Vector2 vector2Invert(Vector2 v) @cname("Vector2Invert");

<*
 Clamp the components of the vector between
 min and max values specified by the given vectors
*>
extern fn Vector2 vector2Clamp(Vector2 v, Vector2 min, Vector2 max) @cname("Vector2Clamp");

<*
 Clamp the magnitude of the vector between two min and max values
*>
extern fn Vector2 vector2ClampValue(Vector2 v, float min, float max) @cname("Vector2ClampValue");

<*
 Check whether two given vectors are almost equal
*>
fn bool vector2Equals(Vector2 p, Vector2 q) @inline => __vector2_equals(p, q) != 0;

<*
 Compute the direction of a refracted ray
 v: normalized direction of the incoming ray
 n: normalized normal vector of the interface of two optical media
 r: ratio of the refractive index of the medium from where the ray comes
    to the refractive index of the medium on the other side of the surface
*>
extern fn Vector2 vector2Refract(Vector2 v, Vector2 n, float r) @cname("Vector2Refract");


//----------------------------------------------------------------------------------
// Module Functions Definition - Vector3 math
//----------------------------------------------------------------------------------

<*
 Vector with components value 0.0f
*>
extern fn Vector3 vector3Zero() @cname("Vector3Zero");

<*
 Vector with components value 1.0f
*>
extern fn Vector3 vector3One() @cname("Vector3One");

<*
 Add two vectors
*>
extern fn Vector3 vector3Add(Vector3 v1, Vector3 v2) @cname("Vector3Add");

<*
 Add vector and float value
*>
extern fn Vector3 vector3AddValue(Vector3 v, float add) @cname("Vector3AddValue");

<*
 Subtract two vectors
*>
extern fn Vector3 vector3Subtract(Vector3 v1, Vector3 v2) @cname("Vector3Subtract");

<*
 Subtract vector by float value
*>
extern fn Vector3 vector3SubtractValue(Vector3 v, float sub) @cname("Vector3SubtractValue");

<*
 Multiply vector by scalar
*>
extern fn Vector3 vector3Scale(Vector3 v, float scalar) @cname("Vector3Scale");

<*
 Multiply vector by vector
*>
extern fn Vector3 vector3Multiply(Vector3 v1, Vector3 v2) @cname("Vector3Multiply");

<*
 Calculate two vectors cross product
*>
extern fn Vector3 vector3CrossProduct(Vector3 v1, Vector3 v2) @cname("Vector3CrossProduct");

<*
 Calculate one vector perpendicular vector
*>
extern fn Vector3 vector3Perpendicular(Vector3 v) @cname("Vector3Perpendicular");

<*
 Calculate vector length
*>
extern fn float vector3Length(Vector3 v) @cname("Vector3Length");

<*
 Calculate vector square length
*>
extern fn float vector3LengthSqr(Vector3 v) @cname("Vector3LengthSqr");

<*
 Calculate two vectors dot product
*>
extern fn float vector3DotProduct(Vector3 v1, Vector3 v2) @cname("Vector3DotProduct");

<*
 Calculate distance between two vectors
*>
extern fn float vector3Distance(Vector3 v1, Vector3 v2) @cname("Vector3Distance");

<*
 Calculate square distance between two vectors
*>
extern fn float vector3DistanceSqr(Vector3 v1, Vector3 v2) @cname("Vector3DistanceSqr");

<*
 Calculate angle between two vectors
*>
extern fn float vector3Angle(Vector3 v1, Vector3 v2) @cname("Vector3Angle");

<*
 Negate provided vector (invert direction)
*>
extern fn Vector3 vector3Negate(Vector3 v) @cname("Vector3Negate");

<*
 Divide vector by vector
*>
extern fn Vector3 vector3Divide(Vector3 v1, Vector3 v2) @cname("Vector3Divide");

<*
 Normalize provided vector
*>
extern fn Vector3 vector3Normalize(Vector3 v) @cname("Vector3Normalize");

<*
 Calculate the projection of the vector v1 on to v2
*>
extern fn Vector3 vector3Project(Vector3 v1, Vector3 v2) @cname("Vector3Project");

<*
 Calculate the rejection of the vector v1 on to v2
*>
extern fn Vector3 vector3Reject(Vector3 v1, Vector3 v2) @cname("Vector3Reject");

<*
 Orthonormalize provided vectors
 Makes vectors normalized and orthogonal to each other
 Gram-Schmidt function implementation
*>
extern fn void vector3OrthoNormalize(Vector3 *v1, Vector3 *v2) @cname("Vector3OrthoNormalize");

<*
 Transforms a Vector3 by a given Matrix
*>
extern fn Vector3 vector3Transform(Vector3 v, Matrix mat) @cname("Vector3Transform");

<*
 Transform a vector by quaternion rotation
*>
extern fn Vector3 vector3RotateByQuaternion(Vector3 v, Quaternion q) @cname("Vector3RotateByQuaternion");

<*
 Rotates a vector around an axis
*>
extern fn Vector3 vector3RotateByAxisAngle(Vector3 v, Vector3 axis, float angle) @cname("Vector3RotateByAxisAngle");

<*
 Move Vector towards target
*>
extern fn Vector3 vector3MoveTowards(Vector3 v, Vector3 target, float maxDistance) @cname("Vector3MoveTowards");

<*
 Calculate linear interpolation between two vectors
*>
extern fn Vector3 vector3Lerp(Vector3 v1, Vector3 v2, float amount) @cname("Vector3Lerp");

<*
 Calculate cubic hermite interpolation between two vectors and their tangents
 as described in the GLTF 2.0 specification: https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#interpolation-cubic
*>
extern fn Vector3 vector3CubicHermite(Vector3 v1, Vector3 tangent1, Vector3 v2, Vector3 tangent2, float amount) @cname("Vector3CubicHermite");

<*
 Calculate reflected vector to normal
*>
extern fn Vector3 vector3Reflect(Vector3 v, Vector3 normal) @cname("Vector3Reflect");

<*
 Get min value for each pair of components
*>
extern fn Vector3 vector3Min(Vector3 v1, Vector3 v2) @cname("Vector3Min");

<*
 Get max value for each pair of components
*>
extern fn Vector3 vector3Max(Vector3 v1, Vector3 v2) @cname("Vector3Max");

<*
 Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c)
 NOTE: Assumes P is on the plane of the triangle
*>
extern fn Vector3 vector3Barycenter(Vector3 p, Vector3 a, Vector3 b, Vector3 c) @cname("Vector3Barycenter");

<*
 Projects a Vector3 from screen space into object space
 NOTE: Self-contained function, no other raymath functions are called
*>
extern fn Vector3 vector3Unproject(Vector3 source, Matrix projection, Matrix view) @cname("Vector3Unproject");

<*
 Invert the given vector
*>
extern fn Vector3 vector3Invert(Vector3 v) @cname("Vector3Invert");

<*
 Clamp the components of the vector between
 min and max values specified by the given vectors
*>
extern fn Vector3 vector3Clamp(Vector3 v, Vector3 min, Vector3 max) @cname("Vector3Clamp");

<*
 Clamp the magnitude of the vector between two values
*>
extern fn Vector3 vector3ClampValue(Vector3 v, float min, float max) @cname("Vector3ClampValue");

<*
 Check whether two given vectors are almost equal
*>
fn bool vector3Equals(Vector3 p, Vector3 q) @inline => __vector3_equals(p, q) != 0;

<*
 Compute the direction of a refracted ray
 v: normalized direction of the incoming ray
 n: normalized normal vector of the interface of two optical media
 r: ratio of the refractive index of the medium from where the ray comes
    to the refractive index of the medium on the other side of the surface
*>
extern fn Vector3 vector3Refract(Vector3 v, Vector3 n, float r) @cname("Vector3Refract");


//----------------------------------------------------------------------------------
// Module Functions Definition - Vector4 math
//----------------------------------------------------------------------------------

<*
 Get vector zero
*>
extern fn Vector4 vector4Zero() @cname("Vector4Zero");

<*
 Get vector one
*>
extern fn Vector4 vector4One() @cname("Vector4One");

<*
 Add two vectors
*>
extern fn Vector4 vector4Add(Vector4 v1, Vector4 v2) @cname("Vector4Add");

<*
 Add value to vector components
*>
extern fn Vector4 vector4AddValue(Vector4 v, float add) @cname("Vector4AddValue");

<*
 Substract vectors
*>
extern fn Vector4 vector4Subtract(Vector4 v1, Vector4 v2) @cname("Vector4Subtract");

<*
 Substract value from vector components
*>
extern fn Vector4 vector4SubtractValue(Vector4 v, float add) @cname("Vector4SubtractValue");

<*
 Vector length
*>
extern fn float vector4Length(Vector4 v) @cname("Vector4Length");

<*
 Vector square length
*>
extern fn float vector4LengthSqr(Vector4 v) @cname("Vector4LengthSqr");

<*
 Vectors dot product
*>
extern fn float vector4DotProduct(Vector4 v1, Vector4 v2) @cname("Vector4DotProduct");

<*
 Calculate distance between two vectors
*>
extern fn float vector4Distance(Vector4 v1, Vector4 v2) @cname("Vector4Distance");

<*
 Calculate square distance between two vectors
*>
extern fn float vector4DistanceSqr(Vector4 v1, Vector4 v2) @cname("Vector4DistanceSqr");

<*
 Scale vector components by value (multiply)
*>
extern fn Vector4 vector4Scale(Vector4 v, float scale) @cname("Vector4Scale");

<*
 Multiply vector by vector
*>
extern fn Vector4 vector4Multiply(Vector4 v1, Vector4 v2) @cname("Vector4Multiply");

<*
 Negate vector
*>
extern fn Vector4 vector4Negate(Vector4 v) @cname("Vector4Negate");

<*
 Divide vector by vector
*>
extern fn Vector4 vector4Divide(Vector4 v1, Vector4 v2) @cname("Vector4Divide");

<*
 Normalize provided vector
*>
extern fn Vector4 vector4Normalize(Vector4 v) @cname("Vector4Normalize");

<*
 Get min value for each pair of components
*>
extern fn Vector4 vector4Min(Vector4 v1, Vector4 v2) @cname("Vector4Min");

<*
 Get max value for each pair of components
*>
extern fn Vector4 vector4Max(Vector4 v1, Vector4 v2) @cname("Vector4Max");

<*
 Calculate linear interpolation between two vectors
*>
extern fn Vector4 vector4Lerp(Vector4 v1, Vector4 v2, float amount) @cname("Vector4Lerp");

<*
 Move Vector towards target
*>
extern fn Vector4 vector4MoveTowards(Vector4 v, Vector4 target, float maxDistance) @cname("Vector4MoveTowards");

<*
 Invert the given vector
*>
extern fn Vector4 vector4Invert(Vector4 v) @cname("Vector4Invert");

<*
 Check whether two given vectors are almost equal
*>
fn bool vector4Equals(Vector4 p, Vector4 q) @inline => __vector4_equals(p, q) != 0;

//----------------------------------------------------------------------------------
// Module Functions Definition - Matrix math
//----------------------------------------------------------------------------------

<*
 Compute matrix determinant
*>
extern fn float matrixDeterminant(Matrix mat) @cname("MatrixDeterminant");

<*
 Get the trace of the matrix (sum of the values along the diagonal)
*>
extern fn float matrixTrace(Matrix mat) @cname("MatrixTrace");

<*
 Transposes provided matrix
*>
extern fn Matrix matrixTranspose(Matrix mat) @cname("MatrixTranspose");

<*
 Invert provided matrix
*>
extern fn Matrix matrixInvert(Matrix mat) @cname("MatrixInvert");

<*
 Get identity matrix
*>
extern fn Matrix matrixIdentity() @cname("MatrixIdentity");

<*
 Add two matrices
*>
extern fn Matrix matrixAdd(Matrix left, Matrix right) @cname("MatrixAdd");

<*
 Subtract two matrices (left - right)
*>
extern fn Matrix matrixSubtract(Matrix left, Matrix right) @cname("MatrixSubtract");

<*
 Get two matrix multiplication
 NOTE: When multiplying matrices... the order matters!
*>
extern fn Matrix matrixMultiply(Matrix left, Matrix right) @cname("MatrixMultiply");

<*
 Multiply matrix components by value
*>
extern fn Matrix matrixMultiplyValue(Matrix left, float value) @cname("MatrixMultiplyValue");

<*
 Get translation matrix
*>
extern fn Matrix matrixTranslate(float x, float y, float z) @cname("MatrixTranslate");

<*
 Create rotation matrix from axis and angle
 NOTE: Angle should be provided in radians
*>
extern fn Matrix matrixRotate(Vector3 axis, float angle) @cname("MatrixRotate");

<*
 Get x-rotation matrix
 NOTE: Angle must be provided in radians
*>
extern fn Matrix matrixRotateX(float angle) @cname("MatrixRotateX");

<*
 Get y-rotation matrix
 NOTE: Angle must be provided in radians
*>
extern fn Matrix matrixRotateY(float angle) @cname("MatrixRotateY");

<*
 Get z-rotation matrix
 NOTE: Angle must be provided in radians
*>
extern fn Matrix matrixRotateZ(float angle) @cname("MatrixRotateZ");


<*
 Get xyz-rotation matrix
 NOTE: Angle must be provided in radians
*>
extern fn Matrix matrixRotateXYZ(Vector3 angle) @cname("MatrixRotateXYZ");

<*
 Get zyx-rotation matrix
 NOTE: Angle must be provided in radians
*>
extern fn Matrix matrixRotateZYX(Vector3 angle) @cname("MatrixRotateZYX");

<*
 Get scaling matrix
*>
extern fn Matrix matrixScale(float x, float y, float z) @cname("MatrixScale");

<*
 Get perspective projection matrix
*>
extern fn Matrix matrixFrustum(double left, double right, double bottom, double top, double nearPlane, double farPlane) @cname("MatrixFrustum");

<*
 Get perspective projection matrix
 NOTE: Fovy angle must be provided in radians
*>
extern fn Matrix matrixPerspective(double fovY, double aspect, double nearPlane, double farPlane) @cname("MatrixPerspective");

<*
 Get orthographic projection matrix
*>
extern fn Matrix matrixOrtho(double left, double right, double bottom, double top, double nearPlane, double farPlane) @cname("MatrixOrtho");

<*
 Get camera look-at matrix (view matrix)
*>
extern fn Matrix matrixLookAt(Vector3 eye, Vector3 target, Vector3 up) @cname("MatrixLookAt");

<*
 Get float array of matrix data
*>
fn Float16 matrixToFloatV(Matrix mat) {
	Float16 result;

	result[0] = mat.m0;
	result[1] = mat.m1;
	result[2] = mat.m2;
	result[3] = mat.m3;
	result[4] = mat.m4;
	result[5] = mat.m5;
	result[6] = mat.m6;
	result[7] = mat.m7;
	result[8] = mat.m8;
	result[9] = mat.m9;
	result[10] = mat.m10;
	result[11] = mat.m11;
	result[12] = mat.m12;
	result[13] = mat.m13;
	result[14] = mat.m14;
	result[15] = mat.m15;

	return result;
}

//----------------------------------------------------------------------------------
// Module Functions Definition - Quaternion math
//----------------------------------------------------------------------------------

<*
 Convert a raylib Quaternion to a C3 math::Quaternionf
*>
fn Quaternionf quaternionToQuatf(Quaternion q) {
	Quaternionf result = { q.x, q.y, q.z, q.w };

	return result;
}

<*
 Add two quaternions
*>
extern fn Quaternion quaternionAdd(Quaternion q1, Quaternion q2) @cname("QuaternionAdd");

<*
 Add quaternion and float value
*>
extern fn Quaternion quaternionAddValue(Quaternion q, float add) @cname("QuaternionAddValue");

<*
 Subtract two quaternions
*>
extern fn Quaternion quaternionSubtract(Quaternion q1, Quaternion q2) @cname("QuaternionSubtract");

<*
 Subtract quaternion and float value
*>
extern fn Quaternion quaternionSubtractValue(Quaternion q, float sub) @cname("QuaternionSubtractValue");

<*
 Get identity quaternion
*>
extern fn Quaternion quaternionIdentity() @cname("QuaternionIdentity");

<*
 Computes the length of a quaternion
*>
extern fn float quaternionLength(Quaternion q) @cname("QuaternionLength");

<*
 Normalize provided quaternion
*>
extern fn Quaternion quaternionNormalize(Quaternion q) @cname("QuaternionNormalize");

<*
 Invert provided quaternion
*>
extern fn Quaternion quaternionInvert(Quaternion q) @cname("QuaternionInvert");

<*
 Calculate two quaternion multiplication
*>
extern fn Quaternion quaternionMultiply(Quaternion q1, Quaternion q2) @cname("QuaternionMultiply");

<*
 Scale quaternion by float value
*>
extern fn Quaternion quaternionScale(Quaternion q, float mul) @cname("QuaternionScale");

<*
 Divide two quaternions
*>
extern fn Quaternion quaternionDivide(Quaternion q1, Quaternion q2) @cname("QuaternionDivide");

<*
 Calculate linear interpolation between two quaternions
*>
extern fn Quaternion quaternionLerp(Quaternion q1, Quaternion q2, float amount) @cname("QuaternionLerp");

<*
 Calculate slerp-optimized interpolation between two quaternions
*>
extern fn Quaternion quaternionNlerp(Quaternion q1, Quaternion q2, float amount) @cname("QuaternionNlerp");

<*
 Calculates spherical linear interpolation between two quaternions
*>
extern fn Quaternion quaternionSlerp(Quaternion q1, Quaternion q2, float amount) @cname("QuaternionSlerp");

<*
 Calculate quaternion cubic spline interpolation using Cubic Hermite Spline algorithm
 as described in the GLTF 2.0 specification: https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#interpolation-cubic
*>
extern fn Quaternion quaternionCubicHermiteSpline(Quaternion q1, Quaternion outTangent1, Quaternion q2, Quaternion inTangent2, float t) @cname("QuaternionCubicHermiteSpline");

<*
 Calculate quaternion based on the rotation from one vector to another
*>
extern fn Quaternion quaternionFromvector3ToVector3(Vector3 from, Vector3 to) @cname("QuaternionFromVector3ToVector3");

<*
 Get a quaternion for a given rotation matrix
*>
extern fn Quaternion quaternionFromMatrix(Matrix mat) @cname("QuaternionFromMatrix");

<*
 Get a matrix for a given quaternion
*>
extern fn Matrix quaternionToMatrix(Quaternion q) @cname("QuaternionToMatrix");

<*
 Get rotation quaternion for an angle and axis
 NOTE: Angle must be provided in radians
*>
extern fn Quaternion quaternionFromAxisAngle(Vector3 axis, float angle) @cname("QuaternionFromAxisAngle");

<*
 Get the rotation angle and axis for a given quaternion
*>
extern fn void quaternionToAxisAngle(Quaternion q, Vector3 *outAxis, float *outAngle) @cname("QuaternionToAxisAngle");

<*
 Get the quaternion equivalent to Euler angles
 NOTE: Rotation order is ZYX
*>
extern fn Quaternion quaternionFromEuler(float pitch, float yaw, float roll) @cname("QuaternionFromEuler");

<*
 Get the Euler angles equivalent to quaternion (roll, pitch, yaw)
 NOTE: Angles are returned in a Vector3 struct in radians
*>
extern fn Vector3 quaternionToEuler(Quaternion q) @cname("QuaternionToEuler");

<*
 Transform a quaternion given a transformation matrix
*>
extern fn Quaternion quaternionTransform(Quaternion q, Matrix mat) @cname("QuaternionTransform");

<*
 Check whether two given quaternions are almost equal
*>
fn bool quaternionEquals(Quaternion p, Quaternion q) @inline => __quaternion_equals(p, q) != 0;

<*
 Compose a transformation matrix from rotational, translational and scaling components
*>
extern fn Matrix matrixCompose(Vector3 translation, Quaternion rotation, Vector3 scale) @cname("MatrixCompose");

<*
 Decompose a transformation matrix into its rotational, translational and scaling components and remove shear
 TODO: WARNING: Following raymath convention and make the function self-contained
*>
extern fn void matrixDecompose(Matrix mat, Vector3 *translation, Quaternion *rotation, Vector3 *scale) @cname("MatrixDecompose");
