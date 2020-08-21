/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include "team.h"
static struct PersonNode * _construct_node(struct Team * team, char * name, Favorites favorites);
static struct Person * _construct_person(struct Team * team, char * name, Favorites favorites);
static        Favorites _construct_favorites(Favorites favorites);
static int		_calc_pop(struct Team * team);
static int _calc_max(int * votes, int pop);
static int _calc_min(int * votes, int pop);
static bool _not_empty(int * votes, int pop);
static int _find_index(struct Team * team, struct Person * person);
static void _set_zero(int * votes, int pop);

struct Team create_test_team() {
	struct Person people[] = {
		{.name = "AA", .favorites = create_favorites(&people[7], &people[0], &people[3], NULL)}, // 0
		{.name = "BB", .favorites = create_favorites(&people[0], &people[7], &people[3], NULL)},  // 1
		{.name = "CC", .favorites = create_favorites(&people[2], &people[0], &people[6], &people[7], NULL)},  // 2
		{.name = "DD", .favorites = create_favorites(&people[2], &people[0], &people[1], NULL)},   // 3
		{.name = "EE", .favorites = create_favorites(&people[0], &people[2], &people[1], NULL)},  // 4
		{.name = "FF", .favorites = create_favorites(&people[2], &people[0], &people[1], NULL)},  // 5
		{.name = "GG", .favorites = create_favorites(&people[7], &people[0], &people[1], NULL)},  // 6
		{.name = "HH", .favorites = create_favorites(&people[2], &people[1], &people[3], NULL)},  // 7
		{.name = "II", .favorites = create_favorites(&people[4], &people[1], &people[0], NULL)},  // 8
		{.name = "JJ", .favorites = create_favorites(&people[5], &people[0], &people[1], NULL)}   // 9
	};
	return create_team("ECE264", 10, people);
}

struct Team create_team(char * name, int population, struct Person * people) {
	struct Team team = {
		.head = NULL,
		.name = strdup(name),
		.tail = NULL
	};
	
	for(int ct = 0; ct < population; ct ++) {
		add_person(&team, people[ct].name, people[ct].favorites);
	}
	for(struct PersonNode * prev = team.head; prev != NULL; prev = prev -> next) {
		struct PersonNode * prevf = prev -> value -> favorites.head;
		while(prevf != NULL) {
			prevf -> value = find_person(&team, prevf -> value -> name);
			prevf = prevf -> next;
		}
	}

	return team;
}

Favorites create_favorites(struct Person * first_choice, ...) {
	va_list more_args;
	va_start(more_args, first_choice);
	Favorites favorites = {
		.head = NULL,
		.name = NULL,
		.tail = NULL
	};
	struct Person * new_fav = first_choice;
	while(new_fav != NULL) {
		struct PersonNode * new = malloc(sizeof(*new));
		new -> prev = NULL;
		new -> value = new_fav;
		new -> next = NULL;
		
		favorites.tail = new;
		if(favorites.head == NULL) {
			favorites.head = new;
		}
		else {
			struct PersonNode * prev = favorites.head;
			while(prev -> next != NULL) {
				prev = prev -> next;
			}
			prev -> next = new;
			new -> prev = prev;
		}
		new_fav = va_arg(more_args, struct Person *);
	} 
	va_end(more_args);
	return favorites;
}

struct Person * add_person(struct Team * team, char * name, Favorites favorites) {
	struct PersonNode * new = _construct_node(team, name, favorites);
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

struct Person * pick_leader(struct Team * team) {
	struct Person * leader = NULL;
	int pop = _calc_pop(team);
	int * votes = malloc(sizeof(*votes) * (1 + pop));
	for(int idx = 0; idx < pop + 1; idx ++) {
		votes[idx] = 0;
	}

	int max_idx = 0;
	int min = 0;
	 do{
		_set_zero(votes, pop);
		struct PersonNode * curr = team -> head;
		while(curr != NULL) {
			if(curr -> value -> favorites.head != NULL) {
				votes[1 + _find_index(team, curr -> value -> favorites.head -> value)] ++;
			}
			curr = curr -> next;
		}
		max_idx = _calc_max(votes, pop);
		if(votes[max_idx] >= pop / 2) {
			int ct = 1;
			curr = team -> head;
			while(ct < max_idx && curr != NULL) {
				curr = curr -> next;
			}
			free(votes);
			return curr -> value;
		}
		min = _calc_min(votes, pop);
		struct PersonNode * curr_min = team -> head;
		int curr_idx = 0;
		while(curr_min != NULL) {
			curr_idx ++;
			if(votes[curr_idx] == min) {
				votes[curr_idx] = -1;
				struct PersonNode * curr_dth = team -> head;
				while(curr_dth != NULL) {
					struct PersonNode * curr_fav = curr_dth -> value -> favorites.head;
					while(curr_fav != NULL) {
						struct PersonNode * next_fav = curr_fav -> next;
						if(strcmp(curr_fav -> value -> name, curr_min -> value -> name) == 0){
							detach_person(&(curr_dth -> value -> favorites), curr_min -> value -> name);
						}
						curr_fav = next_fav;
					}
					curr_dth = curr_dth -> next;
				}
			}
			curr_min = curr_min -> next;
			
		}
		curr = team -> head;
	} while(_not_empty(votes, pop));

	if(_not_empty(votes, pop) == false) {
		leader =  NULL;
	}
	free(votes);
	return leader;
}

void   add_favorite(struct Person * fan, struct Person * favorite, int rank) {
	struct PersonNode * new_fav = malloc(sizeof(*new_fav));
	new_fav -> prev = NULL;
	new_fav -> value = favorite;
	new_fav -> next = NULL;
	if(fan -> favorites.head == NULL) {
		fan -> favorites.head = new_fav;
		fan -> favorites.tail = new_fav;
		return;
	}
	if(rank == 0) {
		new_fav -> next = fan -> favorites.head;
		fan -> favorites.head -> prev = new_fav;
		fan -> favorites.head = new_fav;
	}
	else {
		struct PersonNode * curr = fan -> favorites.head;
		int ct = 0;
		while(curr -> next != NULL && ct < rank) {
			curr = curr -> next;
			ct ++;
		}
		if(curr -> next == NULL || rank < 0){
			new_fav -> prev = fan -> favorites.tail;
			fan -> favorites.tail -> next = new_fav;
			fan -> favorites.tail = new_fav;
		}
		else {
			new_fav -> prev = curr -> prev;
			new_fav -> next = curr;
			curr -> prev = new_fav;
			new_fav -> prev -> next = new_fav;
		}
	}
	return;
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
	struct PersonNode * curr = person -> favorites.head;
	while(curr != NULL) {
		struct PersonNode * todelete = curr -> next;
		free(curr);
		curr = todelete;
	}
	free(person);
	return;
}

void   fprint_team(struct Team * team, FILE * stream) {
	int len = 0;
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		int new_len = _calc_len(curr -> value -> name);
		len = (len < new_len) ? new_len : len;
	}
	fprintf(stdout, "%s\n", team -> name);
	if(team -> head == NULL && team -> tail == NULL) {
		fprintf(stdout, "- leaders: ");
		fprintf(stdout, "(none)\n");
		fprintf(stdout, "- members: ");
		fprintf(stdout, "(none)\n");
		return;
	}
	struct Person * leader = pick_leader(team);
	fprintf(stdout, "- leader:  %s\n", (leader == NULL) ? "(none)" : leader -> name);
	fprintf(stdout, "- members: ");
	// print format
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		struct PersonNode * fav_head = curr -> value -> favorites.head;
		if(curr == team -> head) {
			fprintf(stdout, "%s", curr -> value -> name);
			for(int ct = 0; ct <= len - _calc_len(curr -> value -> name); ct ++) {
				fprintf(stdout, " ");
			}
			fprintf(stdout, "(favorite: %s)\n", ((fav_head == NULL) ? "(none)" : fav_head -> value -> name));
		}
		else {
			fprintf(stdout, "           %s", curr -> value -> name);
			for(int ct = 0; ct <= len - _calc_len(curr -> value -> name); ct ++) {
				fprintf(stdout, " ");
			}
			fprintf(stdout, "(favorite: %s)\n", ((fav_head == NULL) ? "(none)" : fav_head -> value -> name));
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

	add_person(&new_team, team -> head -> value -> name, team -> head -> value -> favorites);
	struct PersonNode * currN = new_team.head;
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		struct PersonNode * currF = curr -> value -> favorites.head -> next;
		currN -> value -> favorites = create_favorites(curr -> value -> favorites.head -> value, NULL);
		while(currF != NULL) {
			add_favorite(currN -> value, currF -> value, -1);
			currF = currF -> next;
		}
		if(curr -> next != NULL) {
			add_person(&new_team, curr -> next -> value -> name, curr -> next -> value -> favorites);
		}
		currN = currN -> next;
	}
	
	
	for(struct PersonNode * prev = new_team.head; prev != NULL; prev = prev -> next) {
		struct PersonNode * prevf = prev -> value -> favorites.head;
		while(prevf != NULL) {
			prevf -> value = find_person(&new_team, prevf -> value -> name);
			prevf = prevf -> next;
		}
	}
	return new_team;
}

static struct PersonNode * _construct_node(struct Team * team, char * name, Favorites favorites) {
	struct PersonNode * nd = malloc(sizeof(*nd));
	nd -> prev = NULL;
	nd -> value = _construct_person(team, name, favorites);
	nd -> next = NULL;
	return nd;
}

static struct Person * _construct_person(struct Team * team, char * name, Favorites favorites) {
	int len = _calc_len(name);
	struct Person * person = malloc(sizeof(*person));
	person -> name = malloc(sizeof(*(person -> name)) * len);
	person -> favorites = _construct_favorites(favorites);
	strcpy(person -> name, name);
	return person;
}

static Favorites _construct_favorites(Favorites favorites) {
	Favorites new_favorites = {
		.name = NULL,
		.head = favorites.head,
		.tail = favorites.tail
	};
	return new_favorites;
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

static int _calc_pop(struct Team * team) {
	int pop = 0;
	struct PersonNode * curr = team -> head;
	while(curr != NULL) {
		curr = curr -> next;
		pop ++;
	}
	return pop;
}

static int _calc_max(int * votes, int pop) {
	int max = 1;
	for(int idx = 1; idx <= pop; idx ++) {
		max = (votes[idx] > votes[max]) ? idx : max;
	}
	return max;
}

static int _calc_min(int * votes, int pop) {
	int min = votes[1];
	for(int idx = 1; idx < pop + 1; idx ++) {
		if(votes[idx] > 0) {
			min = (votes[idx] < min) ? votes[idx] : min;
		}
	}
	return min;
}

static bool _not_empty(int * votes, int pop) {
	for(int idx = 1; idx < pop + 1; idx ++) {
		if(votes[idx] > 0) {
			return true;
		};
	}
	return false;
}

static int _find_index(struct Team * team, struct Person * person) {
	int idx = 0;
	for(struct PersonNode * curr = team -> head; curr != NULL; curr = curr -> next) {
		if(strcmp(curr -> value -> name, person -> name) == 0) {
			return idx;
		}
		idx ++;
	}
	return idx;
}

static void _set_zero(int * votes, int pop) {
	for(int idx = 0; idx < pop + 1; idx ++) {
		if(votes[idx] != -1) {
			votes[idx] = 0;
		}
	}
	return;
}

