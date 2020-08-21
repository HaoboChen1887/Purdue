#include <iostream>
#include "Duck.h"
#include "NoQuack.h"
#include "Dog.h"

Dog::Dog( ) {}
Dog::~Dog( ) { }

void Dog::play(Duck* fowl) {
   std::cout << "dog plays with "; fowl->display( ); std::cout << std::endl;
   std::cout << "dog destroys "; fowl->display( ); std::cout << std::endl;
   fowl->setQuackBehavior(new NoQuack);
}

