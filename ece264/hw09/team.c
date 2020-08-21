/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include "team.h"

struct Team create_team(char * name, int population, struct Person * people) {
	struct Team team = {
		.head = NULL,
		.name = strdup(name),
		.tail = NULL
	};
	
	for(int ct = 0; ct < population; ct ++) {
		add_person(&team, people[ct].name, people[ct].favorite -> name);
	}
	struct PersonNode * prev = team.head;
	for(int ct = 0; ct < population; ct ++) {
		if(prev -> value -> favorite == NULL) { 
			prev -> value -> favorite = find_person(&team, (people[ct].favorite) -> name);
		}
		prev = prev -> next;
	}

	return team;
}


struct Person * add_person(struct Team * team, char * name, char * favorite_name) {
	struct PersonNode * new = _construct_node(team, name, favorite_name);
	if(team -> head == NULL) {
		team -> head = new;
		team -> tail = new;
		return new -> value;
	}
	struct PersonNode * prev = team -> head;
	while(prev -> next != NULL) {
		prev = prev -> next;
	}
	prev -> next = new;
	team -> tail = new;
	new -> prev = prev;
	return new -> value; 
} 

struct Person * find_person(struct Team * team, char * name) {
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		if(strcmp(curr -> value -> name, name) == 0) { 
			return curr -> value;
		}
	}
	return NULL;
}

struct Person * detach_person(struct Team * team, char * name) {
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		if(strcmp(curr -> value -> name, name) == 0) { 
			struct Person * todelete = curr -> value;
			struct PersonNode * after = curr -> next;
			struct PersonNode * bef = curr -> prev;
			// only one element in list
			if(bef == NULL && after == NULL) {
				team -> head = NULL;
				team -> tail = NULL;
				free(curr);
				return todelete;
			}
			// person is the first element
			if(bef == NULL) {
				after -> prev = NULL;
				team -> head = after;
			}
			// person is the last element
			else if(after == NULL) {
				bef -> next = NULL;
				team -> tail = bef;
			}
			// general cases
			else {
				after -> prev = bef;
				bef -> next = after;
			}
			free(curr);
			return todelete;
		}
	}
	return NULL;
}

void   free_team(struct Team * team) {
	struct PersonNode * curr = team -> head;
	free(team -> name);
	while(curr != NULL) {
		struct PersonNode * todelete = curr -> next;
		free_person(detach_person(team, curr -> value -> name));
		curr = todelete;
	}
	return;
}

void   free_person(struct Person * person) {
	free(person -> name);
	free(person);
	return;
}

void   fprint_team(struct Team * team, FILE * stream) {
	int len = 0;
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		int new_len = _calc_len(curr -> value -> name);
		len = (len < new_len) ? new_len : len;
	}
	if(team -> head == NULL && team -> tail == NULL) {
		fprintf(stdout, "%s\n", team -> name);
		fprintf(stdout, "- members: ");
		fprintf(stdout, "(none)\n");
		return;
	}
	fprintf(stdout, "%s\n", team -> name);
	fprintf(stdout, "- members: ");
	// print format
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		if(curr == team -> head) {
			fprintf(stdout, "%s", curr -> value -> name);
			for(int ct = 0; ct <= len - _calc_len(curr -> value -> name); ct ++) {
				fprintf(stdout, " ");
			}
			fprintf(stdout, "(favorite: %s)\n", curr -> value -> favorite -> name);
		}
		else {
			fprintf(stdout, "           %s", curr -> value -> name);
			for(int ct = 0; ct <= len - _calc_len(curr -> value -> name); ct ++) {
				fprintf(stdout, " ");
			}
			fprintf(stdout, "(favorite: %s)\n", curr -> value -> favorite -> name);
		}
	}
	return;
}

struct Team copy_team(struct Team * team) {
	struct Team new_team = {
		.head = NULL,
		.name = strdup(team -> name), // malloc
		.tail = NULL
	};
	// copy the names and allocate memory
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		add_person(&new_team, curr -> value -> name, curr -> value -> favorite -> name);
	}
	struct PersonNode * prev = new_team.head;
	// finish adding favorites of people that were not in the team during add_person
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		if(prev -> value -> favorite == NULL) { 
			prev -> value -> favorite = find_person(&new_team, curr -> value -> favorite -> name);
		}
		prev = prev -> next;
	}
	return new_team;
}

static struct PersonNode * _construct_node(struct Team * team, char * name, char * favorite_name) {
	struct PersonNode * nd = malloc(sizeof(*nd));
	nd -> prev = NULL;
	nd -> value = _construct_person(team, name, favorite_name);
	nd -> next = NULL;
	return nd;
}

static struct Person * _construct_person(struct Team * team, char * name, char * favorite_name) {
	int len = _calc_len(name);
	struct Person * person = malloc(sizeof(*person));
	person -> name = malloc(sizeof(*(person -> name)) * len);
	person -> favorite = find_person(team, favorite_name);
	strcpy(person -> name, name);
	return person;
}

int _calc_len(char * name) {
	//calculate the length of a string including \0
	int len = 0;
	while(name[len] != '\0') {
		len ++;
	}
	len ++;
	return len;
}
