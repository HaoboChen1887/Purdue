/* vim: set tabstop=4 shiftwidth=4 fileencoding=utf-8 noexpandtab: */
#include "index.h"

static int _calc_len(const char * name);
static char* _strdup(const char* s);
static IndexBSTNode * _construct_node(char * word, char * filename);
static IndexBSTNode * _add_comb(IndexBSTNode * nd, char * word, char * filename);
static StringListNode * _add_filename(StringListNode * filenames, char * filename);
static StringListNode * _add_reference(StringListNode * filenames, char * filename);
static IndexBSTNode * _find_node(IndexBSTNode * root, char * word);
static int _find_size(StringListNode * filenames);
static bool _find_word(StringListNode * to_print, char * filename);
static void _free_nodes(IndexBSTNode * root);
static void _free_filenames_ref(StringListNode * filenames);
static void _free_filenames(StringListNode * filenames);

Index create_index() {
	Index idx = {
		.root = NULL
	};
	return idx;
}
void put(Index* index, char* word, char* filename) {
	if(index == NULL || word == NULL || filename == NULL) {
		return;
	}
	index -> root = _add_comb(index -> root, word, filename);
	return;
}

char** get(Index* index, int* count, char* word, ...) {
	if(index -> root == NULL || count == NULL) {
		return NULL;
	}
	va_list more_args;
	va_start(more_args, word);
	StringListNode * to_print = NULL;
	while(word != NULL) {
		IndexBSTNode * to_print_nd = _find_node(index -> root, word);
		StringListNode * curr = (to_print_nd == NULL) ? NULL : to_print_nd -> filenames;
		while(curr != NULL) {
			if(to_print == NULL) {
				to_print = malloc(sizeof(*to_print));
				to_print -> filename = curr -> filename;	
				to_print -> next = NULL;
			}
			else if(_find_word(to_print, curr -> filename) == false) {
				_add_reference(to_print, curr -> filename);
			}
			curr = curr -> next;
		}
		word = va_arg(more_args, char *);
	}
	va_end(more_args);
	int list_size = _find_size(to_print);
	*count = list_size;
	if(*count == 0) {
			return NULL;
	}
	char ** to_print_arr = malloc(sizeof(*to_print_arr) * list_size);
	int ct = 0;
	StringListNode * curr = to_print;
	while(curr != NULL) {
		to_print_arr[ct] = curr -> filename;
		curr = curr -> next;
		ct ++;
	}
	_free_filenames_ref(to_print);
	return to_print_arr;
}

void free_index(Index* index) {
	if(index == NULL || index -> root == NULL) {
		return;
	}
	_free_nodes(index -> root);
}

static int _calc_len(const char * name) {
	int len = 0;
	while(name[len] != '\0') {
		len ++;
	}
	len ++;
	return len;
}

static char* _strdup(const char* s) {
	return strcpy(malloc(sizeof(*s) * _calc_len(s)), s);
}

static IndexBSTNode * _construct_node(char * word, char * filename) {
	IndexBSTNode * nd = malloc(sizeof(*nd));
	nd -> word = _strdup(word);
	nd -> left = NULL;
	nd -> right = NULL;
	nd -> filenames = malloc(sizeof(*(nd -> filenames)));
	nd -> filenames -> filename = _strdup(filename);
	nd -> filenames -> next = NULL;
	return nd;
}

static IndexBSTNode * _add_comb(IndexBSTNode * nd, char * word, char * filename) {
	if(nd == NULL) {
		return _construct_node(word, filename);
	}
	char * wordidx = nd -> word;
	if(strcmp(word, wordidx) == 0) {
		_add_filename(nd -> filenames, filename);
	}
	if(strcmp(word, wordidx) < 0) {
		nd -> left = _add_comb(nd -> left, word, filename);
	}
	if(strcmp(word, wordidx) > 0) {
		nd -> right = _add_comb(nd -> right, word, filename);
	}
	return nd;
}

static StringListNode * _add_filename(StringListNode * filenames, char * filename) {
		StringListNode * curr = filenames;
		while(curr -> next != NULL) {
			if(strcmp(curr -> filename, filename) == 0) {
				return curr;
			}
			curr = curr -> next;
		}
		if(strcmp(curr -> filename, filename) != 0) {
			StringListNode * new = malloc(sizeof(*new));
			curr -> next = new;
			new -> filename = _strdup(filename);
			new -> next = NULL;
		}
		return curr;
}

static StringListNode * _add_reference(StringListNode * filenames, char * filename) {
		StringListNode * curr = filenames;
		while(curr -> next != NULL) {
			if(strcmp(curr -> filename, filename) == 0) {
				return curr;
			}
			curr = curr -> next;
		}
		if(strcmp(curr -> filename, filename) != 0) {
			StringListNode * new = malloc(sizeof(*new));
			curr -> next = new;
			new -> filename = filename;
			new -> next = NULL;
		}
		return curr;
}

static IndexBSTNode * _find_node(IndexBSTNode * root, char * word) {
	if(root == NULL) {
		return NULL;
	}
	if(strcmp(root -> word, word) == 0) {
		return root;
	}
	if(strcmp(word, root -> word) < 0) {
		return _find_node(root -> left, word);
	}
	return _find_node(root -> right, word);
}

static int _find_size(StringListNode * filenames) {
	int list_size = 0;
	StringListNode * curr = filenames;
	while(curr != NULL) {
		list_size ++;
		curr = curr -> next;
	}
	return list_size;
}

static bool _find_word(StringListNode * to_print, char * filename) {
	StringListNode * curr = to_print;
	if(curr == NULL) {
		return false;
	}
	while(curr != NULL) {
		if(strcmp(curr -> filename, filename)) {
			return false;
		}
		curr = curr -> next;
	}
	return true;
}

static void _free_nodes(IndexBSTNode * root) {
	if(root == NULL) {
		return;
	}
	_free_filenames(root -> filenames);
	free(root -> word);
	_free_nodes(root -> left);
	_free_nodes(root ->right);
	free(root);
}

static void _free_filenames_ref(StringListNode * filenames) {
	while(filenames != NULL) {
		StringListNode * curr = filenames -> next;
		free(filenames);
		filenames = curr;
	}
	return;
}

static void _free_filenames(StringListNode * filenames) {
	while(filenames != NULL) {
		StringListNode * curr = filenames -> next;
		free(filenames -> filename);
		free(filenames);
		filenames = curr;
	}
	return;
}

