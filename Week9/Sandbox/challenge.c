#include <stdio.h>

int round_dbl(double flt)
{
	long long x = flt; // long long is int
	double r = flt - (double)x;
	if (r >= .5){
		++x;
	}
	return x;
}

int (*ret_rrdbl_fxn(void))(double)
{
	return &round_dbl;
}

int main (void)
{
	int (* (*x)()) (double); //Q: what is x?
	int (*y)(double); // y is a pointer to a function that takes double and returns int
	x = ret_rrdbl_fxn;
	y = (*x)();
	double dbl = 3.5129;
	printf("3.5129 rounded to nearest whole: %i\n", (*y)(dbl));
	return 0;
}
/* Ans l.20
returns int
func takes type double
pointer function
x pointer as a function takes nothing

x is a pointer to a function with no input; returns a pointer to a function takes a type double input and returns an integer

pointer gives flexibility to functions
*/
