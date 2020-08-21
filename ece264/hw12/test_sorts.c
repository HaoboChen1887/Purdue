#include "sorts.h"

int main(int argc, char * argv[]) {
	const int length = 10;
	int testarr[] = {2, 3, 4, 5, 2, 3, 4, 1, 0, 0};
	merge_sort_array(testarr, length);
	fprintf(stdout, "merge sort result\n");
	for(int ct = 0; ct < length; ct ++) {
		fprintf(stdout, "%d\n", testarr[ct]);
	}
	
	int testarr1[] = {2, 3, 4, 5, 2, 3, 4, 1, 0, 0};
	quick_sort_array(testarr1, length);
	fprintf(stdout, "quick sort result\n");
	for(int ct = 0; ct < length; ct ++) {
		fprintf(stdout, "%d\n", testarr1[ct]);
	}
	int testarr2[] = {2, 3, 4, 5, 2, 3, 4, 1, 0, 0};
	tree_sort_array(testarr2, length);
	fprintf(stdout, "tree sort result\n");
	for(int ct = 0; ct < length; ct ++) {
		fprintf(stdout, "%d\n", testarr2[ct]);
	}

	int testarr3[] = {1};
	merge_sort_array(testarr3, 1);
	fprintf(stdout, "merge sort result\n");
	for(int ct = 0; ct < 1; ct ++) {
		fprintf(stdout, "%d\n", testarr3[ct]);
	}

	int testarr4[] = {1};
	tree_sort_array(testarr4, 1);
	fprintf(stdout, "tree sort result\n");
	for(int ct = 0; ct < 1; ct ++) {
		fprintf(stdout, "%d\n", testarr4[ct]);
	}

	int testarr5[] = {1};
	quick_sort_array(testarr5, 1);
	fprintf(stdout, "quick sort result\n");
	for(int ct = 0; ct < 1; ct ++) {
		fprintf(stdout, "%d\n", testarr5[ct]);
	}
	return EXIT_SUCCESS;
}
