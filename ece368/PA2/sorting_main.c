#include "sorting.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char ** argv) {
	double ini_t = clock();
	if(argc < 3) {
		return EXIT_FAILURE;
	}
	
	Node * header = Load_From_File(argv[1]);
//	Node * curr = header -> next;
//	fprintf(stdout, "%ld\n", header -> value);
//	while(curr -> next != header -> next) {
//		fprintf(stdout, "%ld\n", curr -> value);
//		curr = curr -> next;
//	}
//	Node * header = malloc(sizeof(Node));
//	header -> value = 10;
//	Node * curr = header;
//	for(long i = 9; i >= 0; i--) {
//		curr -> next = malloc(sizeof(Node));
//		curr = curr -> next;
//		curr -> value = i;
//	}
//	curr -> next = header;
	header = Shell_Sort(header);
	double sort_cost = clock();

	Save_To_File(argv[2], header);
	fprintf(stdout, "\n");
	header = Load_From_File(argv[2]);
	//Node * curr = header -> next;
//	curr = header -> next;
//	while(curr -> next != header -> next) {
//		fprintf(stdout, "%ld\n", curr -> value);
//		Node * delete = curr;
//		curr = curr -> next;
//		free(delete);
//	}
//	free(header);

	fprintf(stdout,"I/O time: %le\n", (clock() - ini_t) / CLOCKS_PER_SEC);
	fprintf(stdout,"Sorting time: %le\n", (sort_cost - ini_t) / CLOCKS_PER_SEC);

	return EXIT_SUCCESS;
}
