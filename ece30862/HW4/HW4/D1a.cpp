#include "D1a.h"
#include <iostream>

D1a::D1a( ) : i(1), j(1) { }
D1a::~D1a( ) { }

void D1a::f1( ) {
   std::cout << "D1a::f1 " << i << std::endl;
}

void D1a::f3( ) {
   std::cout << "D1a::f3 " << i << std::endl;
}

void D1a::f4( ) {
   std::cout << "D1a::f4 " << i << std::endl;
}
