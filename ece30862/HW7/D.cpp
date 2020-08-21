#include <iostream>
#include "D.h"

D::D( ) : j(1) {i = 2;}
D::~D( ){ }
void D::print( ) { 
   std::cout << "i: " << i << ", j: " << j << std::endl;
}

