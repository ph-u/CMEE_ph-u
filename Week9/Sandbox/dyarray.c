#include <stdio.h>
#include <stdlib.h>

int main (void)
{
	int numsites = 30;
	int *sppcounts = NULL;

	sppcounts = (int*)malloc(numsites * sizeof(int)); // mem allocation on heap, not stack

	// check malloc succeeded and returned a valid pointer
	if(sppcounts == NULL){
	printf("insufficient mem for operation\n");
	return 1; //exit program
	}

	sppcounts[20] = 44;

	int i = 0;
	for(i=0; i<numsites; ++i){
		printf("data 1 in site %i is: %i\n", i, *(sppcounts +i));
	}

	// free mem, return it to the system before overwriting the pointer to that memory
	free(sppcounts); // or else called "mem leak", only overwrite mem by later mem request
	sppcounts=NULL;
// check whether malloc & calloc return NULL

	sppcounts = (int*)calloc(numsites, sizeof(int)); // clear mem allocation on heap
	sppcounts[20] = 44;
	for(i=0; i<numsites; ++i){
		printf("data 2 in site %i is: %i\n", i, sppcounts[i]); // same as above
	}

	free(sppcounts);
	sppcounts=NULL;

	return 0;
}
