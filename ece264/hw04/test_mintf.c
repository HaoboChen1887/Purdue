#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdarg.h>
#include <limits.h>
#include "mintf.h"

int main(int argc, char* argv[]) {
	mintf("All test cases:\n");
	mintf("Format string only\n");
	mintf("Single % sign\n");
	mintf("Double %% sign\n");
	mintf("7 % sign in string %%%%%%%\n");
	mintf("8 % sign in string %%%%%%%%\n");
	mintf("Substitude the %%s into this sentence\n", "String");
	mintf("Substitude the %s into this sentence\n", "String");
	
	mintf("Nonnegative integer: ");
	for(int count = 0; count < 100; count ++) {
		mintf("%d, ", count);
	}
	mintf("\nMax integer = %d\n", INT_MAX);

	mintf("Negative integer: ");
	for(int count = 0; count > -100; count --) {
		mintf("%d, ", count);
	}
	mintf("\nMin integer = %d\n", INT_MIN);

	mintf("Nonnegative binary: ");
	for(int count = 0; count < 100; count ++) {
		mintf("%b, ", count);
	}
	mintf("\nMax binary = %b\n", INT_MAX);

	mintf("Negative binary: ");
	for(int count = 0; count > -100; count --) {
		mintf("%b, ", count);
	}
	mintf("\nMin binary = %b", INT_MIN);

	mintf("Nonnegative hexadecimal: ");
	for(int count = 0; count < 100; count ++) {
		mintf("%x, ", count);
	}
	mintf("\nMax hexadecimal = %x\n", INT_MAX);

	mintf("Negative hexadecimal: ");
	for(int count = 0; count > -100; count --) {
		mintf("%x, ", count);
	}
	mintf("\nMin hexadecimal = %x\n", INT_MIN);

	double currency = 100;
	mintf("Nonnegative currency: ");
	for(int count = 0; count < 100; count ++) {
		mintf("%$, ", currency += 0.01);
	}

	currency = -100;
	mintf("\nNegative currency: ");
	for(int count = 0; count > -100; count --) {
		mintf("%$, ", currency -= 0.01);
	}

	char letter = ' ';
	mintf("\nAll letters: ");
	for(int count = 0; count < 95; count ++) {
		mintf("%c, ", letter + count);
	}
	return EXIT_SUCCESS;
}
