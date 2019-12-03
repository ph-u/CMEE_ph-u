/* 
Author: PokMan Ho pok.ho19@imperial.ac.uk
Script: 03_2.c
Desc: testing cast results
Input: clang 03_2.c -o 03_2;./03_2
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void){
	char a = 'a';
	int b = 30;
	printf("casting '%c' as integer -> %i\n", a,a);
	printf("casting '%i' as character -> %c\n", b,b);
}
