#ifndef PUBLICDERIVED_H
#define PUBLICDERIVED_H
#include <iostream>
#include <string>
#include "Base.h"
using namespace std;

class PublicDerived : public Base {
public:
   PublicDerived( );
   virtual ~PublicDerived( );
   void print( );
};

#endif /* PUBLICDERIVED_H */
