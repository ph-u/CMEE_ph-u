#ifndef _PRINTARRAY_H_
#define _PRINTARRAY_H_

#include <stdio.h>
#define NWLN printf("\n")
void print_int_array(int array[], int nelems, bool newline);

#endif // _PRINTARRAY_H_
// prevent multiple inclusion looping and crash preprocessor
