#include <stdio.h>
#include <stdlib.h>

//prototype
int *pos_first_odd(const int[], const unsigned long);

// functions
int *pos_first_odd(const int integers[], const unsigned long size) //function of parameter int array which outputs a pointer as an integer
{
	unsigned long int c=0;
	int* ret = NULL; // * is part of the name
	//implementation code
	ret = (int*)integers;
	while ((*ret%2)==0 && c < size){ //assume *ret%2==0
		++ret;
		++c;
	}
	// if((c == size) && (*ret%2 ==0)){
	if(c == size){
		--ret; //back one step from the last \n char
		if((*ret % 2) ==0){
		return NULL;
		}
	}
	return ret; //no * `.` it is an operator
}

int main (void)
{
	int *res = NULL;
	int intarray[] = {2,4,10,21,30};
	res = pos_first_odd(intarray, 5);
	printf("res now points to: %i\n", *res);
	--(*res); // step back to the last valid element; res = res-1 (possible but not suggested)
	
	res = pos_first_odd(intarray, 5); // return NULL
	if(res != NULL){ // always check for NULL possibility
	printf("res now points to: %i\n", *res);
	}
}
