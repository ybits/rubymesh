#include "list.h"

List list_new(void)
{
	List list;
	list.size = 0;
	list.head = NULL;
	list.tail = NULL;
	return list;
}

ListNode* list_first(List *list)
{
	return list->head;		
}

ListNode* list_last(List *list)
{
	return list->tail;
}

ListNode* list_next(List *list, ListNode *node)
{
	return (ListNode*)node->child;
}

void list_push(List *list, void *value)
{
	ListNode node = listnode_new(value);
	if (0 == list->size) {
		list->head = &node;
		list->tail = list->head;
	}
	else {
		list->tail->child = (struct ListNode*)&node;
		list->tail = &node;
	}
	list->size++;
}

void list_shift(List *list, void *value)
{
	ListNode node = listnode_new(value);
	if (0 == list->size) {
		list->head = &node;
		list->tail = list->head;
	}
	else {
		list->head->parent = (struct ListNode*)&node;
		list->head = &node;
	}
	list->size++;
}

ListNode* list_pop(List *list)
{
	ListNode *node, *new_tail;
	
	if (0 == list->size) {
		return NULL;
	}

	node = list->tail;
	if (1 == list->size) {
		list->tail = NULL;
		list->head = NULL;
	}
	else if (2 == list->size) {
		list->tail = list->head;
	}
	else {
		list->tail = (ListNode*)node->parent;	
	}
	list->size--;
	return node;
} 

void list_empty(List *list)
{
	list->size = 0;
	list->head = NULL;
	list->tail = NULL;
}
