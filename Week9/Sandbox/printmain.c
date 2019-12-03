#include <stdbool.h> // find header in std lib
#include "printarray.h" // find header in current dir (can use path)
//void print_int_array(int array[], int nelems, bool newline);

int main (void){
	int array[] = {4,5,6,7,88};
	print_int_array(array,5,true);
}
