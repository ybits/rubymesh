#ifndef YBITS_GEOM_TRIANGLE
#define YBITS_GEOM_TRIANGLE

#include "point.h"
#include "circle.h"
#include "math.h"

typedef struct {
	Point p1, p2, p3, centroid;
	Circle circumcircle;
} Triangle;

Triangle triangle_new(Point*, Point*, Point*);
int triangle_equals(Triangle*, Triangle*);
int trinagle_adjacent(Triangle*, Triangle*);
Circle triangle_circumcircle(Triangle*);
double triangle_circumcenter_x(Triangle*);
double triangle_circumcenter_y(Triangle*);
double triangle_circumcenter_denominator(Triangle*);
double triangle_circumcenter_radius(Triangle*, Point*);

#endif
