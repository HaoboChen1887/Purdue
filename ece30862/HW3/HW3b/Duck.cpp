#include <iostream>
#include <string>
#include "Duck.h"

Duck::Duck( ) {
    kind = "generic duck";
}

Duck::Duck(std::string k) {
    kind = k;
}

Duck::~Duck( ){  }

void Duck::quack( ) {
   if (quackBehavior != NULL) {
      quackBehavior->quack( );
   }
}

void Duck::setQuackBehavior(Quack* q) {quackBehavior = q;}

void Duck::fly( ) {
   if (flyBehavior != NULL) {
      flyBehavior->fly( );
   }
}

void Duck::setFlyBehavior(FlyBehavior* f) {flyBehavior = f;}

void Duck::swim( ) {std::cout << "Swimming!" << std::endl;}

void Duck::display( ) {std::cout << kind << std::endl;}
