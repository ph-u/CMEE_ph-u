/* 
Author: ph-u
Script: 03_3.c
Desc: deincrement and increment
Input: clang 03_3.c -o 03_3;./03_3
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void){
	int a = 3;
	int b = 0;
	printf("initial [a,b]: [3,0]\n");
	b=a++;
	printf("b=a++: [%i,%i] -- b = a, then a = a+1\n", a,b);
	b=++a;
	printf("b=++a: [%i,%i] -- a = a+1, then b=a\n", a,b);
}
