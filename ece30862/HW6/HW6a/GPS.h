#ifndef GPS_H
#define GPS_H
#include "Observer.h"
#include "Subject.h"

class GPS:public Subject{
public:
    GPS(int);
    virtual ~GPS();
    virtual void subscribe(Observer *);
    virtual void update(double, double);
    virtual void notify();

private:
    double x, y;
    int idx;
    int size;
    Observer ** obs;
};
#endif /* GPS_H */
