// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Basic Shapes Drawing Functions (Module: shapes)
//------------------------------------------------------------------------------------
// Set texture and rectangle to be used on shapes drawing
// NOTE: It can be useful when using basic shapes and one single font,
// defining a font char white rectangle would allow drawing everything in a single draw call
//------------------------------------------------------------------------------------

/**
 * Set texture and rectangle to be used on shapes drawing
 */
extern fn void set_shapes_texture(Texture2D texture, Rectangle source) @extern("SetShapesTexture");

// Basic shapes drawing functions
//------------------------------------------------------------------------------------

/**
 * Draw a pixel
 */
extern fn void draw_pixel(int pos_x, int pos_y, Color color) @extern("DrawPixel");

/**
 * Draw a pixel (Vector version)
 */
extern fn void draw_pixel_v(Vector2 position, Color color) @extern("DrawPixelV");

/**
 * Draw a line
 */
extern fn void draw_line(int start_pos_x, int start_pos_y, int end_pos_x, int end_pos_y, Color color) @extern("DrawLine");

/**
 * Draw a line (using gl lines)
 */
extern fn void draw_line_v(Vector2 start_pos, Vector2 end_pos, Color color) @extern("DrawLineV");

/**
 * Draw a line (using triangles/quads)
 */
extern fn void draw_line_ex(Vector2 start_pos, Vector2 end_pos, float thick, Color color) @extern("DrawLineEx");

/**
 * Draw lines sequence (using gl lines)
 */
extern fn void draw_line_strip(Vector2* points, int point_count, Color color) @extern("DrawLineStrip");

/**
 * Draw line segment cubic-bezier in-out interpolation
 */
extern fn void draw_line_bezier(Vector2 start_pos, Vector2 end_pos, float thick, Color color) @extern("DrawLineBezier");

/**
 * Draw a color-filled circle
 */
extern fn void draw_circle(int center_x, int center_y, float radius, Color color) @extern("DrawCircle");

/**
 * Draw a piece of a circle
 */
extern fn void draw_circle_sector(Vector2 center, float radius, float start_angle, float end_angle, int segments, Color color) @extern("DrawCircleSector");

/**
 * Draw circle sector outline
 */
extern fn void draw_circle_sector_lines(Vector2 center, float radius, float start_angle, float end_angle, int segments, Color color) @extern("DrawCircleSectorLines");

/**
 * Draw a gradient-filled circle
 */
extern fn void draw_circle_gradient(int center_x, int center_y, float radius, Color color1, Color color2) @extern("DrawCircleGradient");

/**
 * Draw a color-filled circle (Vector version)
 */
extern fn void draw_circle_v(Vector2 center, float radius, Color color) @extern("DrawCircleV");

/**
 * Draw circle outline
 */
extern fn void draw_circle_lines(int center_x, int center_y, float radius, Color color) @extern("DrawCircleLines");

/**
 * Draw circle outline (Vector version)
 */
extern fn void draw_circle_lines_v(Vector2 center, float radius, Color color) @extern("DrawCircleLinesV");

/**
 * Draw ellipse
 */
extern fn void draw_ellipse(int center_x, int center_y, float radius_h, float radius_v, Color color) @extern("DrawEllipse");

/**
 * Draw ellipse outline
 */
extern fn void draw_ellipse_lines(int center_x, int center_y, float radius_h, float radius_v, Color color) @extern("DrawEllipseLines");

/**
 * Draw ring
 */
extern fn void draw_ring(Vector2 center, float inner_radius, float outer_radius, float start_angle, float end_angle, int segments, Color color) @extern("DrawRing");

/**
 * Draw ring outline
 */
extern fn void draw_ring_lines(Vector2 center, float inner_radius, float outer_radius, float start_angle, float end_angle, int segments, Color color) @extern("DrawRingLines");

/**
 * Draw a color-filled rectangle
 */
extern fn void draw_rectangle(int pos_x, int pos_y, int width, int height, Color color) @extern("DrawRectangle");

/**
 * Draw a color-filled rectangle (Vector version)
 */
extern fn void draw_rectangle_v(Vector2 position, Vector2 size, Color color) @extern("DrawRectangleV");

/**
 * Draw a color-filled rectangle
 */
extern fn void draw_rectangle_rec(Rectangle rec, Color color) @extern("DrawRectangleRec");

/**
 * Draw a color-filled rectangle with pro parameters
 */
extern fn void draw_rectangle_pro(Rectangle rec, Vector2 origin, float rotation, Color color) @extern("DrawRectanglePro");

/**
 * Draw a vertical-gradient-filled rectangle
 */
extern fn void draw_rectangle_gradient_v(int pos_x, int pos_y, int width, int height, Color color1, Color color2) @extern("DrawRectangleGradientV");

/**
 * Draw a horizontal-gradient-filled rectangle
 */
extern fn void draw_rectangle_gradient_h(int pos_x, int pos_y, int width, int height, Color color1, Color color2) @extern("DrawRectangleGradientH");

/**
 * Draw a gradient-filled rectangle with custom vertex colors
 */
extern fn void draw_rectangle_gradient_ex(Rectangle rec, Color col1, Color col2, Color col3, Color col4) @extern("DrawRectangleGradientEx");

/**
 * Draw rectangle outline
 */
extern fn void draw_rectangle_lines(int pos_x, int pos_y, int width, int height, Color color) @extern("DrawRectangleLines");

/**
 * Draw rectangle outline with extended parameters
 */
extern fn void draw_rectangle_lines_ex(Rectangle rec, float line_thick, Color color) @extern("DrawRectangleLinesEx");

/**
 * Draw rectangle with rounded edges
 */
extern fn void draw_rectangle_rounded(Rectangle rec, float roundness, int segments, Color color) @extern("DrawRectangleRounded");

/**
 * Draw rectangle with rounded edges outline
 */
extern fn void draw_rectangle_rounded_lines(Rectangle rec, float roundness, int segments, float line_thick, Color color) @extern("DrawRectangleRoundedLines");

/**
 * Draw a color-filled triangle (vertex in counter-clockwise order!)
 */
extern fn void draw_triangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("DrawTriangle");

/**
 * Draw triangle outline (vertex in counter-clockwise order!)
 */
extern fn void draw_triangle_lines(Vector2 v1, Vector2 v2, Vector2 v3, Color color) @extern("DrawTriangleLines");

/**
 * Draw a triangle fan defined by points (first vertex is the center)
 */
extern fn void draw_triangle_fan(Vector2* points, int point_count, Color color) @extern("DrawTriangleFan");

/**
 * Draw a triangle strip defined by points
 */
extern fn void draw_triangle_strip(Vector2* points, int point_count, Color color) @extern("DrawTriangleStrip");

/**
 * Draw a regular polygon (Vector version)
 */
extern fn void draw_poly(Vector2 center, int sides, float radius, float rotation, Color color) @extern("DrawPoly");

/**
 * Draw a polygon outline of n sides
 */
extern fn void draw_poly_lines(Vector2 center, int sides, float radius, float rotation, Color color) @extern("DrawPolyLines");

/**
 * Draw a polygon outline of n sides with extended parameters
 */
extern fn void draw_poly_lines_ex(Vector2 center, int sides, float radius, float rotation, float line_thick, Color color) @extern("DrawPolyLinesEx");

// Splines drawing functions
//------------------------------------------------------------------------------------

/**
 * Draw spline: Linear, minimum 2 points
 */
extern fn void draw_spline_linear(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineLinear");

/**
 * Draw spline: B-Spline, minimum 4 points
 */
extern fn void draw_spline_basis(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineBasis");

/**
 * Draw spline: Catmull-Rom, minimum 4 points
 */
extern fn void draw_spline_catmull_rom(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineCatmullRom");

/**
 * Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
 */
extern fn void draw_spline_bezier_quadratic(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineBezierQuadratic");

/**
 * Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
 */
extern fn void draw_spline_bezier_cubic(Vector2* points, int point_count, float thick, Color color) @extern("DrawSplineBezierCubic");

/**
 * Draw spline segment: Linear, 2 points
 */
extern fn void draw_spline_segment_linear(Vector2 p1, Vector2 p2, float thick, Color color) @extern("DrawSplineSegmentLinear");

/**
 * Draw spline segment: B-Spline, 4 points
 */
extern fn void draw_spline_segment_basis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) @extern("DrawSplineSegmentBasis");

/**
 * Draw spline segment: Catmull-Rom, 4 points
 */
extern fn void draw_spline_segment_catmull_rom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color) @extern("DrawSplineSegmentCatmullRom");

/**
 * Draw spline segment: Quadratic Bezier, 2 points, 1 control point
 */
extern fn void draw_spline_segment_bezier_quadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color) @extern("DrawSplineSegmentBezierQuadratic");

/**
 * Draw spline segment: Cubic Bezier, 2 points, 2 control points
 */
extern fn void draw_spline_segment_bezier_cubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color) @extern("DrawSplineSegmentBezierCubic");

// Spline segment point evaluation functions, for a given t [0.0f .. 1.0f]
//------------------------------------------------------------------------------------

/**
 * Get (evaluate) spline point: Linear
 */
extern fn Vector2 get_spline_point_linear(Vector2 start_pos, Vector2 end_pos, float t) @extern("GetSplinePointLinear");

/**
 * Get (evaluate) spline point: B-Spline
 */
extern fn Vector2 get_spline_point_basis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) @extern("GetSplinePointBasis");

/**
 * Get (evaluate) spline point: Catmull-Rom
 */
extern fn Vector2 get_spline_point_catmull_rom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t) @extern("GetSplinePointCatmullRom");

/**
 * Get (evaluate) spline point: Quadratic Bezier
 */
extern fn Vector2 get_spline_point_bezier_quad(Vector2 p1, Vector2 c2, Vector2 p3, float t) @extern("GetSplinePointBezierQuad");

/**
 * Get (evaluate) spline point: Cubic Bezier
 */
extern fn Vector2 get_spline_point_bezier_cubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t) @extern("GetSplinePointBezierCubic");

// Basic shapes collision detection functions
//------------------------------------------------------------------------------------

/**
 * Check collision between two rectangles
 */
extern fn bool check_collision_recs(Rectangle rec1, Rectangle rec2) @extern("CheckCollisionRecs");

/**
 * Check collision between two circles
 */
extern fn bool check_collision_circles(Vector2 center1, float radius1, Vector2 center2, float radius2) @extern("CheckCollisionCircles");

/**
 * Check collision between circle and rectangle
 */
extern fn bool check_collision_circle_rec(Vector2 center, float radius, Rectangle rec) @extern("CheckCollisionCircleRec");

/**
 * Check if point is inside rectangle
 */
extern fn bool check_collision_point_rec(Vector2 point, Rectangle rec) @extern("CheckCollisionPointRec");

/**
 * Check if point is inside circle
 */
extern fn bool check_collision_point_circle(Vector2 point, Vector2 center, float radius) @extern("CheckCollisionPointCircle");

/**
 * Check if point is inside a triangle
 */
extern fn bool check_collision_point_triangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3) @extern("CheckCollisionPointTriangle");

/**
 * Check if point is within a polygon described by array of vertices
 */
extern fn bool check_collision_point_poly(Vector2 point, Vector2* points, int point_count) @extern("CheckCollisionPointPoly");

/**
 * Check the collision between two lines defined by two points each, returns collision point by reference
 */
extern fn bool check_collision_lines(Vector2 start_pos1, Vector2 end_pos1, Vector2 start_pos2, Vector2 end_pos2, Vector2* collision_point) @extern("CheckCollisionLines");

/**
 * Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
 */
extern fn bool check_collision_point_line(Vector2 point, Vector2 p1, Vector2 p2, int threshold) @extern("CheckCollisionPointLine");

/**
 * Get collision rectangle for two rectangles collision
 */
extern fn Rectangle get_collision_rec(Rectangle rec1, Rectangle rec2) @extern("GetCollisionRec");

