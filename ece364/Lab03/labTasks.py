def filterByLetter(sentence, c):
    n_sent = sentence.split()
    result = []
    for word in n_sent:
        if((not (word in result)) and (word[0] == c or word[len(word) - 1] == c)):
            result.append(word)
    return result

def getCumulativeSum():
    result = []
    for num in range(1,101):
        result.append(sum(range(1, num + 1)))
    return result

if __name__== "__main__":
    s = "the power of this engine matches that of the one we had last year"
    filterByLetter(s, 't')
    filterByLetter(s, 'r')
    filterByLetter(s, 'e')
    getCumulativeSum()


