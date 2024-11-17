module rl;
import std::math::vector;

// TODO: find a better way to convert math::vector types to raylib Vector types and vice versa? and think a better name...
// Vector convertion functions

macro Vector2 vector::Vec2f.to_rl(&self) => { self.x, self.y };
macro Vector3 vector::Vec3f.to_rl(&self) => { self.x, self.y, self.z };
macro Vector4 vector::Vec4f.to_rl(&self) => { self.x, self.y, self.z, self.w };

macro vector::Vec2f Vector2.to_vecf(&self) => { self.x, self.y };
macro vector::Vec3f Vector3.to_vecf(&self) => { self.x, self.y, self.z };
macro vector::Vec4f Vector4.to_vecf(&self) => { self.x, self.y, self.z, self.w };
