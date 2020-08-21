#ifndef MAP_H
#define MAP_H
#include "Subject.h"
#include "Observer.h"

class Map:public Observer{
public:
        Map(Subject *);
        virtual ~Map();
        virtual void notify(double, double);
};
#endif /* MAP_H */


