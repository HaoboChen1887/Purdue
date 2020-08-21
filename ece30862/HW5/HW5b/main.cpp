//
// THIS CODE IS EVIL and you should never do anything like this.
// It demonstrates what can go wrong when you use C-style casts
//

#include "Person.h"
#include "Student.h"
#include "Faculty.h"
#include <iostream>

int main() {
   Person* p = new Person(1,1,1,"Bob");
   Faculty* f = new Faculty(2,2,2,"Dumbledore");
   Student* s;
   void* v;

   s = (Student*) f; 
   std::cout << "before (s=f).putGPA(6,6)" << std::endl;
   s->putGPA(6.6);
   std::cout << "before (s=f).getGPA" << std::endl;
   s->getGPA( );

   s = new Student(3,3,3,"Irena");
   f = (Faculty *) s; // compiles, but will cause problems at runtime
   std::cout << "before (f=s).putSalary" << std::endl;
   f->putSalary(500.0);
   std::cout << "before (f=s).getSalary" << std::endl;
   f->getSalary( );

   v = (void*) p ;
   s = (Student*) v;
   std::cout << "before (s=p).getGPA" << std::endl;
   s->getGPA( );
   std::cout << "finished" << std::endl;
}
