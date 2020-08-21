/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include <stdio.h>
#include <stdlib.h>

char* my_strdup(const char* original) {
	// TODO
	int count = 0;

	// count the length of the string
	do {
	}while(original[count++] != '\0');
	char* t = malloc(sizeof(*t) * count);
	count = 0;
	// copy string
	do {
		t[count] = original[count];
	}while(original[count++] != '\0');
	
	return t;
}

int main(int argc, char *argv[]) {
	char s[] = "abc\n";
	fputs(s, stdout);  // Should print "abc" followed by a newline ('\n')

	char* t = my_strdup(s);
	fputs(t, stdout);  // Should print "abc" followed by a newline ('\n')
	free(t);

	return 0;
}
