#include "index.h"

int main(int argc, char * argv[]) {
	Index index = create_index();
	int count = 0;
	char ** printarr = get(&index, &count, NULL);

	put(NULL, NULL, NULL);
	put(&index, NULL, NULL);
	put(&index, NULL, "file1");
	put(&index, "word", NULL);
	printarr = get(&index, &count, NULL);
	free(printarr);

	put(&index, "Min", "file99");
	put(&index, "Min", "file1");
	put(&index, "Min", "file2");

	put(&index, "min", "file0");
	put(&index, "min", "file1");
	put(&index, "min", "file2");

	put(&index, "word", "file99");
	put(&index, "word", "file1");
	put(&index, "word", "file2");

	put(&index, "apple", "file2");
	put(&index, "apple", "file2");
	put(&index, "apple", "file2");
	put(&index, "apple", "file2");

	put(&index, "bad", "file1");
	put(&index, "bad", "file4");
	put(&index, "bad", "file5");

	put(&index, "detach", "file6");
	put(&index, "detach", "file7");

	put(&index, "emacs", "file8");
	put(&index, "emacs", "file9");
	put(&index, "apple", "file10");
	put(&index, "apple", "file11");
	put(&index, "apple", "file12");
	put(&index, "apple", "file13");

	put(&index, "class", "file99");

	printarr = get(&index, &count, "a", "b", "c", NULL);
	printf("The length of the array is %d\n", count);
	printf("The files that contain a, b, c is the following\n");
	for(int ct = 0; ct < count; ct ++) {
		printf("File: %s\n", printarr[ct]);
	}
	free(printarr);

	printarr = get(&index, &count, "word", NULL);
	printf("The files that contain word is the following\n");
	printf("The length of the array is %d\n", count);
	for(int ct = 0; ct < count; ct ++) {
		printf("File: %s\n", printarr[ct]);
	}
	free(printarr);

	printarr = get(&index, &count, "min", NULL);
	printf("The files that contain min is the following\n");
	printf("The length of the array is %d\n", count);
	for(int ct = 0; ct < count; ct ++) {
		printf("File: %s\n", printarr[ct]);
	}
	free(printarr);
	
	printarr = get(&index, &count, "Min", NULL);
	printf("The files that contain Min is the following\n");
	printf("The length of the array is %d\n", count);
	for(int ct = 0; ct < count; ct ++) {
		printf("File: %s\n", printarr[ct]);
	}
	free(printarr);

	printarr = get(&index, &count, "apple", NULL);
	printf("The files that contain apple is the following\n");
	printf("The length of the array is %d\n", count);
	for(int ct = 0; ct < count; ct ++) {
		printf("File: %s\n", printarr[ct]);
	}
	free(printarr);

	char ** emptyarr = get(&index, &count, NULL);
	printf("The length of the array is %d\n", count);
	for(int ct = 0; ct < count; ct ++) {
		printf("File: %s\n", emptyarr[ct]);
	}
	free(emptyarr);

	free_index(&index);
	return EXIT_SUCCESS;
}
