/* 
Author: ph-u
Script: 02_2.c
Desc: debug 2
Input: clang 02_2.c -o 02_2;./02_2
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void){
	printf("#include -- extra \";\"\n");
	printf("declare float -- number at start of variable\n");
	printf("1st printf: missed \" after \\n\n");
	printf("2nd printf: variable should be using %%c as indicator; missing \";\"\n");
	printf("3rd printf: variable name issue\n");
	printf("closing function should use }, not ]\n");
}
