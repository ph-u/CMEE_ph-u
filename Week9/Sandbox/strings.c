#include <stdio.h>

int main (void){
	char charray[] = {'A', ' ', 's', 't', 'r', 'i', 'n', 'g', '!', '\0'};
	char string1[] = "A string!"; //shorthand for the above declaration, hidden NULL char at end of string

	printf("The 9th element of charray: %c\n", charray[9]);
	printf("The 9th element of string1: %c\n", string1[9]);
}
