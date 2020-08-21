#include "Base.h"
#include "Derived.h"
#include <string>

void foo(Base b) { }
void foo(Derived d) { }
void foo(Base* b) { }
void foo(Derived* d) { }

int main(void) {
   Base* bP = new Base( ); // LINE 1
   Derived* dP = new Derived( ); // LINE 2
   Base b; // LINE 3
   Derived d; // LINE 4
   

   foo(b); // LINE 5
   foo(d); // LINE 6
   foo((Base) d); // LINE 7
   foo(bP); // LINE 8
   foo(dP); // LINE 9

} // LINE 10 (what is printed as the program completes?
