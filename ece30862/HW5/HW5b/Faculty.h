#ifndef FACULTY_H_
#define FACULTY_H_
#include <string>
#include "Person.h"
#include <string>

class Faculty : public Person {

public:
   Faculty(int, int, int, std::string);
   virtual ~Faculty( );

   virtual void putSalary(float);
   virtual float getSalary( );
   virtual void print( );

private:
   float salary;
};
#endif /* FACULTY_H_ */
