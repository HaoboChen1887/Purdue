# Import PySide classes
import sys
from PySide.QtCore import *
from PySide.QtGui import *
from calculator import *

class MathConsumer(QMainWindow, Ui_MainWindow):

    def __init__(self, parent=None):
        super(MathConsumer, self).__init__(parent)
        self.setupUi(self)
        self.btnCalculate.clicked.connect(self.performOperation)

    def performOperation(self):
        num1 = self.edtNumber1.text()
        num2 = self.edtNumber2.text()
        operator = self.cboOperation.currentText()
        result = 0
        try:
            num1 = float(num1)
            num2 = float(num2)
        except ValueError:
            result = 'E'
        else:
            if operator is '+':
                result = num1 + num2
            elif operator is '-':
                result = num1 - num2
            elif operator is '*':
                result = num1 * num2
            else:
                try:
                    result = num1 / num2
                except ZeroDivisionError:
                    result = 'E'
        self.edtResult.setText(str(result))

if __name__ == "__main__":
    currentApp = QApplication(sys.argv)
    currentForm = MathConsumer()

    currentForm.show()
    currentApp.exec_()
