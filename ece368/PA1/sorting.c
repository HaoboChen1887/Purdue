#include "sorting.h"
#include <stdio.h>
#include <stdlib.h>

static int power(int base, int exp);
static int get_num_of_row(int Size);
static int get_pow_of_3(int Size, int num_of_2);

long * Load_From_File(char * Filename, int * Size) {
	FILE * fp = fopen(Filename, "r");
	if(fp == NULL) {
		fprintf(stderr, "The loading function exited because fopen failed\n");
		return 0;
	}
	if(fseek(fp, 0, SEEK_END) == -1) {
		fprintf(stderr, "The loading function exited because fseek failed\n");
		fclose(fp);
		return 0;
	}
	int file_size = ftell(fp);
	if(file_size == -1) {
		fprintf(stderr, "The loading function exited because ftell failed\n");
		fclose(fp);
		return 0;
	}
	if(fseek(fp, 0, SEEK_SET) == -1) {
		fprintf(stderr, "The loading function exited because fseek failed\n");
		fclose(fp);
		return 0;
	}
	*Size = file_size / sizeof(long); 
	long * data = malloc(sizeof(long) * *Size);
	if(data == NULL) {
		fprintf(stderr, "The loading function exited because malloc failed\n");
		fclose(fp);
		return 0;
	}
	if(fread(data, sizeof(long), *Size, fp) != *Size) {
		fprintf(stderr, "The loading function exited because fread failed\n");
		fclose(fp);
		return 0;
	}
	fclose(fp);
	return data;
}

int Save_To_File(char * Filename, long * Array, int Size) {
	FILE * fp = fopen(Filename, "w");
	if(fp == NULL) {
		fprintf(stderr, "save to file exited because fopen failed\n");
		return 0;
	}
	for(int ct = 0; ct < Size; ct ++) {
		if(fwrite(&(Array[ct]), sizeof(long), 1, fp) != 1) {
			fprintf(stderr, "save to file exited because fwrite failed\n");
			return 0;
		}
		if(fputc('\n', fp) == EOF) {
			fprintf(stderr, "save to file exited because fputc failed\n");
			return 0;
		}
	}
	fclose(fp);
	return Size;
}

void Shell_Insertion_Sort(long * Array, int Size, double * N_Comp, double * N_Move) {
	int num_of_2 = get_num_of_row(Size);
	for(int row = num_of_2; row >= 0; row --) {
		int num_of_3 = get_pow_of_3(Size, row);
		for(int threes = num_of_3; threes >= 0; threes --) {
			int twos = row - threes;
			int seq = power(2, twos ++) * power(3, threes);
			for(int idx = seq; idx < Size; idx += seq) {
				long temp = Array[idx];
				(*N_Move) ++;
				int nxt = idx;
				while(nxt >= seq && Array[nxt - seq] > temp) {
					(*N_Comp) ++;
					Array[nxt] = Array[nxt - seq];
					(*N_Move) ++;
					nxt = nxt - seq;
				}
				Array[nxt] = temp;
				(*N_Move) ++;
			}
		}
	}
}

void Shell_Selection_Sort(long * Array, int Size, double * N_Comp, double * N_Move) {
	int num_of_2 = get_num_of_row(Size);
	for(int row = num_of_2; row >= 0; row --) {
		int num_of_3 = get_pow_of_3(Size, row);
		for(int threes = num_of_3; threes >= 0; threes --) {
			int twos = row - threes;
			int seq = power(2, twos ++) * power(3, threes);
			for(int idx = 0; idx < Size; idx += seq) {
				int min_idx = idx;
				long curr_min = Array[idx];
				(*N_Move) ++;
				for(int nxt = idx + seq; nxt < Size; nxt += seq) {
					(*N_Comp) ++;
					if(curr_min > Array[nxt]) {
						curr_min = Array[nxt];
						(*N_Move) ++;
						min_idx = nxt;
					}
				}
				if(min_idx != idx) {
					Array[min_idx] = Array[idx];
					Array[idx] = curr_min;
					(*N_Move) += 2;
				}
			}
		}
	}
}

int Print_Seq(char * Filename, int Size) {
	FILE * fp = fopen(Filename, "w");
	if(fp == NULL) {
		fprintf(stderr, "print seq exited because fopen failed\n");
		return 0;
	}
	int number = 0;
	int N_Seq = 0;
	for(int twos = 0; power(2, twos) < Size; twos ++) {
		int two = twos;
		for(int threes = 0; threes <= twos; threes ++) {
			number = power(2, two --) * power(3, threes);
			if(number < Size) {
				N_Seq ++;
				if(fwrite(&number, sizeof(int), 1, fp) != 1) {
					fprintf(stderr, "print seq exited because fwrite failed\n");
					return 0;
				}
				if(fputc('\n', fp) == EOF) {
					fprintf(stderr, "print seq exited because fwrite failed\n");
					return 0;
				}
			}
		}
	}
	fclose(fp);
	return N_Seq;
}

// Learnt from Profressor Koh's Lecture
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

static int get_num_of_row(int Size) {
	int ct = 0;
	for(int num = Size; num > 3; num /= 2) {
		ct ++;
	}
	return ct + 1;
}

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
