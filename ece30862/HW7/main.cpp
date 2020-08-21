// No variables that are declared protected or private are accessble in main.
//
// Privates are not accessible because they are only accessible in the classs
// that declares them.
//
// Protected variables are not accessible because they are only accessible in
// the class that declared them or a class that (directly or indirectly) 
// inherits from the class that declared them.  
//
#include <iostream>
#include "Base.h"
#include "D.h"

void foo1(Base& b) {
   b.print( );
}

void foo2(D& d) {
   d.print( );
}

int main(void) {

   Base b;
   D d;
   Base& bR1 = b;
   Base& bR2 = d; // Q1
   D& dR = d;

   bR1.print( );
   bR2.print( );
   dR.print( );

   bR2.i = 3; // Q2
   //bR2.j = 3; // Q3
   bR1 = bR2; // Q4

   std::cout << "bR1.i: " << bR1.i << std::endl; // Q5
   //std::cout << "bR1.j: " << bR1.j << std::endl; // Q6
   std::cout << "bR2.i: " << bR1.i << std::endl; // Q7
   //std::cout << "bR2.j: " << bR1.j << std::endl; // Q8

   dR.i = 4;
   dR.j = 4;
   bR1 = dR; // Q9
   std::cout << "bR1.i: " << bR1.i << std::endl; // Q10
   //std::cout << "bR1.j: " << bR1.j << std::endl; // Q11
   std::cout << "dR.i: " << dR.i << std::endl; // Q12
   std::cout << "dR.j: " << dR.j << std::endl; // Q13

   foo1(dR); // Q14
   foo1(bR1); // Q15
   //foo1(&b); // Q16
   //foo1(&d); // Q17

   foo2(dR); // Q18
   //foo2(bR1); // Q19
   //foo1(&b); // Q20
   //foo1(&d); // Q21
}

