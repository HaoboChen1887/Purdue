#include <iostream>
#include "Mallard.h"

Mallard::Mallard( ) : Duck("Mallard") { 
   setFlyBehavior(new FlyWithWings( ));
   setQuackBehavior(new QuackQuack( ));
}

Mallard::~Mallard( ) { }
