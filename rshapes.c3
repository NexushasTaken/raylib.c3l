module rl;

//------------------------------------------------------------------------------------
// Basic Shapes Drawing Functions (Module: shapes)
//------------------------------------------------------------------------------------
// Set texture and rectangle to be used on shapes drawing
// NOTE: It can be useful when using basic shapes and one single font,
// defining a font char white rectangle would allow drawing everything in a single draw call
//------------------------------------------------------------------------------------

<*
 Set texture and rectangle to be used on shapes drawing
*>
extern fn void setShapesTexture(Texture2D texture, Rectangle source) @extern("SetShapesTexture");

// Basic shapes drawing functions
//------------------------------------------------------------------------------------

<*
 Draw a pixel
*>
extern fn void drawPixel(int pos_x, int pos_y, Color color) @extern("DrawPixel");

<*
 Draw a pixel (Vector version)
*>
extern fn void drawPixelV(Vector2 position, Color color) @extern("DrawPixelV");

<*
 Draw a line
*>
extern fn void drawLine(int start_pos_x, int start_pos_y, int end_pos_x, int end_pos_y, Color color) @extern("DrawLine");

<*
 Draw a line (using gl lines)
*>
extern fn void drawLineV(Vector2 start_pos, Vector2 end_pos, Color color) @extern("DrawLineV");

<*
 Draw a line (using triangles/quads)
*>
extern fn void drawLineEx(Vector2 start_pos, Vector2 end_pos, float thick, Color color) @extern("DrawLineEx");

<*
 Draw lines sequence (using gl lines)
 @require points.len <= int.max
*>
fn void drawLineStrip(Vector2[] points, Color color) {
	__draw_line_strip(points.ptr, (int)points.len, color);
}

<*
 Draw line segment cubic-bezier in-out interpolation
*>
extern fn void drawLineBezier(Vector2 start_pos, Vector2 end_pos, float thick, Color color) @extern("DrawLineBezier");

<*
 Draw a color-filled circle
*>
extern fn void drawCircle(int center_x, int center_y, float radius, Color color) @extern("DrawCircle");

<*
 Draw a piece of a circle
*>
extern fn void drawCircleSector(Vector2 center, float radius, float start_angle, float end_angle, int segments, Color color) @extern("DrawCircleSector");

<*
 Draw circle sector outline
*>
extern fn void drawCircleSectorLines(Vector2 center, float radius, float start_angle, float end_angle, int segments, Color color) @extern("DrawCircleSectorLines");

<*
 Draw a gradient-filled circle
*>
extern fn void drawCircleGradient(int center_x, int center_y, float radius, Color color1, Color color2) @extern("DrawCircleGradient");

<*
 Draw a color-filled circle (Vector version)
*>
extern fn void drawCircleV(Vector2 center, float radius, Color color) @extern("DrawCircleV");

<*
 Draw circle outline
*>
extern fn void drawCircleLines(int center_x, int center_y, float radius, Color color) @extern("DrawCircleLines");

<*
 Draw circle outline (Vector version)
*>
extern fn void drawCircleLinesV(Vector2 center, float radius, Color color) @extern("DrawCircleLinesV");

<*
 Draw ellipse
*>
extern fn void drawEllipse(int center_x, int center_y, float radius_h, float radius_v, Color color) @extern("DrawEllipse");

<*
 Draw ellipse outline
*>
extern fn void drawEllipseLines(int center_x, int center_y, float radius_h, float radius_v, Color color) @extern("DrawEllipseLines");

<*
 Draw ring
*>
extern fn void drawRing(Vector2 center, float inner_radius, float outer_radius, float start_angle, float end_angle, int segments, Color color) @extern("DrawRing");

<*
 Draw ring outline
*>
extern fn void drawRingLines(Vector2 center, float inner_radius, float outer_radius, float start_angle, float end_angle, int segments, Color color) @extern("DrawRingLines");

<*
 Draw a color-filled rectangle
*>
extern fn void drawRectangle(int pos_x, int pos_y, int width, int height, Color color) @extern("DrawRectangle");

<*
 Draw a color-filled rectangle (Vector version)
*>
extern fn void drawRectangleV(Vector2 position, Vector2 size, Color color) @extern("DrawRectangleV");

<*
 Draw a color-filled rectangle
*>
extern fn void drawRectangleRec(Rectangle rec, Color color) @extern("DrawRectangleRec");

<*
 Draw a color-filled rectangle with pro parameters
*>
extern fn void drawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color) @extern("DrawRectanglePro");

<*
 Draw a vertical-gradient-filled rectangle
*>
extern fn void drawRectangleGradientV(int pos_x, int pos_y, int width, int height, Color color1, Color color2) @extern("DrawRectangleGradientV");

<*
 Draw a horizontal-gradient-filled rectangle
*>
extern fn void drawRectangleGradientH(int pos_x, int pos_y, int width, int height, Color color1, Color color2) @extern("DrawRectangleGradientH");

<*
 Draw a gradient-filled rectangle with custom vertex colors
*>
extern fn void drawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4) @extern("DrawRectangleGradientEx");

<*
 Draw rectangle outline
*>
extern fn void drawRectangleLines(int pos_x, int pos_y, int width, int height, Color color) @extern("DrawRectangleLines");

<*
 Draw rectangle outline with extended parameters
*>
extern fn void drawRectangleLinesEx(Rectangle rec, float line_thick, Color color) @extern("DrawRectangleLinesEx");

<*
 Draw rectangle with rounded edges
*>
extern fn void drawRectangleRounded(Rectangle rec, float roundness, int segments, Color color) @extern("DrawRectangleRounded");

<*
 Draw rectangle with rounded edges outline
*>
extern fn void drawRectangleRoundedLines(Rectangle rec, float roundness, int segments, float line_thick, Color color) @extern("DrawRectangleRoundedLines");

<*
 Draw a color-filled triangle (vertex in counter-clockwise order!)
*>
extern fn void drawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("DrawTriangle");

<*
 Draw triangle outline (vertex in counter-clockwise order!)
*>
extern fn void drawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("DrawTriangleLines");

<*
 Draw a triangle fan defined by points (first vertex is the center)
 @require points.len <= int.max
*>
fn void drawTriangleFan(Vector2[] points, Color color) @inline {
    __draw_triangle_fan(points.ptr, (int)points.len, color);
}

<*
 Draw a triangle strip defined by points
 @require points.len <= int.max
*>
fn void drawTriangleStrip(Vector2[] points, Color color) @inline {
    __draw_triangle_strip(points.ptr, (int)points.len, color);
}

<*
 Draw a regular polygon (Vector version)
*>
extern fn void drawPoly(Vector2 center, int sides, float radius, float rotation, Color color) @extern("DrawPoly");

<*
 Draw a polygon outline of n sides
*>
extern fn void drawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color) @extern("DrawPolyLines");

<*
 Draw a polygon outline of n sides with extended parameters
*>
extern fn void drawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float line_thick, Color color) @extern("DrawPolyLinesEx");

// Splines drawing functions
//------------------------------------------------------------------------------------

<*
 Draw spline: Linear, minimum 2 points
 @require points.len <= int.max
*>
fn void drawSplineLinear(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_linear(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline: B-Spline, minimum 4 points
 @require points.len <= int.max
*>
fn void drawSplineBasis(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_basis(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline: Catmull-Rom, minimum 4 points
 @require points.len <= int.max
*>
fn void drawSplineCatmullRom(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_catmull_rom(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
 @require points.len <= int.max
*>
fn void drawSplineBezierQuadratic(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_bezier_quadratic(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
 @require points.len <= int.max
*>
fn void drawSplineBezierCubic(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_bezier_cubic(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline segment: Linear, 2 points
*>
extern fn void drawSplineSegmentLinear(Vector2 p1, Vector2 p2, float thick, Color color) @extern("DrawSplineSegmentLinear");

<*
 Draw spline segment: B-Spline, 4 points
*>
extern fn void drawSplineSegmentBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) @extern("DrawSplineSegmentBasis");

<*
 Draw spline segment: Catmull-Rom, 4 points
*>
extern fn void drawSplineSegmentCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) @extern("DrawSplineSegmentCatmullRom");

<*
 Draw spline segment: Quadratic Bezier, 2 points, 1 control point
*>
extern fn void drawSplineSegmentBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color) @extern("DrawSplineSegmentBezierQuadratic");

<*
 Draw spline segment: Cubic Bezier, 2 points, 2 control points
*>
extern fn void drawSplineSegmentBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color) @extern("DrawSplineSegmentBezierCubic");

// Spline segment point evaluation functions, for a given t [0.0f .. 1.0f]
//------------------------------------------------------------------------------------

<*
 Get (evaluate) spline point: Linear
*>
extern fn Vector2 getSplinePointLinear(Vector2 start_pos, Vector2 end_pos, float t) @extern("GetSplinePointLinear");

<*
 Get (evaluate) spline point: B-Spline
*>
extern fn Vector2 getSplinePointBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) @extern("GetSplinePointBasis");

<*
 Get (evaluate) spline point: Catmull-Rom
*>
extern fn Vector2 getSplinePointCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) @extern("GetSplinePointCatmullRom");

<*
 Get (evaluate) spline point: Quadratic Bezier
*>
extern fn Vector2 getSplinePointBezierQuad(Vector2 p1, Vector2 c2, Vector2 p3, float t) @extern("GetSplinePointBezierQuad");

<*
 Get (evaluate) spline point: Cubic Bezier
*>
extern fn Vector2 getSplinePointBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t) @extern("GetSplinePointBezierCubic");

// Basic shapes collision detection functions
//------------------------------------------------------------------------------------

<*
 Check collision between two rectangles
*>
extern fn bool checkCollisionRecs(Rectangle rec1, Rectangle rec2) @extern("CheckCollisionRecs");

<*
 Check collision between two circles
*>
extern fn bool checkCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2) @extern("CheckCollisionCircles");

<*
 Check collision between circle and rectangle
*>
extern fn bool checkCollisionCircleRec(Vector2 center, float radius, Rectangle rec) @extern("CheckCollisionCircleRec");

<*
 Check if point is inside rectangle
*>
extern fn bool checkCollisionPointRec(Vector2 point, Rectangle rec) @extern("CheckCollisionPointRec");

<*
 Check if point is inside circle
*>
extern fn bool checkCollisionPointCircle(Vector2 point, Vector2 center, float radius) @extern("CheckCollisionPointCircle");

<*
 Check if point is inside a triangle
*>
extern fn bool checkCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3) @extern("CheckCollisionPointTriangle");

<*
 Check if point is within a polygon described by array of vertices
 @require points.len <= int.max
*>
fn bool checkCollisionPointPoly(Vector2 point, Vector2[] points) @inline {
    return __check_collision_point_poly(point, points.ptr, (int)points.len);
}

<*
 Check the collision between two lines defined by two points each, returns collision point by reference
 @param [out] collision_point
*>
extern fn bool checkCollisionLines(Vector2 start_pos1, Vector2 end_pos1, Vector2 start_pos2, Vector2 end_pos2, Vector2* collision_point) @extern("CheckCollisionLines");

<*
 Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
*>
extern fn bool checkCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold) @extern("CheckCollisionPointLine");

<*
 Get collision rectangle for two rectangles collision
*>
extern fn Rectangle getCollisionRec(Rectangle rec1, Rectangle rec2) @extern("GetCollisionRec");
