// You may use/copy any/all code from this file.
#ifndef __INDEX_H__
#define __INDEX_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <assert.h>
#include <stdbool.h>
#define HW11_BONUS_1
#define HW11_BONUS_2

typedef struct _StringListNode {
	char*                   filename;
	struct _StringListNode* next;
} StringListNode;

typedef struct _IndexBSTNode {
	char*                   word;
	StringListNode*         filenames;
	struct _IndexBSTNode*   left;
	struct _IndexBSTNode*   right;
} IndexBSTNode;

typedef struct {
	IndexBSTNode*           root;
	// You may add more fields to this, if you like.
} Index;

Index create_index();
void put(Index* index, char* word, char* filename);
char** get(Index* index, int* count, char* word, ...);
void free_index(Index* index);
#endif
//char* strdup_(const char* s); // you may uncomment if you are using this

/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
