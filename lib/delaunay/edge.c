#include "edge.h"

Edge* edge_new(Point *p1, Point *p2) 
{
	Edge *e;
	e = (Edge*)malloc(sizeof(Edge));
	e->p1 = *p1;
	e->p2 = *p2;
	return e;
}

int edge_equals(Edge *e1, Edge *e2) 
{
	if ((point_equals(&(e1->p1), &(e2->p1)) && point_equals(&(e1->p2), &(e2->p2))) ||
			(point_equals(&(e1->p1), &(e2->p2)) && point_equals(&(e1->p2), &(e2->p1)))) 
			return 1;
	return 0;
}

int edge_to(Edge *e, char *buffer)
{
	char buffer1[50];
	char buffer2[50];
	int buffer1_size;
	int buffer2_size;
	buffer1_size = point_tos(&(e->p1), buffer1);
	buffer2_size = point_tos(&(e->p2), buffer2);
	return sprintf("[%s %s]", buffer1, buffer1_size, buffer2, buffer2_size); 
}

void edge_free(Edge *e)
{
	free(e);
}
