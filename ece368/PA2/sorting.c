#include "sorting.h"
#include <stdio.h>
#include <stdlib.h>

static int power(int base, int exp);
static int get_num_of_row(int Size);
static int get_pow_of_3(int Size, int num_of_2);
static Node * node_idx(Node* list, int idx, int size);

Node * Load_From_File(char * Filename) {
	FILE * fp = fopen(Filename, "r");
	if(fp == NULL) {
		fprintf(stderr, "The loading function exited because fopen failed\n");
		return NULL;
	}
	if(fseek(fp, 0, SEEK_END) == -1) {
		fprintf(stderr, "The loading function exited because fseek failed\n");
		fclose(fp);
		return NULL;
	}
	int file_size = ftell(fp);
	if(file_size == -1) {
		fprintf(stderr, "The loading function exited because ftell failed\n");
		fclose(fp);
		return NULL;
	}
	if(fseek(fp, 0, SEEK_SET) == -1) {
		fprintf(stderr, "The loading function exited because fseek failed\n");
		fclose(fp);
		return NULL;
	}
	int size = file_size / sizeof(long); 
	// link the list in a circular fashion, with the header node storing the number 
	// of elements(excluding itself) in the list
	Node * header = (Node *)malloc(sizeof(Node));
	Node * curr = (Node *)malloc(sizeof(Node));
	header -> next = curr;
	header -> value = 0;
	for(int ct = 0; ct < size; ct ++) {
		if(curr == NULL) {
			fprintf(stderr, "The loading function exited because malloc failed\n");
			fclose(fp);
			return NULL;
		}
		if(fread(&(curr -> value), sizeof(long), 1, fp) != 1) {
			fprintf(stderr, "The loading function exited because fread failed\n");
			fclose(fp);
			return NULL;
		}
		if(ct + 1 == size) {
			curr -> next = header;
		}
		else {
			curr -> next = (Node *)malloc(sizeof(Node));
			curr = curr -> next;
		}
		(header -> value) ++;
	}
	fclose(fp);
	return header;
}

int Save_To_File(char * Filename, Node * list) {
	FILE * fp = fopen(Filename, "w");
	if(fp == NULL) {
		fprintf(stderr, "save to file exited because fopen failed\n");
		return 0;
	}
	int size = 0;
	Node * curr = list -> next;
	while(curr -> next != list -> next) {
		if(fwrite(&(curr -> value), sizeof(long), 1, fp) != 1) {
			fprintf(stderr, "save to file exited because fwrite failed\n");
			return -1;
		}
		Node * delete = curr;
		curr = curr -> next;
		free(delete);
		size ++;
	}
	free(list);
	fclose(fp);
	return size;
}

Node * Shell_Sort(Node * list) {
	int size = list -> value;
	int num_of_2 = get_num_of_row(size);
	for(int row = num_of_2; row >= 0; row --) {
		int num_of_3 = get_pow_of_3(size, row);
		for(int threes = num_of_3; threes >= 0; threes --) {
			int twos = row - threes;
			int seq = power(2, twos ++) * power(3, threes);
			for(int idx = seq; idx < size; idx ++) {
				Node * temp = node_idx(list, idx - 1, size);
				int nxt = idx;
				Node * pre_prev = node_idx(list, nxt - seq - 1, size);
				Node * pre_node = pre_prev -> next;
				Node * pre_next = pre_node -> next;
				Node * post_prev = temp;
				Node * post_node = post_prev -> next;
				Node * post_next = post_node -> next;
				temp = temp -> next;
				// handle the special situation when seq = 1
				if(seq == 1) {
					int ct = 1;
					post_prev -> next = post_next;
					pre_prev = list;
					pre_node = list -> next;
					while(ct <= idx && pre_node -> value < temp -> value) {
						pre_prev = pre_prev -> next;
						pre_node = pre_node -> next;
						ct ++;
					}
						temp -> next = pre_node;
						pre_prev -> next = temp;
				}
				
				else {
					while(nxt >= seq && pre_node -> value > temp -> value) {
						// link prev node to the next position
						post_prev -> next = pre_node;
						pre_node -> next = post_next;
						
						nxt -= seq;
						post_prev = pre_prev;
						post_node = pre_node;
						post_next = pre_next;
						pre_prev = node_idx(list, nxt - seq - 1, size);
						pre_node = pre_prev -> next;
						pre_next = pre_node -> next;
					}
					// link temp node to the right position
					post_prev -> next = temp;
					temp -> next = post_next;
				}
			}
		}
	}
	return list;
}

// Learnt from Profressor Koh's Lecture
// calculate the base^exp value;
static int power(int base, int exponential) {
	if(exponential == 0) {
		return 1;
	}
	int pdt = power(base, exponential / 2);
	if(exponential % 2 == 0) {
		return pdt * pdt;
	}
	else {
		return pdt * pdt * base;
	}
}

// calculate the number of rows of the triangular sequence
static int get_num_of_row(int Size) {
	int ct = 0;
	for(int num = Size; num > 3; num /= 2) {
		ct ++;
	}
	return ct + 1;
}

// calculate the number of items that is necessary in a single row 
static int get_pow_of_3(int Size, int num_of_2) {
	int num_of_3 = 0;
	int pdt = 0;
	while(num_of_2 >= 0 && pdt <= Size) {
		pdt = power(2, num_of_2) * power(3, num_of_3);
		num_of_2 --;
		num_of_3 ++;
	}
	if(num_of_2 >= 0) {
		num_of_3 --;
	}
	return num_of_3 - 1;
}

// return the node with specified index
static Node * node_idx(Node* list, int idx, int size) {
	Node * curr = list -> next;
	if(idx > size || idx < 0) {
		return list;
	}
	for(int ct = 0; ct < idx; ct ++) {
		curr = curr -> next;
	}
	return curr;
}
