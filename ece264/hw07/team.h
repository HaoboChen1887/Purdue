/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
// struct definition
struct Person{
	char * name;
	struct Person * favorite;
};

struct Team{
	struct Person * people;
	int population;
};

// function declaration
struct Team create_team(int population, char * names[], int * favorites);
struct Person * pick_leader(struct Team * team);
void free_team(struct Team * team);
