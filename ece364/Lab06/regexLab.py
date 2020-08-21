import re


def extractValues(sentence):
    pattern = r'[+-]?\d+\.?\d+[Ee]?[+-]?\d*'
    match = re.findall(pattern, sentence)
    return match

def getSwitches(commandline):
    pattern = r'[\+\\]([a-z])\s+([^\s\\\+]\S*)'
    match = re.findall(pattern, commandline)
    return match


if __name__ == '__main__':
    sentence = "With the electron's charge being -1.6022e-19, some choices you have are -110, -32.0 and +55. Assume that po eqquails 3.1415, 'e' equals 2.7 and Na is +6.0221E+023."
    print(extractValues(sentence))
    commandline = "myScript.bash +v  \i 2  +p  /local/bin/somefolder  \s sss"
    print(getSwitches(commandline))
