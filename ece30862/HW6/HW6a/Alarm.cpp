#include <iostream>
#include <cmath>
#include "Alarm.h"

Alarm::Alarm(Subject * s, int i, double xx, double yy, double alarm)
     : id(i), x(xx), y(yy), soundAlarm(alarm){
    s -> subscribe(this);
}

Alarm::~Alarm( ) {
    delete this;
}

void Alarm::notify(double xx, double yy) {
    double dist = std::sqrt((xx - x) * (xx - x) + (yy - y) * (yy - y));
    if(dist > soundAlarm){
        std::cout << "Alarm" << id << " Sounded! Moved " << dist << " meters" << std::endl;
    }
}
