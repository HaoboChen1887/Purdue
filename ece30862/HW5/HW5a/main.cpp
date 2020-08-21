#include "Base.h"
#include "PrivDerived.h"
#include "ProtDerived.h"
#include "PublicDerived.h"
#include "dPriv.h"
#include "dProt.h"
#include "dPublic.h"
#include <iostream>
#include <string>
using namespace std;

int main(void) {

   Base* b = new Base( );
   PrivDerived* privd = new PrivDerived( );
   ProtDerived* protd = new ProtDerived( );
   PublicDerived* publicd = new PublicDerived( );
   dPriv* dpriv = new dPriv( );
   dProt* dprot = new dProt( );
   dPublic* dpublic = new dPublic( );

   cout << "b" << endl;
   //cout << b->privB << endl;
   //cout << b->protB << endl;
   cout << b->publicB << endl;

   cout << "privd" << endl;
   //cout << privd->privB << endl;
   //cout << privd->protB << endl;
   //cout << privd->publicB << endl;

   cout << "protd" << endl;
   //cout << protd->privB << endl;
   //cout << protd->protB << endl;
   //cout << protd->publicB << endl;

   cout << "publicd" << endl;
   //cout << publicd->privB << endl;
   //cout << publicd->protB << endl;
   cout << publicd->publicB << endl;

   cout << "dpriv" << endl;
   //cout << dpriv->privB << endl;
   //cout << dpriv->protB << endl;
   //cout << dpriv->publicB << endl;

   cout << "dprot" << endl;
   //cout << dprot->privB << endl;
   //cout << dprot->protB << endl;
   //cout << dprot->publicB << endl;

   cout << "dpublic" << endl;
   //cout << dpublic->privB << endl;
   //cout << dpublic->protB << endl;
   cout << dpublic->publicB << endl;
}
