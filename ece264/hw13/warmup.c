#ifndef _WARMUP_
#define _WARMUP_
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
typedef struct {
	int x;
	int y;
}Point;

char * read_file(const char *path, char ** error);
void write_file(const char * path, const char * contents, char ** error);
void write_point(char * path, Point p, char ** error);
Point read_point(const char * path, char ** error);

static int _get_size(FILE * ptr);
#endif

int main(int argc, char * argv[]) {
	char * file1 = "warmup.txt";
	char * file2 = "warmup_bi.txt";
	char * error = NULL;
	write_file(file1, "ECE264", &error);
	if(error != NULL) {
		printf("%s\n", error);
		free(error);
		return EXIT_FAILURE;
	}
	char * content1 = read_file("x", &error);
	if(error != NULL) {
		printf("%s\n", error);
		free(error);
		return EXIT_FAILURE;
	}
	content1 = read_file(file1, &error);
	if(error != NULL) {
		printf("%s\n", error);
		free(error);
		return EXIT_FAILURE;
	}
	printf("Content of file1: %s\n", content1);
	free(content1);
	Point p = {
		.x = 1,
		.y = 2
	};
	write_point(file2, p, &error);
	if(error != NULL) {
		printf("%s\n", error);
		free(error);
		return EXIT_FAILURE;
	}
	Point pf = read_point("x", &error);
	if(error != NULL) {
		printf("%s\n", error);
		free(error);
		return EXIT_FAILURE;
	}
	pf = read_point(file2, &error);
	if(error != NULL) {
		printf("%s\n", error);
		free(error);
		return EXIT_FAILURE;
	}
	printf("Content of file2: Point x = %d, y = %d\n", pf.x, pf.y);
	return EXIT_SUCCESS;
}

char * read_file(const char *path, char ** error) {
	char * message = "read_file(const char * path, char ** error) failed because success == false";
	FILE * ptr = fopen(path, "r");
	if(ptr == NULL) {
		*error = malloc((strlen(message + 1) * sizeof(*error)));
		strcpy(*error, message);
		return NULL;
	}
	int size = _get_size(ptr);
	char * text = malloc(sizeof(*text) * size);

	if(fread(text, sizeof(char), size, ptr) != size) {
		fclose(ptr);
		return NULL;
	}

	fclose(ptr);
	return text;
}

void write_file(const char * path, const char * contents, char ** error) {
	char * message = "write_file(const char * path, const char * contents, char ** error) failed because success == false";
	FILE * ptr = fopen(path, "w");
	if(ptr == NULL) {
		*error = malloc((strlen(message + 1) * sizeof(*error)));
		strcpy(*error, message);
		return;
	}

	if(fwrite(contents, sizeof(char), strlen(contents) + 1, ptr) != strlen(contents) + 1) {
		fclose(ptr);
		return;
	}
	fclose(ptr);
	return;
}

void write_point(char * path, Point p, char ** error) {
	char * message = "write_point(const char * path, Point p, char ** error) failed because success == false";
	FILE * ptr = fopen(path, "w");
	if(ptr == NULL) {
		*error = malloc((strlen(message + 1) * sizeof(*error)));
		strcpy(*error, message);
		return;
	}

	if(fwrite(&p, sizeof(Point), 1, ptr) != 1) {
		fclose(ptr);
		return;
	}
	fclose(ptr);
	return;
}

Point read_point(const char * path, char ** error) {
	char * message = "read_point(const char * path, char ** error) failed because success == false";
	FILE * ptr = fopen(path, "r");
	Point newpt = {
		.x = 0,
		.y = 0
	};
	if(ptr == NULL) {
		*error = malloc((strlen(message + 1) * sizeof(*error)));
		strcpy(*error, message);
		return newpt;
	}

	if(fread(&newpt, sizeof(Point), 1, ptr) != 1) {
		fclose(ptr);
		return newpt;
	}

	fclose(ptr);
	return newpt;
}

static int _get_size(FILE * ptr) {
	int letter = 0;
	int count = 0;
	while(letter != EOF) {
		letter = fgetc(ptr);
		count ++;
	}
	fseek(ptr, 0, SEEK_SET);
	return count - 1;
}
