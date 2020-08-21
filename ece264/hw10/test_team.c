/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include "team.h"

int main(int argc, char * argv[]) {
	struct Team team = create_test_team();
	fprint_team(&team, stdout);
	add_favorite(team.head -> value, team.tail -> value, 0);
	add_favorite(team.head -> value, team.head -> next -> next -> value, -1);
	add_favorite(team.head -> value, team.tail -> prev -> value, 1);
	printf("%s's favorite is \n", team.head -> value -> name);
	printf("%s\n", team.head -> value -> favorites.head -> value -> name);
	printf("%s\n", team.head -> value -> favorites.head -> next -> value -> name);
	printf("%s\n", team.head -> value -> favorites.head -> next -> next -> value -> name);
	printf("%s\n", team.head -> value -> favorites.head -> next -> next -> next -> value -> name);
	printf("%s\n", team.head -> value -> favorites.head -> next -> next -> next -> next -> value -> name);
	fprint_team(&team, stdout);
	struct Team new_team = copy_team(&team);
	fprintf(stdout, "copy team\n");
	fprint_team(&new_team, stdout);



	free_team(&team);
	free_team(&new_team);
	team.head = NULL;
	team.name = strdup("ECE264");
	team.tail = NULL;
	printf("Empty team\n");
	fprint_team(&team, stdout);
	add_person(&team, "AA", create_favorites(NULL));
	add_person(&team, "BB", create_favorites(team.head -> value, NULL));
	fprint_team(&team, stdout);
	free_team(&team);

	return EXIT_SUCCESS;
}
