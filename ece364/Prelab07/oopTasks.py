from enum import Enum
import re
from random import sample


class Level(Enum):
    freshman = "Freshman"
    sophomore = "Sophomore"
    junior = "Junior"
    senior = "Senior"


class Student:
    def __init__(self, ID, firstname, lastname, level):
        self.ID = ID
        self.firstName = firstname
        self.lastName = lastname
        self.level = level
        if type(level) is not Level:
            raise TypeError("The argument must be an instance of the 'Level' Enum.")

    def __str__(self):
        return "{0}, {1} {2}, {3}".format(self.ID, self.firstName, self.lastName, self.level.value)


class Circuit:
    def __init__(self, ID, resistors, capacitors, inductors, transistors):
        self.ID = ID
        self.resistors = resistors
        self.capacitors = capacitors
        self.inductors = inductors
        self.transistors = transistors
        if type(self.ID) is not type(str()) or re.search(r'\d{5}', self.ID) is None and self.ID is not '':
            raise ValueError("The circuit ID number is invalid")
        if type(self.resistors) is not type(list()):
            raise ValueError("The resistors' list is not a valid list")
        else:
            for other in self.resistors:
                if type(other) is not type(str()) or re.search(r'[R]\d{0,3}\.\d{0,3}', other) is None and self.resistors is not []:
                    raise ValueError("The resistors' list contain non-string type")
        if type(self.capacitors) is not type(list()):
            raise ValueError("The capacitors' list is not a valid list")
        else:
            for other in self.capacitors:
                if type(other) is not type(str()) or re.search(r'[C]\d{0,3}\.\d{0,3}', other) is None and self.capacitors is not []:
                    raise ValueError("The capacitors' list contain non-string type")
        if type(self.inductors) is not type(list()):
            raise ValueError("The inductors' list is not a valid list")
        else:
            for other in self.inductors:
                if type(other) is not type(str()) or re.search(r'[L]\d{0,3}\.\d{0,3}', other) is None and self.inductors is not []:
                    raise ValueError("The inductors' list contain non-string type")
        if type(self.transistors) is not type(list()):
            raise ValueError("The transistors' list is not a valid list")
        else:
            for other in self.transistors:
                if type(other) is not type(str()) or re.search(r'[T]\d{0,3}\.\d{0,3}', other) is None and self.transistors is not []:
                    raise ValueError("The transistors' list contain non-string type")

    def __str__(self):
        return '{0}: (R = {1}, C = {2}, L = {3}, T = {4})'.format(self.ID, len(self.resistors), len(self.capacitors), len(self.inductors), len(self.transistors))

    def __contains__(self, item):
        if type(item) is not type(str()):
            raise TypeError("The arguement is not a valid string type")
        if re.search(r'^[RCLT]', item) is None:
            raise ValueError("The argument is not a valid device id")
        return item in self.resistors or item in self.transistors or item in self.capacitors or item in self.inductors

    def __radd__(self, other):
        return self + other;

    def __add__(self, other):
        if type(other) is type(str()):
            if re.search(r'^[RCLT]', other) is None:
                raise ValueError("The argument is not a valid device id")
            if other in self.inductors or other in self.resistors or other in self.capacitors or other in self.transistors:
                return self
            if re.search(r'^R', other) is not None:
                self.resistors.append(other)
                self.resistors.sort()
            elif re.search(r'^C', other) is not None:
                self.capacitors.append(other)
                self.capacitors.sort()
            elif re.search(r'^L', other) is not None:
                self.inductors.append(other)
                self.inductors.sort()
            elif re.search(r'^T', other) is not None:
                self.transistors.append(other)
                self.transistors.sort()
            return self
        elif type(other) is Circuit:
            new = Circuit(self.ID, self.resistors, self.capacitors, self.inductors, self.transistors)
            new.ID = '{num:05d}'.format(num=sample(range(0, 100000), 1)[0])
            new.resistors = sorted(set(new.resistors + other.resistors))
            new.capacitors = sorted(set(new.capacitors + other.capacitors))
            new.inductors = sorted(set(new.inductors + other.inductors))
            new.transistors = sorted(set(new.transistors + other.transistors))
            return new
        else:
            raise TypeError("The argument is a invalid type: expecting str or Circuit")


    def __sub__(self, other):
        if type(other) is not type(str()):
            raise TypeError("The arguement is not a valid string type")
        if re.search(r'^[RCLT]', other) is None:
            raise ValueError("The argument is not a valid device id")
        if other not in self.inductors and other not in self.resistors and other not in self.capacitors and other not in self.transistors:
            return self
        if re.search(r'^R', other) is not None:
            self.resistors.remove(other)
        elif re.search(r'^C', other) is not None:
            self.capacitors.remove(other)
        elif re.search(r'^L', other) is not None:
            self.inductors.remove(other)
        elif re.search(r'^T', other) is not None:
            self.transistors.remove(other)
        return self


    def getDetails(self):
        result = ''
        result = result + self.ID + ': ';
        result = result + ' '.join(sorted(self.resistors))
        result = result + ' ' + ' '.join(sorted(self.capacitors))
        result = result + ' ' + ' '.join(sorted(self.inductors))
        result = result + ' ' + ' '.join(sorted(self.transistors))
        return result

class Project:
    def __init__(self, ID, participants, circuits):
        self.ID = ID
        self.participants = participants
        self.circuits = circuits
        if type(self.ID) is not type(str()):
            raise ValueError("The project ID number is invalid")
        if type(self.participants) is not type(list()):
            raise ValueError("The project participants list is invalid")
        else:
            for item in self.participants:
                if type(item) is not Student:
                    raise ValueError("Item(s) in the project participants list is invalid")
        if type(self.circuits) is not type(list()):
            raise ValueError("The circuit list is invalid")
        else:
            for item in self.circuits:
                if type(item) is not Circuit:
                    raise ValueError("Item(s) in the circuit list is invalid")

    def __str__(self):
        return '{proj}: {cir:02d} Circuits, {stu:02d} Participants'.format(proj=self.ID, cir=len(self.circuits), stu=len(self.participants))

    def __contains__(self, item):
        if type(item) is type(str()):
            if re.search(r'^[RCLT]', item) is None:
                raise ValueError("The argument is not a valid device id")
            else:
                for cir in self.circuits:
                    return item in cir.resistors or item in cir.capacitors or item in cir.inductors or item in cir.transistors
        elif type(item) is Circuit:
            return item in self.circuits
        elif type(item) is Student:
            return item in self.participants
        else:
            raise TypeError("The argument is a invalid type: expecting str, Circuit, Student")

    def __add__(self, other):
        if type(other) is Circuit:
            if other in self.circuits:
                return self
            else:
                self.circuits.append(other)
                self.circuits.sort(key=lambda circuit:circuit.ID)
                return self
        elif type(other) is Student:
            if other in self.participants:
                return self
            else:
                self.participants.append(other)
                self.participants.sort(key=lambda student:student.ID)
                return self
        else:
            raise TypeError("The argument is a invalid type: expecting Circuit, Student")

    def __sub__(self, other):
        if type(other) is Circuit:
            if other not in self.circuits:
                return self
            else:
                self.circuits.remove(other)
                return self
        elif type(other) is Student:
            if other not in self.participants:
                return self
            else:
                self.participants.remove(other)
                return self
        else:
            raise TypeError("The argument is a invalid type: expecting Circuit, Student")

    def getDetails(self):
        result = self.ID + '\n\n'
        result = result + 'Participants:\n'
        self.participants.sort(key=lambda student:student.ID)
        self.circuits.sort(key=lambda circuit:circuit.ID)
        for stu in self.participants:
            result = result + str(stu) + '\n'
        result = result + '\nCircuits:\n'
        for cir in self.circuits:
            result = result + cir.getDetails() + '\n'
        return result

class Capstone(Project):
    def __init__(self, ID, participants, circuits):
        Project.__init__(self, ID, participants, circuits)
        proj = Project(ID, participants, circuits)
        for stu in proj.participants:
            if stu.level.value is not "Senior":
                raise ValueError('One or more students in the participants is not a senior')

    def __add__(self, other):
        if other.level.value is not "Senior":
            raise ValueError('One or more students in the participants is not a senior')
        Project.__add__(self, other)
        return self


if __name__ == "__main__":
    level = Level("Senior")
    me = Student("00281-22219", "Haobo", "Chen", level)
    stu = Student("10281-22219", "Haobo", "Chen", level)
    print(me)
    cir = Circuit('55555', [], [], [], [])
    cir = Circuit('99887', ['R436.943', 'R206.298'], ['C261.054', 'C194.315', 'C668.027'], ['L49.234'], ['T663.350'])
    print(cir)
    print(repr(cir.getDetails()))
    print(cir.getDetails())
    print('R436.943' in cir)
    cir = cir + 'R436.943'
    print(cir)
    print('R435.943' in cir)
    cir = cir + 'R435.943'
    print(cir.getDetails())
    print('C261.055' in cir)
    cir = 'C261.055' + cir
    print(cir.getDetails())
    print('R435.943' in cir)
    cir = cir - 'R435.943'
    print(cir.getDetails())
    cir2 = Circuit('55555', ['R555.555', 'R555.555'], ['C664.666'], ['L555.222'], ['T000.000'])
    new = cir + cir2
    print(new.getDetails())
    new = new + cir2
    print(new.getDetails())

    proj = Project('38753067-e3a8-4c9e-bbde-cd13165fa21e', [me] , [cir])
    print(proj)
    print(proj.getDetails())
    print(stu in proj)
    print(me in proj)
    #level = Level("Freshman")
    stu2 = Student("66666-66666", "Haobo", "Chen", level)
    print(stu2 in proj)
    print('R435.943' in proj)
    print('R436.943' in proj)
    print(new in proj)
    print(cir2 in proj)

    print(proj.getDetails())
    proj = proj + stu
    print(proj.getDetails())
    proj = proj - me
    print(proj.getDetails())
    proj = proj + new
    print(proj.getDetails())
    proj = proj - cir
    print(proj.getDetails())

    caps = Capstone('38753067-e3a8-4c9e-bbde-cd13165fa21e', [me] , [cir])
    caps = caps + stu
    print(caps.getDetails())
    caps = caps + stu2
    print(caps.getDetails())
