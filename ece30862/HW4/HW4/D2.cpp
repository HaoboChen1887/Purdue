#include "D2.h"
#include <iostream>

D2::D2( ) : i(2), D1( ) { }
D2::~D2( ) { }

void D2::f1( ) {
   std::cout << "D2::f1 " << i << std::endl;
}

void D2::f3( ) {
   std::cout << "D2::f3 " << i << std::endl;
}

void D2::f4( ) {
   std::cout << "D2::f4 " << i << std::endl;
}
