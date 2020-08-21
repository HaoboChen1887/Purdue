#ifndef PRIVDERIVED_H
#define PRIVDERIVED_H
#include "Base.h"
#include <iostream>
#include <string>
using namespace std;

class PrivDerived : private Base {
public:
   PrivDerived( );
   virtual ~PrivDerived( );
   void print( );
};

#endif /* PRIVDERIVED_H */
