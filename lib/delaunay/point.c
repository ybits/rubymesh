#include "point.h"

Point* point_new(double x, double y) 
{
	Point *p;
	p = (Point*)malloc(sizeof(Point));
	p->x = x;
	p->y = y;
	return p;
}

int point_equals(Point *p1, Point *p2) 
{
	if (p1->x == p2->x && p1->y == p2->y) return 1;
	return 0;
}

void point_print(Point *p)
{
	printf("%f,%f", p->x, p->y);
}

int point_tos(Point *p, char* buffer)
{
	return sprintf(buffer, "%f,%f", p->x, p->y);
}

void point_free(Point *p)
{
	free(p);
}
