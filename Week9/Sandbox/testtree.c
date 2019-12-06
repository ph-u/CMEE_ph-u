#include <stdlib.h>
#include "tree.h"
#include "node.h"

int main (void)
{
		tree_t* t = NULL;
		int anctable[] = {6,7,7,5,5,6,8,8,-1};
		t = new_tree(5);
		tree_read_anc_table(anctable, t);
		tree_traverse(t);
		return 0;
}
