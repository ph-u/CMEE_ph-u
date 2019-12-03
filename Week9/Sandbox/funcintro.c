#include <stdio.h>

int add_integers(int, int); // function prototype
int add_four_integers(int a, int b, int c, int d); // prototype with optional variable names

int add_four_integers(int a, int b, int c, int d){
	int result = 0;
	result = add_integers(a,b) + add_integers(c,d);
	return result;
}

int add_integers (int x, int y){ // control: flow of program
/*	int result = 0;
	result = x+y;
	return result;
*/
	return x+y;
}

int main (void){
	int a = 5;
	int b = 6;
	int result = 0;

	result = add_integers(a,b);
	printf("Sum of a & b: %i\n", result);
	printf("Sum of result & b: %i\n", add_integers(result, b));

	return 0;
} // should not have lots of stuff, program need to be modularized; may not include return but not reecommended
