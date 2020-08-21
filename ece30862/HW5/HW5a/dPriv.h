#ifndef DPRIV_H
#define DPRIV_H
#include <iostream>
#include <string>
#include "PrivDerived.h"
using namespace std;

class dPriv : public PrivDerived {
public:
   dPriv( );
   virtual ~dPriv( );
   void print( );
};

#endif /* DPRIV_H */
