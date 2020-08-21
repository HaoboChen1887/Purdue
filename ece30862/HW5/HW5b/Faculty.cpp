#include "Faculty.h"
#include <string>
#include <iostream>

Faculty::Faculty(int d, int m, int y, std::string n):Person(d,m,y,n) {
   std::cout << "construct Faculty" << std::endl;
 }
Faculty::~Faculty( ) { }

void Faculty::putSalary(float s) {
   salary = s;
   std::cout << "putSalary: " << salary << std::endl;
}

float Faculty::getSalary( ) {
   return salary;
   std::cout << "getSalary: " << salary << std::endl;
}

void Faculty::print( ) {
   std::cout << "faculty: " << getSalary( ) << " makes: " << salary << std::endl;
}
