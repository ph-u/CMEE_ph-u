/* 
Author: PokMan Ho pok.ho19@imperial.ac.uk
Script: 03_1.c
Desc: constants and data type conversions
Input: clang 03_1.c -o 03_1;./03_1
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void){
	char a = 'a';
	float b = 30.19;
	printf("char 'a'-1: %c -> %c\n", a,a-1);
	printf("float -1: %f -> %f\n", b,b-1);
	printf("add char to float: %f -> %f\n", b,b+a);
}
