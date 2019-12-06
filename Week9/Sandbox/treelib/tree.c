#include "tree.h"
#include <stdlib.h>

tree_t* new_tree(int num_taxa)
{
	int i=0;
	tree_t *newt = NULL;
	newt = (tree_t*)calloc(1, sizeof(tree_t));
	if(newt != NULL){
		newt->num_taxa	= num_taxa;
		newt->num_nodes	= 2*num_taxa-1;
		newt->nodes		= (node_t*)calloc(newt->num_nodes, sizeof(node_t));
		if(newt->nodes == NULL){
			//allocation failed; clean up and return NULL
			free(newt);
			return NULL;
		}

	for(i=0;i<newt->num_nodes;++i){
		//assign memory indices to nodes
		newt->nodes[i].mem_index = i;
		//label tips with non-zero
		if(i<newt->num_taxa){
			newt->nodes[i].tip		= i+1;
//			((*newt).nodes[i].tip)	= i+1;
		}else{
			//label the internal nodes with 0 tip
			newt->nodes[i].tip = 0;
		}
	}

	}
	return newt;
}

void delete_tree(tree_t* tree)
{
	//implement me
}

void tree_clear_connects(tree_t* t)
{
		int i = 0;
		for(i=0; i < t->num_nodes; ++i){
				t->nodes[i].left = NULL;
				t->nodes[i].right= NULL;
				t->nodes[i].anc = NULL;
		}
}

void tree_read_anc_table(int *anctable, tree_t* t)
{
	int i	= 0;
	int j	= 0;

	// clear all connector pointers: assume NULL values
	tree_clear_connects(t);
/*
	loop over all elements of anctable
	at each position link that node to its ancestor
*/
	for (i=0; i<t->num_nodes-1; ++i){
			j = anctable[i];// index of ancestor of ith node
			t->nodes[i].anc = &t->nodes[j]; //pointing first node ancestor pointer & assign address of nodes to pointer
		if(t->nodes[j].left == NULL){
			t->nodes[j].left = &t->nodes[i];
		}else{
			t->nodes[j].right = &t->nodes[i];
		}
	}
	t->root = &t->nodes[t->num_nodes-1];
}

void tree_traverse(tree_t* t)
{
		node_traverse(t->root);
}
