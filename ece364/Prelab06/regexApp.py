import re
from uuid import UUID


def getUrlParts(url):
    match = re.search(r'http://(\w{3}.\w+.\w+)/(\w+)/(\w+)', url)
    result = (match.group(1), match.group(2), match.group(3))
    return result

def getQueryParameters(url):
    match = re.findall(r'(\w+)=(\w+)', url)
    result = match
    return result


def getSpecial(sentence, letter):
    pattern = r'\bletter\w*[^letter\W]\b|\b[^letter\W]\w*letter\b'
    pattern = re.sub(r'letter', letter, pattern)
    match = re.findall(pattern, sentence, re.I)
    return match


def getRealMAC(sentence):
    pattern = '[\d|\w]{2}[:|-][\d|\w]{2}[:|-][\d|\w]{2}[:|-][\d|\w]{2}[:|-][\d|\w]{2}[:|-][\d|\w]{2}'
    match = re.search(pattern, sentence, re.I)
    return match.group()


def getRejectedEntries():
    infos = fread("Employees.txt")
    result_list = []
    pattern = r'^(?P<first>\b[A-Z]\w+\b)\s(?P<last>\b[A-Z]\w+\b)[,; ]+$|^(?P<r_last>\b[A-Z]\w+),\s(?P<r_first>\b[A-Z]\w+)[,; ]+$'
    for info in infos:
        match = re.search(pattern, info)
        name = ""
        if match == None:
            continue
        elif match.group('first') is not None and match.group('last') is not None:
            name = "{0} {1}".format(match.group('first'), match.group('last'))
        elif match.group('r_first') is not None and match.group('r_last') is not None:
            name = "{0} {1}".format(match.group(('r_first')), match.group('r_last'))
        result_list.append(name)
        result_list.sort()
    return result_list

def getEmployeesWithIDs():
    result_dict = {}
    infos = fread("Employees.txt")
    patterns = getPatterns()
    for info in infos:
        name = getName(patterns["name"], info)
        id = getID(patterns["id"], info)
        if id is not None:
            result_dict[name] = id
    return result_dict

def getEmployeesWithoutIDs():
    result_list = []
    infos = fread("Employees.txt")
    patterns = getPatterns()
    for info in infos:
        name = getName(patterns["name"], info)
        id = getID(patterns["id"], info)
        phone = getPhone(patterns["phone"], info)
        state = getState(patterns["state"], info)
        if id is None and (phone is not None or state is not None):
            result_list.append(name)
            result_list = sorted(set(result_list))
    return result_list

def getEmployeesWithPhones():
    result_dict = {}
    infos = fread("Employees.txt")
    patterns = getPatterns()
    for info in infos:
        name = getName(patterns["name"], info)
        phone = getPhone(patterns["phone"], info)
        if phone is not None:
            result_dict[name] = phone
    return result_dict


def getEmployeesWithStates():
    result_dict = {}
    infos = fread("Employees.txt")
    patterns = getPatterns()
    for info in infos:
        name = getName(patterns["name"], info)
        state = getState(patterns["state"], info)
        if state is not None:
            result_dict[name] = state
    return result_dict


def getCompleteEntries():
    result_dict = {}
    infos = fread("Employees.txt")
    patterns = getPatterns()
    for info in infos:
        name = getName(patterns["name"], info)
        id = getID(patterns["id"], info)
        phone = getPhone(patterns["phone"], info)
        state = getState(patterns["state"], info)
        if id is not None and phone is not None and state is not None:
            result_dict[name] = (id, phone, state)
    return result_dict


#Classify each field in to groups
def getPatterns():
    name = r'^(?P<first>\b[A-Z]\w+\b)\s(?P<last>\b[A-Z]\w+\b)|^(?P<r_last>\b[A-Z]\w+),\s(?P<r_first>\b[A-Z]\w+\b)'
    id = r'(?P<id1_8>[a-zA-Z0-9]{8})-?(?P<id2_4>[a-zA-Z0-9]{4})-?(?P<id3_4>[a-zA-Z0-9]{4})-?(?P<id4_4>[a-zA-Z0-9]{4})-?(?P<id5_12>[a-zA-Z0-9]{12})'
    phone = r'\b\(?(?P<lead_3>\d{3})\)?[ -]?(?P<mid_3>\d{3})[ -]?(?P<tail_4>\d{4})\b'
    state = r'\b(?P<state>\w+\s?\w+)$'
    return {"name":name, "id":id, "phone":phone, "state":state}

#Get the name field if present
def getName(pattern, info):
    m_name = re.search(pattern, info)
    name = ""
    if m_name == None:
        return None
    elif m_name.group('first') is not None and m_name.group('last') is not None:
        name = "{0} {1}".format(m_name.group('first'), m_name.group('last'))
    elif m_name.group('r_first') is not None and m_name.group('r_last') is not None:
        name = "{0} {1}".format(m_name.group(('r_first')), m_name.group('r_last'))
    return name

#Get the id field if present
def getID(pattern, info):
    m_id = re.search(pattern, info)
    id = ""
    if m_id is None:
        return None
    else:
        id = str(UUID(''.join(m_id.groups())))
    return id

#Get the phone number field if present
def getPhone(pattern, info):
    m_phone = re.search(pattern, info)
    phone = ""
    if m_phone is None:
        return None
    else:
        phone = "({0}) {1}-{2}".format(m_phone.group("lead_3"), m_phone.group("mid_3"), m_phone.group("tail_4"))
    return phone

#Get the state field if present
def getState(pattern, info):
    m_state = re.search(pattern, info)
    state = ""
    if m_state is None:
        return None
    else:
        state = m_state.group("state")
    return state


# Read all file information into a list of lines
def fread(fname):
    lines = []
    with open(fname, 'r') as myFile:
        lines = myFile.readlines()
    return lines


if __name__ == "__main__":
    url = "http://www.purdue.edu/Home/Calendar?Year=2016&Month=September&Semester=Fall"
    print(getUrlParts(url))
    print(getQueryParameters(url))
    url = "http://www.google.com/Math/Const?Pi=3.14&Max_Int=65536&What_Else=Not-Here"
    print(getQueryParameters(url))
    s = "The TART program runs on Tuesdays and Thursdays, but it does not start until next week. ti tt ii it ttti .ti. it. "
    print(getSpecial(s, "t"))
    print(getRealMAC("asdf asdg 58-1C-0A-6E-39-4Dasdfasdg"))
    print(getRealMAC("asdf asdg 58:1C:0A:6E:39:4Dasdfasdg"))
    print(getRealMAC("58-1C-0A-6E-39-4Dasdfasdg"))
    print(getRealMAC("58-CC-0A-6E-39-4Dasdfasdg"))
    print(getRealMAC("asdf asdg 58-1C-0A-6E-39-4D"))
    print(getRejectedEntries())
    print(getEmployeesWithIDs())
    print(getEmployeesWithoutIDs())
    print(getEmployeesWithPhones())
    print(getEmployeesWithStates())
    print(getCompleteEntries())
