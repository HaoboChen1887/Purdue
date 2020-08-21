#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdarg.h>
#include <limits.h>
#include "smintf.h"

int main(int argc, char* argv[]) {
	char *sAddr = NULL;
	
	sAddr = smintf("\nZero = %d\n", 0);
	printf("%s", sAddr);
	free(sAddr);
	//sAddr = sAddr = smintf("All test cases:\n");
	sAddr = sAddr = smintf("%$", -12345.00);
	printf("\n%s", sAddr);
	free(sAddr);

	sAddr = sAddr = smintf("1%%%%%%%5\n");
	printf("%s", sAddr);
	free(sAddr);
	sAddr = sAddr = smintf("123%567\n");
	printf("%s", sAddr);
	free(sAddr);
	sAddr = sAddr = smintf("1%%%%%%%%5\n");
	printf("%s", sAddr);
	free(sAddr);
	sAddr = sAddr = smintf("1%%s4\n", "String");
	printf("%s", sAddr);
	free(sAddr);
	sAddr = sAddr = smintf("1%s8\n", "String");
	printf("%s", sAddr);
	free(sAddr);
	sAddr = sAddr = smintf("1%s", "String");
	printf("%s", sAddr);
	free(sAddr);
	sAddr = sAddr = smintf("Nonnegative integer: ");
	printf("%s", sAddr);
	free(sAddr);
	for(int count = 0; count < 100; count ++) {
		sAddr = sAddr = smintf("%d, ", count);
		printf("%s", sAddr);
		free(sAddr);
	}
	sAddr = smintf("\nMax integer = %d\n", INT_MAX);
	printf("%s", sAddr);
	free(sAddr);

	sAddr = smintf("Negative integer: ");
	printf("%s", sAddr);
	free(sAddr);
	for(int count = 0; count > -100; count --) {
		sAddr = smintf("%d, ", count);
		printf("%s", sAddr);
		free(sAddr);
	}
	sAddr = smintf("\nMin integer = %d\n", INT_MIN);
	printf("%s", sAddr);
	free(sAddr);

	sAddr = smintf("Nonnegative binary: ");
	printf("%s", sAddr);
	free(sAddr);
	for(int count = 0; count < 100; count ++) {
		sAddr = smintf("%b, ", count);
		printf("%s", sAddr);
		free(sAddr);
	}
	sAddr = smintf("\nMax binary = %b\n", INT_MAX);
	printf("%s", sAddr);
	free(sAddr);

	sAddr = smintf("Negative binary: ");
	printf("%s", sAddr);
	free(sAddr);
	for(int count = 0; count > -100; count --) {
		sAddr = smintf("%b, ", count);
		printf("%s", sAddr);
		free(sAddr);
	}
	sAddr = smintf("\nMin binary = %b", INT_MIN);
	printf("%s", sAddr);
	free(sAddr);

	sAddr = smintf("Nonnegative hexadecimal: ");
	printf("%s", sAddr);
	free(sAddr);
	for(int count = 0; count < 100; count ++) {
		sAddr = smintf("%x, ", count);
		printf("%s", sAddr);
		free(sAddr);
	}
	sAddr = smintf("\nMax hexadecimal = %x\n", INT_MAX);
	printf("%s", sAddr);
	free(sAddr);

	sAddr = smintf("Negative hexadecimal: ");
	printf("%s", sAddr);
	free(sAddr);
	for(int count = 0; count > -100; count --) {
		sAddr = smintf("%x, ", count);
		printf("%s", sAddr);
		free(sAddr);
	}
	sAddr = smintf("\nMin hexadecimal = %x\n", INT_MIN);
	printf("%s", sAddr);
	free(sAddr);

	char letter = ' ';
	sAddr = smintf("\nAll letters: ");
	printf("%s", sAddr);
	free(sAddr);
	for(int count = 0; count < 95; count ++) {
		sAddr = sAddr = smintf("%c, ", letter + count);
		printf("%s, ", sAddr);
		free(sAddr);
	}

	double currency = 100;
	sAddr = smintf("Nonnegative currency: ");
	printf("%s", sAddr);
	free(sAddr);
	for(int count = 0; count < 100; count ++) {
		sAddr = smintf("%$, ", currency += 0.01);
		printf("%s", sAddr);
		free(sAddr);
	}

	currency = -100;
	sAddr = smintf("\nNegative currency: ");
	printf("%s", sAddr);
	free(sAddr);
	for(int count = 0; count > -100; count --) {
		sAddr = smintf("%$, ", currency -= 0.01);
		printf("%s", sAddr);
		free(sAddr);
	}

	return EXIT_SUCCESS;
}
