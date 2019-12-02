/* 
Author: PokMan Ho pok.ho19@imperial.ac.uk
Script: var1.c
Desc: test variable usages
Input: clang var1.c -o var1;./var1
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void) { // "main" has to defined by special types
	// variables start at char / _
	int x = 0; // define type of any size, initialize variables
	char y = 0;
	int _integer;
	int _int;

	printf("The value x: %i\n",x);

	return 0;
}
