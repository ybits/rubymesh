#include "list.h"

List* list_new(void)
{
	List *list;
	list = (List*)malloc(sizeof(List));
	list->size = 0;
	list->head = NULL;
	list->tail = NULL;
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
	if (NULL == node) {
		return list->head;
	}
	return node->child;
}

void list_push(List *list, void *value)
{
	ListNode *node = listnode_new(value);
	if (0 == list->size) {
		list->head = node;
		list->tail = list->head;
	}
	else {
		list->tail->child = node;
		node->parent = list->tail;
		list->tail = node;
	}
	list->size++;
}

void list_shift(List *list, void *value)
{
	ListNode *node = listnode_new(value);
	if (0 == list->size) {
		list->head = node;
		list->tail = list->head;
	}
	else {
		list->head->parent = node;
		list->head = node;
	}
	list->size++;
}

ListNode* list_pop(List *list)
{
	ListNode *node;
	
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
		list->tail = node->parent;	
	}
	list->size--;
	return node;
} 

ListNode* list_remove(List *list, ListNode *node)
{
	ListNode *parent, *child;
	if (0 == list->size) {
		return NULL;
	}

	if (1 == list->size) {
		if (node != list->head) {
			return NULL;
		}
		else {
			list->head = NULL;
			list->tail = NULL;
		}
	}

	parent = node->parent;
	child = node->child;
	if (parent) parent->child = child;
	if (child) child->parent = parent;
	listnode_free(node);	
	list->size--;
	return node;
} 

void list_empty(List *list)
{
	list->size = 0;
	list->head = NULL;
	list->tail = NULL;
}