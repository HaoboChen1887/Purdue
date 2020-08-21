/* vim: set tabstop=4 shiftwidth=4 noexpandtab: */
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdbool.h>
#include <limits.h>
#include "mintf.h"

void mintf(const char *FORMAT, ...) {
	bool firstTime = true;
	va_list moreArgs;
	int numOfInput = 0;

	while(*FORMAT != '\0') {
		char letter = *FORMAT;
		if(firstTime == true) {
			va_start(moreArgs, FORMAT);
			firstTime = false;
		}
		if(letter == '%') {
			char *charIn = NULL;
			double number = 0;
			letter = *++FORMAT;
			switch(letter) {
				// skip and print a single %
				case '%': 
					break;
				// print strings
				case 's':
					charIn = va_arg(moreArgs, char*);
					while(*charIn != '\0'){
						letter = *charIn++;
						fputc(letter, stdout);
					}
					letter = *++FORMAT;
					break;
				// print result as decimal
				case 'd':
					print_integer(va_arg(moreArgs, int), 10, "");
					letter = *++FORMAT;
					break;
				// print result as hexadecimal
				case 'x':
					print_integer(va_arg(moreArgs, int), 16, "0x");
					letter = *++FORMAT;
					break;
				// print result as binary
				case 'b':
					print_integer(va_arg(moreArgs, int), 2, "0b");
					letter = *++FORMAT;
					break;
				// print result as character
				case 'c':
					fputc(va_arg(moreArgs, int), stdout);
					letter = *++FORMAT;
					break;
				// print the result in dollars
				case '$':
					number = va_arg(moreArgs, double);
					print_integer((int)number, 10, "$");
					number *= 100;
					if(number < 0) {
						number = -number;
					}
					fputc('.', stdout);
					fputc('0' + (int)number % 100 / 10, stdout);
					fputc('0' + (int)number % 10, stdout);
					letter = *++FORMAT;
					break;
				// print all other cases as plain text
				default:
					fputc(*(FORMAT - 1), stdout);
					if(letter != '\0') {
						fputc(letter, stdout);
						letter = *++FORMAT;
					}
					break;
			}
		}
		// prevent unnecessary output when reaching the end of formatting string
		if(letter != '\0') {
			fputc(letter, stdout);
			FORMAT++;
		}
	}
	va_end(moreArgs);
	return;
}

void print_integer(int n, int radix, char* prefix) {
	int digit = 0;
	int index = 0;
	// print negative sign first when running the first iteration
	if(n < 0) {
		if(n != INT_MIN) {
			n = -n;
		}
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
		if(n == INT_MIN) {
			unsigned int limit = -n;
			digit = limit % radix;
			n = limit / radix;
		}
		else {
			digit = n % radix;
			n /= radix;
		}
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
