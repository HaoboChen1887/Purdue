#ifndef D1_H_
#define D1_H_
#include "Base.h"

class D1 : public Base {
public:
   D1( );
   virtual ~D1( );

   virtual void f1( );
   virtual void f3( );
   void f4( );

   int i, j;

};
#endif /*D1_H*/
