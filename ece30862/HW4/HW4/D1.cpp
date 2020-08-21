#include "D1.h"
#include <iostream>

D1::D1( ) : i(1), j(1), Base( ) { }
D1::~D1( ) { }

void D1::f1( ) {
   std::cout << "D1::f1 " << i << std::endl;
}

void D1::f3( ) {
   std::cout << "D1::f3 " << i << std::endl;
}

void D1::f4( ) {
   std::cout << "D1::f4 " << i << std::endl;
}
