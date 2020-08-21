/* vim: set tabstop=4 shiftwidth=4 noexpandtab: */
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdbool.h>
#include <limits.h>
#include "smintf.h"

int _baseConv(char * subst, int n, int radix, char* prefix);
int _calcLen(int number, int radix);

char* smintf(const char *FORMAT, ...) {
	bool firstTime = true;
	va_list moreArgs;
	int len = 0;
	int index = 0;
	int intV = 0;
	double floatV = 0;
	char letter = FORMAT[0];

	va_start(moreArgs, FORMAT);
	while(FORMAT[index] != '\0') {
		if(FORMAT[index] == '%') {
			if(FORMAT[++ index] == '%') {
				len ++;
			}
			else if(FORMAT[index] == 'c') {
				len ++;
			}
			else if (FORMAT[index] == 's') {
				char* letter = va_arg(moreArgs, char*);
				while(*(letter ++) != '\0') {
					len ++;
				}
			}
			else if (FORMAT[index] == '$') {
				floatV = va_arg(moreArgs, double);
				if(floatV < 0) {
					len ++;
					floatV = -floatV;
				}
				len += (_calcLen((int)floatV, 10) + 4);
			}
			else if (FORMAT[index] == 'x'){
				intV = va_arg(moreArgs, int);
				if(intV < 0) {
					len ++;
				}
				len += (_calcLen(intV, 16) + 2);
			}
			else if (FORMAT[index] == 'b'){
				intV = va_arg(moreArgs, int);
				if(intV < 0) {
					len ++;
				}
				len += (_calcLen(intV, 2) + 2);
			}
			else if (FORMAT[index] == 'd'){
				intV = va_arg(moreArgs, int);
				if(intV < 0) {
					len ++;
				}
				len += _calcLen(intV, 10);
			}
			else {
				len += 2;
			}
		}
		else {
			len ++;
		}
		index ++;
	}
	len ++;
	va_end(moreArgs);

	char* str = malloc(sizeof(*str) * len);
	if(str == NULL) {
		return NULL;
	}
	index = 0;
	while(*FORMAT != '\0') {
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
						str[index ++] = letter;
						//fputc(letter, stdout);
					}
					letter = *++FORMAT;
					break;
				// print result as decimal
				case 'd':
					index += _baseConv(&str[index], va_arg(moreArgs, int), 10, "");
					letter = *++FORMAT;
					break;
				// print result as hexadecimal
				case 'x':
					index += _baseConv(&str[index], va_arg(moreArgs, int), 16, "0x");
					letter = *++FORMAT;
					break;
				// print result as binary
				case 'b':
					index += _baseConv(&str[index], va_arg(moreArgs, int), 2, "0b");
					letter = *++FORMAT;
					break;
				// print result as character
				case 'c':
					str[index ++] = va_arg(moreArgs, int);
					//fputc(va_arg(moreArgs, int), stdout);
					letter = *++FORMAT;
					break;
				// print the result in dollars
				case '$':
					number = va_arg(moreArgs, double);
					index += _baseConv(&str[index], (int)number, 10, "$");
					number *= 100;
					if(number < 0) {
						number = -number;
					}
					str[index ++] = '.';
					str[index ++] = '0' + (int)number % 100 / 10; 
					str[index ++] = '0' + (int)number % 10;
					/*fputc('.', stdout);
					fputc('0' + (int)number % 100 / 10, stdout);
					fputc('0' + (int)number % 10, stdout);*/
					letter = *++FORMAT;
					break;
				// print all other cases as plain text
				default:
					str[index ++] = *(FORMAT - 1);
					if(letter != '\0') {
						str[index ++] = letter;
						FORMAT ++;
					}
					break;
			}
		};
		// prevent unnecessary output when reaching the end of FORMATting string
		if(*FORMAT != '\0') {
			str[index ++] = *(FORMAT ++);
			letter = *FORMAT;
		}
	}
	str[index] = '\0';
	va_end(moreArgs);
	return str;
}

int _baseConv(char* subst, int n, int radix, char* prefix) {
	int index = 0;
	int len = 0;
	int digit = 0;
	int count = 0;
	unsigned int limit = 0;
	
	if(n < 0) {
		subst[index ++] = '-';
		limit = -n;
		len = _calcLen(limit, radix) + 1;
	}
	else {
		limit = n;
		len = _calcLen(limit, radix);
	}

	int idx = 0;
	while(prefix[idx] != '\0') {
		subst[index ++] = prefix[idx ++];
		len ++;
	}

	if(limit == 0) {
		subst[index] = '0';
	}
	index = len - 1;
	while(limit != 0) {
		digit = limit % radix;
		limit /= radix;
		if(digit < 10) {
			subst[index --] = '0' + digit;
		}
		else {
			subst[index --] = 'a' + digit - 10;
		}
	}
	return len;
}

int _calcLen(int number, int radix) {
	int len = 0;
	if(number == 0) {
		len ++;
	}
	else {
		while(number != 0) {
			number /= radix;
			len ++;
		}
	}
	return len;
}
