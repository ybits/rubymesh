#ifndef YBITS_GEOM_TRIANGULATION
#define YBITS_GEOM_TRIANGULATION

typedef struct {
	Triangle *t;
	int num_triangles;
} Triangulation;

Triangulation triangulation_new(Point*, int);
void triangulation_compute(Triangulation*, Point*, int);
#endif
