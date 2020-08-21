#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdbool.h>
#include "mintf.h"

void mintf(const char *format, ...) {
	while(*format != '\0') {
		char letter = *format;
		bool firstTime = true;
		if(letter == '%') {
			format++;
			letter = *format;
			switch(letter) {
				case '%': 
					fputc(letter, stdout);
					format++;
					break;
				default:
					fputc(*(format - 1), stdout);
					fputc(letter, stdout);
					format++;
					break;
			}
		}
		letter = *format++;
		fputc(letter, stdout);
	}
	return;
}
