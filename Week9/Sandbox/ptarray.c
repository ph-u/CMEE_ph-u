#include <stdio.h>
#include <stdlib.h> // defines NULL pointers & more

int main (void)
{
	int integers[] = {2,33,4,10,11};
	int (*aintptr)[] = NULL; // pointer to an array of integers
	int *aintptr2 = NULL; // pointer to an integer

	aintptr = &integers;

	printf("val at index 1 in intarray via indirection: %i\n", (*aintptr)[1]); // bound pointers -> index the array

	aintptr2 = integers;
	printf("dereferencing pointer to array: %i\n", *aintptr2);
	printf("get 2nd value by pointer arithmetric: %i\n", *(aintptr2+1));
	printf("get 2nd value by array subscripting: %i\n", aintptr2[1]);

	int *endofarray = NULL; // pointing to specific value of array
	endofarray = &integers[4]; // now points to last element of array
	for(aintptr2 = integers; aintptr2 <= endofarray; ++aintptr2){ // happen at start; start of each iter; end of each iter
	printf("%i ", *aintptr2); // deref ptr
} // end up in invalid seq in intergers[]
	printf("\n");
	return 0;
}
