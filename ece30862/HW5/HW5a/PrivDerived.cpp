#include "PrivDerived.h"

PrivDerived::PrivDerived( ) { }
PrivDerived::~PrivDerived( ){ }
void PrivDerived::print( ) {
   cout << "PrivDerived" << endl;
   //cout << "privB: " << privB;
   //cout << ", protB: " << protB;
   //cout << ", publicB: " << publicB;
   cout << endl << endl;
}

