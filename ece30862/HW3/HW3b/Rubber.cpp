#include <iostream>
#include "Rubber.h"

Rubber::Rubber( ) : Duck("Rubber") { 
   setFlyBehavior(new NoFly( ));
   setQuackBehavior(new QuackQuack( ));
}
Rubber::~Rubber( ) { }
