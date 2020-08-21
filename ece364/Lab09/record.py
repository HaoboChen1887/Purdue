from institute import *
import re

def loadHistory(fileName):
    inst = Institute()
    with open(fileName, 'r') as myFile:
        history = myFile.readlines()
        history = history[3:]
    for action in history:
        info = action.split('|')
        info = [item.strip() for item in info]
        first = last = accNum = act = ""
        for i in range(0, len(info)):
            if i == 0:
                name = info[i]
                first = name.split()[0]
                last = name.split()[-1]
            elif i == 1:
                accNum = info[i]
            elif i == 2:
                act = info[i]
        print(act)
        num = re.search(r'\(?\$(.+)\)?', act)
        print(num.group(1))
        # if len(num) != len(act) - 1:
        #     action = Action('W', num)
        # else:
        #     action = Action('D', num)
        #
        # if accNum not in inst.accounts:
        #     inst.createNew(first, last, accNum)
        # inst.performAction(accNum, action)


if __name__ == "__main__":
    loadHistory('history.txt')
