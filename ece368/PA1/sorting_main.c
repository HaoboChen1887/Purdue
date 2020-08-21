#include "sorting.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char ** argv) {
	double ini_t = clock();
	if(argc < 5) {
		return EXIT_FAILURE;
	}
	
	int N_Read = 0;
	int N_Write = 0;
	int N_Seq = 0;
	double N_Comp = 0;
	double N_Move = 0;
	long * data = Load_From_File(argv[2], &N_Read);
	
	N_Seq = Print_Seq(argv[3], N_Read);
	if(argv[1][0] == 'i' && argv[1][1] == '\0') {
		Shell_Insertion_Sort(data, N_Read, &N_Comp, &N_Move);
	}
	else if(argv[1][0] == 's' && argv[1][1] == '\0') {
		Shell_Selection_Sort(data, N_Read, &N_Comp, &N_Move);
	}
	else{
		fprintf(stderr, "main exited because of invalid argument\n");
		return EXIT_FAILURE;
	}
	double sort_cost = clock();
	
	N_Write = Save_To_File(argv[4], data, N_Read);
	if(N_Read != N_Write) {
		fprintf(stderr, "main exited because number Read and number written doesn't match\n");
		return EXIT_FAILURE;
	}
	free(data);

	fprintf(stdout,"Number of long integers read: %d\n", N_Read);
	fprintf(stdout,"Number of long integers stored: %d\n", N_Write);
	fprintf(stdout,"Length of sequence: %d\n", N_Seq);
	fprintf(stdout,"Number of comparisons: %le\n", N_Comp);
	fprintf(stdout,"Number of moves: %le\n", N_Move);
	fprintf(stdout,"I/O time: %le\n", (clock() - ini_t) / CLOCKS_PER_SEC);
	fprintf(stdout,"Sorting time: %le\n", (sort_cost - ini_t) / CLOCKS_PER_SEC);

	return EXIT_SUCCESS;
}
