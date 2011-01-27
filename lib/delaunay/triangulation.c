#include "triangulation.h"

Triangulation triangulation_new(Point p[], int num_points)
{
	Triangulation t;
	triangulation_compute(&t, &p, num_points);
	return t;		
}

void triangulation_compute(Triangulation *t, Point p[], int num_points)
{
		
}
