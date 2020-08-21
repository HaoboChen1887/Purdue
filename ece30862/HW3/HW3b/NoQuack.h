#ifndef NOQUACK_H_
#define NOQUACK_H_
#include <string>
#include "Quack.h"

class NoQuack : public Quack {
public:

   NoQuack( );
   virtual ~NoQuack( );
   virtual void quack( );
};
#endif /* NOQUACK_H_ */
