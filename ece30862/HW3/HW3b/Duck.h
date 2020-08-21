#ifndef DUCK_H_
#define DUCK_H_
#include <string>
#include "FlyBehavior.h"
#include "Quack.h"

class Duck {
public:

   Duck(std::string);
   Duck( );
   virtual ~Duck( );

   virtual void quack( );
   virtual void setFlyBehavior(FlyBehavior*);
   virtual void setQuackBehavior(Quack*);
   virtual void fly( );
   virtual void swim( );
   virtual void display( );


private:
   std::string kind;
   FlyBehavior* flyBehavior = NULL;
   Quack* quackBehavior = NULL;
};
#endif /* DUCK_H_ */
