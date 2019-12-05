// data grouping by struct xxx {};
#include <stdio.h>
#include <stdlib.h>

struct listobj { // not use any mem; show existence of a data type
	int data;
	struct listobj* next; //next is a pointer to a newly-declared datatype listobj; next is a pointer to a struct called "listobj"
};

void traverse_list(struct listobj* lobj)
{
	// this function traverses a list recursively and calls out the integer stored inside
	if (lobj != NULL){
		printf("int data: %i\n", (*lobj).data); // preorder excution
		traverse_list((*lobj).next);
		printf("int data: %i\n", (*lobj).data); // postorder execution
	}
}

int main (void)
{
	struct listobj l1; // mem used, declare instance needed
	struct listobj l2;
	struct listobj l3;
	struct listobj l4;

	int intarray[3] = {10,21,33};
	l1.data = 10; // ".": member-selection operator
	l2.data = 21;
	l3.data = 33;
	l4.data = 41;

	//l1.next; // address, not yet initialized -- give garbage pointer
	l1.next = &l2; // "&": address of...
	l2.next = &l3;
	l3.next = NULL;

	// loop through a linked list:
	struct listobj* p = NULL;
	p = &l1;
	// look at member selestion via a pointer
	int data= 0;
//	data = (*p).data; // "." > "*" in compilation
	data = p -> data; // same as the above line

	// leverage for looping
	while (p!=NULL){
		printf("data in p: %i\n", (*p).data);
		p = p->next;
	}
	printf("\n");

	// traverse list recursively using a function
	printf("traversing recursively:\n");
	traverse_list(&l1);
	printf("\n");

	//Insert a new element
	l4.next = &l2;
	l1.next = &l4;
	p = &l1; // reinitialize p
	while (p!=NULL){
		printf("data in p: %i\n", (*p).data);
		p = p->next;
	}
	printf("\n");

	// traverse list recursively using a function
	printf("traversing recursively:\n");
	traverse_list(&l1);
	printf("\n");

	return 0;
}
