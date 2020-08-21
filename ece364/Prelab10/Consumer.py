import sys

from PySide.QtGui import *
from BasicUI import *
import xml.etree.ElementTree as ET


class Consumer(QMainWindow, Ui_MainWindow):

    def __init__(self, parent=None):

        super(Consumer, self).__init__(parent)
        self.setupUi(self)
        self.dataEntry()

        self.txtCnt = [
            self.txtComponentCount_1,
            self.txtComponentCount_2,
            self.txtComponentCount_3,
            self.txtComponentCount_4,
            self.txtComponentCount_5,
            self.txtComponentCount_6,
            self.txtComponentCount_7,
            self.txtComponentCount_8,
            self.txtComponentCount_9,
            self.txtComponentCount_10,
            self.txtComponentCount_11,
            self.txtComponentCount_12,
            self.txtComponentCount_13,
            self.txtComponentCount_14,
            self.txtComponentCount_15,
            self.txtComponentCount_16,
            self.txtComponentCount_17,
            self.txtComponentCount_18,
            self.txtComponentCount_19,
            self.txtComponentCount_20,
        ]

        self.txtName = [
            self.txtComponentName_1,
            self.txtComponentName_2,
            self.txtComponentName_3,
            self.txtComponentName_4,
            self.txtComponentName_5,
            self.txtComponentName_6,
            self.txtComponentName_7,
            self.txtComponentName_8,
            self.txtComponentName_9,
            self.txtComponentName_10,
            self.txtComponentName_11,
            self.txtComponentName_12,
            self.txtComponentName_13,
            self.txtComponentName_14,
            self.txtComponentName_15,
            self.txtComponentName_16,
            self.txtComponentName_17,
            self.txtComponentName_18,
            self.txtComponentName_19,
            self.txtComponentName_20,
        ]

        self.initialize()
        self.btnClear.clicked.connect(self.initialize)

        for name in self.txtName:
            name.textChanged.connect(self.dataEntry)
        for cnt in self.txtCnt:
            cnt.textChanged.connect(self.dataEntry)

        self.txtStudentName.textChanged.connect(self.dataEntry)
        self.txtStudentID.textChanged.connect(self.dataEntry)
        self.chkGraduate.stateChanged.connect(self.dataEntry)
        self.cboCollege.currentIndexChanged.connect(self.dataEntry)

        self.btnSave.clicked.connect(self.saving)
        self.btnLoad.clicked.connect(self.loadData)

    def initialize(self):
        for name in self.txtName:
            name.clear()
        for cnt in self.txtCnt:
            cnt.clear()

        self.txtStudentName.clear()
        self.txtStudentID.clear()
        self.chkGraduate.setChecked(False)
        self.cboCollege.setCurrentIndex(0)

        self.btnClear.setEnabled(True)
        self.btnLoad.setEnabled(True)
        self.btnSave.setDisabled(True)


    def dataEntry(self):
        self.btnLoad.setDisabled(True)
        self.btnSave.setEnabled(True)

    def saving(self):
        with open('target.xml', 'w') as myFile:
            chk = ""
            myFile.write('<?xml version="1.0" encoding="UTF-8"?>\n')
            myFile.write('<Content>\n')
            if self.chkGraduate.isChecked():
                chk = "true"
            else:
                chk = "false"
            myFile.write('    <StudentName graduate="{}">{}</StudentName>\n'.format(chk, self.txtStudentName.text()))
            myFile.write('    <StudentID>{}</StudentID>\n'.format(self.txtStudentID.text()))
            myFile.write('    <College>{}</College>\n'.format(self.cboCollege.currentText()))
            myFile.write('    <Components>\n')
            for i in range(0, len(self.txtName)):
                if self.txtName[i].text() != "" or self.txtCnt[i].text() != "":
                    myFile.write('        <Component name="{}" count="{}" />\n'.format(self.txtName[i].text(), self.txtCnt[i].text()))
            myFile.write('    </Components>\n')
            myFile.write('</Content>\n')

    def loadDataFromFile(self, filePath):
        """
        Handles the loading of the data from the given file name. This method will be invoked by the 'loadData' method.
        
        *** YOU MUST USE THIS METHOD TO LOAD DATA FILES. ***
        *** This method is required for unit tests! ***
        """
        tree = ET.parse(filePath)
        root = tree.getroot()

        self.txtStudentName.setText(root.find('StudentName').text)
        self.txtStudentID.setText(root.find('StudentID').text)
        if root.find('StudentName').get('graduate') == 'true':
            self.chkGraduate.setChecked(True)
        else:
            self.chkGraduate.setChecked(False)
        college = root.find('College').text
        idx = self.cboCollege.findText(college)
        # idx = college.index(college_in)
        self.cboCollege.setCurrentIndex(idx)

        new = list = root.find('Components').findall('Component')
        if len(list) < 20:
            new = []
            for item in list:
                if item.get('name') != '':
                    new.append(item)
        else:
            new = new[0:19]
        for idx in range(0, len(new)):
            self.txtName[idx].setText(new[idx].get('name'))
            self.txtCnt[idx].setText(new[idx].get('count'))

    def loadData(self):
        """
        Obtain a file name from a file dialog, and pass it on to the loading method. This is to facilitate automated
        testing. Invoke this method when clicking on the 'load' button.

        *** DO NOT MODIFY THIS METHOD! ***
        """
        filePath, _ = QFileDialog.getOpenFileName(self, caption='Open XML file ...', filter="XML files (*.xml)")

        if not filePath:
            return

        self.loadDataFromFile(filePath)


if __name__ == "__main__":
    currentApp = QApplication(sys.argv)
    currentForm = Consumer()

    currentForm.show()
    currentApp.exec_()
