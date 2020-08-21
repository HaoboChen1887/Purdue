#ifndef STUDENT_H_
#define STUDENT_H_
#include <string>
#include "Person.h"
#include <string>

class Student : public Person {

public:
   Student(int, int, int, std::string);
   virtual ~Student( );

   virtual float getGPA( );
   virtual void putGPA(float);

private:
   float gpa;
};
#endif /* STUDENT_H_ */
