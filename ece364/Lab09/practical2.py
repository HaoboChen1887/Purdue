import re

def getNumberPattern():
    return r"([01]\d{2}|2[0-4]\d|25[0-5])"

def getLinkPattern():
    return r"href=\"(?P<url>.+)\">(?P<text>.+)<\/a>"

if __name__ == '__main__':
    pattern = getNumberPattern()
    m = re.search(pattern, "We can get less than 300 pieces, but more than 005")
    print(m.group(0))
    m = re.search(pattern, "The point is located at (512, 189, 290")
    print(m.group(0))

    pattern = getLinkPattern()
    m = re.search(pattern, '<a href="http://www.purdue.edu/">Check our</a>')
    print(m.group('url'))
    print(m.group('text'))

    pass