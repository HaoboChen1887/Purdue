#include <iostream>
#include "RedHead.h"

RedHead::RedHead( ) : Duck("RedHead") {
   setFlyBehavior(new FlyWithWings( ));
   setQuackBehavior(new QuackQuack( ));
}

RedHead::~RedHead( ) { }
