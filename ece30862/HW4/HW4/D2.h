#ifndef D2_H_
#define D2_H_
#include "D1.h"

class D2 : public D1 {
public:
   D2( );
   virtual ~D2( );

   virtual void f1( );
   virtual void f3( );
   void f4( );

   int i; 

};
#endif /*D2_H*/
