#include "Subject.h"
#include "Observer.h"
#include "GPS.h"
#include "Map.h"
#include "Alarm.h"
#include <string>

int main(void) {
   GPS* gps = new GPS(3);
   Map* map = new Map(gps);
   Alarm* alarm1 = new Alarm(gps, 1, 0.0, 0.0, 0.9);
   Alarm* alarm2 = new Alarm(gps, 2, 1.0, 1.0, 1.0);
   Alarm* alarm3 = new Alarm(gps, 3, 5.0, 5.0, 1.0);

   gps->update(1.0, 1.0);
   gps->update(4.0, 4.0);

}
