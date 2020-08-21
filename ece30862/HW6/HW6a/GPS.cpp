#include <iostream>
#include "GPS.h"

GPS::GPS(int s) : x(0), y(0), size(s), idx(0){
   obs = new Observer*[size];
}

GPS::~GPS( ) {
   delete obs;
   delete this;
}

void GPS::subscribe(Observer * o) {
    if(idx >= size){
        std::cout << "obs full, size: " << size << ", idx:" << idx << std::endl;
    }
    else{
        obs[idx] = o;
        idx ++;
    }
}

void GPS::update(double xx, double yy) {
    x = xx;
    y = yy;
    notify();
}

void GPS::notify() {
    for(int ct = 0; ct < idx; ct++){
        obs[ct]->notify(x, y);
    }
}
