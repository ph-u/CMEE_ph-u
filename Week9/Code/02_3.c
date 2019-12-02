/* 
Author: PokMan Ho pok.ho19@imperial.ac.uk
Script: 02_3.c
Desc: print terminal message
Input: clang 02_3.c -o 02_3;./02_3
Output: terminal output
Arguments: 2
Date: Dec 2019
*/

#include <stdio.h>

int main (void)
{  
      int x = 300; 
      printf("The value of x: %i\n", x);
    //  return x;
      printf("The value of x: %c\n", x);
      printf("The value of x: %f\n", (float)x);
      printf("The value of x: %e\n", (double)x);
}
