#include "stdlib.h"

#ifndef YBITS_GEOM_POINT
#define YBITS_GEOM_POINT

typedef struct {
	double x, y;
} Point;

Point* point_new(double, double);
int point_equals(void*, void*);
void point_print(Point*);
int point_tos(Point*, char*);
void point_free(void*);
unsigned long point_hash(void*);

#endif

