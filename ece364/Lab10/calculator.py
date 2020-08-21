# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'calculator.ui'
#
# Created: Tue Mar 27 13:24:41 2018
#      by: pyside-uic 0.2.15 running on PySide 1.2.2
#
# WARNING! All changes made in this file will be lost!

from PySide import QtCore, QtGui

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(800, 185)
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.edtNumber1 = QtGui.QLineEdit(self.centralwidget)
        self.edtNumber1.setGeometry(QtCore.QRect(70, 50, 146, 27))
        self.edtNumber1.setObjectName("edtNumber1")
        self.edtNumber2 = QtGui.QLineEdit(self.centralwidget)
        self.edtNumber2.setGeometry(QtCore.QRect(360, 50, 146, 27))
        self.edtNumber2.setObjectName("edtNumber2")
        self.lblNumber1 = QtGui.QLabel(self.centralwidget)
        self.lblNumber1.setGeometry(QtCore.QRect(110, 30, 71, 17))
        self.lblNumber1.setObjectName("lblNumber1")
        self.lblNumber2 = QtGui.QLabel(self.centralwidget)
        self.lblNumber2.setGeometry(QtCore.QRect(400, 30, 71, 17))
        self.lblNumber2.setObjectName("lblNumber2")
        self.cboOperation = QtGui.QComboBox(self.centralwidget)
        self.cboOperation.setGeometry(QtCore.QRect(230, 50, 111, 27))
        self.cboOperation.setObjectName("cboOperation")
        self.cboOperation.addItem("")
        self.cboOperation.addItem("")
        self.cboOperation.addItem("")
        self.cboOperation.addItem("")
        self.edtResult = QtGui.QLineEdit(self.centralwidget)
        self.edtResult.setGeometry(QtCore.QRect(560, 50, 146, 27))
        self.edtResult.setReadOnly(True)
        self.edtResult.setObjectName("edtResult")
        self.lblResult = QtGui.QLabel(self.centralwidget)
        self.lblResult.setGeometry(QtCore.QRect(600, 30, 71, 17))
        self.lblResult.setAlignment(QtCore.Qt.AlignCenter)
        self.lblResult.setObjectName("lblResult")
        self.lblEquals = QtGui.QLabel(self.centralwidget)
        self.lblEquals.setGeometry(QtCore.QRect(520, 50, 21, 17))
        self.lblEquals.setObjectName("lblEquals")
        self.btnCalculate = QtGui.QPushButton(self.centralwidget)
        self.btnCalculate.setGeometry(QtCore.QRect(240, 100, 251, 27))
        self.btnCalculate.setObjectName("btnCalculate")
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 800, 21))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QtGui.QApplication.translate("MainWindow", "MainWindow", None, QtGui.QApplication.UnicodeUTF8))
        self.lblNumber1.setText(QtGui.QApplication.translate("MainWindow", "Number 1", None, QtGui.QApplication.UnicodeUTF8))
        self.lblNumber2.setText(QtGui.QApplication.translate("MainWindow", "Number 2", None, QtGui.QApplication.UnicodeUTF8))
        self.cboOperation.setItemText(0, QtGui.QApplication.translate("MainWindow", "+", None, QtGui.QApplication.UnicodeUTF8))
        self.cboOperation.setItemText(1, QtGui.QApplication.translate("MainWindow", "-", None, QtGui.QApplication.UnicodeUTF8))
        self.cboOperation.setItemText(2, QtGui.QApplication.translate("MainWindow", "*", None, QtGui.QApplication.UnicodeUTF8))
        self.cboOperation.setItemText(3, QtGui.QApplication.translate("MainWindow", "/", None, QtGui.QApplication.UnicodeUTF8))
        self.lblResult.setText(QtGui.QApplication.translate("MainWindow", "Result", None, QtGui.QApplication.UnicodeUTF8))
        self.lblEquals.setText(QtGui.QApplication.translate("MainWindow", "=", None, QtGui.QApplication.UnicodeUTF8))
        self.btnCalculate.setText(QtGui.QApplication.translate("MainWindow", "Calculate", None, QtGui.QApplication.UnicodeUTF8))

