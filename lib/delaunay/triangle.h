#ifndef YBITS_GEOM_TRIANGLE
#define YBITS_GEOM_TRIANGLE

#include "stdlib.h"
#include "point.h"
#include "circle.h"
#include "math.h"
#include "edge.h"

typedef struct {
	Point p1, p2, p3, centroid;
	Circle circumcircle;
} Triangle;

Triangle* triangle_new(Point*, Point*, Point*);
int triangle_equals(Triangle*, Triangle*);
int trinagle_adjacent(Triangle*, Triangle*);
Circle triangle_circumcircle(Triangle*);
Point* triangle_circumcenter(Triangle*);
double triangle_circumcenter_x(Triangle*);
double triangle_circumcenter_y(Triangle*);
double triangle_circumcenter_denominator(Triangle*);
double triangle_circumcircle_radius(Triangle*, Point*);
void triangle_edges(Triangle*, Edge**);
void triangle_free(Triangle*);

#endif
