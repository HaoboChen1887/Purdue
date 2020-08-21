#include "PublicDerived.h"

PublicDerived::PublicDerived( ) { }
PublicDerived::~PublicDerived( ){ }
void PublicDerived::print( ) { 
   cout << "publicDerived" << endl;
   //cout << "privB: " << privB;
   cout << ", protB: " << protB;
   cout << ", publicB: " << publicB; 
   cout << endl << endl;
}

