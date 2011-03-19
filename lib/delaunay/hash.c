#include "hash.h"

HashPair*
hashpair_new(void *key, void *value, unsigned long key_hash, void (*free)(void*))
{
	HashPair *hashpair;
	hashpair = (HashPair*)malloc(sizeof(HashPair));
	hashpair->key = key;
	hashpair->value = value;
	hashpair->key_hash = key_hash;
	hashpair->free = free;
	return hashpair;	
}

void
hashpair_free(void *value)
{
	HashPair *hashpair;
	hashpair = value;
	((void (*)(void*))(hashpair->free))(hashpair->value);
	free(hashpair->key);
	free(hashpair);
}

Hash* 
hash_new(	int (*compare)(void *a, void *b), 
					unsigned long (*hash_fx)(void *value),
					void (*free)(void *value))
{
	Hash *hash;
	int i = 0;

	hash = (Hash*)malloc(sizeof(Hash));
	hash->size = 0;
	hash->free = free;
	hash->hash = hash_fx;
	hash->compare = compare;
	for (i=0; i<HASH_INTERNAL_SIZE; i++) {
		hash->table[i] = NULL;
	}
	return hash;
}

void*
hash_set(Hash *hash, void *key, void *value)
{
	unsigned long key_hash, key_mod;
	List *list;
	ListNode *node = NULL;
	HashPair *hashpair;

	key_hash = ((unsigned long (*)(void*))hash->hash)(key);
	key_mod = key_hash % HASH_INTERNAL_SIZE;
	if ((list = hash->table[key_mod]) == NULL) {
		list = list_new(hash->compare, hash->hash, hashpair_free);
		hash->table[key_mod] = list;
	}
	while (node = (list_next(list, node))) {
		hashpair = node->value;
		if (hashpair->key_hash == key_hash) {
			list_remove(list, node);
			hash->size -= 1;
		} 			
	}	

	hashpair = hashpair_new(key, value, key_hash, hash->free);

	list_push(list, hashpair);
	hash->size += 1;
	
}

void*
hash_get(Hash *hash, void *key)
{
	unsigned long key_hash, key_mod;
	List *list;
	ListNode *node = NULL;
	HashPair *hashpair;
	void * rval= NULL;

	if (key) {
		key_hash = ((unsigned long (*)(void*))hash->hash)(key);
		key_mod = key_hash % HASH_INTERNAL_SIZE;
		if (list = hash->table[key_mod]) {
			while (node = (list_next(list, node))) {
				hashpair = node->value;
				if (hashpair->key_hash == key_hash) {
					return hashpair->value;	
				} 			
			}	
		}
	}
	return rval;
}

void*
hash_unset(Hash *hash, void *key)
{
	unsigned long key_hash, key_mod;
	List *list;
	ListNode *node = NULL;
	HashPair *hashpair;

	key_hash = ((unsigned long (*)(void*))hash->hash)(key);
	key_mod = key_hash % HASH_INTERNAL_SIZE;
	if (list = hash->table[key_mod]) {
		while (node = (list_next(list, node))) {
			hashpair = node->value;
			if (hashpair->key_hash == key_hash) {
				list_remove(list, node);
			} 			
		}	
	}
}

unsigned long 
sdbm_hash(void *value)
{
	unsigned char *str;
	str = value;
	unsigned long hash = 0;
	int c;

	while (c = *str++)
			hash = c + (hash << 6) + (hash << 16) - hash;

	return hash;
}
