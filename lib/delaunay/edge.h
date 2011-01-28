#ifndef YBITS_GEOM_EDGE
#define YBITS_GEOM_EDGE

#include "point.h"

typedef struct {
	Point p1, p2;	
} Edge;

Edge* edge_new(Point*, Point*);
int edge_equals(Edge*, Edge*);
int edge_tos(Edge*, char*);
void edge_free(Edge*);

#endif
