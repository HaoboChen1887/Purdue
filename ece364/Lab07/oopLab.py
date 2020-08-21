class TimeSpan:
    def __init__(self, weeks, days, hours):
        if weeks < 0 or days < 0 or hours < 0:
            raise ValueError("The arguements cannot be negative")
        else:
            days = days + hours // 24
            hours = hours % 24
            weeks = weeks + days // 7
            days = days % 7
            self.weeks = weeks
            self.days = days
            self.hours = hours

    def __str__(self):
        return "{weeks:02d}W {days:01d}D {hours:02d}H".format(weeks=self.weeks, days=self.days, hours=self.hours)

    def getTotalHours(self):
        return self.weeks * 7 * 24 + self.days * 24 + self.hours

    def __radd__(self, other):
        return self + other

    def __add__(self, other):
        if type(other) is not TimeSpan:
            raise TypeError("Adding a non-TimeSpan arguement to a TimeSpan class is not supported")
        else:
            new = TimeSpan(0, 0, 0)
            new.weeks = self.weeks + other.weeks
            new.days = self.days + other.days
            new.hours = self.hours + other.hours
            new.days = new.days + new.hours // 24
            new.hours = new.hours % 24
            new.weeks = new.weeks + new.days // 7
            new.days = new.days % 7
        return new

    def __rmul__(self, other):
        return self * other

    def __mul__(self, other):
        if type(other) is not type(int()):
            raise TypeError("Multipying TimeSpan class with a non-int argument is not supported")
        elif other <= 0:
            raise ValueError("The argument has to be a positive number")
        else:
            new = TimeSpan(0, 0, 0)
            new.weeks = self.weeks * other
            new.days = self.days * other
            new.hours = self.hours * other
            new.days = new.days + new.hours // 24
            new.hours = new.hours % 24
            new.weeks = new.weeks + new.days // 7
            new.days = new.days % 7
        return new



if __name__ == "__main__":
    ts = TimeSpan(2, 15, 49)
    print(ts)
    print(ts.getTotalHours())
    ts = ts + ts
    print(ts)
    print(ts.getTotalHours())
    ts = 2 * ts
    print(ts)
    print(ts.getTotalHours())
    ts = ts * 2
    print(ts)
    print(ts.getTotalHours())
