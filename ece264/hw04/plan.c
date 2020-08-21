/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include <stdlib.h>
#include "mintf.h"

int main(int argc, char* argv[]) {
	// Test 00: empty test
	// Expect: ""
	
	// Test 01: empty string
	mintf("");
	// Expect: ""
	
	// Test 02: accept a meaningful string as the only input
	mintf("String test");
	// Expect: "String test"
	
	// Test 03: accpet string and a integer as input and express in decimal without prefix
	mintf("%d", 10);
	// Expect: "10"

	// Test 04: accept string and a integer as input and express in hex with prefix "0x"
	mintf("%x", 10);
	// Expect: "0xa"
	
	// Test 05: accept string and a integer as input and express in binary with prefix "0b"
	mintf("%b", 10);
	// Expect: "0b1010:
	
	// Test 06: accept string and a float as input and express with a $ sign prefix and 2 numbers after decimal point
	mintf("%$", 10.00);
	// Expect: "$10.00"

	// Test 07: accept string and a char or int as input and express it according to ASCII chart
	minf("%c", 'a');
	// Expect: "a"

	// Test 08: Identify %% as a single % sign and print it out
	mintf("%%");
	// Expect: "%"

	// Test 09: Test negative values for all cases involved with numbers above
	mintf("%d, %x, %b, %$", -10, -10, -10, -10.00);
	// Expect: "-10, -0xa, -0b1010, -10.00"

	// Test 10: Test all cases in one call of function
	mintf("%d, %d, %x, %x, %b, %b, %$, %$, %c, %%", 10, -10, 10, -10, 10, -10, 10.001, -10.00, 'a');
	// Expect: "10, -10, 0xa, -0xa, 0b1010, -0b1010, $10.00, -$10.00, a, %"
	return EXIT_SUCCESS;
}
