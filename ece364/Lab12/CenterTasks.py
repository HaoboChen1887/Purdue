def getDetails():
    dict = {}
    with open('community.txt', 'r') as myFile:
        lines = myFile.readlines()

    met = lines[1].split()
    met = [txt.strip() for txt in met]
    met = met[2:]
    lines = lines[3:]
    info = []
    for line in lines:
        line = line.split('|')
        line = [txt.strip() for txt in line]
        list = []
        for idx in range(len(met)):
            if line[idx + 1] != '-':
                list.append((met[idx], float(line[idx + 1])))
        dict[line[0]] = sorted(list)
    return dict

def getPerformance():
    dict = {}
    with open('community.txt', 'r') as myFile:
        lines = myFile.readlines()

    met = lines[1].split()
    met = [txt.strip() for txt in met]
    met = met[2:]
    lines = lines[3:]
    for idx in range(len(met)):
        for line in lines:
            line = line.split('|')
            line = [txt.strip() for txt in line]
            if met[idx] not in dict.keys():
                if line[idx + 1] != '-':
                    dict[met[idx]] = [(line[0], float(line[idx + 1]))]
            else:
                if line[idx + 1] != '-':
                    dict[met[idx]].append((line[0], float(line[idx + 1])))
    return dict


def getHighest(course):
    dict = getPerformance()
    max_name, max = dict[course][0]
    for info in dict[course]:
        name, score = info
        if max <= score:
            max = score
            max_name = name
    return (max_name, max)

def getMean(course):
    dict = getPerformance()
    list = []
    for info in dict[course]:
        name, score = info
        list.append(score)
    return round(sum(list) / len(list), 2)

def getCumulativeScore(name):
    with open('hours.txt', 'r') as myFile:
        weights = myFile.readlines()
    weights = weights[2:]
    weights = [weight.split() for weight in weights]
    dict = {}
    for course in weights:
        dict[course[0]] = float(course[1])
    info = getDetails()
    total = 0
    hours = 0
    for course_tup in info[name]:
        cor, score = course_tup
        total += score * dict[cor]
        hours += dict[cor]
    return round(total / hours, 2)


if __name__ == "__main__":
    # print(getDetails())

    # getPerformance()

    # cor = 'MET290'
    # print(getHighest(cor))
    # cor = 'MET388'
    # print(getHighest(cor))

    # cor = 'MET475'
    # print(getMean(cor))
    # cor = 'MET344'
    # print(getMean(cor))

    # name = 'Floria Uribe'
    # print(getCumulativeScore(name))
    # name = 'Melba Gist'
    # print(getCumulativeScore(name))
    pass