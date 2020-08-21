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
static bool alt_is_better(Tnode * prnt, double * alt);
static bool alt_is_same(Tnode * prnt, double * alt);
static double * better_soln(Tnode * prnt, double * min, double * alt);
static void calc_wh(Tnode * prnt, Tnode * new_l, Tnode * new_r, double * alt);
//static int small(int a, int b);

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
				tn -> alt_w = tn -> item.w;
				tn -> alt_h = tn -> item.h;
			}
			else if(divid == 'H') {
				tn -> item.w = large(left -> item.w, right -> item.w);
				tn -> item.h = left -> item.h + right -> item.h;
				tn -> alt_w = tn -> item.w;
				tn -> alt_h = tn -> item.h;
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
			item = item_construct(item, idx, 'N', w, h);
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

// pack the tree representation
void packing(Tnode * tn) {
	if(tn == NULL) {
		return;
	}
	if(tn -> item.divid == 'H') {
		// if vertical division pass coordinate to right and calc left coordinate
		tn -> left -> x = tn -> x;
		tn -> left -> y = tn -> y + tn -> right -> item.h;
		tn -> right -> x = tn -> x;
		tn -> right -> y = tn -> y;
	}
	else if(tn -> item.divid == 'V') {
		// if vertical division pass coordinate to left and calc right coordinate
		tn -> left -> x = tn -> x;
		tn -> left -> y = tn -> y;
		tn -> right -> x = tn -> x + tn -> left -> item.w;
		tn -> right -> y = tn -> y;
	}
	packing(tn -> left);
	packing(tn ->right);
	return;
}

// find the reroot edge that result in a minimum packing area
void reroot(Tnode * grnd, Tnode * prnt, Tnode * tn, double * min) {
	//if(tn -> left == NULL && tn -> right == NULL) {
	if(tn == NULL || tn -> item.divid == 'N') {
		return;
	}
	double alt[2] = {0, 0};
	double alt_l[2] = {0, 0};
	double alt_r[2] = {0, 0};
	if(tn == prnt -> left) {
		// Goto the left 
		tn -> alt_w = min[0];
		tn -> alt_h = min[1];
		if(grnd == prnt) {
			calc_wh(prnt, tn -> right, prnt -> right, alt);
		}
		else {
			calc_wh(prnt, tn -> right, grnd, alt);
		}
		prnt -> alt_w = alt[0];
		prnt -> alt_h = alt[1];
		alt_l[0] = alt[0];
		alt_l[1] = alt[1];
		calc_wh(tn, tn -> left, prnt, alt);
		min = better_soln(tn, min, alt);
		// Goto the right
		if(grnd == prnt) {
			calc_wh(prnt, tn -> left, prnt -> right, alt);
		}
		else {
			calc_wh(prnt, tn -> left, grnd, alt);
		}
		prnt -> alt_w = alt[0];
		prnt -> alt_h = alt[1];
		alt_r[0] = alt[0];
		alt_r[1] = alt[1];
		calc_wh(tn, prnt, tn -> right, alt);
		min = better_soln(tn, min, alt);
	}
	else if(tn == prnt -> right) {
		// Goto the left 
		tn -> alt_w = min[0];
		tn -> alt_h = min[1];
		if(grnd == prnt) {
			calc_wh(prnt, prnt -> left, tn -> right, alt);
		}
		else {
			calc_wh(prnt, grnd, tn -> right, alt);
		}
		prnt -> alt_w = alt[0];
		prnt -> alt_h = alt[1];
		alt_l[0] = alt[0];
		alt_l[1] = alt[1];
		calc_wh(tn, tn -> left, prnt, alt);
		min = better_soln(tn, min, alt);
		// Goto the right
		if(grnd == prnt) {
			calc_wh(prnt, prnt -> left, tn -> left, alt);
		}
		else {
			calc_wh(prnt, grnd, tn -> left, alt);
		}
		prnt -> alt_w = alt[0];
		prnt -> alt_h = alt[1];
		alt_r[0] = alt[0];
		alt_r[1] = alt[1];
		calc_wh(tn, prnt, tn -> right, alt);
		min = better_soln(tn, min, alt);
	}
	if(alt_l[0] != 0 && alt_l[1] != 0){
		prnt -> alt_w = alt_l[0];
		prnt -> alt_h = alt_l[1];
	}
	reroot(prnt, tn, tn -> left, min);
	// re-initalize width & height
	if(alt_r[0] != 0 && alt_r[1] != 0){
		prnt -> alt_w = alt_r[0];
		prnt -> alt_h = alt_r[1];
	}
	tn -> left -> alt_w = tn -> left -> item.w;
	tn -> left -> alt_h = tn -> left -> item.h;
	reroot(prnt, tn, tn -> right, min);
	return;
}

// Save the tree structure to the file specified
Tnode * save_tree(char * filename, Tnode * tn) {
	FILE * fp = fopen(filename, "w");
	if(fp == NULL) {
		fprintf(stderr, "save_tree exited because the file specified can't be opened");
		return tn;
	}

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
	tn -> alt_w = item.w;
	tn -> alt_h = item.h;
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

// Check if the new packing is better
static bool alt_is_better(Tnode * prnt, double * alt) {
	return prnt -> alt_w * prnt -> alt_h > alt[0] * alt[1];
}

// Check if the new packing is the same
static bool alt_is_same(Tnode * prnt, double * alt) {
	return prnt -> alt_w * prnt -> alt_h == alt[0] * alt[1];
}

// If the new packing is better, store the value into alt fields
static double * better_soln(Tnode * prnt, double * min, double * alt) {
	if(alt_is_better(prnt, alt)) {
		prnt -> alt_w = alt[0];
		prnt -> alt_h = alt[1];
		min[0] = alt[0];
		min[1] = alt[1];
	}
	else if(alt_is_same(prnt, alt) && alt[0] < prnt -> alt_w) {
		prnt -> alt_w = alt[0];
		prnt -> alt_h = alt[1];
		min[0] = alt[0];
		min[1] = alt[1];
	}
	return min;
}

// Calculate the total width and height of two children after rerooting
static void calc_wh(Tnode * prnt, Tnode * new_l, Tnode * new_r, double * alt){
	if(prnt -> item.divid == 'N') {
		return;
	}
	if(prnt -> item.divid == 'H') {
		alt[0] = large(new_l -> alt_w, new_r -> alt_w);
		alt[1] = new_l -> alt_h + new_r -> alt_h;
	}
	else if(prnt -> item.divid == 'V') {
		alt[0] = new_l -> alt_w + new_r -> alt_w;
		alt[1] = large(new_l -> alt_h, new_r -> alt_h);
	}
}
// Return the smaller number of the two
//static int small(int a, int b) {
//	return ((a < b) ? a : b);
//}

