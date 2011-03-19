#include "stdlib.h"

#ifndef YBITS_GEOM_HASH
#define YBITS_GEOM_HASH

#include "list.h"

typedef struct {
	int size;
	List *table[8096];
	void *compare;
	void *free;
	void *hash;
} Hash;

typedef struct {
	void *key;
	void *value;
	unsigned int key_hash;
	void *free;
} HashPair;

Hash* hash_new(int (*)(void*, void*), unsigned long (*)(void*), void (*)(void*));
void* hash_get(Hash *hash, void*);
void* hash_set(Hash *hash, void*, void*);
void* hash_unset(Hash *hash, void*);
void hash_empty(Hash *hash);

HashPair* hash_pair_new(void*, void*, unsigned int, void (*)(void*));
void hashpair_free(void*);

unsigned long sdbm_hash(void*);
#endif
