#ifndef YBITS_GEOM_POINT
#define YBITS_GEOM_POINT

typedef struct {
	double x, y;
} Point;

Point point_new(double, double);
int point_equals(Point*, Point*);
void point_print(Point*);

#endif

