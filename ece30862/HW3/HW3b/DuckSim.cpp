#include <iostream>
#include "Duck.h"
#include "Mallard.h"
#include "RedHead.h"
#include "DogToy.h"
#include "Rubber.h"
#include "Dog.h"

int main (int argc, char *argv[]) { 

    Duck* ducks[5];
    Dog* dog = new Dog( );

    ducks[0] = new Duck( );
    ducks[1] = new Mallard( );
    ducks[2] = new RedHead( );
    ducks[3] = new Rubber( );
    ducks[4] = new DogToy( );

    for (int i = 0; i < 5; i++) {
       ducks[i]->display( );
       ducks[i]->quack( );
       ducks[i]->fly( );
       std::cout << std::endl;
   }

   dog->play(ducks[4]);
   ducks[4]->display( );
   ducks[4]->quack( );
   ducks[4]->fly( );

   
}
