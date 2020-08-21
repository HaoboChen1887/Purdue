class Element:
    def __init__(self, intKey, strVal):
        if type(intKey) is not int or type(strVal) is not str:
            raise TypeError('invalid argument')
        self.IntegerKey = intKey
        self.StringValue = strVal

    def __str__(self):
        return '({}: "{}")'.format(self.IntegerKey, self.StringValue)

    def __hash__(self):
        return hash(self.IntegerKey)

class StrongDictionary:
    def __init__(self, name):
        if name is "":
            raise ValueError('invalid argument')
        self._name = name
        self._backend = {}

    def __str__(self):
        return '["{0}": {1:02d}]'.format(self._name, len(self._backend.values()))

    def add(self, element):
        if element.IntegerKey in self._backend.keys():
            raise ValueError("element alreay in the dict")
        self._backend[element.__hash__()] = element

    def remove(self, element):
        if element.IntegerKey not in self._backend.keys():
            raise KeyError("element not in dict")
        self._backend.pop(element.__hash__())

    def get(self, key):
        if key not in self._backend.keys():
            raise KeyError("element not in dict")
        return self._backend[key]

    def getAll(self):
        dict = {}
        for hkey in self._backend.keys():
            key = self._backend[hkey].IntegerKey
            value = self._backend[hkey].StringValue
            dict[key] = value
        return dict

if __name__ == '__main__':
    key = 4
    val = 's'
    element = Element(key, val)
    print(element)
    h = hash(element)
    print(h)

    name = 'dict'
    strdic = StrongDictionary(name)
    print(strdic)
    strdic.add(Element(2, 'a'))
    strdic.add(element)
    print(strdic)
    print(strdic._backend)

    strdic.remove(element)
    print(strdic)
    print(strdic._backend)

    print(strdic.get(2))

    strdic.add(Element(222, '1ii11'))
    print(strdic.getAll())

    pass