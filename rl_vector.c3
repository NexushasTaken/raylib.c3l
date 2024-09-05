// vi: ts=4 sw=4 noet
module rl;
import std::math::vector;

// Vector convertion functions
// TODO: find a better way to convert math::vector types to raylib Vector types and vice versa? and think a better name...

fn Vector2 vector::Vec2f.to_vec_rl(&this) @inline {
	return Vector2 { this.x, this.y };
}

fn Vector3 vector::Vec3f.to_vec_rl(&this) @inline {
	return Vector3 { this.x, this.y, this.z };
}

fn Vector4 vector::Vec4f.to_vec_rl(&this) @inline {
	return Vector4 { this.x, this.y, this.z, this.w };
}

fn vector::Vec2f Vector2.to_vecf(&this) @inline {
	return vector::Vec2f { this.x, this.y };
}

fn vector::Vec3f Vector3.to_vecf(&this) @inline {
	return vector::Vec3f { this.x, this.y, this.z };
}

fn vector::Vec4f Vector4.to_vecf(&this) @inline {
	return vector::Vec4f { this.x, this.y, this.z, this.w };
}

