from exModule import runNetworkCode
import re
import os

def checkNetwork(**kwargs):
    try:
        runNetworkCode(**kwargs)
    except ConnectionError:
        raise
    except OSError as ose:
        return "An issue encountered during runtime. " \
               "The name of the error is: {}".format(ose.__class__.__name__)
    except:
        return False
    else:
        return True

def isOK(SignalName):
    match = re.match(r'[A-Z]{3}\-\d{3}', SignalName)
    return match is not None

def loadDataFrom(signalName, folderName):
    if not isOK(signalName):
        raise ValueError("{} is invalid.".format(signalName))
    else:
        path = "./{}/{}.txt".format(folderName, signalName)
        sigs = []
        try:
            with open(path) as myFiles:
                sigs = myFiles.readlines()
        except OSError:
            raise OSError("The path {} is incorrect because either the folder of the txt file doesn't exist".format(path))
        else:
            sigs = [sig.strip() for sig in sigs]
            invalid_ct = 0
            result_l = []
            for sig in sigs:
                try:
                    sig = float(sig)
                except ValueError:
                    invalid_ct += 1
                else:
                    result_l.append(sig)

        return (result_l, invalid_ct)

def isBounded(signalValues, bounds, threshold):
    min, max = bounds
    invalid_ct = 0
    if signalValues == []:
        raise ValueError("Signal contains no data")
    else:
        for sig in signalValues:
            if not min <= sig <= max:
                invalid_ct += 1
                if invalid_ct > threshold:
                    return False
    return True






if __name__ == "__main__":
    print(checkNetwork(a=1))
    signalName = "DAS-900"
    print(isOK(signalName))
    signalName = "0AS-900"
    print(isOK(signalName))

    signalName = "CIG-308"
    folderName = "Signals"
    print(loadDataFrom(signalName, folderName))

    sigs, invalid = loadDataFrom(signalName, folderName)
    print(isBounded(sigs, (-13, 13), 50))
