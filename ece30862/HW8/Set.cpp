//
// Created by Haobo Chen on 9/29/2018.
//

#include "Set.h"
int Set::copy_cnt = 0;

Set::Set(int size):size(size){
    slots = new int[size];
    for(int ct = 0; ct < size; ct ++){
        slots[ct] = 0;
    }
}

Set::Set(const Set &orig) {
    //slots = orig.getSlots();
    slots = new int[orig.getSize()];
    size = orig.getSize();
    int* orig_slots = orig.getSlots();
    for(int ct = 0; ct < size; ct++){
        slots[ct] = orig_slots[ct];
    }
    Set::copy_cnt++;
}

Set::~Set(){
}

Set Set::operator+(const int & new_num) {
    Set new_set = Set(*this);
    //Set new_set = Set(size);
    for(int ct = 0; ct < size; ct ++){
        if(slots[ct] == 1){
            new_set.addNum(ct);
        }
    }
    new_set.addNum(new_num);
    return new_set;
}

Set Set::operator-(const int & del_num) {
    Set new_set = Set(*this);
    //Set new_set = Set(size);
    for(int ct = 0; ct < size; ct ++){
        if(slots[ct] == 1){
            new_set.addNum(ct);
        }
    }
    new_set.delNum(del_num);
    return new_set;
}

Set Set::operator&(const Set& comp_set) {
    //Set new_set = Set(*this);
    Set new_set = Set(size);
    int* comp_slots = comp_set.getSlots(); // TODO: might be wrong
    for(int ct = 0; ct < size; ct ++){
        if(slots[ct] == 1 && comp_slots[ct] == 1){
            new_set.addNum(ct);
        }
    }
    return new_set;
}

Set Set::operator/(const Set & diff_set) {
    //Set new_set = Set(*this);
    Set new_set = Set(size);
    int* diff_slots = diff_set.getSlots();
    for(int ct = 0; ct < size; ct ++) {
        if(slots[ct] == 1 && diff_slots[ct] != 1){
            new_set.addNum(ct);
        }
    }
    return new_set;
}

Set Set::operator~() {
    //Set new_set = Set(*this);
    Set new_set = Set(size);
    for(int ct = 0; ct < size; ct ++) {
        if(slots[ct] != 1){
            new_set.addNum(ct);
        }
    }
    return new_set;
}
/*
Set Set::operator=(const Set& old_set){
    if(this != &old_set){
        delete [] slots;
        slots = new int[old_set.getSize()];
        for (int ct; ct < old_set.getSize(); ct ++){
            slots[ct] = old_set.getSlots()[ct];
        }
    }
    return *this;
}
*/
std::ostream& operator<<(std::ostream & os , const Set & print_set) {
    int* print_slots = print_set.getSlots();
    bool first = true;
    for(int ct = 0; ct < print_set.getSize(); ct ++) {
        if(print_slots[ct] == 1){
            if(first){
                first = false;
                os << ct;
            }
            else{
                os << ", " << ct;
            }
        }
    }
    os << std::endl;
    return os;
}
