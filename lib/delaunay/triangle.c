#include "triangle.h"

Triangle* triangle_new(Point *p1, Point *p2, Point *p3) 
{
	Triangle *t;
	t = (Triangle*)malloc(sizeof(Triangle));
	t->p1 = *p1;
	t->p2 = *p2;
	t->p3 = *p3;
	t->centroid = *point_new((p1->x + p2->x + p3->x) / 3,
												 (p1->y + p2->y + p3->y) / 3); 
	return t;
}

int triangle_equals(Triangle *t1, Triangle *t2) 
{
	int coincident_points = triangle_coincident_points(t1, t2);
	return 3 == coincident_points;
}

int triangle_adjacent(Triangle *t1, Triangle *t2)
{
	int coincident_points = triangle_coincident_points(t1, t2);
	return 2 == coincident_points;
}

int triangle_coincident_point(Triangle *t1, Triangle *t2)
{
	int coincident_points = triangle_coincident_points(t1, t2);
	return 1 == coincident_points;
}

int triangle_coincident_points(Triangle *t1, Triangle *t2)
{
	Point a[3] = {t1->p1, t1->p2, t1->p3};
	Point b[3] = {t2->p1, t2->p2, t2->p3};
	int found = 0;
	int i;
	int j;
	for (i = 0; i < 3; i++) {
		for (j = 0; j < 3; j++) {
			if (point_equals(&(a[i]), &(b[j]))) {
				found++;
				break;
			}
		}
	} 
	return found;
}

Circle triangle_circumcircle(Triangle *t)
{
	if (t->circumcircle.radius) {
		Point *center = triangle_circumcenter(t);
		t->circumcircle = *circle_new(center, triangle_circumcircle_radius(t, center));	
	}
	return t->circumcircle;
}

Point* triangle_circumcenter(Triangle *t)
{
	return point_new(triangle_circumcenter_x(t), triangle_circumcenter_y(t));
}

double triangle_circumcenter_x(Triangle *t)
{
	double exp = 2.0;
	return	
	(
		(pow(t->p1.y, exp) + pow(t->p1.x, exp)) * (t->p2.y - t->p3.y) +
		(pow(t->p2.y, exp) + pow(t->p2.x, exp)) * (t->p3.y - t->p1.y) +
		(pow(t->p3.y, exp) + pow(t->p3.x, exp)) * (t->p1.y - t->p2.y)
	)	/ triangle_circumcenter_denominator(t);
}

double triangle_circumcenter_y(Triangle *t)
{
	double exp = 2.0;
	return	
	(
		(pow(t->p1.x, exp) + pow(t->p1.y, exp)) * (t->p2.x - t->p3.x) +
		(pow(t->p2.x, exp) + pow(t->p2.y, exp)) * (t->p3.x - t->p1.x) +
		(pow(t->p3.x, exp) + pow(t->p3.y, exp)) * (t->p1.x - t->p2.x)
	)	/ triangle_circumcenter_denominator(t);
}

double triangle_circumcenter_denominator(Triangle *t)
{
	return 2.0 *
	(
		(t->p1.x * (t->p2.y - t->p3.y)) +
		(t->p2.x * (t->p3.y - t->p1.y)) +
		(t->p3.x * (t->p1.y - t->p2.y))
	);
}

double triangle_circumcircle_radius(Triangle *t, Point *center)
{
	return sqrt(pow((t->p1.x - center->x), 2.0) + pow((t->p1.y - center->y), 2.0));
}

void triangle_edges(Triangle *t, Edge* e[])
{
	e[0] = edge_new(&(t->p1), &(t->p2));
	e[1] = edge_new(&(t->p2), &(t->p3));
	e[2] = edge_new(&(t->p3), &(t->p1));
}

void triangle_free(Triangle *t)
{
	free(t);
}
