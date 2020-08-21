#ifndef DOG_H_
#define DOG_H_
#include "Duck.h"

class Dog {
public:

   Dog( );
   virtual ~Dog( );
   void play(Duck*);
};
#endif /* DOG_H_ */
