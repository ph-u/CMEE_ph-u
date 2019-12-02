/* 
Author: PokMan Ho pok.ho19@imperial.ac.uk
Script: var2.c
Desc: print terminal message
Input: clang var2.c -o var2;./var2
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void) {
	int a = 7;
	int b = 2;

	printf("division %i\n", 7/2);
	printf("division %f\n", (float)7/2);
	printf("division %i\n", a/b);

	return 0;
}
