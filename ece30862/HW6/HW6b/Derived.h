#ifndef Derived_H
#define Derived_H
#include "Base.h"

class Derived : public Base {
private:
   int id;
public:
   static void print( );
   static int count;
   Derived();
   virtual ~Derived( );
};

#endif /* Derived_H */
