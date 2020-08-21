#include <stdio.h>

struct Name{
	char* first;
	char* last;
};

void swap_first_last(struct Name * name);
void swap_names(struct Name * name1, struct Name * name2);
void print_name(struct Name name); 

void swap_first_last(struct Name * name) {
	char* temp = name -> first;
	name -> first = name -> last;
	name -> last = temp;
}

void swap_names(struct Name * name1, struct Name * name2) {
	struct Name temp = *name2;
	*name2 = *name1;
	*name1 = temp;
}

void print_name(struct Name name) {    /* DO NOT CHANGE print_name(..) */
	printf("%s %s\n", name.first, name.last);
}

int main(int argc, const char *argv[]) /* DO NOT CHANGE main(..) */
{
	struct Name name1 = {"Smith", "Marcus"};  // initialize with first name "Smith", last name "Marcus"
	struct Name name2 = {"Garcia", "Anna"};  // initizlize with first name "Garcia", last name "Anna"
	printf("Start\n");
	print_name(name1);  // output:  "Smith Marcus"
	print_name(name2);  // output:  "Garcia Anna"

	swap_first_last(&name1);
	swap_first_last(&name2);
	printf("after swap_first_last(..) x 2\n");
	print_name(name1);  // output:  "Marcus Smith"
	print_name(name2);  // output:  "Anna Garcia"

	swap_names(&name1, &name2);
	printf("after swap_names(..) x 2\n");
	print_name(name1);  // output:  "Anna Garcia"
	print_name(name2);  // output:  "Marcus Smith"

	return 0;
}
