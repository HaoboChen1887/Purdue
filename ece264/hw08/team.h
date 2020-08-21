/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
// struct definition
#ifndef __TEAM_H__
#define __TEAM_H__

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>

struct Person {
	char * name;
	struct Person * favorite;
};

struct Team {
	char * name;
	struct PersonNode * head;
	struct PersonNode * tail;
};

struct PersonNode {
	struct PersonNode * prev;
	struct Person * value;
	struct PersonNode * next;
};
// function declaration
struct Team create_team(char * name, int population, struct Person * people);
struct Team create_test_team();
void   free_team(struct Team * team);
void   free_person(struct Person * person);
struct Person * add_person(struct Team * team, char * name, char * favorite_name);
struct Person * detach_person(struct Team * team, char * name);
struct Person * find_person(struct Team * team, char * name);
struct Person * pick_leader(struct Team * team);
void   fprint_team(struct Team * team, FILE * stream);

int    _calc_len(char * name);
static struct PersonNode * _construct_node(struct Team * team, char * name, char * favorite_name);
static struct Person * _construct_person(struct Team * team, char * name, char * favorite_name);
#endif
