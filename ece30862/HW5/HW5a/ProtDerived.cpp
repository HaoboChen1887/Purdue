#include "ProtDerived.h"

ProtDerived::ProtDerived( ) { }
ProtDerived::~ProtDerived( ){ }
void ProtDerived::print( ) { 
   cout << "ProtDerived" << endl;
   //cout << "privB: " << privB;
   cout << ", protB: " << protB;
   cout << ", publicB: " << publicB; 
   cout << endl << endl;
}

