#ifndef YBITS_GEOM_LIST
#define YBITS_GEOM_LIST

#include "stdlib.h"
#include "listnode.h"

typedef struct {
	int size;
	ListNode *head;
	ListNode *tail;
} List;

List list_new(void);
ListNode* list_first(List*);
ListNode* list_last(List*);
ListNode* list_next(List*, ListNode*);
void list_push(List*, void*);
ListNode* list_pop(List*);
void list_empty(List*);

#endif
