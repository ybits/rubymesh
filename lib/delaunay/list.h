#include "stdlib.h"

#ifndef YBITS_GEOM_LIST
#define YBITS_GEOM_LIST

#include "listnode.h"

typedef struct {
	int size;
	ListNode *head;
	ListNode *tail;
	void *compare;
	void (*free)();
	void *hash;
} List;

List* list_new(int (*)(void*, void*), unsigned long (*)(void*), void (*)(void*));
ListNode* list_first(List*);
ListNode* list_last(List*);
ListNode* list_next(List*, ListNode*);
void list_push(List*, void*);
void list_shift(List*, void*);
ListNode* list_pop(List*);
ListNode* list_remove(List*, ListNode*);
void list_empty(List*);

#endif
