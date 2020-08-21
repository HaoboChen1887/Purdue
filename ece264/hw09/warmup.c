/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

struct Node {
	struct Node * prev;
	int value;
	struct Node * next;
};

void append(int value, struct Node** a_head, struct Node** a_tail) {
	struct Node * new = malloc(sizeof(*new));
	new -> value = value;
	new -> next = NULL;
	if(*a_head == NULL) {
		new -> prev = NULL;
		*a_head = new;
	}
	else {
		(*a_tail) -> next = new;
		new -> prev = *a_tail;
	}
	*a_tail = new;
	
	assert(*a_head != NULL);            // This helps you catch bugs in your code.
	assert(*a_tail != NULL);            // "    "     "   "     "    "  "    "
	assert((*a_head) -> prev == NULL);  // "    "     "   "     "    "  "    "
	assert((*a_tail) -> next == NULL);  // "    "     "   "     "    "  "    "
}

void delete(struct Node* victim, struct Node** a_head, struct Node** a_tail) {
	if(victim -> prev == NULL && victim -> next == NULL) {
		return;
	}
	if(victim -> prev == NULL) {
		*a_head = victim -> next;
		victim -> next -> prev = NULL;
	}
	else if (victim -> next == NULL) {
		*a_tail = victim -> prev;
		victim -> prev -> next = NULL;
	}
	else {
		victim -> prev -> next = victim -> next;
		victim -> next -> prev = victim -> prev;
	}
	free(victim);
}

void empty_list(struct Node** a_head, struct Node** a_tail) {
	struct Node * next;
	while(*a_head != NULL) {
		next = (*a_head) -> next;
		free(*a_head);
		*a_head = next;
	}
	*a_head = NULL;
	*a_tail = NULL;
	assert(*a_head == NULL);  // This helps you catch bugs in your code.
	assert(*a_tail == NULL);  // "    "     "   "     "    "  "    "
}

void print_list(struct Node* head) {  /* do not modify print_list(..) */
	if(head == NULL) {
		printf("EMPTY\n");
	}
	else {
		for(struct Node* curr = head; curr != NULL; curr = curr -> next) {
			printf("%d", curr -> value);
		}
		printf("\n");
	}
}

int main(int argc, char *argv[]) {    /* do not modify main(..) */
	struct Node* head = NULL;
	struct Node* tail = NULL;
	append(7, &head, &tail);
	assert(head == tail);
	print_list(head);  // Output:  "7"
	append(6, &head, &tail);
	append(8, &head, &tail);
	print_list(head);  // Output:  "768"
	append(3, &head, &tail);
	append(3, &head, &tail);
	append(6, &head, &tail);
	print_list(head);  // Output:  "768336"
	delete(tail, &head, &tail);
	print_list(head);  // Output:  "76833"
	delete(head, &head, &tail);
	print_list(head);  // Output:  "6833"
	delete(head -> next, &head, &tail);
	print_list(head);  // Output:  "633"
	append(9, &head, &tail);
	print_list(head);  // Output:  "6339"
	empty_list(&head, &tail);
	print_list(head);  // Output:  "EMPTY"
	return EXIT_SUCCESS;
}
