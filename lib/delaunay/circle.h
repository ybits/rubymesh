#ifndef YBITS_GEOM_CIRCLE
#define YBITS_GEOM_CIRCLE

#include "point.h"
#include "math.h"

typedef struct {
	Point center;
	double radius;
} Circle;

Circle* circle_new(Point*, double);
int circle_equals(Circle*, Circle*);
int circle_circumscribes(Circle*, Point*);
void circle_free(Circle*);

#endif
