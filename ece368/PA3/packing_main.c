#include "packing.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char ** argv) {
	if(argc < 3) {
		fprintf(stderr, "main exited because of invalid arguments");
		return EXIT_FAILURE;
	}
	
	Tnode * tn = load_tree(argv[1]);
	packing(tn);
	Tnode * result = save_tree(argv[2], tn);
	
	fprintf(stdout, "Width: %le\n", tn -> item.w);
	fprintf(stdout, "Height: %le\n", tn -> item.h);
	fprintf(stdout, "X-coordinate: %le\n", result -> x);
	fprintf(stdout, "Y-coordinate: %le\n", result -> y);
	
	tree_destroy(tn);
	return EXIT_SUCCESS;
}
