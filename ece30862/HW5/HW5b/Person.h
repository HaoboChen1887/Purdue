#ifndef PERSON_H_
#define PERSON_H_
#include <string>
#include <string>

class Person {

public:
   Person(int, int, int, std::string);
   virtual ~Person( );

private:
   int day;
   int month;
   int year;
   std::string name;
};
#endif /* PERSON_H_ */
