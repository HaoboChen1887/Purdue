def find(pattern):
    with open('sequence.txt', 'r') as myFile:
        pool = myFile.read()

    pttlen = len(pattern)
    pollen = len(pool)
    result = []
    curr = ""

    # ct loop counter
    for ct in range(0, pollen - pttlen):
        # pct is the counter that from the current index of the pool and
        # counts up to current pool index+patternLen repeatedly
        for pct in range(ct, ct + pttlen):
            # pct - ct = index in pattern
            idx = pct - ct
            if pattern[idx] != 'X' and pool[pct] == pattern[idx]:
                curr = curr + pool[pct]
            elif pattern[idx] == 'X':
                curr = curr + pool[pct]
            else:
                curr = ""
                break
        if curr != "":
            result.append(curr)
    return result

def getStreakProduct(sequence, maxSize, product):
    seqlen = len(sequence)
    matchlist = []
    result = 1;
    curr_str = ""
    curr_p = 1 # current product
    # p_idx is the idx of the pool list
    # This loop iterate over the entire sequence
    for p_idx in range(0, seqlen):
        # len_ct is the length counter for iterating trough all possible keywords
        # This loop iterate over all possible keywords
        for len_ct in range(2, maxSize + 1):
            # s_ct provides the idx of the current keyword
            # This loop iterate a single sequence
            if p_idx + len_ct > seqlen:
                break
            for s_ct in range(p_idx, p_idx + len_ct):
                result *= int(sequence[s_ct])
                curr_str += sequence[s_ct]
            if result == product:
                matchlist.append(curr_str)
            result = 1;
            curr_str = ""
    return matchlist

def writePyramids(filePath, basesize, count, char):
    result = ""
    level = ""
    for row in range(0, (basesize + 1) // 2):
        for pad_ct in range(0, basesize // 2 - row):
            level += " "
        for char_ct in range(0, 2 * row + 1):
            level += char
        for pad_ct in range(0, basesize // 2 - row):
            level += " "
        for py_ct in range(0, count):
            if py_ct == count - 1:
                result = result + level + "\n"
            else:
                result = result + level + " "
        with open(filePath, 'w') as myFile:
            myFile.writelines(result)
        level = ""
    return

def getStreaks(sequence, letters):
    seqlen = len(sequence)
    keylen = len(letters)

    curr = ""
    result = []
    for p_idx in range(0, seqlen):
        for k_idx in range(0, keylen):
            if letters[k_idx] == sequence[p_idx]:
                curr += sequence[p_idx]
                break
        if p_idx + 1 < seqlen:
            if sequence[p_idx] != sequence[p_idx + 1] and curr != "":
                result.append(curr)
                curr = ""
        elif curr != "":
            result.append(curr)

    return result

def findNames(nameList, part, name):
    list_len = len(nameList)
    result = []
    for l_ct in range(0, list_len):
        if part == 'L':
            lname = nameList[l_ct].split(' ')
            if name.lower() == lname[1].lower():
                result.append(nameList[l_ct])
        elif part == 'F':
            lname = nameList[l_ct].split(' ')
            if name.lower() == lname[0].lower():
                result.append(nameList[l_ct])
        elif part == "FL":
            lname = nameList[l_ct].split(' ')
            if name.lower() == lname[0].lower() or name.lower() == lname[1].lower():
                result.append(nameList[l_ct])
    return result

def convertToBoolean(num, size):
    result = []
    if type(num) == int and type(size) == int:
        num = bin(num)
        num = num[2:len(num)];
        # padding bits
        if size > len(num):
            for idx in range(0, size - len(num)):
                result.append(False)
        # actual bits
        for idx in range(0, len(num)):
            if int(num[idx]) == 1:
                result.append(True)
            else:
                result.append(False)
        return result;
    else:
        return result;

def convertToInteger(boolList):
    result = ""
    for idx in range(0, len(boolList)):
        result += str(int(boolList[idx]))
    result = int(result, 2);
    return result

if __name__ == "__main__":
    find("9999")
    getStreakProduct("14822", 5, 32)
    writePyramids("test1.txt", 3, 6, 'X')
    writePyramids("test2.txt", 5, 5, '*')
    getStreaks("AAASSSSSSAPPPSSPPBBCCCSSS", "SAQT")
    getStreaks("AAASSSSSSAPPPSSPPBBCCCSSS", "PAZ")
    names = ["George Smith", "Mark Johnson", "Cordell Theodore", "Maria Satterfield", "Johnson Cadence"]
    findNames(names, "L", "johnson")
    findNames(names, "F", "JOHNSON")
    findNames(names, "FL", "johnson")
    convertToBoolean(9, 6)
    convertToBoolean(9, 3)
    convertToBoolean(135, 12)
    bList = [True, False, False, False, False, True, True, True]
    convertToInteger(bList)
    bList = [False, False, True, False, False, True]
    convertToInteger(bList)

