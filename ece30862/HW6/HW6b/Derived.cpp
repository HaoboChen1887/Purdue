#include <iostream>
#include "Derived.h"

int Derived::count = 0;

Derived::Derived( ) : Base( ) {
   id = count;
   count++;
   std::cout << "C D: " << id << std::endl;
}

Derived::~Derived( ) {
   std::cout << "D D: " << id << std::endl;
}
