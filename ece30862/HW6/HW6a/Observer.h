#ifndef OBSERVER_H
#define OBSERVER_H

class Observer {
public:
   Observer( );
   virtual ~Observer( );
   // need an abstract notify function here
   virtual void notify(double, double) = 0;
};

#endif /* OBSERVER_H */
