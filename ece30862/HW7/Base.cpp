#include "Base.h"

Base::Base( ) : i(0) {  }

Base::~Base( ) { }

void Base::print( ) {
  std::cout << "i: " << i << std::endl;
}
