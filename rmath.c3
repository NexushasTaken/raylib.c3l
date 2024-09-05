// vi: ts=4 sw=4 noet
module rl;
import std::math; // Required for: math::sin(), math::cos(), tan(), math::atan2(), math::sqrt(), floor(), math::min(), math::max(), fabs()

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------
const EPSILON = 0.000001f;

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------
// NOTE: Helper types to be used instead of array return types for *ToFloat functions
def Float3 = float[3];
def Float16 = float[<16>];
def Quaternionf = quaternion::Quaternion(<float>);

//----------------------------------------------------------------------------------
// Module Functions Definition - Utils math
//----------------------------------------------------------------------------------

// Clamp float value
fn float clamp(float value, float min, float max) @inline {
	return value.clamp(min, max);
}

// Calculate linear interpolation between two floats
fn float lerp(float start, float end, float amount) {
	float result = start + amount*(end - start);

	return result;
}

// Normalize input value within input range
fn float normalize(float value, float start, float end) {
	float result = (value - start)/(end - start);

	return result;
}

// Remap input value within input range to output range
fn float remap(float value, float inputStart, float inputEnd, float outputStart, float outputEnd) {
	float result = (value - inputStart)/(inputEnd - inputStart)*(outputEnd - outputStart) + outputStart;

	return result;
}

// Wrap input value from min to max
fn float wrap(float value, float min, float max) {
	float result = value - (max - min)*math::floor((value - min)/(max - min));

	return result;
}

// Check whether two given floats are almost equal
fn bool float_equals(float x, float y) {
	bool result = (math::abs(x - y)) <= (EPSILON*math::max(1.0f, math::max(math::abs(x), math::abs(y))));

	return result;
}

//----------------------------------------------------------------------------------
// Module Functions Definition - Vector2 math
//----------------------------------------------------------------------------------

// Vector with components value 0.0f
fn Vector2 vector2_zero() @inline {
	Vector2 result = { 0.0f, 0.0f };

	return result;
}

// Vector with components value 1.0f
fn Vector2 vector2_one() @inline {
	Vector2 result = { 1.0f, 1.0f };

	return result;
}

// Add two vectors (v1 + v2)
fn Vector2 vector2_add(Vector2 v1, Vector2 v2) {
	Vector2 result = { v1.x + v2.x, v1.y + v2.y };

	return result;
}

// Add vector and float value
fn Vector2 vector2_add_value(Vector2 v, float add) {
	Vector2 result = { v.x + add, v.y + add };

	return result;
}

// Subtract two vectors (v1 - v2)
fn Vector2 vector2_subtract(Vector2 v1, Vector2 v2) {
	Vector2 result = { v1.x - v2.x, v1.y - v2.y };

	return result;
}

// Subtract vector by float value
fn Vector2 vector2_subtract_value(Vector2 v, float sub) {
	Vector2 result = { v.x - sub, v.y - sub };

	return result;
}

// Calculate vector length
fn float vector2_length(Vector2 v) {
	float result = math::sqrt((v.x*v.x) + (v.y*v.y));

	return result;
}

// Calculate vector square length
fn float vector2_length_sqr(Vector2 v) {
	float result = (v.x*v.x) + (v.y*v.y);

	return result;
}

// Calculate two vectors dot product
fn float vector2_dot_product(Vector2 v1, Vector2 v2) {
	float result = (v1.x*v2.x + v1.y*v2.y);

	return result;
}

// Calculate distance between two vectors
fn float vector2_distance(Vector2 v1, Vector2 v2) {
	float result = math::sqrt((v1.x - v2.x)*(v1.x - v2.x) + (v1.y - v2.y)*(v1.y - v2.y));

	return result;
}

// Calculate square distance between two vectors
fn float vector2_distance_sqr(Vector2 v1, Vector2 v2) {
	float result = ((v1.x - v2.x)*(v1.x - v2.x) + (v1.y - v2.y)*(v1.y - v2.y));

	return result;
}

// Calculate angle between two vectors
// NOTE: Angle is calculated from origin point (0, 0)
fn float vector2_angle(Vector2 v1, Vector2 v2) {
	float result = 0.0f;

	float dot = v1.x*v2.x + v1.y*v2.y;
	float det = v1.x*v2.y - v1.y*v2.x;

	result = math::atan2(det, dot);

	return result;
}

// Calculate angle defined by a two vectors line
// NOTE: Parameters need to be normalized
// Current implementation should be aligned with glm::angle
fn float vector2_line_angle(Vector2 start, Vector2 end) {
	float result = 0.0f;

	// TODO(10/9/2023): Currently angles move clockwise, determine if this is wanted behavior
	result = -math::atan2(end.y - start.y, end.x - start.x);

	return result;
}

// Scale vector (multiply by value)
fn Vector2 vector2_scale(Vector2 v, float scale) {
	Vector2 result = { v.x*scale, v.y*scale };

	return result;
}

// Multiply vector by vector
fn Vector2 vector2_multiply(Vector2 v1, Vector2 v2) {
	Vector2 result = { v1.x*v2.x, v1.y*v2.y };

	return result;
}

// Negate vector
fn Vector2 vector2_negate(Vector2 v) {
	Vector2 result = { -v.x, -v.y };

	return result;
}

// Divide vector by vector
fn Vector2 vector2_divide(Vector2 v1, Vector2 v2) {
	Vector2 result = { v1.x/v2.x, v1.y/v2.y };

	return result;
}

// Normalize provided vector
fn Vector2 vector2_normalize(Vector2 v) {
	Vector2 result;
	float length = math::sqrt((v.x*v.x) + (v.y*v.y));

	if (length > 0)
	{
		float ilength = 1.0f/length;
		result.x = v.x*ilength;
		result.y = v.y*ilength;
	}

	return result;
}

// Transforms a Vector2 by a given Matrix
fn Vector2 vector2_transform(Vector2 v, Matrix mat) {
	Vector2 result;

	float x = v.x;
	float y = v.y;
	float z = 0;

	result.x = mat.m0*x + mat.m4*y + mat.m8*z + mat.m12;
	result.y = mat.m1*x + mat.m5*y + mat.m9*z + mat.m13;

	return result;
}

// Calculate linear interpolation between two vectors
fn Vector2 vector2_lerp(Vector2 v1, Vector2 v2, float amount) {
	Vector2 result;

	result.x = v1.x + amount*(v2.x - v1.x);
	result.y = v1.y + amount*(v2.y - v1.y);

	return result;
}

// Calculate reflected vector to normal
fn Vector2 vector2_reflect(Vector2 v, Vector2 normal) {
	Vector2 result;

	float dotProduct = (v.x*normal.x + v.y*normal.y); // Dot product

	result.x = v.x - (2.0f*normal.x)*dotProduct;
	result.y = v.y - (2.0f*normal.y)*dotProduct;

	return result;
}

// Rotate vector by angle
fn Vector2 vector2_rotate(Vector2 v, float angle) {
	Vector2 result;

	float cosres = math::cos(angle);
	float sinres = math::sin(angle);

	result.x = v.x*cosres - v.y*sinres;
	result.y = v.x*sinres + v.y*cosres;

	return result;
}

// Move Vector towards target
fn Vector2 vector2_move_towards(Vector2 v, Vector2 target, float maxDistance) {
	Vector2 result;

	float dx = target.x - v.x;
	float dy = target.y - v.y;
	float value = (dx*dx) + (dy*dy);

	if ((value == 0) || ((maxDistance >= 0) && (value <= maxDistance*maxDistance))) return target;

	float dist = math::sqrt(value);

	result.x = v.x + dx/dist*maxDistance;
	result.y = v.y + dy/dist*maxDistance;

	return result;
}

// Invert the given vector
fn Vector2 vector2_invert(Vector2 v) {
	Vector2 result = { 1.0f/v.x, 1.0f/v.y };

	return result;
}

// Clamp the components of the vector between
// min and max values specified by the given vectors
fn Vector2 vector2_clamp(Vector2 v, Vector2 min, Vector2 max) {
	Vector2 result;

	result.x = math::min(max.x, math::max(min.x, v.x));
	result.y = math::min(max.y, math::max(min.y, v.y));

	return result;
}

// Clamp the magnitude of the vector between two min and max values
fn Vector2 vector2_clamp_value(Vector2 v, float min, float max) {
	Vector2 result = v;

	float length = (v.x*v.x) + (v.y*v.y);
	if (length > 0.0f)
	{
		length = math::sqrt(length);

		if (length < min)
		{
			float scale = min/length;
			result.x = v.x*scale;
			result.y = v.y*scale;
		}
		else if (length > max)
		{
			float scale = max/length;
			result.x = v.x*scale;
			result.y = v.y*scale;
		}
	}

	return result;
}

// Check whether two given vectors are almost equal
fn bool vector2_equals(Vector2 p, Vector2 q) {
	bool result = ((math::abs(p.x - q.x)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.x), math::abs(q.x))))) &&
				  ((math::abs(p.y - q.y)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.y), math::abs(q.y)))));

	return result;
}

//----------------------------------------------------------------------------------
// Module Functions Definition - Vector3 math
//----------------------------------------------------------------------------------

// Vector with components value 0.0f
fn Vector3 vector3_zero() {
	Vector3 result = { 0.0f, 0.0f, 0.0f };

	return result;
}

// Vector with components value 1.0f
fn Vector3 vector3_one() {
	Vector3 result = { 1.0f, 1.0f, 1.0f };

	return result;
}

// Add two vectors
fn Vector3 vector3_add(Vector3 v1, Vector3 v2) {
	Vector3 result = { v1.x + v2.x, v1.y + v2.y, v1.z + v2.z };

	return result;
}

// Add vector and float value
fn Vector3 vector3_add_value(Vector3 v, float add) {
	Vector3 result = { v.x + add, v.y + add, v.z + add };

	return result;
}

// Subtract two vectors
fn Vector3 vector3_subtract(Vector3 v1, Vector3 v2) {
	Vector3 result = { v1.x - v2.x, v1.y - v2.y, v1.z - v2.z };

	return result;
}

// Subtract vector by float value
fn Vector3 vector3_subtract_value(Vector3 v, float sub) {
	Vector3 result = { v.x - sub, v.y - sub, v.z - sub };

	return result;
}

// Multiply vector by scalar
fn Vector3 vector3_scale(Vector3 v, float scalar) {
	Vector3 result = { v.x*scalar, v.y*scalar, v.z*scalar };

	return result;
}

// Multiply vector by vector
fn Vector3 vector3_multiply(Vector3 v1, Vector3 v2) {
	Vector3 result = { v1.x*v2.x, v1.y*v2.y, v1.z*v2.z };

	return result;
}

// Calculate two vectors cross product
fn Vector3 vector3_cross_product(Vector3 v1, Vector3 v2) {
	Vector3 result = { v1.y*v2.z - v1.z*v2.y, v1.z*v2.x - v1.x*v2.z, v1.x*v2.y - v1.y*v2.x };

	return result;
}

// Calculate one vector perpendicular vector
fn Vector3 vector3_perpendicular(Vector3 v) {
	Vector3 result;

	float min = (float) math::abs(v.x);
	Vector3 cardinalAxis = {1.0f, 0.0f, 0.0f};

	if (math::abs(v.y) < min)
	{
		min = (float) math::abs(v.y);
		Vector3 tmp = {0.0f, 1.0f, 0.0f};
		cardinalAxis = tmp;
	}

	if (math::abs(v.z) < min)
	{
		Vector3 tmp = {0.0f, 0.0f, 1.0f};
		cardinalAxis = tmp;
	}

	// Cross product between vectors
	result.x = v.y*cardinalAxis.z - v.z*cardinalAxis.y;
	result.y = v.z*cardinalAxis.x - v.x*cardinalAxis.z;
	result.z = v.x*cardinalAxis.y - v.y*cardinalAxis.x;

	return result;
}

// Calculate vector length
fn float vector3_length(Vector3 v) {
	float result = math::sqrt(v.x*v.x + v.y*v.y + v.z*v.z);

	return result;
}

// Calculate vector square length
fn float vector3_length_sqr(Vector3 v) {
	float result = v.x*v.x + v.y*v.y + v.z*v.z;

	return result;
}

// Calculate two vectors dot product
fn float vector3_dot_product(Vector3 v1, Vector3 v2) {
	float result = (v1.x*v2.x + v1.y*v2.y + v1.z*v2.z);

	return result;
}

// Calculate distance between two vectors
fn float vector3_distance(Vector3 v1, Vector3 v2) {
	float result = 0.0f;

	float dx = v2.x - v1.x;
	float dy = v2.y - v1.y;
	float dz = v2.z - v1.z;
	result = math::sqrt(dx*dx + dy*dy + dz*dz);

	return result;
}

// Calculate square distance between two vectors
fn float vector3_distance_sqr(Vector3 v1, Vector3 v2) {
	float result = 0.0f;

	float dx = v2.x - v1.x;
	float dy = v2.y - v1.y;
	float dz = v2.z - v1.z;
	result = dx*dx + dy*dy + dz*dz;

	return result;
}

// Calculate angle between two vectors
fn float vector3_angle(Vector3 v1, Vector3 v2) {
	float result = 0.0f;

	Vector3 cross = { v1.y*v2.z - v1.z*v2.y, v1.z*v2.x - v1.x*v2.z, v1.x*v2.y - v1.y*v2.x };
	float len = math::sqrt(cross.x*cross.x + cross.y*cross.y + cross.z*cross.z);
	float dot = (v1.x*v2.x + v1.y*v2.y + v1.z*v2.z);
	result = math::atan2(len, dot);

	return result;
}

// Negate provided vector (invert direction)
fn Vector3 vector3_negate(Vector3 v) {
	Vector3 result = { -v.x, -v.y, -v.z };

	return result;
}

// Divide vector by vector
fn Vector3 vector3_divide(Vector3 v1, Vector3 v2) {
	Vector3 result = { v1.x/v2.x, v1.y/v2.y, v1.z/v2.z };

	return result;
}

// Normalize provided vector
fn Vector3 vector3_normalize(Vector3 v) {
	Vector3 result = v;

	float length = math::sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
	if (length != 0.0f)
	{
		float ilength = 1.0f/length;

		result.x *= ilength;
		result.y *= ilength;
		result.z *= ilength;
	}

	return result;
}

//Calculate the projection of the vector v1 on to v2
fn Vector3 vector3_project(Vector3 v1, Vector3 v2) {
	Vector3 result;

	float v1dv2 = (v1.x*v2.x + v1.y*v2.y + v1.z*v2.z);
	float v2dv2 = (v2.x*v2.x + v2.y*v2.y + v2.z*v2.z);

	float mag = v1dv2/v2dv2;

	result.x = v2.x*mag;
	result.y = v2.y*mag;
	result.z = v2.z*mag;

	return result;
}

//Calculate the rejection of the vector v1 on to v2
fn Vector3 vector3_reject(Vector3 v1, Vector3 v2) {
	Vector3 result;

	float v1dv2 = (v1.x*v2.x + v1.y*v2.y + v1.z*v2.z);
	float v2dv2 = (v2.x*v2.x + v2.y*v2.y + v2.z*v2.z);

	float mag = v1dv2/v2dv2;

	result.x = v1.x - (v2.x*mag);
	result.y = v1.y - (v2.y*mag);
	result.z = v1.z - (v2.z*mag);

	return result;
}

// Orthonormalize provided vectors
// Makes vectors normalized and orthogonal to each other
// Gram-Schmidt function implementation
fn void vector3_ortho_normalize(Vector3 *v1, Vector3 *v2) {
	float length = 0.0f;
	float ilength = 0.0f;

	// vector3_Normalize(*v1);
	Vector3 v = *v1;
	length = math::sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
	if (length == 0.0f) {
	  length = 1.0f;
	}
	ilength = 1.0f/length;
	v1.x *= ilength;
	v1.y *= ilength;
	v1.z *= ilength;

	// vector3_CrossProduct(*v1, *v2)
	Vector3 vn1 = { v1.y*v2.z - v1.z*v2.y, v1.z*v2.x - v1.x*v2.z, v1.x*v2.y - v1.y*v2.x };

	// vector3_Normalize(vn1);
	v = vn1;
	length = math::sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
	if (length == 0.0f) length = 1.0f;
	ilength = 1.0f/length;
	vn1.x *= ilength;
	vn1.y *= ilength;
	vn1.z *= ilength;

	// vector3_CrossProduct(vn1, *v1)
	Vector3 vn2 = { vn1.y*v1.z - vn1.z*v1.y, vn1.z*v1.x - vn1.x*v1.z, vn1.x*v1.y - vn1.y*v1.x };

	*v2 = vn2;
}

// Transforms a Vector3 by a given Matrix
fn Vector3 vector3_transform(Vector3 v, Matrix mat) {
	Vector3 result;

	float x = v.x;
	float y = v.y;
	float z = v.z;

	result.x = mat.m0*x + mat.m4*y + mat.m8*z + mat.m12;
	result.y = mat.m1*x + mat.m5*y + mat.m9*z + mat.m13;
	result.z = mat.m2*x + mat.m6*y + mat.m10*z + mat.m14;

	return result;
}

// Transform a vector by quaternion rotation
fn Vector3 vector3_rotate_by_quaternion(Vector3 v, Quaternion q) {
	Vector3 result;

	result.x = v.x*(q.x*q.x + q.w*q.w - q.y*q.y - q.z*q.z) + v.y*(2*q.x*q.y - 2*q.w*q.z) + v.z*(2*q.x*q.z + 2*q.w*q.y);
	result.y = v.x*(2*q.w*q.z + 2*q.x*q.y) + v.y*(q.w*q.w - q.x*q.x + q.y*q.y - q.z*q.z) + v.z*(-2*q.w*q.x + 2*q.y*q.z);
	result.z = v.x*(-2*q.w*q.y + 2*q.x*q.z) + v.y*(2*q.w*q.x + 2*q.y*q.z)+ v.z*(q.w*q.w - q.x*q.x - q.y*q.y + q.z*q.z);

	return result;
}

// Rotates a vector around an axis
fn Vector3 vector3_rotate_by_axis_angle(Vector3 v, Vector3 axis, float angle) {
	// Using Euler-Rodrigues Formula
	// Ref.: https://en.wikipedia.org/w/index.php?title=Euler%E2%80%93Rodrigues_formula

	Vector3 result = v;

	// vector3_Normalize(axis);
	float length = math::sqrt(axis.x*axis.x + axis.y*axis.y + axis.z*axis.z);
	if (length == 0.0f) length = 1.0f;
	float ilength = 1.0f / length;
	axis.x *= ilength;
	axis.y *= ilength;
	axis.z *= ilength;

	angle /= 2.0f;
	float a = math::sin(angle);
	float b = axis.x*a;
	float c = axis.y*a;
	float d = axis.z*a;
	a = math::cos(angle);
	Vector3 w = { b, c, d };

	// vector3_CrossProduct(w, v)
	Vector3 wv = { w.y*v.z - w.z*v.y, w.z*v.x - w.x*v.z, w.x*v.y - w.y*v.x };

	// vector3_CrossProduct(w, wv)
	Vector3 wwv = { w.y*wv.z - w.z*wv.y, w.z*wv.x - w.x*wv.z, w.x*wv.y - w.y*wv.x };

	// vector3_Scale(wv, 2*a)
	a *= 2;
	wv.x *= a;
	wv.y *= a;
	wv.z *= a;

	// vector3_Scale(wwv, 2)
	wwv.x *= 2;
	wwv.y *= 2;
	wwv.z *= 2;

	result.x += wv.x;
	result.y += wv.y;
	result.z += wv.z;

	result.x += wwv.x;
	result.y += wwv.y;
	result.z += wwv.z;

	return result;
}

// Calculate linear interpolation between two vectors
fn Vector3 vector3_lerp(Vector3 v1, Vector3 v2, float amount) {
	Vector3 result;

	result.x = v1.x + amount*(v2.x - v1.x);
	result.y = v1.y + amount*(v2.y - v1.y);
	result.z = v1.z + amount*(v2.z - v1.z);

	return result;
}

// Calculate reflected vector to normal
fn Vector3 vector3_reflect(Vector3 v, Vector3 normal) {
	Vector3 result;

	// I is the original vector
	// N is the normal of the incident plane
	// R = I - (2*N*(DotProduct[I, N]))

	float dotProduct = (v.x*normal.x + v.y*normal.y + v.z*normal.z);

	result.x = v.x - (2.0f*normal.x)*dotProduct;
	result.y = v.y - (2.0f*normal.y)*dotProduct;
	result.z = v.z - (2.0f*normal.z)*dotProduct;

	return result;
}

// Get min value for each pair of components
fn Vector3 vector3_min(Vector3 v1, Vector3 v2) {
	Vector3 result;

	result.x = math::min(v1.x, v2.x);
	result.y = math::min(v1.y, v2.y);
	result.z = math::min(v1.z, v2.z);

	return result;
}

// Get max value for each pair of components
fn Vector3 vector3_max(Vector3 v1, Vector3 v2) {
	Vector3 result;

	result.x = math::max(v1.x, v2.x);
	result.y = math::max(v1.y, v2.y);
	result.z = math::max(v1.z, v2.z);

	return result;
}

// Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c)
// NOTE: Assumes P is on the plane of the triangle
fn Vector3 vector3_barycenter(Vector3 p, Vector3 a, Vector3 b, Vector3 c) {
	Vector3 result;

	Vector3 v0 = { b.x - a.x, b.y - a.y, b.z - a.z };   // vector3_Subtract(b, a)
	Vector3 v1 = { c.x - a.x, c.y - a.y, c.z - a.z };   // vector3_Subtract(c, a)
	Vector3 v2 = { p.x - a.x, p.y - a.y, p.z - a.z };   // vector3_Subtract(p, a)
	float d00 = (v0.x*v0.x + v0.y*v0.y + v0.z*v0.z);	// vector3_DotProduct(v0, v0)
	float d01 = (v0.x*v1.x + v0.y*v1.y + v0.z*v1.z);	// vector3_DotProduct(v0, v1)
	float d11 = (v1.x*v1.x + v1.y*v1.y + v1.z*v1.z);	// vector3_DotProduct(v1, v1)
	float d20 = (v2.x*v0.x + v2.y*v0.y + v2.z*v0.z);	// vector3_DotProduct(v2, v0)
	float d21 = (v2.x*v1.x + v2.y*v1.y + v2.z*v1.z);	// vector3_DotProduct(v2, v1)

	float denom = d00*d11 - d01*d01;

	result.y = (d11*d20 - d01*d21)/denom;
	result.z = (d00*d21 - d01*d20)/denom;
	result.x = 1.0f - (result.z + result.y);

	return result;
}

// Projects a Vector3 from screen space into object space
// NOTE: We are avoiding calling other raymath functions despite available
fn Vector3 vector3_unproject(Vector3 source, Matrix projection, Matrix view) {
	Vector3 result;

	// Calculate unprojected matrix (multiply view matrix by projection matrix) and invert it
	Matrix matViewProj = {	  // MatrixMultiply(view, projection);
		view.m0*projection.m0 + view.m1*projection.m4 + view.m2*projection.m8 + view.m3*projection.m12,
		view.m0*projection.m1 + view.m1*projection.m5 + view.m2*projection.m9 + view.m3*projection.m13,
		view.m0*projection.m2 + view.m1*projection.m6 + view.m2*projection.m10 + view.m3*projection.m14,
		view.m0*projection.m3 + view.m1*projection.m7 + view.m2*projection.m11 + view.m3*projection.m15,
		view.m4*projection.m0 + view.m5*projection.m4 + view.m6*projection.m8 + view.m7*projection.m12,
		view.m4*projection.m1 + view.m5*projection.m5 + view.m6*projection.m9 + view.m7*projection.m13,
		view.m4*projection.m2 + view.m5*projection.m6 + view.m6*projection.m10 + view.m7*projection.m14,
		view.m4*projection.m3 + view.m5*projection.m7 + view.m6*projection.m11 + view.m7*projection.m15,
		view.m8*projection.m0 + view.m9*projection.m4 + view.m10*projection.m8 + view.m11*projection.m12,
		view.m8*projection.m1 + view.m9*projection.m5 + view.m10*projection.m9 + view.m11*projection.m13,
		view.m8*projection.m2 + view.m9*projection.m6 + view.m10*projection.m10 + view.m11*projection.m14,
		view.m8*projection.m3 + view.m9*projection.m7 + view.m10*projection.m11 + view.m11*projection.m15,
		view.m12*projection.m0 + view.m13*projection.m4 + view.m14*projection.m8 + view.m15*projection.m12,
		view.m12*projection.m1 + view.m13*projection.m5 + view.m14*projection.m9 + view.m15*projection.m13,
		view.m12*projection.m2 + view.m13*projection.m6 + view.m14*projection.m10 + view.m15*projection.m14,
		view.m12*projection.m3 + view.m13*projection.m7 + view.m14*projection.m11 + view.m15*projection.m15 };

	// Calculate inverted matrix . MatrixInvert(matViewProj);
	// Cache the matrix values (speed optimization)
	float a00 = matViewProj.m0;
	float a01 = matViewProj.m1;
	float a02 = matViewProj.m2;
	float a03 = matViewProj.m3;
	float a10 = matViewProj.m4;
	float a11 = matViewProj.m5;
	float a12 = matViewProj.m6;
	float a13 = matViewProj.m7;
	float a20 = matViewProj.m8;
	float a21 = matViewProj.m9;
	float a22 = matViewProj.m10;
	float a23 = matViewProj.m11;
	float a30 = matViewProj.m12;
	float a31 = matViewProj.m13;
	float a32 = matViewProj.m14;
	float a33 = matViewProj.m15;

	float b00 = a00*a11 - a01*a10;
	float b01 = a00*a12 - a02*a10;
	float b02 = a00*a13 - a03*a10;
	float b03 = a01*a12 - a02*a11;
	float b04 = a01*a13 - a03*a11;
	float b05 = a02*a13 - a03*a12;
	float b06 = a20*a31 - a21*a30;
	float b07 = a20*a32 - a22*a30;
	float b08 = a20*a33 - a23*a30;
	float b09 = a21*a32 - a22*a31;
	float b10 = a21*a33 - a23*a31;
	float b11 = a22*a33 - a23*a32;

	// Calculate the invert determinant (inlined to avoid double-caching)
	float invDet = 1.0f/(b00*b11 - b01*b10 + b02*b09 + b03*b08 - b04*b07 + b05*b06);

	Matrix matViewProjInv = {
		(a11*b11 - a12*b10 + a13*b09)*invDet,
		(-a01*b11 + a02*b10 - a03*b09)*invDet,
		(a31*b05 - a32*b04 + a33*b03)*invDet,
		(-a21*b05 + a22*b04 - a23*b03)*invDet,
		(-a10*b11 + a12*b08 - a13*b07)*invDet,
		(a00*b11 - a02*b08 + a03*b07)*invDet,
		(-a30*b05 + a32*b02 - a33*b01)*invDet,
		(a20*b05 - a22*b02 + a23*b01)*invDet,
		(a10*b10 - a11*b08 + a13*b06)*invDet,
		(-a00*b10 + a01*b08 - a03*b06)*invDet,
		(a30*b04 - a31*b02 + a33*b00)*invDet,
		(-a20*b04 + a21*b02 - a23*b00)*invDet,
		(-a10*b09 + a11*b07 - a12*b06)*invDet,
		(a00*b09 - a01*b07 + a02*b06)*invDet,
		(-a30*b03 + a31*b01 - a32*b00)*invDet,
		(a20*b03 - a21*b01 + a22*b00)*invDet };

	// Create quaternion from source point
	Quaternion quat = { source.x, source.y, source.z, 1.0f };

	// Multiply quat point by unprojecte matrix
	Quaternion qtransformed = {	 // QuaternionTransform(quat, matViewProjInv)
		matViewProjInv.m0*quat.x + matViewProjInv.m4*quat.y + matViewProjInv.m8*quat.z + matViewProjInv.m12*quat.w,
		matViewProjInv.m1*quat.x + matViewProjInv.m5*quat.y + matViewProjInv.m9*quat.z + matViewProjInv.m13*quat.w,
		matViewProjInv.m2*quat.x + matViewProjInv.m6*quat.y + matViewProjInv.m10*quat.z + matViewProjInv.m14*quat.w,
		matViewProjInv.m3*quat.x + matViewProjInv.m7*quat.y + matViewProjInv.m11*quat.z + matViewProjInv.m15*quat.w };

	// Normalized world points in vectors
	result.x = qtransformed.x/qtransformed.w;
	result.y = qtransformed.y/qtransformed.w;
	result.z = qtransformed.z/qtransformed.w;

	return result;
}

// Get Vector3 as float array
fn vector::Vec3 vector3_to_vec3(Vector3 v) { // counterpart to Vector3ToFloatV
	vector::Vec3 buffer;

	buffer.x = v.x;
	buffer.y = v.y;
	buffer.z = v.z;

	return buffer;
}

fn vector::Vec3f vector3_to_vec3f(Vector3 v) { // counterpart to Vector3ToFloatV
	vector::Vec3f buffer;

	buffer.x = v.x;
	buffer.y = v.y;
	buffer.z = v.z;

	return buffer;
}

// Invert the given vector
fn Vector3 vector3_invert(Vector3 v) {
	Vector3 result = { 1.0f/v.x, 1.0f/v.y, 1.0f/v.z };

	return result;
}

// Clamp the components of the vector between
// min and max values specified by the given vectors
fn Vector3 vector3_clamp(Vector3 v, Vector3 min, Vector3 max) {
	Vector3 result;

	result.x = math::min(max.x, math::max(min.x, v.x));
	result.y = math::min(max.y, math::max(min.y, v.y));
	result.z = math::min(max.z, math::max(min.z, v.z));

	return result;
}

// Clamp the magnitude of the vector between two values
fn Vector3 vector3_clamp_value(Vector3 v, float min, float max) {
	Vector3 result = v;

	float length = (v.x*v.x) + (v.y*v.y) + (v.z*v.z);
	if (length > 0.0f)
	{
		length = math::sqrt(length);

		if (length < min)
		{
			float scale = min/length;
			result.x = v.x*scale;
			result.y = v.y*scale;
			result.z = v.z*scale;
		}
		else if (length > max)
		{
			float scale = max/length;
			result.x = v.x*scale;
			result.y = v.y*scale;
			result.z = v.z*scale;
		}
	}

	return result;
}

// Check whether two given vectors are almost equal
fn bool vector3_equals(Vector3 p, Vector3 q) {
	bool result = ((math::abs(p.x - q.x)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.x), math::abs(q.x))))) &&
				 ((math::abs(p.y - q.y)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.y), math::abs(q.y))))) &&
				 ((math::abs(p.z - q.z)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.z), math::abs(q.z)))));

	return result;
}

// Compute the direction of a refracted ray
// v: normalized direction of the incoming ray
// n: normalized normal vector of the interface of two optical media
// r: ratio of the refractive index of the medium from where the ray comes
//	to the refractive index of the medium on the other side of the surface
fn Vector3 vector3_refract(Vector3 v, Vector3 n, float r) {
	Vector3 result;

	float dot = v.x*n.x + v.y*n.y + v.z*n.z;
	float d = 1.0f - r*r*(1.0f - dot*dot);

	if (d >= 0.0f)
	{
		d = math::sqrt(d);
		v.x = r*v.x - (r*dot + d)*n.x;
		v.y = r*v.y - (r*dot + d)*n.y;
		v.z = r*v.z - (r*dot + d)*n.z;

		result = v;
	}

	return result;
}

//----------------------------------------------------------------------------------
// Module Functions Definition - Matrix math
//----------------------------------------------------------------------------------

// Compute matrix determinant
fn float matrix_determinant(Matrix mat) {
	float result = 0.0f;

	// Cache the matrix values (speed optimization)
	float a00 = mat.m0;
	float a01 = mat.m1;
	float a02 = mat.m2;
	float a03 = mat.m3;
	float a10 = mat.m4;
	float a11 = mat.m5;
	float a12 = mat.m6;
	float a13 = mat.m7;
	float a20 = mat.m8;
	float a21 = mat.m9;
	float a22 = mat.m10;
	float a23 = mat.m11;
	float a30 = mat.m12;
	float a31 = mat.m13;
	float a32 = mat.m14;
	float a33 = mat.m15;

	result = a30*a21*a12*a03 - a20*a31*a12*a03 - a30*a11*a22*a03 + a10*a31*a22*a03 +
			 a20*a11*a32*a03 - a10*a21*a32*a03 - a30*a21*a02*a13 + a20*a31*a02*a13 +
			 a30*a01*a22*a13 - a00*a31*a22*a13 - a20*a01*a32*a13 + a00*a21*a32*a13 +
			 a30*a11*a02*a23 - a10*a31*a02*a23 - a30*a01*a12*a23 + a00*a31*a12*a23 +
			 a10*a01*a32*a23 - a00*a11*a32*a23 - a20*a11*a02*a33 + a10*a21*a02*a33 +
			 a20*a01*a12*a33 - a00*a21*a12*a33 - a10*a01*a22*a33 + a00*a11*a22*a33;

	return result;
}

// Get the trace of the matrix (sum of the values along the diagonal)
fn float matrix_trace(Matrix mat) {
	float result = (mat.m0 + mat.m5 + mat.m10 + mat.m15);

	return result;
}

// Transposes provided matrix
fn Matrix matrix_transpose(Matrix mat) {
	Matrix result;

	result.m0 = mat.m0;
	result.m1 = mat.m4;
	result.m2 = mat.m8;
	result.m3 = mat.m12;
	result.m4 = mat.m1;
	result.m5 = mat.m5;
	result.m6 = mat.m9;
	result.m7 = mat.m13;
	result.m8 = mat.m2;
	result.m9 = mat.m6;
	result.m10 = mat.m10;
	result.m11 = mat.m14;
	result.m12 = mat.m3;
	result.m13 = mat.m7;
	result.m14 = mat.m11;
	result.m15 = mat.m15;

	return result;
}

// Invert provided matrix
fn Matrix matrix_invert(Matrix mat) {
	Matrix result;

	// Cache the matrix values (speed optimization)
	float a00 = mat.m0;
	float a01 = mat.m1;
	float a02 = mat.m2;
	float a03 = mat.m3;
	float a10 = mat.m4;
	float a11 = mat.m5;
	float a12 = mat.m6;
	float a13 = mat.m7;
	float a20 = mat.m8;
	float a21 = mat.m9;
	float a22 = mat.m10;
	float a23 = mat.m11;
	float a30 = mat.m12;
	float a31 = mat.m13;
	float a32 = mat.m14;
	float a33 = mat.m15;

	float b00 = a00*a11 - a01*a10;
	float b01 = a00*a12 - a02*a10;
	float b02 = a00*a13 - a03*a10;
	float b03 = a01*a12 - a02*a11;
	float b04 = a01*a13 - a03*a11;
	float b05 = a02*a13 - a03*a12;
	float b06 = a20*a31 - a21*a30;
	float b07 = a20*a32 - a22*a30;
	float b08 = a20*a33 - a23*a30;
	float b09 = a21*a32 - a22*a31;
	float b10 = a21*a33 - a23*a31;
	float b11 = a22*a33 - a23*a32;

	// Calculate the invert determinant (inlined to avoid double-caching)
	float invDet = 1.0f/(b00*b11 - b01*b10 + b02*b09 + b03*b08 - b04*b07 + b05*b06);

	result.m0 = (a11*b11 - a12*b10 + a13*b09)*invDet;
	result.m1 = (-a01*b11 + a02*b10 - a03*b09)*invDet;
	result.m2 = (a31*b05 - a32*b04 + a33*b03)*invDet;
	result.m3 = (-a21*b05 + a22*b04 - a23*b03)*invDet;
	result.m4 = (-a10*b11 + a12*b08 - a13*b07)*invDet;
	result.m5 = (a00*b11 - a02*b08 + a03*b07)*invDet;
	result.m6 = (-a30*b05 + a32*b02 - a33*b01)*invDet;
	result.m7 = (a20*b05 - a22*b02 + a23*b01)*invDet;
	result.m8 = (a10*b10 - a11*b08 + a13*b06)*invDet;
	result.m9 = (-a00*b10 + a01*b08 - a03*b06)*invDet;
	result.m10 = (a30*b04 - a31*b02 + a33*b00)*invDet;
	result.m11 = (-a20*b04 + a21*b02 - a23*b00)*invDet;
	result.m12 = (-a10*b09 + a11*b07 - a12*b06)*invDet;
	result.m13 = (a00*b09 - a01*b07 + a02*b06)*invDet;
	result.m14 = (-a30*b03 + a31*b01 - a32*b00)*invDet;
	result.m15 = (a20*b03 - a21*b01 + a22*b00)*invDet;

	return result;
}

// Get identity matrix
fn Matrix matrix_identity() {
	Matrix result = { 1.0f, 0.0f, 0.0f, 0.0f,
					  0.0f, 1.0f, 0.0f, 0.0f,
					  0.0f, 0.0f, 1.0f, 0.0f,
					  0.0f, 0.0f, 0.0f, 1.0f };

	return result;
}

// Add two matrices
fn Matrix matrix_add(Matrix left, Matrix right) {
	Matrix result;

	result.m0 = left.m0 + right.m0;
	result.m1 = left.m1 + right.m1;
	result.m2 = left.m2 + right.m2;
	result.m3 = left.m3 + right.m3;
	result.m4 = left.m4 + right.m4;
	result.m5 = left.m5 + right.m5;
	result.m6 = left.m6 + right.m6;
	result.m7 = left.m7 + right.m7;
	result.m8 = left.m8 + right.m8;
	result.m9 = left.m9 + right.m9;
	result.m10 = left.m10 + right.m10;
	result.m11 = left.m11 + right.m11;
	result.m12 = left.m12 + right.m12;
	result.m13 = left.m13 + right.m13;
	result.m14 = left.m14 + right.m14;
	result.m15 = left.m15 + right.m15;

	return result;
}

// Subtract two matrices (left - right)
fn Matrix matrix_subtract(Matrix left, Matrix right) {
	Matrix result;

	result.m0 = left.m0 - right.m0;
	result.m1 = left.m1 - right.m1;
	result.m2 = left.m2 - right.m2;
	result.m3 = left.m3 - right.m3;
	result.m4 = left.m4 - right.m4;
	result.m5 = left.m5 - right.m5;
	result.m6 = left.m6 - right.m6;
	result.m7 = left.m7 - right.m7;
	result.m8 = left.m8 - right.m8;
	result.m9 = left.m9 - right.m9;
	result.m10 = left.m10 - right.m10;
	result.m11 = left.m11 - right.m11;
	result.m12 = left.m12 - right.m12;
	result.m13 = left.m13 - right.m13;
	result.m14 = left.m14 - right.m14;
	result.m15 = left.m15 - right.m15;

	return result;
}

// Get two matrix multiplication
// NOTE: When multiplying matrices... the order matters!
fn Matrix matrix_multiply(Matrix left, Matrix right) {
	Matrix result;

	result.m0 = left.m0*right.m0 + left.m1*right.m4 + left.m2*right.m8 + left.m3*right.m12;
	result.m1 = left.m0*right.m1 + left.m1*right.m5 + left.m2*right.m9 + left.m3*right.m13;
	result.m2 = left.m0*right.m2 + left.m1*right.m6 + left.m2*right.m10 + left.m3*right.m14;
	result.m3 = left.m0*right.m3 + left.m1*right.m7 + left.m2*right.m11 + left.m3*right.m15;
	result.m4 = left.m4*right.m0 + left.m5*right.m4 + left.m6*right.m8 + left.m7*right.m12;
	result.m5 = left.m4*right.m1 + left.m5*right.m5 + left.m6*right.m9 + left.m7*right.m13;
	result.m6 = left.m4*right.m2 + left.m5*right.m6 + left.m6*right.m10 + left.m7*right.m14;
	result.m7 = left.m4*right.m3 + left.m5*right.m7 + left.m6*right.m11 + left.m7*right.m15;
	result.m8 = left.m8*right.m0 + left.m9*right.m4 + left.m10*right.m8 + left.m11*right.m12;
	result.m9 = left.m8*right.m1 + left.m9*right.m5 + left.m10*right.m9 + left.m11*right.m13;
	result.m10 = left.m8*right.m2 + left.m9*right.m6 + left.m10*right.m10 + left.m11*right.m14;
	result.m11 = left.m8*right.m3 + left.m9*right.m7 + left.m10*right.m11 + left.m11*right.m15;
	result.m12 = left.m12*right.m0 + left.m13*right.m4 + left.m14*right.m8 + left.m15*right.m12;
	result.m13 = left.m12*right.m1 + left.m13*right.m5 + left.m14*right.m9 + left.m15*right.m13;
	result.m14 = left.m12*right.m2 + left.m13*right.m6 + left.m14*right.m10 + left.m15*right.m14;
	result.m15 = left.m12*right.m3 + left.m13*right.m7 + left.m14*right.m11 + left.m15*right.m15;

	return result;
}

// Get translation matrix
fn Matrix matrix_translate(float x, float y, float z) {
	Matrix result = { 1.0f, 0.0f, 0.0f, x,
					  0.0f, 1.0f, 0.0f, y,
					  0.0f, 0.0f, 1.0f, z,
					  0.0f, 0.0f, 0.0f, 1.0f };

	return result;
}

// Create rotation matrix from axis and angle
// NOTE: Angle should be provided in radians
fn Matrix matrix_rotate(Vector3 axis, float angle) {
	Matrix result;

	float x = axis.x;
	float y = axis.y;
	float z = axis.z;

	float lengthSquared = x*x + y*y + z*z;

	if ((lengthSquared != 1.0f) && (lengthSquared != 0.0f))
	{
		float ilength = 1.0f/math::sqrt(lengthSquared);
		x *= ilength;
		y *= ilength;
		z *= ilength;
	}

	float sinres = math::sin(angle);
	float cosres = math::cos(angle);
	float t = 1.0f - cosres;

	result.m0 = x*x*t + cosres;
	result.m1 = y*x*t + z*sinres;
	result.m2 = z*x*t - y*sinres;
	result.m3 = 0.0f;

	result.m4 = x*y*t - z*sinres;
	result.m5 = y*y*t + cosres;
	result.m6 = z*y*t + x*sinres;
	result.m7 = 0.0f;

	result.m8 = x*z*t + y*sinres;
	result.m9 = y*z*t - x*sinres;
	result.m10 = z*z*t + cosres;
	result.m11 = 0.0f;

	result.m12 = 0.0f;
	result.m13 = 0.0f;
	result.m14 = 0.0f;
	result.m15 = 1.0f;

	return result;
}

// Get x-rotation matrix
// NOTE: Angle must be provided in radians
fn Matrix matrix_rotate_x(float angle) {
	Matrix result = { 1.0f, 0.0f, 0.0f, 0.0f,
					  0.0f, 1.0f, 0.0f, 0.0f,
					  0.0f, 0.0f, 1.0f, 0.0f,
					  0.0f, 0.0f, 0.0f, 1.0f }; // MatrixIdentity()

	float cosres = math::cos(angle);
	float sinres = math::sin(angle);

	result.m5 = cosres;
	result.m6 = sinres;
	result.m9 = -sinres;
	result.m10 = cosres;

	return result;
}

// Get y-rotation matrix
// NOTE: Angle must be provided in radians
fn Matrix matrix_rotate_y(float angle) {
	Matrix result = { 1.0f, 0.0f, 0.0f, 0.0f,
					  0.0f, 1.0f, 0.0f, 0.0f,
					  0.0f, 0.0f, 1.0f, 0.0f,
					  0.0f, 0.0f, 0.0f, 1.0f }; // MatrixIdentity()

	float cosres = math::cos(angle);
	float sinres = math::sin(angle);

	result.m0 = cosres;
	result.m2 = -sinres;
	result.m8 = sinres;
	result.m10 = cosres;

	return result;
}

// Get z-rotation matrix
// NOTE: Angle must be provided in radians
fn Matrix matrix_rotate_z(float angle) {
	Matrix result = { 1.0f, 0.0f, 0.0f, 0.0f,
					  0.0f, 1.0f, 0.0f, 0.0f,
					  0.0f, 0.0f, 1.0f, 0.0f,
					  0.0f, 0.0f, 0.0f, 1.0f }; // MatrixIdentity()

	float cosres = math::cos(angle);
	float sinres = math::sin(angle);

	result.m0 = cosres;
	result.m1 = sinres;
	result.m4 = -sinres;
	result.m5 = cosres;

	return result;
}


// Get xyz-rotation matrix
// NOTE: Angle must be provided in radians
fn Matrix matrix_rotate_x_y_z(Vector3 angle) {
	Matrix result = { 1.0f, 0.0f, 0.0f, 0.0f,
					  0.0f, 1.0f, 0.0f, 0.0f,
					  0.0f, 0.0f, 1.0f, 0.0f,
					  0.0f, 0.0f, 0.0f, 1.0f }; // MatrixIdentity()

	float cosz = math::cos(-angle.z);
	float sinz = math::sin(-angle.z);
	float cosy = math::cos(-angle.y);
	float siny = math::sin(-angle.y);
	float cosx = math::cos(-angle.x);
	float sinx = math::sin(-angle.x);

	result.m0 = cosz*cosy;
	result.m1 = (cosz*siny*sinx) - (sinz*cosx);
	result.m2 = (cosz*siny*cosx) + (sinz*sinx);

	result.m4 = sinz*cosy;
	result.m5 = (sinz*siny*sinx) + (cosz*cosx);
	result.m6 = (sinz*siny*cosx) - (cosz*sinx);

	result.m8 = -siny;
	result.m9 = cosy*sinx;
	result.m10= cosy*cosx;

	return result;
}

// Get zyx-rotation matrix
// NOTE: Angle must be provided in radians
fn Matrix matrix_rotate_z_y_x(Vector3 angle) {
	Matrix result;

	float cz = math::cos(angle.z);
	float sz = math::sin(angle.z);
	float cy = math::cos(angle.y);
	float sy = math::sin(angle.y);
	float cx = math::cos(angle.x);
	float sx = math::sin(angle.x);

	result.m0 = cz*cy;
	result.m4 = cz*sy*sx - cx*sz;
	result.m8 = sz*sx + cz*cx*sy;
	result.m12 = 0;

	result.m1 = cy*sz;
	result.m5 = cz*cx + sz*sy*sx;
	result.m9 = cx*sz*sy - cz*sx;
	result.m13 = 0;

	result.m2 = -sy;
	result.m6 = cy*sx;
	result.m10 = cy*cx;
	result.m14 = 0;

	result.m3 = 0;
	result.m7 = 0;
	result.m11 = 0;
	result.m15 = 1;

	return result;
}

// Get scaling matrix
fn Matrix matrix_scale(float x, float y, float z) {
	Matrix result = { x, 0.0f, 0.0f, 0.0f,
					  0.0f, y, 0.0f, 0.0f,
					  0.0f, 0.0f, z, 0.0f,
					  0.0f, 0.0f, 0.0f, 1.0f };

	return result;
}

// Get perspective projection matrix
fn Matrix matrix_frustum(double left, double right, double bottom, double top, double near, double far) {
	Matrix result;

	float rl = (float)(right - left);
	float tb = (float)(top - bottom);
	float fmn = (float)(far - near); // fmn = far minus near

	result.m0 = ((float)near*2.0f)/rl;
	result.m1 = 0.0f;
	result.m2 = 0.0f;
	result.m3 = 0.0f;

	result.m4 = 0.0f;
	result.m5 = ((float)near*2.0f)/tb;
	result.m6 = 0.0f;
	result.m7 = 0.0f;

	result.m8 = ((float)right + (float)left)/rl;
	result.m9 = ((float)top + (float)bottom)/tb;
	result.m10 = -((float)far + (float)near)/fmn;
	result.m11 = -1.0f;

	result.m12 = 0.0f;
	result.m13 = 0.0f;
	result.m14 = -((float)far*(float)near*2.0f)/fmn;
	result.m15 = 0.0f;

	return result;
}

// Get perspective projection matrix
// NOTE: Fovy angle must be provided in radians
fn Matrix matrix_perspective(double fovY, double aspect, double nearPlane, double farPlane) {
	Matrix result;

	double top = nearPlane*math::tan(fovY*0.5);
	double bottom = -top;
	double right = top*aspect;
	double left = -right;

	// MatrixFrustum(-right, right, -top, top, near, far);
	float rl = (float)(right - left);
	float tb = (float)(top - bottom);
	float fmn = (float)(farPlane - nearPlane); // fmn = farPlane minus nearPlane

	result.m0 = ((float)nearPlane*2.0f)/rl;
	result.m5 = ((float)nearPlane*2.0f)/tb;
	result.m8 = ((float)right + (float)left)/rl;
	result.m9 = ((float)top + (float)bottom)/tb;
	result.m10 = -((float)farPlane + (float)nearPlane)/fmn;
	result.m11 = -1.0f;
	result.m14 = -((float)farPlane*(float)nearPlane*2.0f)/fmn;

	return result;
}

// Get orthographic projection matrix
fn Matrix matrix_ortho(double left, double right, double bottom, double top, double nearPlane, double farPlane) {
	Matrix result;

	float rl = (float)(right - left);
	float tb = (float)(top - bottom);
	float fmn = (float)(farPlane - nearPlane); // fmn = farPlane minus nearPlane

	result.m0 = 2.0f/rl;
	result.m1 = 0.0f;
	result.m2 = 0.0f;
	result.m3 = 0.0f;
	result.m4 = 0.0f;
	result.m5 = 2.0f/tb;
	result.m6 = 0.0f;
	result.m7 = 0.0f;
	result.m8 = 0.0f;
	result.m9 = 0.0f;
	result.m10 = -2.0f/fmn;
	result.m11 = 0.0f;
	result.m12 = -((float)left + (float)right)/rl;
	result.m13 = -((float)top + (float)bottom)/tb;
	result.m14 = -((float)farPlane + (float)nearPlane)/fmn;
	result.m15 = 1.0f;

	return result;
}

// Get camera look-at matrix (view matrix)
fn Matrix matrix_look_at(Vector3 eye, Vector3 target, Vector3 up) {
	Matrix result;

	float length = 0.0f;
	float ilength = 0.0f;

	// vector3_Subtract(eye, target)
	Vector3 vz = { eye.x - target.x, eye.y - target.y, eye.z - target.z };

	// vector3_Normalize(vz)
	Vector3 v = vz;
	length = math::sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
	if (length == 0.0f) length = 1.0f;
	ilength = 1.0f/length;
	vz.x *= ilength;
	vz.y *= ilength;
	vz.z *= ilength;

	// vector3_CrossProduct(up, vz)
	Vector3 vx = { up.y*vz.z - up.z*vz.y, up.z*vz.x - up.x*vz.z, up.x*vz.y - up.y*vz.x };

	// vector3_Normalize(x)
	v = vx;
	length = math::sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
	if (length == 0.0f) length = 1.0f;
	ilength = 1.0f/length;
	vx.x *= ilength;
	vx.y *= ilength;
	vx.z *= ilength;

	// vector3_CrossProduct(vz, vx)
	Vector3 vy = { vz.y*vx.z - vz.z*vx.y, vz.z*vx.x - vz.x*vx.z, vz.x*vx.y - vz.y*vx.x };

	result.m0 = vx.x;
	result.m1 = vy.x;
	result.m2 = vz.x;
	result.m3 = 0.0f;
	result.m4 = vx.y;
	result.m5 = vy.y;
	result.m6 = vz.y;
	result.m7 = 0.0f;
	result.m8 = vx.z;
	result.m9 = vy.z;
	result.m10 = vz.z;
	result.m11 = 0.0f;
	result.m12 = -(vx.x*eye.x + vx.y*eye.y + vx.z*eye.z);   // vector3_DotProduct(vx, eye)
	result.m13 = -(vy.x*eye.x + vy.y*eye.y + vy.z*eye.z);   // vector3_DotProduct(vy, eye)
	result.m14 = -(vz.x*eye.x + vz.y*eye.y + vz.z*eye.z);   // vector3_DotProduct(vz, eye)
	result.m15 = 1.0f;

	return result;
}

// Get float array of matrix data
fn Float16 matrix_to_float_v(Matrix mat) {
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

fn Quaternionf quaternion_to_quatf(Quaternion q) {
	Quaternionf result = { q.x, q.y, q.z, q.w };

	return result;
}

// Add two quaternions
fn Quaternion quaternion_add(Quaternion q1, Quaternion q2) {
	Quaternion result = {q1.x + q2.x, q1.y + q2.y, q1.z + q2.z, q1.w + q2.w};

	return result;
}

// Add quaternion and float value
fn Quaternion quaternion_add_value(Quaternion q, float add) {
	Quaternion result = {q.x + add, q.y + add, q.z + add, q.w + add};

	return result;
}

// Subtract two quaternions
fn Quaternion quaternion_subtract(Quaternion q1, Quaternion q2) {
	Quaternion result = {q1.x - q2.x, q1.y - q2.y, q1.z - q2.z, q1.w - q2.w};

	return result;
}

// Subtract quaternion and float value
fn Quaternion quaternion_subtract_value(Quaternion q, float sub) {
	Quaternion result = {q.x - sub, q.y - sub, q.z - sub, q.w - sub};

	return result;
}

// Get identity quaternion
fn Quaternion quaternion_identity() {
	Quaternion result = { 0.0f, 0.0f, 0.0f, 1.0f };

	return result;
}

// Computes the length of a quaternion
fn float quaternion_length(Quaternion q) {
	float result = math::sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);

	return result;
}

// Normalize provided quaternion
fn Quaternion quaternion_normalize(Quaternion q) {
	Quaternion result;

	float length = math::sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
	if (length == 0.0f) length = 1.0f;
	float ilength = 1.0f/length;

	result.x = q.x*ilength;
	result.y = q.y*ilength;
	result.z = q.z*ilength;
	result.w = q.w*ilength;

	return result;
}

// Invert provided quaternion
fn Quaternion quaternion_invert(Quaternion q) {
	Quaternion result = q;

	float lengthSq = q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w;

	if (lengthSq != 0.0f)
	{
		float invLength = 1.0f/lengthSq;

		result.x *= -invLength;
		result.y *= -invLength;
		result.z *= -invLength;
		result.w *= invLength;
	}

	return result;
}

// Calculate two quaternion multiplication
fn Quaternion quaternion_multiply(Quaternion q1, Quaternion q2) {
	Quaternion result;

	float qax = q1.x;
	float qay = q1.y;
	float qaz = q1.z;
	float qaw = q1.w;
	float qbx = q2.x;
	float qby = q2.y;
	float qbz = q2.z;
	float qbw = q2.w;

	result.x = qax*qbw + qaw*qbx + qay*qbz - qaz*qby;
	result.y = qay*qbw + qaw*qby + qaz*qbx - qax*qbz;
	result.z = qaz*qbw + qaw*qbz + qax*qby - qay*qbx;
	result.w = qaw*qbw - qax*qbx - qay*qby - qaz*qbz;

	return result;
}

// Scale quaternion by float value
fn Quaternion quaternion_scale(Quaternion q, float mul) {
	Quaternion result;

	result.x = q.x*mul;
	result.y = q.y*mul;
	result.z = q.z*mul;
	result.w = q.w*mul;

	return result;
}

// Divide two quaternions
fn Quaternion quaternion_divide(Quaternion q1, Quaternion q2) {
	Quaternion result = { q1.x/q2.x, q1.y/q2.y, q1.z/q2.z, q1.w/q2.w };

	return result;
}

// Calculate linear interpolation between two quaternions
fn Quaternion quaternion_lerp(Quaternion q1, Quaternion q2, float amount) {
	Quaternion result;

	result.x = q1.x + amount*(q2.x - q1.x);
	result.y = q1.y + amount*(q2.y - q1.y);
	result.z = q1.z + amount*(q2.z - q1.z);
	result.w = q1.w + amount*(q2.w - q1.w);

	return result;
}

// Calculate slerp-optimized interpolation between two quaternions
fn Quaternion quaternion_nlerp(Quaternion q1, Quaternion q2, float amount) {
	Quaternion result;

	// QuaternionLerp(q1, q2, amount)
	result.x = q1.x + amount*(q2.x - q1.x);
	result.y = q1.y + amount*(q2.y - q1.y);
	result.z = q1.z + amount*(q2.z - q1.z);
	result.w = q1.w + amount*(q2.w - q1.w);

	// QuaternionNormalize(q);
	Quaternion q = result;
	float length = math::sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
	if (length == 0.0f) length = 1.0f;
	float ilength = 1.0f/length;

	result.x = q.x*ilength;
	result.y = q.y*ilength;
	result.z = q.z*ilength;
	result.w = q.w*ilength;

	return result;
}

// Calculates spherical linear interpolation between two quaternions
fn Quaternion quaternion_slerp(Quaternion q1, Quaternion q2, float amount) {
	Quaternion result;

	float cosHalfTheta = q1.x*q2.x + q1.y*q2.y + q1.z*q2.z + q1.w*q2.w;

	if (cosHalfTheta < 0)
	{
		q2.x = -q2.x; q2.y = -q2.y; q2.z = -q2.z; q2.w = -q2.w;
		cosHalfTheta = -cosHalfTheta;
	}

	if (math::abs(cosHalfTheta) >= 1.0f) { result = q1; }
	else if (cosHalfTheta > 0.95f) { result = quaternion_nlerp(q1, q2, amount); }
	else
	{
		float halfTheta = math::acos(cosHalfTheta);
		float sinHalfTheta = math::sqrt(1.0f - cosHalfTheta*cosHalfTheta);

		if (math::abs(sinHalfTheta) < EPSILON)
		{
			result.x = (q1.x*0.5f + q2.x*0.5f);
			result.y = (q1.y*0.5f + q2.y*0.5f);
			result.z = (q1.z*0.5f + q2.z*0.5f);
			result.w = (q1.w*0.5f + q2.w*0.5f);
		}
		else
		{
			float ratioA = math::sin((1 - amount)*halfTheta)/sinHalfTheta;
			float ratioB = math::sin(amount*halfTheta)/sinHalfTheta;

			result.x = (q1.x*ratioA + q2.x*ratioB);
			result.y = (q1.y*ratioA + q2.y*ratioB);
			result.z = (q1.z*ratioA + q2.z*ratioB);
			result.w = (q1.w*ratioA + q2.w*ratioB);
		}
	}

	return result;
}

// Calculate quaternion based on the rotation from one vector to another
fn Quaternion quaternion_fromvector3_to_vector3(Vector3 from, Vector3 to) {
	Quaternion result;

	float cos2Theta = (from.x*to.x + from.y*to.y + from.z*to.z);	// vector3_DotProduct(from, to)
	Vector3 cross = { from.y*to.z - from.z*to.y, from.z*to.x - from.x*to.z, from.x*to.y - from.y*to.x }; // vector3_CrossProduct(from, to)

	result.x = cross.x;
	result.y = cross.y;
	result.z = cross.z;
	result.w = 1.0f + cos2Theta;

	// QuaternionNormalize(q);
	// NOTE: Normalize to essentially nlerp the original and identity to 0.5
	Quaternion q = result;
	float length = math::sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
	if (length == 0.0f) length = 1.0f;
	float ilength = 1.0f/length;

	result.x = q.x*ilength;
	result.y = q.y*ilength;
	result.z = q.z*ilength;
	result.w = q.w*ilength;

	return result;
}

// Get a quaternion for a given rotation matrix
fn Quaternion quaternion_from_matrix(Matrix mat) {
	Quaternion result;

	float fourWSquaredMinus1 = mat.m0  + mat.m5 + mat.m10;
	float fourXSquaredMinus1 = mat.m0  - mat.m5 - mat.m10;
	float fourYSquaredMinus1 = mat.m5  - mat.m0 - mat.m10;
	float fourZSquaredMinus1 = mat.m10 - mat.m0 - mat.m5;

	int biggestIndex = 0;
	float fourBiggestSquaredMinus1 = fourWSquaredMinus1;
	if (fourXSquaredMinus1 > fourBiggestSquaredMinus1)
	{
		fourBiggestSquaredMinus1 = fourXSquaredMinus1;
		biggestIndex = 1;
	}

	if (fourYSquaredMinus1 > fourBiggestSquaredMinus1)
	{
		fourBiggestSquaredMinus1 = fourYSquaredMinus1;
		biggestIndex = 2;
	}

	if (fourZSquaredMinus1 > fourBiggestSquaredMinus1)
	{
		fourBiggestSquaredMinus1 = fourZSquaredMinus1;
		biggestIndex = 3;
	}

	float biggestVal = math::sqrt(fourBiggestSquaredMinus1 + 1.0f)*0.5f;
	float mult = 0.25f / biggestVal;

	switch (biggestIndex)
	{
		case 0:
			result.w = biggestVal;
			result.x = (mat.m6 - mat.m9)*mult;
			result.y = (mat.m8 - mat.m2)*mult;
			result.z = (mat.m1 - mat.m4)*mult;
			break;
		case 1:
			result.x = biggestVal;
			result.w = (mat.m6 - mat.m9)*mult;
			result.y = (mat.m1 + mat.m4)*mult;
			result.z = (mat.m8 + mat.m2)*mult;
			break;
		case 2:
			result.y = biggestVal;
			result.w = (mat.m8 - mat.m2)*mult;
			result.x = (mat.m1 + mat.m4)*mult;
			result.z = (mat.m6 + mat.m9)*mult;
			break;
		case 3:
			result.z = biggestVal;
			result.w = (mat.m1 - mat.m4)*mult;
			result.x = (mat.m8 + mat.m2)*mult;
			result.y = (mat.m6 + mat.m9)*mult;
			break;
	}

	return result;
}

// Get a matrix for a given quaternion
fn Matrix quaternion_to_matrix(Quaternion q) {
	Matrix result = { 1.0f, 0.0f, 0.0f, 0.0f,
					  0.0f, 1.0f, 0.0f, 0.0f,
					  0.0f, 0.0f, 1.0f, 0.0f,
					  0.0f, 0.0f, 0.0f, 1.0f }; // MatrixIdentity()

	float a2 = q.x*q.x;
	float b2 = q.y*q.y;
	float c2 = q.z*q.z;
	float ac = q.x*q.z;
	float ab = q.x*q.y;
	float bc = q.y*q.z;
	float ad = q.w*q.x;
	float bd = q.w*q.y;
	float cd = q.w*q.z;

	result.m0 = 1 - 2*(b2 + c2);
	result.m1 = 2*(ab + cd);
	result.m2 = 2*(ac - bd);

	result.m4 = 2*(ab - cd);
	result.m5 = 1 - 2*(a2 + c2);
	result.m6 = 2*(bc + ad);

	result.m8 = 2*(ac + bd);
	result.m9 = 2*(bc - ad);
	result.m10 = 1 - 2*(a2 + b2);

	return result;
}

// Get rotation quaternion for an angle and axis
// NOTE: Angle must be provided in radians
fn Quaternion quaternion_from_axis_angle(Vector3 axis, float angle) {
	Quaternion result = { 0.0f, 0.0f, 0.0f, 1.0f };

	float axisLength = math::sqrt(axis.x*axis.x + axis.y*axis.y + axis.z*axis.z);

	if (axisLength != 0.0f)
	{
		angle *= 0.5f;

		float length = 0.0f;
		float ilength = 0.0f;

		// vector3_Normalize(axis)
		Vector3 v = axis;
		length = math::sqrt(v.x*v.x + v.y*v.y + v.z*v.z);
		if (length == 0.0f) length = 1.0f;
		ilength = 1.0f/length;
		axis.x *= ilength;
		axis.y *= ilength;
		axis.z *= ilength;

		float sinres = math::sin(angle);
		float cosres = math::cos(angle);

		result.x = axis.x*sinres;
		result.y = axis.y*sinres;
		result.z = axis.z*sinres;
		result.w = cosres;

		// QuaternionNormalize(q);
		Quaternion q = result;
		length = math::sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
		if (length == 0.0f) length = 1.0f;
		ilength = 1.0f/length;
		result.x = q.x*ilength;
		result.y = q.y*ilength;
		result.z = q.z*ilength;
		result.w = q.w*ilength;
	}

	return result;
}

// Get the rotation angle and axis for a given quaternion
fn void quaternion_to_axis_angle(Quaternion q, Vector3 *outAxis, float *outAngle) {
	if (math::abs(q.w) > 1.0f)
	{
		// QuaternionNormalize(q);
		float length = math::sqrt(q.x*q.x + q.y*q.y + q.z*q.z + q.w*q.w);
		if (length == 0.0f) length = 1.0f;
		float ilength = 1.0f/length;

		q.x = q.x*ilength;
		q.y = q.y*ilength;
		q.z = q.z*ilength;
		q.w = q.w*ilength;
	}

	Vector3 resAxis = { 0.0f, 0.0f, 0.0f };
	float resAngle = 2.0f*math::acos(q.w);
	float den = math::sqrt(1.0f - q.w*q.w);

	if (den > EPSILON)
	{
		resAxis.x = q.x/den;
		resAxis.y = q.y/den;
		resAxis.z = q.z/den;
	}
	else
	{
		// This occurs when the angle is zero.
		// Not a problem: just set an arbitrary normalized axis.
		resAxis.x = 1.0f;
	}

	*outAxis = resAxis;
	*outAngle = resAngle;
}

// Get the quaternion equivalent to Euler angles
// NOTE: Rotation order is ZYX
fn Quaternion quaternion_from_euler(float pitch, float yaw, float roll) {
	Quaternion result;

	float x0 = math::cos(pitch*0.5f);
	float x1 = math::sin(pitch*0.5f);
	float y0 = math::cos(yaw*0.5f);
	float y1 = math::sin(yaw*0.5f);
	float z0 = math::cos(roll*0.5f);
	float z1 = math::sin(roll*0.5f);

	result.x = x1*y0*z0 - x0*y1*z1;
	result.y = x0*y1*z0 + x1*y0*z1;
	result.z = x0*y0*z1 - x1*y1*z0;
	result.w = x0*y0*z0 + x1*y1*z1;

	return result;
}

// Get the Euler angles equivalent to quaternion (roll, pitch, yaw)
// NOTE: Angles are returned in a Vector3 struct in radians
fn Vector3 quaternion_to_euler(Quaternion q) {
	Vector3 result;

	// Roll (x-axis rotation)
	float x0 = 2.0f*(q.w*q.x + q.y*q.z);
	float x1 = 1.0f - 2.0f*(q.x*q.x + q.y*q.y);
	result.x = math::atan2(x0, x1);

	// Pitch (y-axis rotation)
	float y0 = 2.0f*(q.w*q.y - q.z*q.x);
	y0 = y0 > 1.0f ? 1.0f : y0;
	y0 = y0 < -1.0f ? -1.0f : y0;
	result.y = math::asin(y0);

	// Yaw (z-axis rotation)
	float z0 = 2.0f*(q.w*q.z + q.x*q.y);
	float z1 = 1.0f - 2.0f*(q.y*q.y + q.z*q.z);
	result.z = math::atan2(z0, z1);

	return result;
}

// Transform a quaternion given a transformation matrix
fn Quaternion quaternion_transform(Quaternion q, Matrix mat) {
	Quaternion result;

	result.x = mat.m0*q.x + mat.m4*q.y + mat.m8*q.z + mat.m12*q.w;
	result.y = mat.m1*q.x + mat.m5*q.y + mat.m9*q.z + mat.m13*q.w;
	result.z = mat.m2*q.x + mat.m6*q.y + mat.m10*q.z + mat.m14*q.w;
	result.w = mat.m3*q.x + mat.m7*q.y + mat.m11*q.z + mat.m15*q.w;

	return result;
}

// Check whether two given quaternions are almost equal
fn bool quaternion_equals(Quaternion p, Quaternion q) {
	bool result = (((math::abs(p.x - q.x)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.x), math::abs(q.x))))) &&
				  ((math::abs(p.y - q.y)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.y), math::abs(q.y))))) &&
				  ((math::abs(p.z - q.z)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.z), math::abs(q.z))))) &&
				  ((math::abs(p.w - q.w)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.w), math::abs(q.w)))))) ||
				 (((math::abs(p.x + q.x)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.x), math::abs(q.x))))) &&
				  ((math::abs(p.y + q.y)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.y), math::abs(q.y))))) &&
				  ((math::abs(p.z + q.z)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.z), math::abs(q.z))))) &&
				  ((math::abs(p.w + q.w)) <= (EPSILON*math::max(1.0f, math::max(math::abs(p.w), math::abs(q.w))))));

	return result;
}

