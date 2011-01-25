#include "edge.h"

Edge edge_new(Point *p1, Point *p2) 
{
	Edge e;
	e.p1 = *p1;
	e.p2 = *p2;
	return e;
}

int edge_equals(Edge *e1, Edge *e2) 
{
	if ((point_equals(&(e1->p1), &(e2->p1)) && point_equals(&(e1->p2), &(e2->p2))) ||
			(point_equals(&(e1->p1), &(e2->p2)) && point_equals(&(e1->p2), &(e2->p1)))) 
			return 1;
	return 0;
}
