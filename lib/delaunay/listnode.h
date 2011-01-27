#include "stdio.h"

#ifndef YBITS_GEOM_LISTNODE
#define YBITS_GEOM_LISTNODE

typedef struct {
	struct ListNode* parent;
	struct ListNode* child;
	void* value;
} ListNode;

ListNode* listnode_new(void*);
void listnode_free(ListNode*);

#endif
