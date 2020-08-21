/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include <stdio.h>
#include <stdlib.h>
#include "team.h"

const int POP = 5;

int main(int argc, char * argv[]) {
	char * names[] = {"AA", "BB", "CC", "DD", "EE"};
	int favorites[] = {1, 1, 2, 2, 2};
	struct Team team = create_team(POP, names, favorites);
	struct Person * leader = pick_leader(&team);
	printf("There are %d people on the team. \n", team.population);
	for(int ct = 0; ct < POP; ct ++) {
		printf("%s's favorite is %s. \n", team.people[ct].name, team.people[ct].favorite -> name);
	}
	printf("The leader is %s. \n", leader -> name);
	free_team(&team);
	int favorites2[] = {1, 1, 2, 2, 0};
	printf("If there is a tie: \n");
	team = create_team(POP, names, favorites2);
	printf("There are %d people on the team. \n", team.population);
	for(int ct = 0; ct < POP; ct ++) {
		printf("%s's favorite is %s. \n", team.people[ct].name, team.people[ct].favorite -> name);
	}
	leader = pick_leader(&team);
	printf("The leader is %s. \n", leader -> name);

	return EXIT_SUCCESS;
}
