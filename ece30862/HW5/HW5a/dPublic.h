#ifndef DPUBLIC_H
#define DPUBLIC_H
#include <iostream>
#include <string>
#include "PublicDerived.h"
using namespace std;

class dPublic : public PublicDerived {
public:
   dPublic( );
   virtual ~dPublic( );
   void print( );
};

#endif /* DPUBLIC_H */
