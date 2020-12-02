/* 
Author: ph-u
Script: 02_5.c
Desc: memory limitations
Input: clang 02_5.c -o 02_5;./02_5
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>
#include <limits.h>

int main (void){
	int x = 2147483648;
	printf("%i is warned wrapping\n", x);
	printf("max integer is %i\n", INT_MAX);
}
