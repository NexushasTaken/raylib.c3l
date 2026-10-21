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
extern fn void setShapesTexture(Texture2D texture, Rectangle rec) @cname("SetShapesTexture");

<*
 Get texture that is used for shapes drawing
*>
extern fn Texture2D getShapesTexture() @cname("GetShapesTexture");

<*
 Get texture source rectangle that is used for shapes drawing
*>
extern fn Rectangle getShapesTextureRectangle() @cname("GetShapesTextureRectangle");

// Basic shapes drawing functions
//------------------------------------------------------------------------------------

<*
 Draw a pixel using geometry [Can be slow, use with care]
*>
extern fn void drawPixel(int pos_x, int pos_y, Color color) @cname("DrawPixel");

<*
 Draw a pixel using geometry (Vector version) [Can be slow, use with care]
*>
extern fn void drawPixelV(Vector2 position, Color color) @cname("DrawPixelV");

<*
 Draw a line
*>
extern fn void drawLine(int start_pos_x, int start_pos_y, int end_pos_x, int end_pos_y, Color color) @cname("DrawLine");

<*
 Draw a line (using gl lines)
*>
extern fn void drawLineV(Vector2 start_pos, Vector2 end_pos, Color color) @cname("DrawLineV");

<*
 Draw a line (using triangles/quads)
*>
extern fn void drawLineEx(Vector2 start_pos, Vector2 end_pos, float thick, Color color) @cname("DrawLineEx");

<*
 Draw lines sequence (using gl lines)
 @require points.len <= int::max
*>
fn void drawLineStrip(Vector2[] points, Color color) {
	__draw_line_strip(points.ptr, (int)points.len, color);
}

<*
 Draw line segment cubic-bezier in-out interpolation
*>
extern fn void drawLineBezier(Vector2 start_pos, Vector2 end_pos, float thick, Color color) @cname("DrawLineBezier");

<*
 Draw a dashed line
*>
extern fn void drawLineDashed(Vector2 start_pos, Vector2 end_pos, int dash_size, int space_size, Color color) @cname("DrawLineDashed");

<*
 Draw a color-filled circle
*>
extern fn void drawCircle(int center_x, int center_y, float radius, Color color) @cname("DrawCircle");

<*
 Draw a piece of a circle
*>
extern fn void drawCircleSector(Vector2 center, float radius, float start_angle, float end_angle, int segments, Color color) @cname("DrawCircleSector");

<*
 Draw circle sector outline
*>
extern fn void drawCircleSectorLines(Vector2 center, float radius, float start_angle, float end_angle, int segments, Color color) @cname("DrawCircleSectorLines");

<*
 Draw circle sector outline with thickness
*>
extern fn void drawCircleSectorLinesEx(Vector2 center, float radius, float start_angle, float end_angle, int segments, float thick, Color color) @cname("DrawCircleSectorLinesEx");

<*
 Draw a gradient-filled circle
*>
extern fn void drawCircleGradient(Vector2 center, float radius, Color inner, Color outer) @cname("DrawCircleGradient");

<*
 Draw a color-filled circle (Vector version)
*>
extern fn void drawCircleV(Vector2 center, float radius, Color color) @cname("DrawCircleV");

<*
 Draw circle outline
*>
extern fn void drawCircleLines(int center_x, int center_y, float radius, Color color) @cname("DrawCircleLines");

<*
 Draw circle outline (Vector version)
*>
extern fn void drawCircleLinesV(Vector2 center, float radius, Color color) @cname("DrawCircleLinesV");

<*
 Draw circle outline with line thickness
*>
extern fn void drawCircleLinesEx(Vector2 center, float radius, float thick, Color color) @cname("DrawCircleLinesEx");

<*
 Draw ellipse
*>
extern fn void drawEllipse(int center_x, int center_y, float radius_h, float radius_v, Color color) @cname("DrawEllipse");

<*
 Draw ellipse (Vector version)
*>
extern fn void drawEllipseV(Vector2 center, float radius_h, float radius_v, Color color) @cname("DrawEllipseV");

<*
 Draw ellipse outline
*>
extern fn void drawEllipseLines(int center_x, int center_y, float radius_h, float radius_v, Color color) @cname("DrawEllipseLines");

<*
 Draw ellipse outline (Vector version)
*>
extern fn void drawEllipseLinesV(Vector2 center, float radius_h, float radius_v, Color color) @cname("DrawEllipseLinesV");

<*
 Draw ellipse outline with line thickness
*>
extern fn void drawEllipseLinesEx(Vector2 center, float radius_h, float radius_v, float thick, Color color) @cname("DrawEllipseLinesEx");

<*
 Draw ring
*>
extern fn void drawRing(Vector2 center, float inner_radius, float outer_radius, float start_angle, float end_angle, int segments, Color color) @cname("DrawRing");

<*
 Draw ring outline
*>
extern fn void drawRingLines(Vector2 center, float inner_radius, float outer_radius, float start_angle, float end_angle, int segments, Color color) @cname("DrawRingLines");

<*
 Draw ring outline with line thickness
*>
extern fn void drawRingLinesEx(Vector2 center, float inner_radius, float outer_radius, float start_angle, float end_angle, int segments, float thick, Color color) @cname("DrawRingLinesEx");

<*
 Draw a color-filled rectangle
*>
extern fn void drawRectangle(int pos_x, int pos_y, int width, int height, Color color) @cname("DrawRectangle");

<*
 Draw a color-filled rectangle (Vector version)
*>
extern fn void drawRectangleV(Vector2 position, Vector2 size, Color color) @cname("DrawRectangleV");

<*
 Draw a color-filled rectangle
*>
extern fn void drawRectangleRec(Rectangle rec, Color color) @cname("DrawRectangleRec");

<*
 Draw a color-filled rectangle with pro parameters
*>
extern fn void drawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color) @cname("DrawRectanglePro");

<*
 Draw a vertical-gradient-filled rectangle
*>
extern fn void drawRectangleGradientV(int pos_x, int pos_y, int width, int height, Color top, Color bottom) @cname("DrawRectangleGradientV");

<*
 Draw a horizontal-gradient-filled rectangle
*>
extern fn void drawRectangleGradientH(int pos_x, int pos_y, int width, int height, Color left, Color right) @cname("DrawRectangleGradientH");

<*
 Draw a gradient-filled rectangle with custom vertex colors, counter-clockwise color order
*>
extern fn void drawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4) @cname("DrawRectangleGradientEx");

<*
 Draw rectangle outline
*>
extern fn void drawRectangleLines(int pos_x, int pos_y, int width, int height, Color color) @cname("DrawRectangleLines");

<*
 Draw rectangle outline with line thickness
*>
extern fn void drawRectangleLinesEx(Rectangle rec, float thick, Color color) @cname("DrawRectangleLinesEx");

<*
 Draw rectangle with rounded edges
*>
extern fn void drawRectangleRounded(Rectangle rec, float roundness, int segments, Color color) @cname("DrawRectangleRounded");


<*
 Draw rectangle lines with rounded edges
*>
extern fn void drawRectangleRoundedLines(Rectangle rec, float roundness, int segments, Color color) @cname("DrawRectangleRoundedLines");

<*
 Draw rectangle lines with rounded edges outline and line thickness
*>
extern fn void drawRectangleRoundedLinesEx(Rectangle rec, float roundness, int segments, float thick, Color color) @cname("DrawRectangleRoundedLinesEx");

<*
 Draw a color-filled triangle, counter-clockwise vertex order
*>
extern fn void drawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @cname("DrawTriangle");

<*
 Draw triangle with interpolated colors, counter-clockwise vertex/color order
*>
extern fn void drawTriangleGradient(Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3) @cname("DrawTriangleGradient");

<*
 Draw triangle outline, counter-clockwise vertex order
*>
extern fn void drawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @cname("DrawTriangleLines");

<*
 Draw triangle outline with line thickness, counter-clockwise vertex order
*>
extern fn void drawTriangleLinesEx(Vector2 v1, Vector2 v2, Vector2 v3, float thick, Color color) @cname("DrawTriangleLinesEx");

<*
 Draw a triangle fan defined by points (first vertex is the center)
 @require points.len <= int::max
*>
fn void drawTriangleFan(Vector2[] points, Color color) @inline {
    __draw_triangle_fan(points.ptr, (int)points.len, color);
}

<*
 Draw a triangle strip defined by points
 @require points.len <= int::max
*>
fn void drawTriangleStrip(Vector2[] points, Color color) @inline {
    __draw_triangle_strip(points.ptr, (int)points.len, color);
}

<*
 Draw a polygon of n sides
*>
extern fn void drawPoly(Vector2 center, int sides, float radius, float rotation, Color color) @cname("DrawPoly");

<*
 Draw a polygon outline of n sides
*>
extern fn void drawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color) @cname("DrawPolyLines");

<*
 Draw a polygon outline of n sides with line thickness
*>
extern fn void drawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float thick, Color color) @cname("DrawPolyLinesEx");

// Splines drawing functions
//------------------------------------------------------------------------------------

<*
 Draw spline: Linear, minimum 2 points
 @require points.len <= int::max
*>
fn void drawSplineLinear(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_linear(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline: B-Spline, minimum 4 points
 @require points.len <= int::max
*>
fn void drawSplineBasis(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_basis(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline: Catmull-Rom, minimum 4 points
 @require points.len <= int::max
*>
fn void drawSplineCatmullRom(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_catmull_rom(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
 @require points.len <= int::max
*>
fn void drawSplineBezierQuadratic(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_bezier_quadratic(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
 @require points.len <= int::max
*>
fn void drawSplineBezierCubic(Vector2[] points, float thick, Color color) @inline {
    __draw_spline_bezier_cubic(points.ptr, (int)points.len, thick, color);
}

<*
 Draw spline segment: Linear, 2 points
*>
extern fn void drawSplineSegmentLinear(Vector2 p1, Vector2 p2, float thick, Color color) @cname("DrawSplineSegmentLinear");

<*
 Draw spline segment: B-Spline, 4 points
*>
extern fn void drawSplineSegmentBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) @cname("DrawSplineSegmentBasis");

<*
 Draw spline segment: Catmull-Rom, 4 points
*>
extern fn void drawSplineSegmentCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) @cname("DrawSplineSegmentCatmullRom");

<*
 Draw spline segment: Quadratic Bezier, 2 points, 1 control point
*>
extern fn void drawSplineSegmentBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color) @cname("DrawSplineSegmentBezierQuadratic");

<*
 Draw spline segment: Cubic Bezier, 2 points, 2 control points
*>
extern fn void drawSplineSegmentBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color) @cname("DrawSplineSegmentBezierCubic");

// Spline segment point evaluation functions, for a given t [0.0f .. 1.0f]
//------------------------------------------------------------------------------------

<*
 Get (evaluate) spline point: Linear
*>
extern fn Vector2 getSplinePointLinear(Vector2 start_pos, Vector2 end_pos, float t) @cname("GetSplinePointLinear");

<*
 Get (evaluate) spline point: B-Spline
*>
extern fn Vector2 getSplinePointBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) @cname("GetSplinePointBasis");

<*
 Get (evaluate) spline point: Catmull-Rom
*>
extern fn Vector2 getSplinePointCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) @cname("GetSplinePointCatmullRom");

<*
 Get (evaluate) spline point: Quadratic Bezier
*>
extern fn Vector2 getSplinePointBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float t) @cname("GetSplinePointBezierQuadratic");

<*
 Get (evaluate) spline point: Cubic Bezier
*>
extern fn Vector2 getSplinePointBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t) @cname("GetSplinePointBezierCubic");

// Basic shapes collision detection functions
//------------------------------------------------------------------------------------

<*
 Check collision between two rectangles
*>
extern fn bool checkCollisionRecs(Rectangle rec1, Rectangle rec2) @cname("CheckCollisionRecs");

<*
 Check collision between two circles
*>
extern fn bool checkCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2) @cname("CheckCollisionCircles");

<*
 Check collision between circle and rectangle
*>
extern fn bool checkCollisionCircleRec(Vector2 center, float radius, Rectangle rec) @cname("CheckCollisionCircleRec");

<*
 Check if circle collides with a line created between two points [p1] and [p2]
*>
extern fn bool checkCollisionCircleLine(Vector2 center, float radius, Vector2 p1, Vector2 p2) @cname("CheckCollisionCircleLine");

<*
 Check if point is inside rectangle
*>
extern fn bool checkCollisionPointRec(Vector2 point, Rectangle rec) @cname("CheckCollisionPointRec");

<*
 Check if point is inside circle
*>
extern fn bool checkCollisionPointCircle(Vector2 point, Vector2 center, float radius) @cname("CheckCollisionPointCircle");

<*
 Check if point is inside a triangle
*>
extern fn bool checkCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3) @cname("CheckCollisionPointTriangle");

<*
 Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
*>
extern fn bool checkCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold) @cname("CheckCollisionPointLine");

<*
 Check if point is within a polygon described by array of vertices
 @require points.len <= int::max
*>
fn bool checkCollisionPointPoly(Vector2 point, Vector2[] points) @inline {
    return __check_collision_point_poly(point, points.ptr, (int)points.len);
}

<*
 Check the collision between two lines defined by two points each, returns collision point by reference
 @param [out] collision_point
*>
extern fn bool checkCollisionLines(Vector2 start_pos1, Vector2 end_pos1, Vector2 start_pos2, Vector2 end_pos2, Vector2* collision_point) @cname("CheckCollisionLines");

<*
 Get collision rectangle for two rectangles collision
*>
extern fn Rectangle getCollisionRec(Rectangle rec1, Rectangle rec2) @cname("GetCollisionRec");
