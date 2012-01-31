#include "stdlib.h"

#ifndef YBITS_GEOM_HASH
#define YBITS_GEOM_HASH

#ifndef HASH_INTERNAL_SIZE
#define HASH_INTERNAL_SIZE 100000 
#endif

#include "list.h"

typedef struct {
	int size;
	List *table[HASH_INTERNAL_SIZE];
	int (*compare_key)();
	int (*compare_value)();
	unsigned long (*hash)();
	void (*free_key)();
	void (*free_value)();
} Hash;

typedef struct {
	void *key;
	void *value;
	unsigned long key_hash;
} HashPair;

Hash* hash_new(int (*)(void*, void*), int (*)(void*, void*), unsigned long (*)(void*), void (*)(void*), void (*)(void*));
Hash* hash_snew(void);
void hash_set(Hash *hash, void*, void*);
void* hash_get(Hash *hash, void*);
void* hash_unset(Hash *hash, void*);
void hash_free_hashpair(Hash *hash, HashPair*);
void hash_empty(Hash *hash);

HashPair* hash_pair_new(void*, void*, unsigned int);
void hashpair_free(void*);

unsigned long sdbm_hash(void*);
#endif
