#include "genome.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main(int argc, char ** argv) {
	if(argc < 2) {
		fprintf(stderr, "main exited because of invalid arguments");
		return EXIT_FAILURE;
	}
	int size_of_seq = 0;
	int * longest = Longest_conserved_gene_sequence(argv[1], &size_of_seq);
	fprintf(stdout, "Length: %d\n", size_of_seq);
	free(longest);
	return EXIT_SUCCESS;
}
