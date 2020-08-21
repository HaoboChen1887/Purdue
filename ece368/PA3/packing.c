#include "packing.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

static Tnode * Tnode_construct(Item item);
static void stack_init(Stack * sptr);
static Tnode * stack_top(Stack * sptr);
static int empty(Stack * sptr);
static Tnode * pop(Stack * sptr);
static int push(Stack * sptr, Tnode * tn);
static Item item_construct(Item item, int idx, char divid, double w, double h);
static int large(int a, int b);

// load the tree information from given files
Tnode * load_tree(char * filename) {
	FILE * fp = fopen(filename, "r");
	if(fp == NULL) {
		fprintf(stderr, "load_tree exited because fopen failed");
		return NULL;
	}

	Tnode * tn = NULL;
	Tnode * left = NULL;
	Tnode * right = NULL;
	int idx = 0;
	char divid = '\0';
	double w = 0;
	double h = 0;
	Stack * sptr = malloc(sizeof(*sptr));
	stack_init(sptr);
	Item item = item_construct(item, 0, '\0', 0, 0);
	
	// Push the information into the stack
	// Use stack to build the tree directly
	while(fgetc(fp) != EOF) {
		fseek(fp, -1, SEEK_CUR);
		divid = fgetc(fp);
		if(divid == 'V' || divid == 'H') {
			item = item_construct(item, 0, divid, 0, 0);
			push(sptr, Tnode_construct(item));
			tn = pop(sptr);
			right = pop(sptr);
			left = pop(sptr);
			// Assign label nodes the total size of its children
			if(divid == 'V') {
				tn -> item.w = left -> item.w + right -> item.w;
				tn -> item.h = large(left -> item.h, right -> item.h);
			}
			else if(divid == 'H') {
				tn -> item.w = large(left -> item.w, right -> item.w);
				tn -> item.h = left -> item.h + right -> item.h;
			}
			tn -> right = right;
			tn -> left = left;
			fgetc(fp);
		}
		else {
			fseek(fp, -1, SEEK_CUR);
			if(fscanf(fp, "%d(%le,%le)\n", &idx, &w, &h) == EOF) {
				fprintf(stderr, "load_tree exited because fscanf failed");
				fclose(fp);
				return NULL;
			}
			item = item_construct(item, idx, divid, w, h);
			push(sptr, Tnode_construct(item));
		}
		if(tn != NULL) {
			push(sptr, tn);
			tn = NULL;
		}
		item = item_construct(item, 0, '\0', 0, 0);
	}

	// Root is always the third item left over on the stack
	tn = sptr -> tnodes[2];
	free(sptr -> tnodes);
	free(sptr); 
	fclose(fp);
	return tn;
}

void packing(Tnode * tn) {
	if(tn == NULL) {
		return;
	}
	if(tn -> item.divid == 'H') {
		tn -> left -> x = tn -> x;
		tn -> left -> y = tn -> y + tn -> right -> item.h;
		tn -> right -> x = tn -> x;
		tn -> right -> y = tn -> y;
	}
	else if(tn -> item.divid == 'V') {
		tn -> left -> x = tn -> x;
		tn -> left -> y = tn -> y;
		tn -> right -> x = tn -> x + tn -> left -> item.w;
		tn -> right -> y = tn -> y;
	}
	packing(tn -> left);
	packing(tn ->right);
	return;
}

// Save the tree structure to the file specified
Tnode * save_tree(char * filename, Tnode * tn) {
	FILE * fp = fopen(filename, "w");

	Tnode * curr = tn;
	Tnode * result = tn; // get the node with largest index

	Stack * sptr = malloc(sizeof(*sptr));
	Stack * sptr_div = malloc(sizeof(*sptr));
	stack_init(sptr);
	stack_init(sptr_div);

	// inorder traversal with stack from the left branch
	do {
		while(curr != NULL) {
			if(curr != stack_top(sptr)) {
				push(sptr, curr);
			}
			curr = curr -> left;
		}
		curr = pop(sptr);
		if(curr != NULL) {
			// When it is not a dividing label
			if(curr -> item.divid != 'H' && curr -> item.divid != 'V') {
				if(curr -> item.idx > result -> item.idx) {
					result = curr; // get the node with largest index
				}
				fprintf(fp, "%d %le %le %le %le\n", curr -> item.idx, curr -> item.w, curr -> item.h, curr -> x, curr -> y);
			}
			
		}
		if(curr -> right != NULL) {
			push(sptr, curr -> right);
		}
		curr = curr -> right;
	}while(!empty(sptr));
	
	free(sptr_div -> tnodes);
	free(sptr_div);
	free(sptr -> tnodes);
	free(sptr);
	fclose(fp);
	return result;
}

// destroy the entire tree and free allocated memory
void tree_destroy(Tnode * tn) {
	Tnode * curr = tn;
	Stack * sptr = malloc(sizeof(*sptr));
	stack_init(sptr);
	// inorder traversal with stack
	do {
		while(curr != NULL) {
			if(curr != stack_top(sptr)) {
				push(sptr, curr);
			}
			curr = curr -> left;
		}
		curr = pop(sptr);
		if(curr -> right != NULL) {
			push(sptr, curr -> right);
		}
		if(curr != NULL) {
			Tnode * delete = curr;
			curr = curr -> right;
			free(delete);
		}
	}while(!empty(sptr));
	free(sptr -> tnodes);
	free(sptr);
}

// initialize or construct a tree node
static Tnode * Tnode_construct(Item item) {
	Tnode * tn;
	tn = malloc(sizeof(Tnode));
	if(tn == NULL) {
		fprintf(stderr, "TNode_construct exited because malloc failed");
		return NULL;
	}
	tn -> left = NULL;
	tn -> right = NULL;
	tn -> item.divid = item.divid;
	tn -> item.idx = item.idx;
	tn -> item.w = item.w;
	tn -> item.h = item.h;
	tn -> x = 0;
	tn -> y = 0;
	return tn;
}

// Initialize a stack structure
static void stack_init(Stack * sptr) {
	sptr -> top = -1;
	sptr -> size = STACK_SIZE;
	sptr -> tnodes  = malloc(sizeof(Tnode*) * sptr -> size);
	if(sptr -> tnodes == NULL) {
		fprintf(stderr, "stack_init exited because malloc failed");
		return;
	}
}

// return the top element on the stack
static Tnode * stack_top(Stack * sptr) {
	return (empty(sptr) ? NULL : sptr -> tnodes[sptr -> top]);
}

// check if the stack is empty
static int empty(Stack * sptr) {
	return (sptr -> top < 0);
}

// pop the top item on the stack, return a Tnode *
static Tnode * pop(Stack * sptr) {
	Tnode * results = sptr -> tnodes[sptr -> top];
	sptr -> top --;
	return results;
}

// Push a Tnode onto the stack
static int push(Stack * sptr, Tnode * tn) {
	if(sptr -> top >= sptr -> size - 1) {
		sptr -> tnodes = realloc(sptr -> tnodes, sizeof(Tnode *) * sptr -> size * 2);
		if(sptr -> tnodes == NULL) {
			fprintf(stderr, "push exited because malloc failed");
			return 0;
		}
	}
	sptr -> tnodes[++(sptr -> top)] = tn;
	return 1;
}

// Initialize an item struct 
static Item item_construct(Item item, int idx, char divid, double w, double h) {
	item.idx = idx;
	item.divid = divid;
	item.w = w;
	item.h = h;
	return item;
}

// Return the larger number of the two
static int large(int a, int b) {
	return ((a > b) ? a : b);
}


