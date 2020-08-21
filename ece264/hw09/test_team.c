/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include "team.h"

struct Team create_test_team() {
	struct Person people[] = {
		{.name = "Charles Ma", .favorite = &people[4]},
		{.name = "Jessie Chu", .favorite = &people[4]},
		{.name = "Shixin Meng", .favorite = &people[0]},
		{.name = "Yixin Chen", .favorite = &people[0]},
		{.name = "Haobo Chen", .favorite = &people[3]}
	};

	return create_team("ECE264", 5, people);
}

int main(int argc, char * argv[]) {
	struct Team team = create_test_team();
	fprint_team(&team, stdout);
	struct Person * search = find_person(&team, "Charles Ma");
	printf("The person %s is found at address %p\n", *search, search);
	struct Person * notfound = find_person(&team, "ZZ");
	printf("The person ZZ not found, the address returned is %p\n", notfound);
	add_person(&team, "Jessie Chu", "Charles Ma");
	printf("After adding a person with a same name to the team\n");
	fprint_team(&team, stdout);

	add_person(&team, "BOSS", "Haobo Chen");
	printf("After adding a boss to the team\n");
	fprint_team(&team, stdout);

	struct Person * todelete = detach_person(&team, "Haobo Chen");
	printf("After deleting the Haobo Chen from the team\n");
	fprint_team(&team, stdout);
	free_person(todelete);

	free_team(&team);

	team.head = NULL;
	team.name = "ECE264";
	team.tail = NULL;
	printf("Empty team\n");
	fprint_team(&team, stdout);

	team = create_test_team();
	struct Team new_team = copy_team(&team);
	fprint_team(&team, stdout);
	fprint_team(&new_team, stdout);
	search = find_person(&new_team, "Charles Ma");
	printf("The person %s is found at address %p\n", *search, search);
	notfound = find_person(&new_team, "ZZ");
	printf("The person ZZ not found, the address returned is %p\n", notfound);
	add_person(&new_team, "Jessie Chu", "Charles Ma");
	printf("After adding a person with a same name to the team\n");
	fprint_team(&new_team, stdout);

	add_person(&new_team, "BOSS", "Haobo Chen");
	printf("After adding a boss to the team\n");
	fprint_team(&new_team, stdout);

	todelete = detach_person(&new_team, "Haobo Chen");
	printf("After deleting the Haobo Chen from the team\n");
	fprint_team(&new_team, stdout);
	free_person(todelete);

	free_team(&team);
	free_team(&new_team);
	return EXIT_SUCCESS;
}
