#ifndef __PACKING_H__
#define __PACKING_H__
#define STACK_SIZE 10
typedef struct _Item{
	int idx;
	char divid;
	double w;
	double h;
}Item;

typedef struct _Tnode {
	struct _Item item;
	double x;
	double y;
	struct _Tnode * left;
	struct _Tnode * right;
}Tnode;

typedef struct _Stack{
	int top;
	int size;
	struct _Tnode ** tnodes;
}Stack;

Tnode * load_tree(char * filename);
void packing(Tnode * tn);
Tnode * save_tree(char * filename, Tnode * tn);
Tnode * tree_insert(Tnode * tn, Tnode * left, Tnode * right);
void tree_destroy(Tnode * tn);
#endif

