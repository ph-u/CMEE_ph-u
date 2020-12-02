/* 
Author: ph-u
Script: 02_6.c
Desc: floating point binary
Input: clang 02_6.c -o 02_6;./02_6
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void){
	int x0 = 32;
	int x1 = 23;
	int x2 = 31;
	printf("total length of %i-bit processors = %i\n", x0,x0);
	printf("floating point IEEE-754 std: S [E]_%i [M]_%i\n", x2-x1,x1);
	printf("integral std: S [I]_%i\n", x2);
}
