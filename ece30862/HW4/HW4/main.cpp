// This is the main class for HW3

#include "Base.h"
#include "D1.h"
#include "D1a.h"
#include "D2.h"
#include <iostream>

int main(int argc, char **argv) {

   Base *bP = new Base( );
   D1 *d1P = new D1( );
   D1a *d1aP = new D1a( );
   D2 *d2P = new D2( );
   Base bV;
   D1 d1V;
   D1a d1aV;
   D2 d2V;

bV.f1( ); // Q1
bV.f3( ); // Q2
bV.f4( ); // Q3
bV.f5( ); // Q4
std::cout << bV.i << ", " << bV.j << ", " << bV.k << std::endl; // Q5

d1P->f1( ); // Q6
d1P->f3( ); // Q7
d1P->f4( ); // Q8
d1P->f5( ); // Q9
std::cout << d1P->i << ", " << d1P->j << ", " << d1P->k << std::endl; // Q10

d1V.f1( ); // Q11
d1V.f3( ); // Q12
d1V.f4( ); // Q13
d1V.f5( ); // Q14
std::cout << d1V.i << ", " << d1V.j << ", " << d1V.k << std::endl; // Q15

/*
d1aP->f1( ); // Q16
d1aP->f2( ); // Q17
d1aP->f3( ); // Q18
d1aP->f4( ); // Q19
d1aP->f5( ); // Q20
std::cout << d1aP->i << ", " << d1aP->j << ", " << d1aP->k << std::endl; // Q21

d1aV.f1( ); // Q22
d1aV.f2( ); // Q23
d1aV.f3( ); // Q24
d1aV.f4( ); // Q25
d1aV.f5( ); // Q26
std::cout << d1aV.i << ", " << d1aV.j << ", " << d1aV.k << std::endl; // Q27
*/

d2P->f1( ); // Q28
d2P->f3( ); // Q29
d2P->f4( ); // Q30
d2P->f5( ); // Q31
std::cout << d2P->i << ", " << d2P->j << ", " << d2P->k << std::endl; // Q32

d2V.f1( ); // Q33
d2V.f3( ); // Q34
d2V.f4( ); // Q35
d2V.f5( ); // Q36
std::cout << d2V.i << ", " << d2V.j << ", " << d2V.k << std::endl; // Q37

bP = d2P;
d1P = d2P; 
bV = d2V; 

bP->f1( ); // Q38
bP->f2( ); // Q39
bP->f3( ); // Q40
bP->f4( ); // Q41
bP->f5( ); // Q42

bV.f1( ); // Q43
bV.f2( ); // Q44
bV.f3( ); // Q45
bV.f4( ); // Q46
bV.f5( ); // Q47
std::cout << bV.i << ", " << bV.j << ", " << bV.k << std::endl; // Q48

d1P->f1( ); // Q49
d1P->f2( ); // Q50
d1P->f3( ); // Q51
d1P->f4( ); // Q52
d1P->f5( ); // Q53
std::cout << d1P->i << ", " << d1P->j << ", " << d1P->k << std::endl; // Q54

d1V.f1( ); // Q55
d1V.f2( ); // Q56
d1V.f3( ); // Q57
d1V.f4( ); // Q58
d1V.f5( ); // Q59
std::cout << d1V.i << ", " << d1V.j << ", " << d1V.k << std::endl; // Q60

d2P->f1( ); // Q61
d2P->f2( ); // Q62
d2P->f3( ); // Q63
d2P->f4( ); // Q64
d2P->f5( ); // Q65
std::cout << d2P->i << ", " << d2P->j << ", " << d2P->k << std::endl; // Q66

d2V.f1( ); // Q67
d2V.f2( ); // Q68
d2V.f3( ); // Q69
d2V.f4( ); // Q70
d2V.f5( ); // Q71
std::cout << d2V.i << ", " << d2V.j << ", " << d2V.k << std::endl; // Q72

bP = d1aP; // Q73
bV = d1aV; // Q74
d1P = d1aP; // Q75
d1V = d1aV; // Q76
}

