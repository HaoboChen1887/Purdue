#! /user/local/bin/python3.4

import sys
from importlib import import_module
from inspect import getmembers, isfunction, isclass


def printResult(moduleName, resultType):
    if resultType == "Success":
        message = "Code file '{}' imported successfully.".format(moduleName)
    else:
        message = "Cannot import '{}'. File is missing or cannot be compiled.".format(moduleName)

    print("-------------------------------\n{}\n-------------------------------".format(message))


def loadModule(memberNames, memberType):

    identifier = "function" if memberType == isfunction else "class"

    # Obtain all members in the code.
    presentMembers = [fnName for fnName, _ in getmembers(student, memberType)]

    # Check whether each member is present or missing, and print out the result.
    for memberIndex, memberName in enumerate(memberNames):

        if memberName in presentMembers:
            print('{:02d}- {} "{}" located.'.format(memberIndex + 1, identifier.capitalize(), memberName))
        else:
            print('{:02d}- =======> Unable to locate the {} "{}".'.format(memberIndex + 1, identifier, memberName))


if __name__ == "__main__":
    # Define desired members that should be present.
    memberInfo = [("CenterTasks", ["getDetails", "getPerformance", "getHighest", "getMean", "getCumulativeScore"], isfunction),
                  ("CustomClass", ["Element", "StrongDictionary"], isclass)]

    for moduleName, memberNames, memberCheck in memberInfo:

        try:
            student = import_module(moduleName)
        except:
            printResult(moduleName, "Fail")
        else:
            printResult(moduleName, "Success")
            loadModule(memberNames, memberCheck)

        print("\n" * 2)
