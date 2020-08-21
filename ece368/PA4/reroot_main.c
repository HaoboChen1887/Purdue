#include "packing.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char ** argv) {
	if(argc < 3) {
		fprintf(stderr, "main exited because of invalid arguments");
		return EXIT_FAILURE;
	}

	// load tree from file
	Tnode * tn = load_tree(argv[1]);
	packing(tn);
	Tnode * result = save_tree(argv[2], tn);
	double min[2] = {tn -> alt_w, tn -> alt_h};
	// create a dummy node for the ease of future operation
	Item d_item = {
		.idx = 0,
		.divid = 'H',
		.w = 0,
		.h = 0
	};
	Tnode * dummy = malloc(sizeof(*dummy));
	if(dummy == NULL) {
		fprintf(stderr, "main exited because malloc failed");
		return EXIT_FAILURE;
	}
	dummy -> left = tn;
	dummy -> right = NULL;
	dummy -> item.divid = d_item.divid;
	dummy -> item.idx = d_item.idx;
	dummy -> item.w = d_item.w;
	dummy -> item.h = d_item.h;
	dummy -> alt_w = d_item.w;
	dummy -> alt_h = d_item.h;
	dummy -> x = 0;
	dummy -> y = 0;
	reroot(dummy, tn, tn, min);
	
	// print result
	fprintf(stdout, "Width: %le\n", tn -> item.w);
	fprintf(stdout, "Height: %le\n", tn -> item.h);
	fprintf(stdout, "X-coordinate: %le\n", result -> x);
	fprintf(stdout, "Y-coordinate: %le\n", result -> y);
	fprintf(stdout, "Best width: %le\n", min[0]);
	fprintf(stdout, "Best height: %le\n", min[1]);
	
	// destroy the tree
	tree_destroy(dummy);
	return EXIT_SUCCESS;
}
