#include <stdio.h>

int main (void){
	char cap = '\0';
	char ost = 'A'-'a'; // any pair of letters

	printf("Input a capital character: ");
	cap = getchar();

	//if(cap>='A') if(cap<='Z')printf("Lower case of %c: %c", cap,cap-ost); // valid if only one function line is inside
/*
	if(cap>='A'){ // if condition satisfied, value non-0
	if(cap<='Z'){
	printf("Lower case of %c: %c\n", cap,cap-ost);
	}
	else{
	printf("input out of range (Z!); enter a capital letter\n");
	}}
	else{
	printf("input out of range (A!); enter a capital letter\n");
	}
	return 0;
*/
	if(cap>='A' && cap<='Z'){
	printf("Lower case of %c: %c\n", cap,cap-ost);
	}else{
	printf("input out of range -- CAPITAL letter required\n");
	}
}
