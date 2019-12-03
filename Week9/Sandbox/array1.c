#include <stdio.h>

int main (void){
	int i = 0; // interpretation: reserve mem with a read/write size of an int
	int j = 0;
	char c = 'c';
	double pi = 3.14;

	int intarray[4]; // explicit array size declaration
	int intarray2[] = {0, 0, 1, 4}; // implicit array size declaration and write each element content

	int matrix[2][4]; // matrices can be specified
	int nmatrix[2][4][3]; // n-dim matrices

	//reading and writing from/to arrays:
	//e.g. read from uninitialised array:
	// read/write in C zero-based:
	j=intarray[0];
	printf("intarray at position 0: %i\n", j);
	printf("intarray at position 1: %i\n", intarray[1]);
	printf("intarray at position 2: %i\n", intarray[2]);
	printf("intarray at position 3: %i\n", intarray[3]);

	printf("intarray2 at position 0: %i\n", intarray2[0]);
	printf("intarray2 at position 1: %i\n", intarray2[1]);
	printf("intarray2 at position 2: %i\n", intarray2[2]);
	printf("intarray2 at position 3: %i\n", intarray2[3]);

	intarray2[0]=3;
	intarray2[1]=2;
	printf("after assignment:\n");
	printf("intarray at position 0: %i\n", intarray2[0]);
	printf("intarray at position 0: %i\n", intarray2[1]);
	printf("intarray at position 0: %i\n", intarray2[2]);
	printf("intarray at position 0: %i\n", intarray2[3]);
	
	printf("reading out of intarray bounds: %i\n", intarray[4]);

return 0;
}
