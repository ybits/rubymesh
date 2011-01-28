#include <stdio.h>
#include <string.h>
#include "CUnit/Basic.h"
#include "point.h"
#include "edge.h"
#include "circle.h"
#include "triangle.h"
#include "listnode.h"
#include "list.h"

int init_suite1(void)
{
	return 0;
}

int clean_suite1(void)
{
	return 0;
}

void test_point_creation(void)
{
	double x = 20.0;
	double y = 30.0;
	Point *p = point_new(x,y);

	CU_ASSERT(x == p->x); 
	CU_ASSERT(y == p->y); 
}

void test_point_equality(void)
{
	double x = 20.0;
	double y = 30.0;
	Point *p1 = point_new(x, y);
	Point *p2 = point_new(x, y);
	Point *p3 = point_new(x+1, y);
	Point *p4 = point_new(x, y+1);

	CU_ASSERT(point_equals(p1, p2)); 
	CU_ASSERT(!point_equals(p1, p3)); 
	CU_ASSERT(!point_equals(p1, p4)); 
}

void testPOINT(void)
{
	test_point_creation();
	test_point_equality();
}

void test_edge_creation(void)
{
	double x1 = 20.0;
	double y1 = 30.0;
	double x2 = 20.0;
	double y2 = 30.0;
	Point *p1 = point_new(x1, y1);
	Point *p2 = point_new(x2, y2);
	Edge *e = edge_new(p1, p2);

	CU_ASSERT(e->p1.x == x1);
	CU_ASSERT(e->p1.y == y1);
	CU_ASSERT(e->p2.x == x2);
	CU_ASSERT(e->p2.y == y2);
}

void test_edge_equality(void)
{
	double x1 = 20.0;
	double y1 = 30.0;
	double x2 = 25.5;
	double y2 = 33.3;
	Point *p1 = point_new(x1, y1);
	Point *p2 = point_new(x2, y2);
	Point *p3 = point_new(x1, y2);
	Edge *e1 = edge_new(p1, p2);
	Edge *e2 = edge_new(p2, p1);
	Edge *e3 = edge_new(p1, p3);
	Edge *e4 = edge_new(p3, p1);
	CU_ASSERT(edge_equals(e1, e2));
	CU_ASSERT(!edge_equals(e1, e3));
	CU_ASSERT(!edge_equals(e4, e1));
}

void testEDGE(void)
{
	test_edge_creation();
	test_edge_equality();
}

void test_circle_creation(void)
{
	double x = 1.0;
	double y = 1.0;
	double radius = 7.0;
	Point *p = point_new(x, y);
	Circle *c = circle_new(p, radius);

	CU_ASSERT(point_equals(&(c->center), p));
	CU_ASSERT(radius == c->radius);
}

void test_circle_equality(void)
{
	double x = 1.0;
	double y = 2.0;
	double radius = 7.0;
	Point *p1 = point_new(x, y);
	Point *p2 = point_new(y, x);
	Circle *c1 = circle_new(p1, radius);
	Circle *c2 = circle_new(p1, radius);
	Circle *c3 = circle_new(p2, radius);
	Circle *c4 = circle_new(p1, radius + 12);

	CU_ASSERT(circle_equals(c1, c2));
	CU_ASSERT(!circle_equals(c1, c3));
	CU_ASSERT(!circle_equals(c1, c4));
}

void test_circle_circumscribes(void)
{
	double radius = 5.0;
	Point *p1 = point_new(0.0, 0.0);
	Point *inside_point = point_new(0.0, 1.0);
	Point *outside_point = point_new(10.0, 10.0);
	Circle *c1 = circle_new(p1, radius);

	CU_ASSERT(circle_circumscribes(c1, inside_point));
	CU_ASSERT(!circle_circumscribes(c1, outside_point));
}

void testCIRCLE(void)
{
	test_circle_creation();
	test_circle_equality();
	test_circle_circumscribes();
}

void test_triangle_creation(void)
{
	Point *p1 = point_new(1.0, 1.0);
	Point *p2 = point_new(2.0, 2.0);
	Point *p3 = point_new(3.0, 3.0);
	Triangle *t = triangle_new(p1, p2, p3);

	CU_ASSERT(point_equals(p1, &(t->p1)));
	CU_ASSERT(point_equals(p2, &(t->p2)));
	CU_ASSERT(point_equals(p3, &(t->p3)));
}

void test_triangle_equality(void)
{
	Point *p1 = point_new(1.0, 1.0);
	Point *p2 = point_new(2.0, 2.0);
	Point *p3 = point_new(3.0, 3.0);
	Triangle *t1 = triangle_new(p1, p2, p3);

	Point *p4 = point_new(1.0, 1.0);
	Point *p5 = point_new(2.0, 2.0);
	Point *p6 = point_new(3.0, 3.0);
	Triangle *t2 = triangle_new(p4, p5, p6);

	Point *p7 = point_new(1.0, 1.0);
	Point *p8 = point_new(2.0, 2.0);
	Point *p9 = point_new(3.0, 3.1);
	Triangle *t3 = triangle_new(p7, p8, p9);

	CU_ASSERT(triangle_equals(t1, t2));
	CU_ASSERT(!triangle_equals(t1, t3));
}

void test_triangle_centroid(void)
{
	Point *p1 = point_new(1.0, 1.0);
	Point *p2 = point_new(1.0, 1.0);
	Point *p3 = point_new(4.0, 4.0);
	Point *centroid = point_new(2.0, 2.0);
	Triangle *t = triangle_new(p1, p2, p3);

	CU_ASSERT(point_equals(centroid, &(t->centroid)));
}

void test_triangle_adjacent(void)
{
	Point *p1 = point_new(1.0, 1.0);	
	Point *p2 = point_new(1.0, 2.0);	
	Point *p3 = point_new(4.0, 4.0);	
	Point *p4 = point_new(5.0, 5.0);	
	Point *p5 = point_new(5.0, 6.0);	
	Triangle *t1 = triangle_new(p1, p2, p3);
	Triangle *t2 = triangle_new(p1, p2, p4);
	Triangle *t3 = triangle_new(p1, p4, p5);

	CU_ASSERT(triangle_adjacent(t1, t2));
	CU_ASSERT(!triangle_adjacent(t1, t3));
}

void test_triangle_edges(void)
{
	Point *p1 = point_new(1.0, 1.0);
	Point *p2 = point_new(1.0, 2.0);
	Point *p3 = point_new(4.0, 4.0);
	Edge *e1 = edge_new(p1, p2);
	Edge *e2 = edge_new(p2, p3);
	Edge *e3 = edge_new(p3, p1);
	Triangle *t = triangle_new(p1, p2, p3);
	Edge *edges[3];
	triangle_edges(t, edges);

	CU_ASSERT(edge_equals(e1, (edges[0])));
	CU_ASSERT(edge_equals(e2, (edges[1])));
	CU_ASSERT(edge_equals(e3, (edges[2])));
}

void testTRIANGLE(void)
{
	test_triangle_creation();
	test_triangle_equality();
	test_triangle_centroid();
	test_triangle_adjacent();
	test_triangle_edges();
}

void test_listnode_creation(void)
{
	Point *p1 = point_new(1.0, 1.1);
	ListNode *node1 = listnode_new(p1);
	Point* p2 = (Point*)node1->value;
	listnode_free(node1);
	
	CU_ASSERT(point_equals(p1, p2));
	Point *p3 = point_new(2.0, 2.2);
	Edge *e1 = edge_new(p1, p3);
	ListNode *node2 = listnode_new(e1);
	Edge* e2 = (Edge*)node2->value;
	listnode_free(node2);
	
	CU_ASSERT(edge_equals(e1, e2)); 
}

void test_listnode_accessors(void)
{
	Point *p1 = point_new(1.0, 1.1);
	ListNode *node1 = listnode_new(p1);
	ListNode *node2 = listnode_new(p1);
	ListNode *node3;
	Point *p2;

	node1->child = node2;
	node3 = node1->child;
	p2 = node3->value;
	listnode_free(node1);
}

void testLISTNODE(void)
{
	test_listnode_creation();
	test_listnode_accessors();
}

void test_list_creation(void)
{
	List* list = list_new();
	
	CU_ASSERT(0 == list->size);
}

void test_list_push(void)
{
	List *list = list_new();
	Point *p1 = point_new(1.0, 1.1);
	list_push(list, p1);
 	
	CU_ASSERT(1 == list->size);
	CU_ASSERT(point_equals(p1, (Point*)list->head->value));

	Point *p2 = point_new(1.0, 1.1);
	list_push(list, p2);
 	
	CU_ASSERT(2 == list->size);
	Point *p3 = list->head->child->value;
	CU_ASSERT(point_equals(p2, p3));
}

void test_list_shift(void)
{
	List* list = list_new();
	Point *p1 = point_new(1.0, 1.1);
	list_shift(list, p1);
 	
	CU_ASSERT(1 == list->size);

	Point *p2 = point_new(1.0, 1.1);
	list_shift(list, p2);
 	
	CU_ASSERT(2 == list->size);
	Point *p3 = list->head->value;
	CU_ASSERT(point_equals(p2, p3));
}

void test_list_pop(void)
{
	List *list = list_new();
	ListNode *node;

	node = list_pop(list);

	CU_ASSERT(NULL == node);

	Point *p1 = point_new(1.0, 1.1);
	list_push(list, p1);
	node = list_pop(list);

	CU_ASSERT(0 == list->size);

	Point *p2 = point_new(1.0, 1.1);
	list_push(list, p1);
	list_push(list, p2);
	node = list_pop(list);
 	
	CU_ASSERT(1 == list->size);
}

void test_list_remove_head(void)
{
	List *list = list_new();
	Point *points[3];
	int points_i = 0;
	Point *p1 = point_new(1.0, 1.1);
	Point *p2 = point_new(1.0, 2.1);
	Point *p3 = point_new(1.0, 3.1);
	ListNode* node = NULL;
	
	list_push(list, p1);
	list_push(list, p2);
	list_push(list, p3);

	node = (ListNode*)list->head;

	CU_ASSERT(point_equals(p1, node->value));

	list_remove(list, node);
	node = (ListNode*)list->head;

	CU_ASSERT(point_equals(p1, node->value));
	CU_ASSERT(2 == list->size);
}

void test_list_remove_middle(void)
{
	List *list = list_new();
	Point *points[3];
	int points_i = 0;
	Point *p1 = point_new(1.0, 1.1);
	Point *p2 = point_new(1.0, 2.1);
	Point *p3 = point_new(1.0, 3.1);
	ListNode* node = NULL;
	
	list_push(list, p1);
	list_push(list, p2);
	list_push(list, p3);

	node = (ListNode*)list->head->child;
	
	CU_ASSERT(point_equals(p2, node->value));

	list_remove(list, node);
	node = (ListNode*)list->head;

	CU_ASSERT(point_equals(p1, node->value));
	CU_ASSERT(point_equals(p3, node->child->value));
	CU_ASSERT(2 == list->size);
}

void test_list_remove_tail(void)
{
	List *list = list_new();
	Point *points[3];
	int points_i = 0;
	Point *p1 = point_new(1.0, 1.1);
	Point *p2 = point_new(1.0, 2.1);
	Point *p3 = point_new(1.0, 3.1);
	ListNode* node = NULL;
	
	list_push(list, p1);
	list_push(list, p2);
	list_push(list, p3);

	node = (ListNode*)list->tail;

	CU_ASSERT(point_equals(p3, node->value));
	
	list_remove(list, node);
	node = (ListNode*)list->head;

	CU_ASSERT(point_equals(p1, node->value));
	CU_ASSERT(point_equals(p2, node->child->value));
	CU_ASSERT(2 == list->size);
}

void test_list_next(void)
{
	List *list = list_new();
	Point *points[3];
	int points_i = 0;
	Point *p1 = point_new(1.0, 1.1);
	Point *p2 = point_new(1.0, 2.1);
	Point *p3 = point_new(1.0, 3.1);
	ListNode* node = NULL;
	
	list_push(list, p1);
	list_push(list, p2);
	list_push(list, p3);

	points[0] = p1;
	points[1] = p2;
	points[2] = p3;	
 	
	CU_ASSERT(3 == list->size);
	while (node = (list_next(list, node))) {
		CU_ASSERT(point_equals(points[points_i], (Point*)node->value));
		points_i++;
	}
}

void testLIST(void)
{
	test_list_creation();
	test_list_push();
	test_list_shift();
	test_list_pop();
	test_list_remove_head();
	test_list_remove_middle();
	test_list_remove_tail();
	test_list_next();
}

void test_functionality_10_points(void)
{
	int i;
	int buffer_len;
	char buffer[50];
	Point *p;
	List *list;
	list = list_new();
	ListNode *node;

	printf("\nPoints being pushed:\n");
	for (i = 0; i < 10; i++) {
		p = point_new(random(), random());
		buffer_len = point_tos(p, buffer);
		printf("%s\n", buffer, buffer_len);
		list_push(list, p);
	}

	printf("\nPoints being iterated:\n");
	while (node = (list_next(list, node))) {
		buffer_len = point_tos((Point*)node->value, buffer);
		printf("%s\n", buffer, buffer_len);
	}
}

void testFUNCTIONALITY(void)
{
	test_functionality_10_points();
}


int main()
{
   CU_pSuite pSuite = NULL;

   /* initialize the CUnit test registry */
   if (CUE_SUCCESS != CU_initialize_registry())
      return CU_get_error();

   /* add a suite to the registry */
   pSuite = CU_add_suite("Suite_1", init_suite1, clean_suite1);
   if (NULL == pSuite) {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* add the tests to the suite */
   if ((NULL == CU_add_test(pSuite, "Test Point", testPOINT)) ||
			(NULL == CU_add_test(pSuite, "Test Edge", testEDGE)) ||
			(NULL == CU_add_test(pSuite, "Test Circle", testCIRCLE)) ||
			(NULL == CU_add_test(pSuite, "Test Triangle", testTRIANGLE)) ||
			(NULL == CU_add_test(pSuite, "Test ListNode", testLISTNODE)) ||
			(NULL == CU_add_test(pSuite, "Test List", testLIST)) ||
			(NULL == CU_add_test(pSuite, "Test Functionality", testFUNCTIONALITY)))
   {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* Run all tests using the CUnit Basic interface */
   CU_basic_set_mode(CU_BRM_VERBOSE);
   CU_basic_run_tests();
   CU_cleanup_registry();
   return CU_get_error();
}
