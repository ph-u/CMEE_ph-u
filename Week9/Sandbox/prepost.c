#include <stdio.h>

int main (void){
	int x = 6;
	int y = 0;

	//postfix incrementation:
	y=++x;
	printf("y after postfix assignment: %i\n", y);
	printf("x after postfix assignment: %i\n", x);
	//prefix incrementation:
	y=x++;
	printf("y after prefix assignment: %i\n", y);
	printf("x after prefix assignment: %i\n", x);
	//deincrement x
	//printf("x with deincrement in function call: %i\n", x--); //result undefined
	int z = x--;
	printf("x with deincrement: %i\n", x); //better syntax
	printf("x from postfix decrement: %i\n", z);
	return 0;
}
