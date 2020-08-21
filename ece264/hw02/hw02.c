/* vim: set tabstop=4 shiftwidth=4 fileencoding-utf-8 noexpandtab: */
#include <stdio.h>
#include <stdlib.h>
#include "hw02.h"

void print_integer(int n, int radix, char* prefix) {
	int digit = 0;
	int index = 0;
	// print negative sign first when running the first iteration
	if(n < 0) {
		n = -n;
		fputc('-', stdout);
	}
	// print prefix after negative if applicable when running the first iteration
	while(prefix != NULL && *(prefix + index) != '\0') {
		fputc(*(prefix + index++), stdout);
	}
	// treat 0 as a special situation, otherwise nothing will be printed if the input is a single 0 using this method 
	if(prefix != NULL && n == 0) {
		fputc('0', stdout);
	}
	prefix = NULL; // set for identifying the first iteration, prefix and 0 won't be printed during following iterations
	// convert number to designated radix
	if(n != 0) {
		//unsigned int number = n;
		digit = n % radix;
		n /= radix;
		print_integer(n, radix, prefix);
		// print result
		if(digit < 10) {
			fputc('0' + digit, stdout);
		}
		else {
			fputc('a' + digit - 10, stdout);
		}
	}

	return;
}
