#ifndef SUBJECT_H
#define SUBJECT_H
#include "Observer.h"

class Subject {
public:
   Subject( );
   virtual ~Subject( );
   // need an abstract subscribe function declaration
   virtual void subscribe(Observer *) = 0;
};

#endif /* SUBJECT_H */
