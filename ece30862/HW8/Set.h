//
// Created by Haobo Chen on 9/29/2018.
//

#ifndef HW8_SET_H
#define HW8_SET_H

#include <iostream>


class Set {
public:
    Set(int);
    Set(const Set&);
    virtual ~Set();
    int* getSlots() const{
        return slots;
    }
    int getSize() const{
        return size;
    }
    void setSize(const int & sz) {
        size = sz;
    }
    void addNum(const int & idx) {
        slots[idx] = 1;
    }
    void delNum(const int & idx) {
        slots[idx] = 0;
    }
    int getCopyCount() const {
        return copy_cnt;
    }
    Set operator+(const int&);
    Set operator-(const int&);
    Set operator&(const Set&);
    Set operator~();
    Set operator/(const Set&);
    //Set operator=(const Set&);
    static int copy_cnt;
private:
    int size;
    int * slots;
};
std::ostream& operator<<(std::ostream&, const Set&);
#endif //HW8_SET_H
