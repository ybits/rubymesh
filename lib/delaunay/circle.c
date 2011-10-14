#include "circle.h"

Circle*
circle_new(Point *center, double radius)
{
	Circle *c;
	c = (Circle*)malloc(sizeof(Circle));
	c->center = (Point*)malloc(sizeof(Point));
	memcpy(
		c->center,
		center,
		sizeof(Point)
	);
	c->radius = radius;
	return c;
}

int
circle_equals(Circle *c1, Circle *c2)
{
	if (point_equals(c1->center, c2->center) && c1->radius == c2->radius) return 1;
	return 0;
}

int
circle_circumscribes(Circle *c, Point *p) 
{
	double squared_dist = pow(c->center->x - p->x, 2) +
	                      pow(c->center->y - p->y, 2);
	if (squared_dist <= pow(c->radius, 2)) return 1;
	return 0;
}

void
circle_free(Circle *c)
{
	point_free(c->center);
	free(c);
}
