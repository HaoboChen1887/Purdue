#! /user/local/bin/python3.4
def getHorizontalMax():
    rows = fread("square.txt")
    matrix = []
    for row in rows:
        matrix.append(row.split())
    dim = len(matrix)
    max = 0
    result = ()
    for row in range(0, dim):
        for col in range(0, dim - 3):
            prod = 1
            for idx in range(col, col + 4):
                prod = prod * int(matrix[row][idx])
            if prod >= max:
                max = prod
                result = (max, [int(matrix[row][col]), int(matrix[row][col+1]), int(matrix[row][col+2]), int(matrix[row][col+3])])
    return result

def getVerticalMax():
    rows = fread("square.txt")
    matrix = []
    for row in rows:
        matrix.append(row.split())
    matrix = reverseMatrix(matrix)
    dim = len(matrix)
    max = 0
    result = ()
    for row in range(0, dim):
        for col in range(0, dim - 3):
            prod = 1
            for idx in range(col, col + 4):
                prod = prod * int(matrix[row][idx])
            if prod >= max:
                max = prod
                result = (max, [int(matrix[row][col]), int(matrix[row][col+1]), int(matrix[row][col+2]), int(matrix[row][col+3])])
    return result

def getCode(name, day):
    dict = {}
    lines = fread("codes.txt")
    lines = [line.split() for line in lines]
    lines = lines[3:]
    for line in lines:
        for days in range(1, 21):
            dict[(line[0] + ' ' + line[1], "{0:02d}/{1:02d}".format(int(day[0:2]), days))] = line[days + 1]

    return dict[(name, day)]

def getCodesOn(day):
    dict = {}
    lines = fread("codes.txt")
    lines = [line.split() for line in lines]
    lines = lines[3:]
    dict = {}
    for line in lines:
        for days in range(1, 21):
            key = "{0:02d}/{1:02d}".format(int(day[0:2]), days)
            if key not in dict:
                dict[key] = [line[days + 1]]
            else:
                dict[key].append(line[days + 1])
    if day not in dict:
        result = set()
    else:
        result = set(dict[day])
    return result

def getUsersOf(code):
    dict = {}
    lines = fread("codes.txt")
    lines = [line.split() for line in lines]
    day = lines[1][2][0:2]
    lines = lines[3:]

    for line in lines:
        for days in range(1, 21):
            key = line[days + 1]
            if key not in dict:
                dict[key] = [(line[0] + ' ' + line[1], "{0:02d}/{1:02d}".format(int(day[0:2]), days))]
            else:
                dict[key].append((line[0] + ' ' + line[1], "{0:02d}/{1:02d}".format(int(day[0:2]), days)))
    if code not in dict:
        return set()
    return dict[code]

def getCommonCodes(name1, name2):
    dict = {}
    lines = fread("codes.txt")
    lines = [line.split() for line in lines]
    lines = lines[3:]

    for line in lines:
        for codes in line[2:]:
            name = line[0] + ' ' + line[1]
            if name not in dict:
                dict[name] = [codes]
            else:
                dict[name].append(codes)

    result = set()
    for code1 in dict[name1]:
        if code1 in dict[name2]:
            result.add(code1)

    return result


def reverseMatrix(matrix):
    dim = len(matrix)
    r_matrix = []
    line = []
    for row in range(0, dim):
        for col in range (0, dim):
            line.append(0)
        r_matrix.append(line)
        line = []

    for row in range(0, dim):
        for col in range(0,dim):
            r_matrix[row][col] = matrix[col][row]
    return r_matrix

# Read all file information into a list of lines
def fread(fname):
    lines = []
    with open(fname, 'r') as myFile:
        lines = myFile.readlines()
    return lines

if __name__ == "__main__":
    print(getHorizontalMax())
    print(getVerticalMax())
    print(getCode("Turner, Theresa", "08/14"))
    print(getCodesOn("08/14"))
    print(getCodesOn("08/24"))
    print(getUsersOf("80860"))
    print(getUsersOf("99999"))
    print(getCommonCodes("Moore, John", "Ross, Frances"))
    print(getCommonCodes("Lee, Julie", "Thomas, Mark"))
    print(getCommonCodes("Brooks, Carol", "Smith, Jimmy"))

    pass