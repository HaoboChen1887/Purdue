#include "sorts.h"

static List _construct_list(int size);
static void _add_node(List * list, int value);
static ListNode * _merge_list(ListNode * left, ListNode * right);
static int _cmp_int(const void * num1, const void * num2);
static BSTNode * _bst_add(BSTNode * nd, int val);
static void _free_bst(BSTNode * root);
static void _store_result(BSTNode * root, int * array, int * idx);

void merge_sort_array(int * array, size_t size) {
	if(size < 2) {
		return;
	}
	List list = create_list(array, size);
	merge_sort_list(&list);
	ListNode * curr = list.head;
	for(int ct = 0; ct < size; ct ++) {
		array[ct] = curr -> value;
		curr = curr -> next;
	}
	empty_list(&list);
	return;
}

void tree_sort_array(int * array, size_t size) {
	if(size < 2) {
		return;
	}
	BST bst = create_bst(array, size);
	int idx = 0;
	_store_result(bst.root, array, &idx);
	empty_bst(&bst);
	return;
}

void quick_sort_array(int * array, size_t size) {
	if(size < 2) {
		return;
	}
	qsort(&array[0], size, sizeof(int), _cmp_int);
	return;
}

List create_list(const int * array, int size) {
	List list = _construct_list(size);
	for(int ct = 0; ct < size; ct ++) {
		_add_node(&list, array[ct]);
	}
	return list;
}

void merge_sort_list(List * list) {
	if(list -> size == 0 || list -> size == 1) {
		return;
	}
	ListNode * curr = list -> head;
	for(int ct = 1; ct < list -> size / 2; ct ++) {
		curr = curr -> next;
	}

	List left = {
		.head = list -> head,
		.tail = curr,
		.size = list -> size / 2
	};
	curr = curr -> next;
	left.tail -> next = NULL;
	List right = {
		.head = curr,
		.tail = list -> tail,
		.size = (list -> size % 2 == 0) ? (list -> size / 2) : (list -> size / 2 + 1)
	};
	merge_sort_list(&left);
	merge_sort_list(&right);
	list -> head = _merge_list(left.head, right.head);

	return;
}

void empty_list(List * list) {
	ListNode * curr = list -> head;
	while(curr != NULL) {
		ListNode * todelete = curr -> next;
		free(curr);
		curr = todelete;
	}
	return;
}

BST create_bst(const int * array, int size) {
	BST bst = {
		.root = NULL,
		.size = 0
	};
	for(int ct = 0; ct < size; ct ++) {
		bst.root = _bst_add(bst.root, array[ct]);
	}
	return bst;
}

static BSTNode * _bst_add(BSTNode * nd, int val) {
	if(nd == NULL) {
		nd = malloc(sizeof(*nd));
		nd -> value = val;
		nd -> left = NULL;
		nd -> right = NULL;
		return nd;
	}
	if(val < nd -> value) {
		nd -> left = _bst_add(nd -> left, val);
	}
	else {
		nd -> right = _bst_add(nd -> right, val);
	}
	return nd;
}

void empty_bst(BST * bst) {
	_free_bst(bst -> root);
	return;
}

static List _construct_list(int size) {
	List list = {
		.head = NULL,
		.tail = NULL,
		.size = size
	};
	return list;
}


static void _add_node(List * list, int value) {
	ListNode * newnd = malloc(sizeof(*newnd));
	newnd -> next = NULL;
	newnd -> value = value;
	if(list -> head == NULL) {
		list -> head = newnd;
	}
	else {
		ListNode * curr = list -> head;
		while(curr -> next != NULL) {
			curr = curr -> next;
		}
		curr -> next = newnd;
	}
	list -> tail = newnd;
	return;
}

static ListNode *  _merge_list(ListNode * currl, ListNode * currr) {
	ListNode * newhead = NULL;
	// if one list is empty, return the other sorted list;
	if(currl == NULL) {
		return currr;
	}
	else if(currr == NULL) {
		return currl;
	}

	if(currl -> value < currr -> value) {
		newhead = currl;
		newhead -> next = _merge_list(currl -> next, currr);
	}
	else {
		newhead = currr;
		newhead -> next = _merge_list(currr -> next, currl);
	}
	return newhead;
}

static int _cmp_int(const void * num1, const void * num2) {
	return (*(int*)num1) - (*(int*)num2);
}

static void _free_bst(BSTNode * root) {
	if(root == NULL) {
		return;
	}
	_free_bst(root -> left);
	_free_bst(root -> right);
	free(root);
	return;
}

static void _store_result(BSTNode * root, int * array, int * idx) {
	if(root == NULL) {
		return;
	}	
	_store_result(root -> left, array, idx);
	array[*idx] = root -> value;
	(*idx) ++;
	_store_result(root -> right, array, idx);
	return;
}
