// This is the main class for HW2
// This assignment demonstrates inheritance, overriding and polymorphism
//
// Modify the Base and Derived classes to get the output indicated below.
#include "Base.h"
#include "Derived.h"
#include <iostream>

int main(int argc, char **argv) {

   Base *b = new Base( );
   Derived *d = new Derived( );

   b->f1( ); // prints "Base f1"
   b->f2( ); // prints "Base f2"

   d->f1( ); // prints "Base f1"
   d->f2( ); // prints "Derived f2"

   b = d;
   b->f1( ); // prints "Base f1"
   b->f2( ); // prints "Derived f2"
}

