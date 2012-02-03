#include "list.h"

List*
list_new(
	int (*compare)(void *a, void *b), 
	unsigned long(*hash)(void *value),
	void (*free)(void *value)
)
{
	List *list;
	list = (List*)malloc(sizeof(List));
	list->size = 0;
	list->head = NULL;
	list->tail = NULL;
	list->free = free;
	list->hash = hash;
	list->compare = compare;
	return list;
}

ListNode*
list_first(List *list)
{
	return list->head;		
}

ListNode*
list_last(List *list)
{
	return list->tail;
}

ListNode*
list_next(List *list, ListNode *node)
{
	if (NULL == node) {
		return list->head;
	}
	return node->child;
}

void
list_push(List *list, void *value)
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

void
list_shift(List *list, void *value)
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

ListNode*
list_pop(List *list)
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

ListNode*
list_remove(List *list, ListNode *node)
{
	if (node == NULL || 0 == list->size) {
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

	if (list->head == node) list->head = node->child;
	if (list->tail == node) list->tail = node->parent;
	if (node->parent) node->parent->child = node->child;
	if (node->child) node->child->parent = node->parent;
	if (list->free) list->free(node->value);
	listnode_free(node);
	list->size--;
	return node;
} 

void
list_empty(List *list)
{
	list->size = 0;
	list->head = NULL;
	list->tail = NULL;
}
