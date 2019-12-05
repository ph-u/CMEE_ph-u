#ifndef _NODE_H
#define _NODE_H

//a typedef save keystrokes: typedef <known type> <new alias>
typedef struct _node node_t;
typedef struct _node {
	node_t*	left;
	node_t*	right;
	node_t*	anc;
	int		tip;
	int		mem_index;
	char	*label;
} node_t;

//node_t* new_node(void);
//void    delete_node;


#endif
