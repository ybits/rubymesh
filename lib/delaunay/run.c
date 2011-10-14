#include "hash.h"

int
main()
{
	Hash *people;
	char* result;

	people = hash_snew();
	hash_set(people, "ryan", "daddy");
	hash_set(people, "helen", "mommy");
	hash_set(people, "riley", "son");

	result = hash_get(people, "helen");
	printf("Helen is a %s", result);
	return 0;
}
