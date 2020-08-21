import os

def identifyAccess():
    result_dict = {}
    folder = os.listdir("Departments")
    for file in folder:
        info = []
        with open('./Departments/' + file, 'r') as myFile:
            info = myFile.readlines()
            for name in info:
                name = name.strip()
                if name in result_dict:
                    result_dict[name].append(file[:(len(file) - 4)])
                    sorted(set(result_dict[name]))
                else:
                    result_dict[name] = [file[:(len(file) - 4)]]
    return result_dict

def getCommon(name1, name2):
    dict = identifyAccess()
    common = set()
    if name1 not in dict or name2 not in dict:
        return None
    for room in dict[name1]:
        if room in dict[name2]:
            common.add(room)
    return common


if __name__ == '__main__':
    print(identifyAccess())
    print(getCommon('Tamatha Granderson', 'Tasha Shell'))
    print(getCommon('Zenaida Blaisdell', 'Neomi Flournoy'))
    print(getCommon('Merideth Kind', 'Melba Gist'))
    print(getCommon('Not Exist', 'Melba Gist'))
    print(getCommon('Merideth Kind', 'Not Exist'))
