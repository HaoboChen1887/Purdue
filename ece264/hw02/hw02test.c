/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include "hw02.h"

int main(int argc, char* argv[]) {
	print_integer(-0, 10, "0d");
	printf("\n");
	print_integer(0, 16, "");
	printf("\n");
	print_integer(-12345, 2, "0b");
	printf("\n");
	print_integer(-12345, 36, "");
	printf("\n");
	print_integer(-12345, 20, "");
	printf("\n");
	print_integer(-12345, 16, "");
	printf("\n");
	print_integer(-12345, 2, "");
	printf("\n");
	print_integer(INT_MAX, 2, "");
	printf("\n");
	print_integer(INT_MIN, 36, "");

	return EXIT_SUCCESS;
}
