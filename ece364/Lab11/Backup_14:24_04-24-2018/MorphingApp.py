import sys
import copy
import os.path
from pprint import pprint as pp

import imageio as imio
import numpy as np
from PySide.QtCore import *
from PySide.QtGui import *
from scipy import spatial

from Morphing import *
from MorphingGUI import *

class Consumer(QMainWindow, Ui_MainWindow):
    def __init__(self, parent=None):

        super(Consumer, self).__init__(parent)
        self.state = "INIT"

        self.startFile = None
        self.startImage = None
        self.startImageLoaded = False
        self.startPoints = np.ndarray((0, 0))
        self.startUndoPointsList = []
        self.startRedoPointsList = []

        self.endFile = None
        self.endImage = None
        self.endImageLoaded = False
        self.endPoints = np.ndarray((0, 0))
        self.endUndoPointsList = []
        self.endRedoPointsList = []

        self.startOrigin = None
        self.startPixmap = None
        self.startCleanPoints = None
        self.startCache = None
        self.startUndoPointsDict = {}

        self.endOrigin = None
        self.endPixmap = None
        self.endCleanPoints = None
        self.endCache = None
        self.endUndoPointsDict = {}

        self.startTriangle = None
        self.startTriCache = None
        self.startTriFinal = None
        self.startUndoTriDict = {}

        self.endTriangle = None
        self.endTriCache = None
        self.endTriFinal = None
        self.endUndoTriDict = {}

        self.startScene = None
        self.endScene = None
        self.targetScene = None

        self.alpha = 0
        self.target = None
        self.targetList = []

        self.startClicked = False
        self.endClicked = False
        self.otherClicked = False
        self.startSaved = False
        self.endSaved = False

        self.tempStart = None
        self.saveStart = None
        self.tempEnd = None
        self.saveEnd = None

        self.lastClicked = True # True is start image, False is end image

        self.prevKey = 0
        self.currKey = 0

        self.setupUi(self)
        self.initialization()
        self.btnLoadStart.clicked.connect(self.loadStartImage)
        self.btnLoadEnding.clicked.connect(self.loadEndingImage)
        self.btnBlend.clicked.connect(self.blendImageSeq)
        # self.btnBlend.clicked.connect(self.blendImage)

        self.sldAlpha.valueChanged.connect(self.displayBlendedImage)
        self.sldAlpha.valueChanged.connect(self.setAlpha)

        self.chkTriangles.stateChanged.connect(self.displayTriangles)

        # self.dspStartImage.mousePressEvent = self.startMousePressEventWithLog
        # self.dspEndImage.mousePressEvent = self.endMousePressEventWithLog
        # self.mousePressEvent = self.mousePressEventWithLog
        self.dspStartImage.mousePressEvent = self.startMousePressEvent
        self.dspEndImage.mousePressEvent = self.endMousePressEvent

    def initialization(self):
        self.sldAlpha.setEnabled(False)
        self.txtAlpha.setText('0.0')
        self.txtAlpha.setEnabled(False)

        self.btnBlend.setEnabled(False)
        self.btnLoadStart.setEnabled(True)
        self.btnLoadEnding.setEnabled(True)

        self.chkTriangles.setEnabled(False)
        self.chkTriangles.setChecked(False)

        self.dspStartImage.setEnabled(False)
        self.dspEndImage.setEnabled(False)
        self.dspBlendedImage.setEnabled(False)

    def funcEnable(self):
        self.sldAlpha.setEnabled(True)
        self.txtAlpha.setText('0.0')
        self.txtAlpha.setEnabled(True)

        self.btnBlend.setEnabled(True)
        self.btnLoadStart.setEnabled(True)
        self.btnLoadEnding.setEnabled(True)

        self.chkTriangles.setEnabled(True)
        self.chkTriangles.setChecked(False)

        self.dspStartImage.setEnabled(True)
        self.dspEndImage.setEnabled(True)

    def setAlpha(self):
        self.alpha = self.sldAlpha.value() / 20
        self.txtAlpha.setText("{0:.2f}".format(self.alpha))

    def displayPoints(self):
        paint = QPainter()

        if len(self.startPoints) != 0 and self.startImageLoaded is False:
            self.startImageLoaded = True
            paint.begin(self.startPixmap)
            paint.setPen(Qt.red)
            paint.setBrush(Qt.red)
            for point in self.startPoints.tolist():
                paint.drawEllipse(point[0], point[1], 10, 10)
            paint.end()

            self.startCache = copy.copy(self.startPixmap)
            self.startCleanPoints = copy.copy(self.startPixmap)
            self.startTriangle = copy.copy(self.startPixmap)
            self.startOrigin = copy.copy(self.startPixmap)

            self.startScene.addPixmap(self.startPixmap)
            self.dspStartImage.setScene(self.startScene)
            self.dspStartImage.fitInView(0, 0, self.startScene.width(), self.startScene.height(), Qt.KeepAspectRatio)

        if len(self.endPoints) != 0 and self.endImageLoaded is False:
            self.endImageLoaded = True
            paint.begin(self.endPixmap)
            paint.setPen(Qt.red)
            paint.setBrush(Qt.red)
            for point in self.endPoints.tolist():
                paint.drawEllipse(point[0], point[1], 10, 10)
            paint.end()

            self.endCache = copy.copy(self.endPixmap)
            self.endCleanPoints = copy.copy(self.endPixmap)
            self.endTriangle= copy.copy(self.endPixmap)
            self.endOrigin = copy.copy(self.endPixmap)

            self.endScene.addPixmap(self.endPixmap)
            self.dspEndImage.setScene(self.endScene)
            self.dspEndImage.fitInView(0, 0, self.endScene.width(), self.endScene.height(), Qt.KeepAspectRatio)

    def displayTriangles(self):
        paint = QPainter()
        if self.chkTriangles.isChecked():
            triangles = self.startPoints[spatial.Delaunay(self.startPoints).simplices]
            self.startTriangle = copy.copy(self.startCleanPoints)
            paint.begin(self.startTriangle)
            if self.state is "BLEND":
                paint.setPen(QPen(Qt.red, 3))
                paint.setBrush(Qt.red)
            elif self.state is "PLOT":
                paint.setPen(QPen(Qt.blue, 3))
                paint.setBrush(Qt.blue)
            elif self.state is "ADDPLOT":
                paint.setPen(QPen(Qt.cyan, 3))
                paint.setBrush(Qt.cyan)
            for tri in triangles:
                paint.drawLine(tri[0][0], tri[0][1], tri[1][0], tri[1][1])
                paint.drawLine(tri[0][0], tri[0][1], tri[2][0], tri[2][1])
                paint.drawLine(tri[2][0], tri[2][1], tri[1][0], tri[1][1])
            paint.end()

            triangles = self.endPoints[spatial.Delaunay(self.endPoints).simplices]
            self.endTriangle = copy.copy(self.endCleanPoints)
            paint.begin(self.endTriangle)
            if self.state is "BLEND":
                paint.setPen(QPen(Qt.red, 3))
                paint.setBrush(Qt.red)
            elif self.state is "PLOT":
                paint.setPen(QPen(Qt.blue, 3))
                paint.setBrush(Qt.blue)
            elif self.state is "ADDPLOT":
                paint.setPen(QPen(Qt.cyan, 3))
                paint.setBrush(Qt.cyan)
            for tri in triangles:
                paint.drawLine(tri[0][0], tri[0][1], tri[1][0], tri[1][1])
                paint.drawLine(tri[0][0], tri[0][1], tri[2][0], tri[2][1])
                paint.drawLine(tri[2][0], tri[2][1], tri[1][0], tri[1][1])
            paint.end()
            self.startScene.addPixmap(self.startTriangle)
            self.dspStartImage.setScene(self.startScene)
            self.dspStartImage.fitInView(0, 0, self.startScene.width(), self.startScene.height(), Qt.KeepAspectRatio)

            self.endScene.addPixmap(self.endTriangle)
            self.dspEndImage.setScene(self.endScene)
            self.dspEndImage.fitInView(0, 0, self.endScene.width(), self.endScene.height(), Qt.KeepAspectRatio)

        elif self.startPoints is not None and self.endPoints is not None:
            self.startScene.addPixmap(self.startCleanPoints)
            self.dspStartImage.setScene(self.startScene)
            self.dspStartImage.fitInView(0, 0, self.startScene.width(), self.startScene.height(), Qt.KeepAspectRatio)

            self.endScene.addPixmap(self.endCleanPoints)
            self.dspEndImage.setScene(self.endScene)
            self.dspEndImage.fitInView(0, 0, self.endScene.width(), self.endScene.height(), Qt.KeepAspectRatio)

    def drawPoint(self, point, clicked, saved, seFlag):
        if clicked is True:
            if seFlag is True:
                self.startPixmap = copy.copy(self.startCache)
                self.startTriangle = copy.copy(self.startTriCache)
                for idx in range(len(self.startScene.items())):
                    self.startScene.removeItem(self.startScene.items()[0])
            else:
                self.endPixmap = copy.copy(self.endCache)
                self.endTriangle = copy.copy(self.endTriCache)
                for idx in range(len(self.endScene.items())):
                    self.endScene.removeItem(self.endScene.items()[0])

        paint = QPainter()
        if seFlag is True:
            paint.begin(self.startPixmap)
        else:
            paint.begin(self.endPixmap)

        if saved is True:
            paint.setPen(Qt.blue)
            paint.setBrush(Qt.blue)
        else:
            paint.setPen(Qt.green)
            paint.setBrush(Qt.green)
        paint.drawEllipse(point.x(), point.y(), 10, 10)
        paint.end()

        if seFlag is True:
            paint.begin(self.startTriangle)
        else:
            paint.begin(self.endTriangle)

        if saved is True:
            paint.setPen(Qt.blue)
            paint.setBrush(Qt.blue)
        else:
            paint.setPen(Qt.green)
            paint.setBrush(Qt.green)
        paint.drawEllipse(point.x(), point.y(), 10, 10)
        paint.end()

        if seFlag is True:
            self.startTriFinal = copy.copy(self.startTriangle)
            self.startCleanPoints = copy.copy(self.startPixmap)
            if self.chkTriangles.isChecked():
                self.startScene.addPixmap(self.startTriFinal)
            else:
                self.startScene.addPixmap(self.startPixmap)
            self.dspStartImage.setScene(self.startScene)
            self.dspStartImage.fitInView(0, 0, self.startScene.width(), self.startScene.height(), Qt.KeepAspectRatio)
        else:
            self.endTriFinal = copy.copy(self.endTriangle)
            self.endCleanPoints = copy.copy(self.endPixmap)
            if self.chkTriangles.isChecked():
                self.endScene.addPixmap(self.endTriFinal)
            else:
                self.endScene.addPixmap(self.endPixmap)
            self.dspEndImage.setScene(self.endScene)
            self.dspEndImage.fitInView(0, 0, self.endScene.width(), self.endScene.height(), Qt.KeepAspectRatio)

    def saveToFile(self):
        with open('{}.txt'.format(self.startFile), 'w') as myFile:
            for point in self.startPoints:
                if myFile.tell() == 0:
                    myFile.writelines('{0:6d}{1:6d}'.format(int(point[0]), int(point[1])))
                else:
                    myFile.writelines('\n{0:6d}{1:6d}'.format(int(point[0]), int(point[1])))
        with open('{}.txt'.format(self.endFile), 'w') as myFile:
            for point in self.endPoints:
                if myFile.tell() == 0:
                    myFile.writelines('{0:6d}{1:6d}'.format(int(point[0]), int(point[1])))
                else:
                    myFile.writelines('\n{0:6d}{1:6d}'.format(int(point[0]), int(point[1])))

    def startMousePressEvent(self, event):
        if self.state is "BLEND":
            self.state = "ADDPLOT"
        actualPos = self.dspStartImage.mapToScene(event.pos().x() - 2, event.pos().y() - 2)
        # TODO: Offset of 2 because of border

        if self.endClicked is True:
            self.saveEnd = self.tempEnd
            self.endSaved = True
            self.endClicked = False

        if self.startSaved is True and self.endSaved is True:
            if len(self.startPoints) != 0:
                self.startPoints = np.vstack((self.startPoints, np.array([np.round(self.saveStart.x()), np.round(self.saveStart.y())])))
            else:
                self.startPoints = np.array([np.round(self.saveStart.x()), np.round(self.saveStart.y())])
            self.drawPoint(self.saveStart, self.startClicked, self.startSaved, True)
            if len(self.endPoints) != 0:
                self.endPoints = np.vstack((self.endPoints, np.array([np.round(self.saveEnd.x()), np.round(self.saveEnd.y())])))
            else:
                self.endPoints = np.array([np.round(self.saveEnd.x()), np.round(self.saveEnd.y())])
            self.drawPoint(self.saveEnd, self.endClicked, self.endSaved, False)
            if self.chkTriangles.isChecked():
                self.displayTriangles()
            self.startSaved = False
            self.endSaved = False


        if 0 <= actualPos.x() <= self.startImage.shape[1] and 0 <= actualPos.y() <= self.startImage.shape[0]:
            if self.startSaved is False:
                if self.startClicked is False:
                    self.startCache = copy.copy(self.startPixmap)
                    self.startTriCache = copy.copy(self.startTriangle)
                    self.tempStart = actualPos
                    self.drawPoint(actualPos, self.startClicked, self.startSaved, True)
                    self.startClicked = True

    def endMousePressEvent(self, event):
        if self.state is "BLEND":
            self.state = "ADDPLOT"
        actualPos = self.dspEndImage.mapToScene(event.pos().x() - 2, event.pos().y() - 2)
        # TODO: Offset of 2 because of border

        if self.startClicked is True:
            self.saveStart = self.tempStart
            self.startSaved = True
            self.startClicked = False

        if self.startSaved is True and self.endSaved is True:
            if len(self.startPoints) != 0:
                self.startPoints = np.vstack((self.startPoints, np.array([np.round(self.saveStart.x()), np.round(self.saveStart.y())])))
            else:
                self.startPoints = np.array([np.round(self.saveStart.x()), np.round(self.saveStart.y())])
            self.drawPoint(self.saveStart, self.startClicked, self.startSaved, True)
            if len(self.endPoints) != 0:
                self.endPoints = np.vstack((self.endPoints, np.array([np.round(self.saveEnd.x()), np.round(self.saveEnd.y())])))
            else:
                self.endPoints = np.array([np.round(self.saveEnd.x()), np.round(self.saveEnd.y())])
            self.drawPoint(self.saveEnd, self.endClicked, self.endSaved, False)
            if self.chkTriangles.isChecked():
                self.displayTriangles()
            self.startSaved = False
            self.endSaved = False

        if 0 <= actualPos.x() <= self.endImage.shape[1] and 0 <= actualPos.y() <= self.endImage.shape[0]:
            if self.endSaved is False and self.startSaved is True:
                if self.endClicked is False:
                    self.endCache = copy.copy(self.endPixmap)
                    self.endTriCache = copy.copy(self.endTriangle)
                    self.tempEnd = actualPos
                    self.drawPoint(actualPos, self.endClicked, self.endSaved, False)
                    self.endClicked = True

    def mousePressEvent(self, event):
        self.otherClicked = True
        if self.startClicked is True:
            self.saveStart = self.tempStart
            self.startSaved = True
            self.startClicked = False
        elif self.endClicked is True:
            self.saveEnd = self.tempEnd
            self.endSaved = True
            self.endClicked = False

        if self.startSaved is True and self.endSaved is True:
            if len(self.startPoints) != 0:
                self.startPoints = np.vstack((self.startPoints, np.array([np.round(self.saveStart.x()), np.round(self.saveStart.y())])))
            else:
                self.startPoints = np.array([np.round(self.saveStart.x()), np.round(self.saveStart.y())])
            self.drawPoint(self.saveStart, self.startClicked, self.startSaved, True)
            if len(self.endPoints) != 0:
                self.endPoints = np.vstack((self.endPoints, np.array([np.round(self.saveEnd.x()), np.round(self.saveEnd.y())])))
            else:
                self.endPoints = np.array([np.round(self.saveEnd.x()), np.round(self.saveEnd.y())])
            self.drawPoint(self.saveEnd, self.endClicked, self.endSaved, False)
            if self.chkTriangles.isChecked():
                self.displayTriangles()
            self.startSaved = False
            self.endSaved = False

    def closeEvent(self, event):
        self.saveToFile()



    def keyPressEvent(self, event):
        if event.key() == 16777219:
            if self.startClicked is True:
                self.startClicked = False
                self.startTriangle = copy.copy(self.startTriCache)
                self.startPixmap = copy.copy(self.startCache)
                if self.chkTriangles.isChecked():
                    self.startScene.addPixmap(self.startTriangle)
                    self.dspStartImage.setScene(self.startScene)
                    self.dspStartImage.fitInView(0, 0, self.startScene.width(), self.startScene.height(), Qt.KeepAspectRatio)
                else:
                    self.startScene.addPixmap(self.startPixmap)
                    self.dspStartImage.setScene(self.startScene)
                    self.dspStartImage.fitInView(0, 0, self.startScene.width(), self.startScene.height(), Qt.KeepAspectRatio)
            elif self.endClicked is True:
                self.endClicked = False
                self.endTriangle = copy.copy(self.endTriCache)
                self.endPixmap = copy.copy(self.endCache)
                if self.chkTriangles.isChecked():
                    self.endScene.addPixmap(self.endTriangle)
                    self.dspEndImage.setScene(self.endScene)
                    self.dspEndImage.fitInView(0, 0, self.endScene.width(), self.endScene.height(), Qt.KeepAspectRatio)
                else:
                    self.endScene.addPixmap(self.endPixmap)
                    self.dspEndImage.setScene(self.endScene)
    def blendImage(self):
        if len(self.startImage.shape) == 2 or len(self.endImage.shape) == 2:
            blender = Blender(self.startImage, self.startPoints, self.endImage, self.endPoints)
            self.target = blender.getBlendedImage(self.alpha)
            grayImage = np.ndarray((self.target.shape[0], self.target.shape[1], 3), np.uint8)
            grayImage[:, :, 0] = self.target
            grayImage[:, :, 1] = self.target
            grayImage[:, :, 2] = self.target
            self.target = grayImage
        else:
            blender = ColorBlender(self.startImage, self.startPoints, self.endImage, self.endPoints)
            self.target = blender.getBlendedImage(self.alpha)
        targetPix = QImage(self.target, self.target.shape[1], self.target.shape[0], QImage.Format_RGB888)
        scene = QGraphicsScene()
        scene.addPixmap(QPixmap(targetPix))
        self.targetScene = scene
        self.dspBlendedImage.setScene(self.targetScene)
        self.dspBlendedImage.fitInView(0, 0, self.targetScene.width(), self.targetScene.height(), Qt.KeepAspectRatio)

    def blendImageSeq(self):
        self.targetList = []
        if len(self.startImage.shape) == 2 or len(self.endImage.shape) == 2:
            blender = Blender(self.startImage, self.startPoints, self.endImage, self.endPoints)
            for alpha in np.arange(0, 1.05, 0.05):
                self.target = blender.getBlendedImage(alpha)
                grayImage = np.ndarray((self.target.shape[0], self.target.shape[1], 3), np.uint8)
                grayImage[:, :, 0] = self.target
                grayImage[:, :, 1] = self.target
                grayImage[:, :, 2] = self.target
                self.targetList.append(grayImage)
        else:
            for alpha in np.arange(0, 1.05, 0.05):
                blender = ColorBlender(self.startImage, self.startPoints, self.endImage, self.endPoints)
                self.targetList.append(blender.getBlendedImage(alpha))
        self.displayBlendedImage()

    def displayBlendedImage(self):
        if len(self.targetList) != 0:
            idx = round(self.alpha * 20)
            targetPix = QImage(self.targetList[idx], self.targetList[idx].shape[1], self.targetList[idx].shape[0], QImage.Format_RGB888)
            scene = QGraphicsScene()
            scene.addPixmap(QPixmap(targetPix))
            self.targetScene = scene
            self.dspBlendedImage.setScene(self.targetScene)
            self.dspBlendedImage.fitInView(0, 0, self.targetScene.width(), self.targetScene.height(), Qt.KeepAspectRatio)

    def loadStartImage(self):
        filePath, _ = QFileDialog.getOpenFileName(self, caption='Open jpg/png file ...',
                                                  filter="jpg, png files (*.jpg *.png)")
        self.startFile = filePath
        if not filePath:
            return
        self.startImageLoaded = False
        self.startUndoPointsDict = {}
        self.startUndoTriDict = {}
        self.startUndoPointsList = []
        self.startRedoPointsList = []
        self.loadStartImageFromFile(filePath)

    def loadStartImageFromFile(self, filePath):
        scene = QGraphicsScene()
        self.startPixmap = QPixmap(filePath)
        self.startCache = copy.copy(self.startPixmap)
        self.startTriangle = copy.copy(self.startPixmap)
        scene.addPixmap(self.startPixmap)
        self.startScene = scene
        self.dspStartImage.setScene(self.startScene)
        self.dspStartImage.fitInView(0, 0, self.startScene.width(), self.startScene.height(), Qt.KeepAspectRatio)
        self.startImage = imio.imread(filePath)
        if os.path.isfile('{}.txt'.format(filePath)):
            self.startPoints = np.loadtxt('{}.txt'.format(filePath))
            self.state = "BLEND"
        else:
            with open('{}.txt'.format(filePath), 'w') as myFile:
                pass
            self.state = "PLOT"
        self.displayPoints()
        if self.startImage is not None and self.endImage is not None:
            self.funcEnable()

    def loadEndingImage(self):
        filePath, _ = QFileDialog.getOpenFileName(self, caption='Open jpg/png file ...',
                                                  filter="jpg, png files (*.jpg *.png)")
        self.endFile = filePath
        if not filePath:
            return
        self.endUndoPointsList = {}
        self.endUndoTriDict = {}
        self.endUndoPointsList = []
        self.endRedoPointsList = []
        self.endImageLoaded = False
        self.loadEndingImageFromFile(filePath)

    def loadEndingImageFromFile(self, filePath):
        scene = QGraphicsScene()
        self.endPixmap = QPixmap(filePath)
        self.endCache = copy.copy(self.endPixmap)
        self.endTriangle = copy.copy(self.endPixmap)
        scene.addPixmap(self.endPixmap)
        self.endScene = scene
        self.dspEndImage.setScene(self.endScene)
        self.dspEndImage.fitInView(0, 0, self.endScene.width(), self.endScene.height(), Qt.KeepAspectRatio)
        self.endImage = imio.imread(filePath)
        if os.path.isfile('{}.txt'.format(filePath)):
            self.endPoints = np.loadtxt('{}.txt'.format(filePath))
        else:
            with open('{}.txt'.format(filePath), 'w') as myFile:
                pass
            self.state = "PLOT"
        self.displayPoints()
        if self.startImage is not None and self.endImage is not None:
            self.funcEnable()


if __name__ == "__main__":
    currentApp = QApplication(sys.argv)
    currentForm = Consumer()

    currentForm.show()
    currentApp.exec_()
