#ifndef __GENOME__
#define __GENOME__
typedef struct _Gseq{
	int connect;
	int * subseq;
}Gseq;

int * Longest_conserved_gene_sequence(char * filename, int * size_of_seq);
#endif
