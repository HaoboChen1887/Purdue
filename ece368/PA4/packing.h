#ifndef __PACKING_H__
#define __PACKING_H__
#define STACK_SIZE 10
typedef struct _Item{ // Item that stores basic specs
	int idx; // index of a tree node 
	char divid; // division label of a non-leaf node
	double w; // original width of a block
	double h; // original height of a block
}Item; 

typedef struct _Tnode { // Tree Node
	struct _Item item; // item that stores basic specs
	double alt_w; // an alternative width solution
	double alt_h; // an alternative height solution
	double x; // x coordinate
	double y; // y coordinate
	struct _Tnode * left; // left child
	struct _Tnode * right; // right child
}Tnode;

typedef struct _Stack{ // Stack structure
	int top; // stack top
	int size; // stack size
	struct _Tnode ** tnodes; // Tnodes as stack elements 
}Stack;

Tnode * load_tree(char * filename); // load tree from file
void packing(Tnode * tn); // perform packing and calculate x, y coordinates
void reroot(Tnode * grnd, Tnode * prnt, Tnode * tn, double * min); // find the best reroot solution
Tnode * save_tree(char * filename, Tnode * tn); // save the orignal tree to the file
Tnode * tree_insert(Tnode * tn, Tnode * left, Tnode * right); // insert new nodes into the tree;
void tree_destroy(Tnode * tn); // destroy the entire tree and free memories;
#endif

