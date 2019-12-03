/* 
Author: PokMan Ho pok.ho19@imperial.ac.uk
Script: 02_4.c
Desc: variable types impact
Input: clang 02_4.c -o 02_4;./02_4
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void){
	int x = 'a';
	char x1 = 'a'; // " & ' incompetable
	printf("output of %c is %i\n", x1,x);
}
