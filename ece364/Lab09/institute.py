class Action:
    def __init__(self, actionType, amount):
        if actionType != 'W' and actionType != 'D':
            raise ValueError("Invalid Action Type")
        self.actionType = actionType
        self.amount = amount

class Client:
    def __init__(self, firstName, lastName):
        self.firstName = firstName
        self.lastName= lastName

    def __str__(self):
        return "{} {}".format(self.firstName, self.lastName)

class Account:
    def __init__(self, accountNumber, client, amount, minThreshold):
        self.accountNumber = accountNumber
        self.client = client
        self.amount = amount
        self.minThreshold = minThreshold

    def __str__(self):
        if self.amount >= 0:
            return "{}, {}, Balance = ${bal:.2f}".format(self.accountNumber, self.client, bal=self.amount)
        else:
            return "{}, {}, Balance = (${bal:.2f})".format(self.accountNumber, self.client, bal=-(float(self.amount)))

    def performAction(self, action):
        if action.actionType == 'D':
            self.amount += action.amount
            self.amount = round(self.amount, 2)
        else:
            remain = self.amount - action.amount
            if remain < 0:
                raise ValueError("The account balance is not enough")
            if remain < self.minThreshold:
                remain -= 10
            self.amount = round(remain, 2)


class Institute:
    def __init__(self):
        self.accounts = {}

    def createNew(self, firstName, lastName, accountNum):
        if accountNum not in self.accounts:
            self.accounts[accountNum] = Account(accountNum, Client(firstName, lastName), 500.00, 1000.00)

    def performAction(self, accountNum, action):
        if accountNum in self.accounts:
            self.accounts[accountNum].performAction(action)

if __name__ == '__main__':
    cl = Client('John', 'Smith')
    print(cl)
    amo = Account('00000-00000', cl, -100.11, 10.00)
    print(amo)
    amo = Account('00000-00000', cl, 100.000, 10.00)
    print(amo)
    act_d = Action('D', 10.00)
    amo.performAction(act_d)
    print(amo)
    act_w = Action('W', 100.00)
    amo.performAction(act_w)
    print(amo)
    inst = Institute();
    inst.createNew('John', 'Smith', '11111-11111')
    inst.createNew('Jhn', 'Smith', '11111-11111')
    inst.createNew('Jhn', 'Smith', '00000-11111')
    print(inst.accounts)
    print(inst.accounts['11111-11111'])
    inst.performAction('11111-11111', act_d)
    print(inst.accounts['11111-11111'])
    inst.performAction('11111-11111', act_w)
    print(inst.accounts['11111-11111'])
    pass