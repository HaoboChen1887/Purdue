#ifndef DERIVED_H_
#define DERIVED_H_
#include "Base.h"
#include <string>
#include <iostream>
using namespace std;

class Derived : public Base {
public:
   Derived( );
   virtual ~Derived( );

   // add necessary functions here
   void f2();

};
#endif /*DERIVED_H*/
