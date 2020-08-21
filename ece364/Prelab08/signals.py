from moduleTasks import *

def loadMultiple(signalNames, folderName, maxCount):
    dict = {}
    for sig in signalNames:
        if isOK(sig):
            try:
                val, invalid_ct = loadDataFrom(sig, folderName)
            except OSError:
                dict[sig] = None
            else:
                if invalid_ct <= maxCount:
                    dict[sig] = val
                else:
                    dict[sig] = []
        else:
            dict[sig] = None
    return dict

def saveData(signalDictionary, targetFolder, bounds, threshold):
    for key, value in signalDictionary.items():
        flag = False
        if signalDictionary[key] is not None and signalDictionary[key] is not []:
            try:
                flag = isBounded(signalDictionary[key], bounds, threshold)
            except ValueError:
                pass
            else:
                myPath = "./{}/{}.txt".format(targetFolder, key)
                with open(myPath, 'w+') as myFile:
                    length = len(signalDictionary[key])
                    for ct in range(0, length):
                        if ct != length - 1:
                            myFile.write("{val:.3f}\n".format(val=signalDictionary[key][ct]))
                        else:
                            myFile.write("{val:.3f}".format(val=signalDictionary[key][ct]))


if __name__ == "__main__":
    signalNames = ["CIG-308", "CIR-999", "HPQ-298", "NPU-381"]
    folderName = "Signals"
    dict = loadMultiple(signalNames, folderName, 10)
    print(dict)

    folderName = "Outputs"
    saveData(dict, folderName, (-13, 13), 6)
