#include "genome.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

static int ** load_from_file(char * filename, int * size, int * root);
static void find_seq(int ** matrix, int * seq, int * tmp, int row, int size, int len, int * size_of_seq, int reset);
static bool eoseq(int * row, int size);
static void zeros(int * array, int size);
//static void array_cp(int * des, int * src, int size);

int * Longest_conserved_gene_sequence(char * filename, int * size_of_seq) {
	int size = 0;
	int root = 0; // The row number of the root node in the matrix
	int ** adj_mx = load_from_file(filename, &size, &root);
	int * temp = malloc(sizeof(*temp) * size);
	int * seq = malloc(sizeof(*temp) * size);
	zeros(temp, size);
	zeros(seq, size);
	find_seq(adj_mx, seq, temp, root, size, 0, size_of_seq, root);
	int * longest = malloc(sizeof(*longest) * ++(*size_of_seq));
	for(int ct = 0; ct < (*size_of_seq); ct ++) {
		longest[ct] = seq[ct];
	}
	for(int ct = 0; ct < size; ct ++) {
		free(adj_mx[ct]);
	}
	free(adj_mx);
	free(temp);
	free(seq);
	return longest;
}

static int ** load_from_file(char * filename, int * size, int * root) {
		FILE * fp = fopen(filename, "r");
	// check fopen
	if(fp == NULL) {
		fprintf(stderr, "load_from_file exited because the file specified can't be opened");
		return NULL;
	}
	int spc = 0;
	int num = 0;
	if(fread(&num, sizeof(int), 1, fp) != 1) {
		// check fread
		fprintf(stderr, "load_from_file exited because fread of spc failed");
		fclose(fp);
		return NULL;
	}
	if(fread(&spc, sizeof(int), 1, fp) != 1) {
		// check fread
		fprintf(stderr, "load_from_file exited because fread of num failed");
		fclose(fp);
		return NULL;
	}
	int ** adj_mx = malloc(sizeof(*adj_mx) * num);
	*size = num;
	// check malloc
	if(adj_mx == NULL) {
		fprintf(stderr, "load_from_file exited because malloc of adj_mx failed");
		fclose(fp);
		return NULL;
	}
	// Initialize the adjacency matrix
	for(int row = 0; row < num; row ++) {
		adj_mx[row] = malloc(sizeof(**adj_mx) * num);
		// check malloc
		if(adj_mx[row] == NULL) {
			fprintf(stderr, "load_from_file exited because malloc of adj_mx[row] failed");
			for(int dl = row - 1; dl >= 0; dl --) {
				free(adj_mx[dl]);
			}
			fclose(fp);
			return NULL;
		}
		for(int col = 0; col < num; col ++) {
			adj_mx[row][col] = 0;
		}
	}

	int * seq = malloc(sizeof(*seq) * num); // stores the value of the current species
	// check malloc
	if(seq == NULL) {
		fprintf(stderr, "load_from_file exited because malloc of seq failed");
		return NULL;
	}
	bool fst = true; // flag for the first iteration
	int max_edge = 0;; // maximum number of edges connected to a node
	// Read data
	for(int row = 0; row < spc; row ++) {
		if(fread(seq, sizeof(int), num, fp) != num) {
			// check fread
			fprintf(stderr, "load_from_file exited because fread of seq failed");
			fclose(fp);
			return NULL;
		}
		int head;
		for(head = 0; head < num; head ++) {
			for(int tail = head + 1; tail < num; tail ++) {
				adj_mx[seq[head] - 1][seq[tail] - 1]++;
			}
			if(!fst) { // Not the first iteration
				for(int col = 0; col < num; col ++) {
					if(adj_mx[seq[head] - 1][col] != 0) {
						adj_mx[seq[head] - 1][col]--; // decrement anything that is not a common sequence to 0
					}
				}
			}
		}
		fst = false;
	}
	// find the row number of the node with the largest number of edges connected to it
	for(int row = 0; row < num; row ++) {
		if(eoseq(adj_mx[row], num)) {
			adj_mx[row][0] = -1;
		}
		int edges = 0; // number of edges connected to the current node
		for(int col = 0; col < num; col ++) {
			edges += adj_mx[row][col];
		}
		if(edges > max_edge) {
			max_edge = edges;
			*root = row;
		}
	}
	free(seq);
	fclose(fp);
	return adj_mx;
}

static void find_seq(int ** matrix, int * seq, int * tmp, int row, int size, int len, int * size_of_seq, int reset) {
	if(matrix[row][0] == -1) {
		if(len > *size_of_seq) {
			*size_of_seq = len;
			for(int n = 0; n <= len; n ++) {
				seq[n] = tmp[n];
			}
		}
		return;
	}
	for(int idx = 0; idx < size; idx ++) {
		if(matrix[row][idx] == 1) {
			if(reset == row) {
				len = 0;
			}
			tmp[len ++] = row + 1; // update len
			tmp[len] = idx + 1;
			find_seq(matrix, seq, tmp, idx, size, len, size_of_seq, reset);
		}
	}
	return;
}

// check if the current element is the end of sequence
static bool eoseq(int * row, int size) {
	for(int i = 0; i < size; i ++) {
		if(row[i] != 0) {
			return false;
		}
	}
	return true;
}

// initialize array elements to zero
static void zeros(int * array, int size) {
	for(int ct = 0; ct < size; ct ++) {
		array[ct] = 0;
	}
	return;
}
