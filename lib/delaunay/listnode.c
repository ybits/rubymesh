#include "listnode.h"

ListNode* listnode_new(void* value)
{
	ListNode *node;
	node = (ListNode*)malloc(sizeof(ListNode));
	node->value = value;
	return node;
}

void listnode_free(ListNode* node)
{
	free(node);
}
