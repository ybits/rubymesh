#include <string.h>
#include "hash.h"

HashPair*
hashpair_new(
	void *key,
	void *value,
	unsigned long key_hash
)
{
	HashPair *hashpair;
	hashpair = (HashPair*)malloc(sizeof(HashPair));
	hashpair->key = key;
	hashpair->value = value;
	hashpair->key_hash = key_hash;
	return hashpair;	
}

void
hashpair_free(void *hashpair)
{
	return free(hashpair);
}

Hash* 
hash_new(
	int internal_size,
	int (*compare_key)(void *a, void *b),
	int (*compare_value)(void *a, void *b),
	unsigned long (*hash_fx)(void *value),
	void (*free_key)(void *key),
	void (*free_value)(void *value)
)
{
	Hash *hash;
	int i = 0;

	hash                = (Hash*) malloc(sizeof(Hash));
	hash->table         = (List**) malloc(sizeof(List)*internal_size);
	hash->internal_size = internal_size <= 0 ? 1024 : internal_size;
	hash->size          = 0;
	hash->free_key      = free_key;
	hash->free_value    = free_value;
	hash->hash          = (hash_fx == NULL) ? sdbm_hash : hash_fx;
	hash->compare_key   = (compare_key == NULL) ? memcmp : compare_key;
	hash->compare_value = (compare_value == NULL) ? memcmp : compare_value;

	for (i=0; i<hash->internal_size; i++) {
		hash->table[i] = NULL;
	}
	return hash;
}

Hash*
hash_snew()
{
	return hash_new(0,NULL,NULL,NULL,NULL,NULL);
}

void
hash_set(Hash *hash, void *key, void *value)
{
	unsigned long key_hash, key_mod;
	List *list;
	ListNode *node = NULL;
	HashPair *hashpair, *found_hashpair;
	int replace = 0;

	if (!hash || !key) return;

	key_hash = ((unsigned long (*)(void*))hash->hash)(key);
	key_mod = key_hash % hash->internal_size;
	if ((list = hash->table[key_mod]) == NULL) {
		list = list_new(hash->compare_value, hash->hash, NULL);
		hash->table[key_mod] = list;
	}

	hashpair = hashpair_new(key, value, key_hash);
	while (node = (list_next(list, node))) {
		found_hashpair = node->value;
		if ( hashpair->key_hash == key_hash &&
			(0 == hash->compare_key(hashpair->key, found_hashpair->key))) {
			hash_free_hashpair(hash, found_hashpair);
			node->value = hashpair;
			replace = 1;
			break;
		} 			
	}	

	if (!replace) {
		list_push(list, hashpair);
		hash->size += 1;
	}
}

void*
hash_get(Hash *hash, void *key)
{
	unsigned long key_hash, key_mod;
	List *list;
	ListNode *node = NULL;
	HashPair *hashpair;
	void *rval= NULL;

	if (!hash || !key) return rval;

	key_hash = ((unsigned long (*)(void*))hash->hash)(key);
	key_mod = key_hash % hash->internal_size;
	if (list = hash->table[key_mod]) {
		while (node = (list_next(list, node))) {
			hashpair = node->value;
			if ( hashpair->key_hash == key_hash &&
				(0 == hash->compare_key(hashpair->key, key))) {
				return hashpair->value;	
			} 			
		}	
	}
	return rval;
}

void
hash_unset(Hash *hash, void *key)
{
	unsigned long key_hash, key_mod;
	List *list;
	ListNode *node = NULL;
	HashPair *hashpair;

	if (!hash || !key) return;

	key_hash = ((unsigned long (*)(void*))hash->hash)(key);
	key_mod = key_hash % hash->internal_size;
	if (list = hash->table[key_mod]) {
		while (node = (list_next(list, node))) {
			hashpair = node->value;
			if ( hashpair->key_hash == key_hash &&
				(0 == hash->compare_key(hashpair->key, key))) {
					hash_free_hashpair(hash, hashpair);
					list_remove(list, node);
					hash->size -= 1;
			} 			
		}	
	}
}

void
hash_teardown(Hash *hash)
{
	int i;
	List *list;
	ListNode *node = NULL;
	HashPair *hashpair;

	if (!hash) return;

	for (i=0; i < hash->internal_size; i++) {
		if (list = hash->table[i]) {
			while (node = (list_last(list))) {
				hashpair = node->value;
				hash_free_hashpair(hash, hashpair);
				list_remove(list, node);
				hash->size -= 1;
			}	
		}
	}
}

void
hash_free_hashpair(Hash *hash, HashPair *hp)
{
	if (!hash || !hp) return;

	if (hash->free_key) hash->free_key(hp->key);
	if (hash->free_value) hash->free_value(hp->value);
	return hashpair_free(hp);
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
