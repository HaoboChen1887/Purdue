#include "Set.h"
#include <iostream>
using namespace std;

int main(int argc, char * argv[]) {

   Set a = Set(63);
   Set b = Set(63);

   a = a + 4;
   a = a + 8;
   cout << "a w/4, 8: " << a << endl;

   b = b + 8;
   b = b + 16;
   cout << "b w/8, 16: " << b << endl;

   a = a / b;
   cout << "a / b: " << a << endl;

   a = a + 12;
   a = a + 16;
   a = a - 12;
   a = a - 7;
   cout << "a w/4, 16: " << a << endl;

   cout << "~a: " << ~a << endl;
   cout << "a copy count: " << a.getCopyCount( ) << endl;
   cout << "b copy count: " << b.getCopyCount( ) << endl;
}
