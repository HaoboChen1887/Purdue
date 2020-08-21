#! /user/local/bin/python3.4

from inspect import getmembers, isfunction


def printSuccess(moduleName):
    print("-------------------------------")
    print("Code file '{}' imported successfully.".format(moduleName))
    print("-------------------------------")
    print()


def failSafe(moduleName):
    print("-------------------------------")
    print("Cannot import '{}'. File is missing or cannot be compiled.".format(moduleName))
    print("-------------------------------")
    print()
    exit(-1)


def loadModule(functionNames):

    # Obtain all functions in the code.
    presentFunctions = [fnName for fnName, _ in getmembers(student, isfunction)]

    # Check whether each function is present or missing, and print out the result.
    for fnIndex, fnName in enumerate(functionNames):

        if fnName in presentFunctions:
            print('{:02d}- Function "{}" located.'.format(fnIndex + 1, fnName))
        else:
            print('{:02d}- =======> Unable to locate the function "{}".'.format(fnIndex + 1, fnName))


# Define desired functions that should be present.
functionNames = ["checkNetwork", "isOK", "loadDataFrom", "isBounded"]
moduleName = "moduleTasks"

# Attempt to import the code, and fail otherwise.
try:
    import moduleTasks as student
except:
    failSafe(moduleName)
else:
    printSuccess(moduleName)

loadModule(functionNames)

print("\n" * 3)

# Define desired functions that should be present.
functionNames = ["loadMultiple", "saveData"]
moduleName = "signals"

# Attempt to import the code, and fail otherwise.
try:
    import signals as student
except:
    failSafe(moduleName)
else:
    printSuccess(moduleName)

loadModule(functionNames)

