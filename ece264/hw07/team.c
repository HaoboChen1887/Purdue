/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include <stdlib.h>
#include <stdio.h>
#include "team.h"

int _calcLen(char * name);

struct Team create_team(int population, char * names[], int * favorites) {
	int len = 0;
	char* namex = NULL;
	struct Team team = {NULL, population};
	team.people = malloc(sizeof(*(team.people)) * population);
	team.population = population;
	for(int ct = 0; ct < population; ct ++) {
		// allocate memory with calculated string length
		team.people[ct].favorite = &(team.people[favorites[ct]]);
		len = _calcLen(names[ct]);
		team.people[ct].name = malloc(sizeof(*namex) * len);
		namex = team.people[ct].name;
		// copy string
		int idx = 0;
		while(names[ct][idx] != '\0') {
			namex[idx] = names[ct][idx];
			idx ++;
		}
		namex[idx] = '\0';
	}
	return team;
}

struct Person* pick_leader(struct Team * team) {
	int cts[team -> population];
	int max = 0;
	int maxIdx = 0;
	struct Person * leader = NULL;
	// initialize counter
	for(int ct = 0; ct < team -> population; ct ++) {
		cts[ct] = 0;
	}
	// count vote
	for(int ct = 0; ct < team -> population; ct ++) {
		cts[team -> people[ct].favorite - team -> people] ++;
	}
	// find the person with maximum vote
	for(int ct = 0; ct < team -> population; ct ++) {
		if(max < cts[ct]) {
			max = cts[ct];
			maxIdx = ct;
		}
	}
	leader = &(team -> people[maxIdx]);
	return leader;
}

void free_team(struct Team * team) {
	int ct = 0;
	// free memory for each person's name
	while(ct < team -> population) {
		free(team -> people[ct].name);
		ct ++;
	}
	free(team -> people);
	return;
}

int _calcLen(char * name) {
	int len = 0;
	while(name[len] != '\0') {
		len ++;
	}
	len ++;
	return len;
}
