#include "point.h"

Point* 
point_new(double x, double y) 
{
	Point *p;
	p = (Point*)malloc(sizeof(Point));
	p->x = x;
	p->y = y;
	return p;
}

int 
point_equals(void *v1, void *v2) 
{
	Point *p1, *p2;
	p1 = v1;
	p2 = v2;	
	if (p1->x == p2->x && p1->y == p2->y) return 1;
	return 0;
}

void 
point_print(Point *p)
{
	printf("%f,%f", p->x, p->y);
}

int 
point_tos(Point *p, char* buffer)
{
	return sprintf(buffer, "%f,%f", p->x, p->y);
}

void 
point_free(void *p)
{
	free(p);
}

unsigned long
point_hash(void *v)
{
	return 1;
}
