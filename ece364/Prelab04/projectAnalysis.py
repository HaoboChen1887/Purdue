import os

# Question 1
def getComponentCountByProject(projectID):
    result = ()
    proj_dict = makeDic('projects.txt', {}, None)
    if projectID not in proj_dict:
        return None

    comp_list = []
    for cir_ID in proj_dict[projectID]:
        fname = "./Circuits/circuit_" + cir_ID + ".txt"
        comp_str = fread(fname)
        comp_list = list(set(comp_list + comp_str[4].split(', ')))

    result = countComp(comp_list, result)
    return result

# Question 2
def getComponentCountByStudent(studentName):
    result = ()
    stu_dict = makeDic(('students.txt'), {}, '|')
    if studentName not in stu_dict:
        return None
    stu_ID = stu_dict[studentName]

    comp_list = []
    folder = os.listdir("Circuits")
    for file in folder:
        comp_str = fread("./Circuits/" + file)
        if stu_ID[0] in comp_str[1]:
            comp_list = list(set(comp_list + comp_str[4].split(', ')))
    result = countComp(comp_list, result)
    return result

# Question 3
def getParticipationByStudent(studentName):
    result = set()
    dict = makeDic('students.txt', {}, '|')
    dict = makeDic('projects.txt', dict, None)
    if studentName not in dict:
        return None
    stu_ID = dict[studentName]

    folder = os.listdir("Circuits")
    for file in folder:
        student_info = fread("./Circuits/" + file)
        if stu_ID[0] in student_info[1]:
            circuit_ID = file[8:13]
            for proj_ID in dict[circuit_ID]:
                result.add(proj_ID)
    return result

# Question 4
def getParticipationByProject(projectID):
    result = set()
    dict = makeDic('students.txt', {}, '|')
    dict = makeDic('projects.txt', dict, None)
    if projectID not in dict:
        return None

    stu_IDs = []
    for cir_ID in dict[projectID]:
        fname = "./Circuits/circuit_" + cir_ID + ".txt"
        circuit = fread(fname)
        stu_IDs = stu_IDs + circuit[1].strip().split(', ')

    stu_IDs = list(set(stu_IDs))
    for stu_ID in stu_IDs:
        if stu_ID not in dict:
            return None
        else:
            stu_name = dict[stu_ID][0]
            result.add(stu_name)
    return result

# Question 5 Check
def getProjectByComponent(components):
    result_set = set()
    result_dic = {}
    dict = makeDic('projects.txt', {}, None)
    for comp in components:
        result_set = set()
        folder = os.listdir("Circuits")
        for file in folder:
            comp_info = fread("./Circuits/" + file)[4]
            if comp in comp_info:
                cir_ID = file[8:13]
                for proj_ID in dict[cir_ID]:
                    result_set.add(proj_ID)
        result_dic[comp] = result_set
    return result_dic

# Question 6 Check
def getStudentByComponent(components):
    result_set = set()
    result_dic = {}
    dict = makeDic('students.txt', {}, '|')
    for comp in components:
        result_set = set()
        folder = os.listdir("Circuits")
        for file in folder:
            info = fread("./Circuits/" + file)
            comp_info = info[4]
            if comp in comp_info:
                stu_IDs = info[1].strip().split(', ')
                for stu_ID in stu_IDs:
                    result_set.add(dict[stu_ID][0])
        result_dic[comp] = result_set
    return result_dic

# Question 7
def getComponentByStudent(studentNames):
    result_set = set()
    result_dic = {}
    dict = makeDic('students.txt', {}, '|')
    for studentName in studentNames:
        result_set = set()
        folder = os.listdir("Circuits")
        for file in folder:
            info = fread("./Circuits/" + file)
            if dict[studentName][0] in info[1]:
                comp_info = info[4].strip().split(', ')
                for comp in comp_info:
                    result_set.add(comp)
            result_dic[studentName] = result_set
    return result_dic

# Question 8
def getCommonByProject(projectID1, projectID2):
    dict = makeDic('projects.txt', {}, None)
    if projectID1 not in dict or projectID2 not in dict:
        return None
    result_list = comp_list_1 = comp_list_2 = []
    folder = os.listdir("Circuits")
    for cir_ID in dict[projectID1]:
        comp_info = fread("./Circuits/circuit_" + cir_ID + ".txt")[4].strip().split(', ')
        comp_list_1 = comp_list_1 + comp_info
    for cir_ID in dict[projectID2]:
        comp_info = fread("./Circuits/circuit_" + cir_ID + ".txt")[4].strip().split(', ')
        comp_list_2 = comp_list_2 + comp_info

    for comp in comp_list_1:
        if comp in comp_list_2:
            result_list.append(comp)
    result_list = list(set(result_list))
    return result_list

# Question 9
def getCommonByStudent(studentName1, studentName2):
    dict = makeDic('students.txt', {}, '|')
    if studentName1 not in dict or studentName2 not in dict:
        return None
    result_list = comp_list_1 = comp_list_2 = []
    folder = os.listdir("Circuits")
    for file in folder:
        info = fread("./Circuits/" + file)
        stu_IDs = info[1]
        if dict[studentName1][0] in stu_IDs:
            comp_list_1 = comp_list_1 + info[4].strip().split(', ')
        if dict[studentName2][0] in stu_IDs:
            comp_list_2 = comp_list_2 + info[4].strip().split(', ')

    for comp in comp_list_1:
        if comp in comp_list_2:
            result_list.append(comp)
    return result_list

# Question 10
def getProjectByCircuit():
    dict = makeDic('projects.txt', {}, None)
    result_dict = {}
    cir_IDs = fread('projects.txt')[2:]
    for cir_ID in cir_IDs:
        cir_ID = cir_ID.strip().split()[0]
        result_dict[cir_ID] = sorted(dict[cir_ID])
    return result_dict

# Question 11
def getCircuitByStudent():
    dict = makeDic('students.txt', {}, '|')
    result_dict = {}
    stu_infos = fread('students.txt')[2:]
    folder = os.listdir("Circuits")
    for stu_info in stu_infos:
        stu_name = stu_info.split('|')[0].strip()
        result_dict[stu_name] = []
    for file in folder:
        cir_ID = file[8:13]
        for stu_info in stu_infos:
            stu_name = stu_info.split('|')[0].strip()
            stu_id = stu_info.split('|')[1].strip()
            if stu_id in fread('./Circuits/' + file)[1]:
                result_dict[stu_name].append(cir_ID)
                result_dict[stu_name] = sorted(list(set(result_dict[stu_name])))
    return result_dict

# Question 12
def getCircuitByStudentPartial(studentName):
    dict = getCircuitByStudent()
    result_dict = {}
    stu_infos = fread('students.txt')[2:]
    exist = True
    for stu_info in stu_infos:
        stu_name = stu_info.split('|')[0].strip()
        if studentName in stu_name:
            result_dict[stu_name] = dict[stu_name]
    if not result_dict:
        return None
    return result_dict


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

# Count the component with a given circuit
def countComp(comp_list, result):
    if not result:
        result = (0, 0, 0, 0)
    comp_dic = {'R':0, 'L':0, 'C':0, 'T':0}
    for comp in comp_list:
        comp_dic[comp[0]] = comp_dic[comp[0]] + 1
    R = comp_dic['R']
    L = comp_dic['L']
    C = comp_dic['C']
    T = comp_dic['T']
    r, l, c, t = result
    r = r + R
    l = l + L
    c = c + C
    t = t + T
    result = r, l, c, t
    if r == l == c == t == 0:
        result = ()
    return result

if __name__ == "__main__":
    print('Test 1: getComponentCountByProject')
    print(getComponentCountByProject('082D6241-40EE-432E-A635-65EA8AA374B6'))
    ids = fread('projects.txt')[2:]
    for id in ids:
        id = id.split()
        print(getComponentCountByProject(id[1]))
    print(getComponentCountByProject("Does not exist"))
    print('Test 2: getComponentCountByStudent')
    names = fread('students.txt')[2:]
    for name in names:
        name = name.split('|')
        name[0] = name[0].strip()
        name[1] = name[1].strip()
        print(getComponentCountByStudent(name[0]))
    print(getComponentCountByStudent("Does not exist"))
    print('Test 3: getParticipationByStudent')
    names = fread('students.txt')[2:]
    for name in names:
        name = name.split('|')
        name[0] = name[0].strip()
        name[1] = name[1].strip()
        print(getParticipationByStudent(name[0]))
    print(getParticipationByStudent("Does not exist"))
    print('Test 4: getParticipationByProject')
    ids = fread('projects.txt')[2:]
    for id in ids:
        id = id.split()
        print(getParticipationByProject(id[1]))
    print(getParticipationByProject('Does not exist'))
    print('Test 5: getProjectByComponent')
    comp_list = []
    folder = os.listdir("Circuits")
    for file in folder:
        comp_list = comp_list + fread("./Circuits/" + file)[4].strip().split(', ')
    set(comp_list)
    print(getProjectByComponent(comp_list))
    print(getProjectByComponent({'L617.377', 'T119.763', 'C421.132'}))
    print('Test 6: getStudentByComponent')
    comp_list = []
    folder = os.listdir("Circuits")
    for file in folder:
        comp_list = comp_list + fread("./Circuits/" + file)[4].strip().split(', ')
    set(comp_list)
    print(getStudentByComponent(comp_list))
    print(getStudentByComponent({'L617.377', 'T119.763', 'C421.132'}))
    print('Test 7: getComponentByStudent')
    names = fread('students.txt')[2:]
    name_list = []
    for name in names:
        name = name.split('|')
        name[0] = name[0].strip()
        name[1] = name[1].strip()
        name_list.append(name[0])
    print(getComponentByStudent(name_list))
    print(getComponentByStudent({'Adams, Keith', 'Alexander, Carlos', 'Butler, Julia'}))
    print('Test 8: getCommonByProject')
    print(getCommonByProject('082D6241-40EE-432E-A635-65EA8AA374B6', '90BE0D09-1438-414A-A38B-8309A49C02EF'))
    print('Test 9: getCommonByStudent')
    print(getCommonByStudent('Adams, Keith', 'Bennett, Nancy'))
    print('Test 10: getProjectByCircuit')
    print(getProjectByCircuit())
    print('Test 11: getCircuitByStudent')
    print(getCircuitByStudent())
    print('Test 12: getCircuitByStudentPartial')
    print(getCircuitByStudentPartial('Shawn'))
    print(getComponentCountByProject('082D6241-40EE-432E-A635-65EA8AA374B6'))
    print(getComponentCountByStudent('Adams, Keith'))
    print(getParticipationByStudent("Adams, Keith"))
    print(getParticipationByProject('082D6241-40EE-432E-A635-65EA8AA374B6'))
    print(getProjectByComponent({'T475.274', 'C471.636'}))
    print(getStudentByComponent({'T475.274', 'C471.636'}))
    print(getComponentByStudent({'Adams, Keith', 'Alexander, Carlos'}))
    print(len(getCommonByProject('082D6241-40EE-432E-A635-65EA8AA374B6', '90BE0D09-1438-414A-A38B-8309A49C02EF'))) # check 95
    print(getCommonByStudent('Adams, Keith', 'Alexander, Carlos'))
    print(getProjectByCircuit())
    print(getCircuitByStudent())
    print(getCircuitByStudentPartial('Howard'))
