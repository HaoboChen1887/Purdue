/********************************************************************
 *
 * This is a kludge for the time being because we don't yet know 
 * about abstract classes.  But it will work for now.  The only
 * purpose of this class is for other classes to inherit from it
 * and to therefore support polymorphic behavior.
 *
 *********************************************************************/
#ifndef FLYBEHAVIOR_H_
#define FLYBEHAVIOR_H_
#include <string>

class FlyBehavior {
public:

   FlyBehavior( );
   virtual ~FlyBehavior( );
   virtual void fly( );
};
#endif /* FLYBEHAVIOR_H_ */
