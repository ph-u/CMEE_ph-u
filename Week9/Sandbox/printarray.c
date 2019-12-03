#include <stdio.h>
#include <stdbool.h>

void print_int_array(const int array[], const int nelems, bool newline){ // small, do one job, not modifying input variables
	int i = 0;
//	const int limit = nelems; // declare an initialized constant
	for(i=0; i<nelems; ++i){
		printf("%i", array[i]);
		if(i<(nelems-1)){
			printf(", ");
		}
	}
	if(newline == false){
		return;
	}
	printf("\n");
	return;
}
/*
int main (void){
	int intarray[] = {8,6,44,2,1,51};
	print_int_array(intarray, 6, false);
}
*/
