#ifndef __SORTING_H__
#define __SORTING_H_
typedef struct _Node {
	long value;
	struct _Node * next;
}Node;

Node * Load_From_File(char * Filename);
int Save_To_File(char * Filename, Node * list);
Node * Shell_Sort(Node * list);
int Print_Seq(char * Filename, int Size);
#endif
