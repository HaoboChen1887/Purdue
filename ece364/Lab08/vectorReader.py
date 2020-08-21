from simpleVector import Vector

def loadVectors(fileName):
    result = []
    new = ""
    with open(fileName, "r") as myFile:
        vects = myFile.readlines()
    vects = [line.strip() for line in vects]
    for vect in vects:
        try:
            new = Vector(vect)
        except Exception:
            result.append(None)
        else:
            result.append(new)
    return result

if __name__ == "__main__":
    #fileName = "values.txt"
    #print(loadVectors(fileName))

