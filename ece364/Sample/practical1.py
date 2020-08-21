
def isValidOutput(fileName):
    solution = ""
    valid = True;
    with open(fileName, 'r') as myFile:
        solution = myFile.readlines()
    solution = [line.strip() for line in solution]

    for line in solution:
        for num in range(1, 10):
            if str(num) not in line:
                return False

    solution = reverseMatrix(solution)
    for line in solution:
        for num in range(1, 10):
            if str(num) not in line:
                return False
    return valid

def isColumnPuzzle(fileName):
    with open(fileName, 'r') as myFile:
        puzzle = myFile.readlines()
    puzzle = [line.strip() for line in puzzle]

    if '.........' in puzzle:
        return False
    else:
        return True

def solvePuzzle(sourceFileName, targetFileName):
    with open(sourceFileName, 'r') as myFile:
        puzzle = myFile.readlines()
    puzzle = [line.strip() for line in puzzle]

    if not isColumnPuzzle(sourceFileName):
        temp = reverseMatrix(puzzle)
    else:
        temp = reverseMatrix(reverseMatrix(puzzle))

    solution = temp
    for line in temp:
        for num in range(1, 10):
            if str(num) not in line:
                '''print(line)
                print(solution.index(line))
                print(line.index('.'))
                print(line[line.index('.')])'''
                solution[solution.index(line)][line.index('.')] = str(num)

    if not isColumnPuzzle(sourceFileName):
        solution = reverseMatrix(solution)
    with open(targetFileName, 'w') as myFile:
        for line in solution:
            for char in line:
               myFile.write(char)
            myFile.write('\n')
    return solution


def getCallersOf(phoneNumber):
    activity_dict = makeDic('ActivityList.txt', {}, None, 2, 1, 0, 1)
    name_dict = makeDic('People.txt', {}, '|', 2, 1, 0, 1)
    name_set = set()
    for phone in activity_dict[phoneNumber]:
        last_num = phone[len(phone) - 4:len(phone)]
        for num in name_dict.keys():
            if last_num in num:
                name_set.add(name_dict[num][0])

    name_list = sorted(name_set)
    return name_list


def getCallActivity():
    result_dict = {};
    name_dict = makeDic('People.txt', {}, '|', 2, 1, 0, 1)
    activity_dict = makeDic('ActivityList.txt', {}, None, 2, 0, 2, 1)
    for key in name_dict.keys():
        for a_key in activity_dict.keys():
            if key[1:len(key)] in a_key:
                if name_dict[key][0] in result_dict:
                    result_dict[name_dict[key][0]].append(activity_dict[a_key])
                else:
                    result_dict[name_dict[key][0]] = [activity_dict[a_key]]

    for name in name_dict.values():
        for times in result_dict[name[0]]:
            hrs = 0;
            min = 0;
            sec = 0;
            cnt = 0;
            print(times)
            for time in times:
                print(time)
                print(time[0:2])
                print(time[3:5])
                cnt = cnt + 1
                min = min + int(time[0:2])
                sec = sec + int(time[3:5])
            min = min + sec / 60;
            sec = sec % 60;
            hrs = hrs + min / 60;
            min = min % 60;
            result_dict[name[0]] = (cnt, "{0:02d}:{1:02d}:{2:02d}".format(int(hrs), int(min), int(sec)))
    print(result_dict)

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

# Make the information in a string in to a dictionary
def makeDic(fname, dict, delim, startline, pair1, pair2, direction):
    new_info = fread(fname)
    new_info = new_info[startline:]
    new_list = []
    for info in new_info:
        info = info.split(delim)
        info[pair1] = info[pair1].strip()
        info[pair2] = info[pair2].strip()
        if direction == 1: # forward search
            if info[pair1] in dict:
                dict[info[pair1]].append(info[pair2])
                list(set(dict[info[pair1]]))
            else:
                dict[info[pair1]] = [info[pair2]]
        else: # bidirectional search
            if info[pair1] in dict:
                dict[info[pair1]].append(info[pair2])
                list(set(dict[info[pair1]]))
            else:
                dict[info[pair1]] = [info[pair2]]
            if info[pair2] in dict:
                dict[info[pair2]].append(info[pair1])
                list(set(dict[info[pair2]]))
            else:
                dict[info[pair2]] = [info[pair1]]
    return dict

# Read all file information into a list of lines
def fread(fname):
    lines = []
    with open(fname, 'r') as myFile:
        lines = myFile.readlines()
    return lines


if __name__ == "__main__":
    print(isValidOutput('valid.sud'))
    print(isValidOutput('invalid1.sud'))
    print(isValidOutput('invalid2.sud'))
    print(isColumnPuzzle('open1.sud'))
    print(isColumnPuzzle('open2.sud'))
    solvePuzzle('open1.sud', 'mysol1.sud')
    solvePuzzle('open2.sud', 'mysol2.sud')
    print(isValidOutput('mysol1.sud'))
    print(isValidOutput('mysol2.sud'))
    getCallersOf('707-825-5871')
    getCallActivity()