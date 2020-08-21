#! /user/local/bin/python3.4

import sys
from importlib import import_module
from inspect import getmembers, isfunction, isclass


def runCheckAgainstStringFunctions():
    stringFunctions = ['capitalize', 'casefold', 'center', 'count', 'encode', 'endswith', 'expandtabs', 'find',
                       'format_map', 'index', 'isalnum', 'isalpha', 'isdecimal', 'isdigit', 'isidentifier', 'islower',
                       'isnumeric', 'isprintable', 'isspace', 'istitle', 'isupper', 'ljust', 'lower', 'lstrip',
                       'maketrans', 'partition', 'replace', 'rfind', 'rindex', 'rjust', 'rpartition', 'rsplit',
                       'rstrip', 'split', 'startswith', 'strip', 'swapcase', 'title', 'translate', 'upper', 'zfill']

    fileName = "practical2.py"
    with open(fileName, "r") as cFile:
        lines = cFile.readlines()

    printOut = ""
    functions = set()

    for index, line in enumerate(lines):
        for fn in stringFunctions:
            verb = "." + fn + "("

            if verb in line :
                printOut += '   Fn: "{}()" => Line({:03d}): "{}"\n'.format(fn, index, line.strip())
                functions.add("{}()".format(fn))

    if printOut:
        message = "The file {0} contain one or more functions that cannot be used.\n".format(fileName)
        message += "Please remove these functions, or you might get 0.\n\n"
        message += "Functions Used: {0}\n\n".format(", ".join(functions))
        message += "Location Details:\n" + printOut
    else:
        message = "The file {0} does not contain invalid functions.".format(fileName)

    print("-------------------------------\n{}\n-------------------------------".format(message))


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
    memberInfo = [("practical2", ["getNumberPattern", "getLinkPattern", "parseFile"], isfunction),
                  ("institute", ["Action", "Client", "Account", "Institute"], isclass),
                  ("record", ["loadHistory", "getTotalBy", "getLendingPower"], isfunction)]

    for moduleName, memberNames, memberCheck in memberInfo:

        try:
            student = import_module(moduleName)
        except:
            printResult(moduleName, "Fail")
        else:
            printResult(moduleName, "Success")
            loadModule(memberNames, memberCheck)

        print("\n" * 2)

    runCheckAgainstStringFunctions()
