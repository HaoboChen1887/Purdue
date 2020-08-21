#include "Student.h"
#include <string>
#include <iostream>

Student::Student(int d, int m, int y, std::string n):Person(d,m,y,n) {
   std::cout << "construct Student " << std::endl;
 }

Student::~Student( ) { }

float Student::getGPA( ) {
   return gpa;
   std::cout << "getGPA" << gpa << std::endl;
}

void Student::putGPA(float g) {
   gpa = g;
   std::cout << "putGPA: " << gpa << std::endl;
}
