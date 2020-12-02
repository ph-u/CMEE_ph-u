/* 
Author: ph-u
Script: 01_1.c
Desc: Ex.1,2 answers
Input: clang 01_1.c -o hello;./hello
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void)
{
	printf("removing stdio.h caused error \"implicitly declaring library function \'printf\' with type \'int (const char *, ...)\'\"\n");
	printf("leaving return statement commented / changing to other int has no observable impacts to final result\n");
	printf("specific type of return value clear paths for any designated values\n");
	return (float)1.1;
}
