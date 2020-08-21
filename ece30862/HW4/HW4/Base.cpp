#include "Base.h"
#include <iostream>

Base::Base( ) : i(0), j(0), k(0) { }

Base::~Base( ) { }

void Base::f1( ) {
   std::cout << "Base::f1 " << i << std::endl;
}

void Base::f2( ) {
   std::cout << "Base::f2 " << i << std::endl;
}

void Base::f3( ) {
   std::cout << "Base::f3 " << i << std::endl;
}

void Base::f4( ) {
   std::cout << "Base::f4 " << i << std::endl;
}

void Base::f5( ) {
   std::cout << "Base::f5 " << i << std::endl;
}
