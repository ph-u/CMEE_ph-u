#include <stdio.h>

int main (void){
	int i = 0;
	int intarray[] = {4, 8, 5, 44};
	char hello[] = "Hello!";

	// while loop
	while(i < 4){ // while condition is non-zero
	// execute code in here
	printf("%i ", intarray[i]); // compiler won't warn infinite loops
	++i;
	}
	printf("\n");

	printf("do-while loop:\n");
	i=0; // reinitialize i
	do{
	printf("%i ", intarray[i]);
	++i;
	}while(i<4);
	printf("\n");

	printf("Using a for-loop:\n");
	for (i=0 ; i<4 ; i++){ // ini, cond, return i val
	printf("%i ", intarray[i]); // run command before condition checked
	}
	printf("\n");

	printf("Read an array backwards:\n");
//	for(i=3 ; i>=0 ; --i){
//	for(i=3 ; --i ; ){ // defined as check for non-zero; do loop -> check state -> decrement i -- pre-increment lead to eliminated 0 pos
	for(i=4 ; i-- ; ){ // post-increment eliminated nth pos
		printf("%i ", intarray[i]);
	}
	printf("\n");

	// 3 ways to print a string:
	//char hello[] = "Hello!"
	for(i=0 ; i<6 ; ++i){
	putchar(hello[i]);
	}
	printf("\n");

	for(i=0; hello[i]; ++i){ // evaluating non-null
	putchar(hello[i]);
	};printf("\n");

	printf("%s\n", hello);

	return 0;
}
