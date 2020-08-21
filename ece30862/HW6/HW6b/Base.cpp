#include <iostream>
#include "Base.h"

int Base::count=0;

Base::Base( ) {
  id = count++;
  std::cout << "C B: " << id << std::endl;
}

Base::~Base( ) {std::cout << "~Base: " << id << std::endl;}
