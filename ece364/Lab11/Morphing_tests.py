import unittest
from os import path
from glob import glob
import shutil
import numpy as np
from imageio import imread
from PIL import Image
from MorphingUtility import *
from Morphing import *

testFolder = "test_data"

# Modify this settings to increase acceptable difference.
maxDiff = 5


class MorphingTestSuite(unittest.TestCase, ImageAssertion):

    def test_AffineInitializer(self):       # 3 Points

        with self.subTest(key="Normal Initializer"):

            affine = Affine(self.data.startTriangle1, self.data.endTriangle1)
            self.assertIsInstance(affine, Affine)

        with self.subTest(key="Incorrect Input Dimensions"):

            self.assertRaises(ValueError, Affine, self.data.startPoints, self.data.endTriangle1)

        with self.subTest(key="Incorrect Input Types"):

            self.assertRaises(ValueError, Affine, self.data.startTriangle1, self.data.endTriangle1.astype(np.uint8))

    def test_AffineAttributes(self):        # 7 Points
        affine = Affine(self.data.startTriangle2, self.data.endTriangle2)

        with self.subTest(key = "source"): # 1 Points

            self.assertArrayEqual(affine.source, self.data.startTriangle2)

        with self.subTest(key = "destination"): # 1 Points

            self.assertArrayEqual(affine.destination, self.data.endTriangle2)

        with self.subTest(key = "matrix"):  # 5 Points

            self.assertArrayAlmostEqual(affine.matrix, self.data.homography2, tolerance=1.e-3)

    def test_AffineTransformWithEmptyTarget(self):  # 10 Points

        sourcePath = path.join(testFolder, 'StartSmallGray.png')
        targetPath = path.join(testFolder, 'OneTriangle.png')

        affine = Affine(self.data.startTriangle1, self.data.endTriangle1)
        startImage = imread(sourcePath)
        expectedTarget = imread(targetPath)
        targetImage = np.zeros_like(expectedTarget)

        affine.transform(startImage, targetImage)
        comparisonImagePath = path.join(testFolder, 'EmptyTargetComparison.png')

        self.assertArrayAlmostEqual(expectedTarget, targetImage, maxDiff, comparisonImagePath)

    def test_AffineTransformWithNonEmptyTarget(self):   # 10 Points

        sourcePath = path.join(testFolder, 'StartSmallGray.png')
        targetPath = path.join(testFolder, 'TwoTriangles.png')

        startImage = imread(sourcePath)
        expectedTarget = imread(targetPath)
        targetImage = np.zeros_like(expectedTarget)

        affine = Affine(self.data.startTriangle1, self.data.endTriangle1)
        affine.transform(startImage, targetImage)

        affine = Affine(self.data.startTriangle2, self.data.endTriangle2)
        affine.transform(startImage, targetImage)

        comparisonImagePath = path.join(testFolder, 'NonEmptyTargetComparison.png')

        self.assertArrayAlmostEqual(expectedTarget, targetImage, maxDiff, comparisonImagePath)

    def test_BlenderInitializer(self):       # 6 Points

        startPath = path.join(testFolder, 'StartSmallGray.png')
        endPath = path.join(testFolder, 'EndSmallGray.png')

        with self.subTest(key="Normal Initializer"):
            startImage = imread(startPath)
            endImage = imread(endPath)

            blender = Blender(startImage, self.data.startPoints, endImage, self.data.endPoints)
            self.assertIsInstance(blender, Blender)

        with self.subTest(key="Incorrect Input Arguments 1"):
            startImage = Image.open(startPath)
            endImage = Image.open(endPath)

            self.assertRaises(TypeError, Blender, startImage, self.data.startPoints, endImage, self.data.endPoints)

        with self.subTest(key="Incorrect Input Arguments 2"):
            startImage = imread(startPath)
            endImage = imread(endPath)
            points = [[2., 2.], [3., 3.]]
            self.assertRaises(TypeError, Blender, startImage, points, endImage, points)

    def test_BlenderAttributes(self):        # 4 Points
        startPath = path.join(testFolder, 'StartSmallGray.png')
        endPath = path.join(testFolder, 'EndSmallGray.png')

        startImage = imread(startPath)
        endImage = imread(endPath)

        blender = Blender(startImage, self.data.startPoints, endImage, self.data.endPoints)

        with self.subTest(key = "startImage"):
            self.assertArrayEqual(blender.startImage, startImage)

        with self.subTest(key = "startPoints"):
            self.assertArrayEqual(blender.startPoints, self.data.startPoints)

        with self.subTest(key = "endImage"):
            self.assertArrayEqual(blender.endImage, endImage)

        with self.subTest(key = "endPoints"):
            self.assertArrayEqual(blender.endPoints, self.data.endPoints)

    def test_BlenderAlpha25(self):      # 20 Points

        startPath = path.join(testFolder, 'StartSmallGray.png')
        endPath = path.join(testFolder, 'EndSmallGray.png')
        expectedPath = path.join(testFolder, 'Alpha25Gray.png')

        startImage = imread(startPath)
        endImage = imread(endPath)

        blender = Blender(startImage, self.data.startPoints, endImage, self.data.endPoints)

        expectedImage = imread(expectedPath)
        actualImage = blender.getBlendedImage(0.25)

        comparisonImagePath = path.join(testFolder, 'Alpha25Comparison.png')
        self.assertArrayAlmostEqual(expectedImage, actualImage, maxDiff, comparisonImagePath)

    def test_BlenderAlpha50(self):      # 20 Points

        startPath = path.join(testFolder, 'StartSmallGray.png')
        endPath = path.join(testFolder, 'EndSmallGray.png')
        expectedPath = path.join(testFolder, 'Alpha50Gray.png')

        startImage = imread(startPath)
        endImage = imread(endPath)

        blender = Blender(startImage, self.data.startPoints, endImage, self.data.endPoints)

        expectedImage = imread(expectedPath)
        actualImage = blender.getBlendedImage(0.50)

        comparisonImagePath = path.join(testFolder, 'Alpha50Comparison.png')
        self.assertArrayAlmostEqual(expectedImage, actualImage, maxDiff, comparisonImagePath)

    def test_BlenderAlpha75(self):      # 20 Points
        startPath = path.join(testFolder, 'StartSmallGray.png')
        endPath = path.join(testFolder, 'EndSmallGray.png')
        expectedPath = path.join(testFolder, 'Alpha75Gray.png')

        startImage = imread(startPath)
        endImage = imread(endPath)

        blender = Blender(startImage, self.data.startPoints, endImage, self.data.endPoints)

        expectedImage = imread(expectedPath)
        actualImage = blender.getBlendedImage(0.75)

        comparisonImagePath = path.join(testFolder, 'Alpha75Comparison.png')
        self.assertArrayAlmostEqual(expectedImage, actualImage, maxDiff, comparisonImagePath)

    @classmethod
    def setUpClass(cls):
        cls.data = DataSupport()


class ColorMorphingTestSuite(unittest.TestCase, ImageAssertion): # 5 Points

    def test_ColorAffineInitializer(self):

        with self.subTest(key="Normal"):

            affine = ColorAffine(self.data.startTriangle1, self.data.endTriangle1)
            self.assertIsInstance(affine, ColorAffine)

        with self.subTest(key="Attributes"):

            affine = ColorAffine(self.data.startTriangle1, self.data.endTriangle1)
            self.assertTrue(hasattr(affine, 'source') and hasattr(affine, 'destination') and hasattr(affine, 'matrix'))

    def test_ColorAffineTransform(self):

        sourcePath = path.join(testFolder, 'EndSmallColor.png')
        targetPath = path.join(testFolder, 'ColorAffine.png')

        startImage = imread(sourcePath)
        expectedTarget = imread(targetPath)
        targetImage = np.zeros_like(startImage)

        affine = ColorAffine(self.data.endTriangle1, self.data.startTriangle1)
        affine.transform(startImage, targetImage)

        affine = ColorAffine(self.data.endTriangle2, self.data.startTriangle2)
        affine.transform(startImage, targetImage)

        comparisonImagePath = path.join(testFolder, 'ColorAffineComparison.png')

        self.assertArrayAlmostEqual(expectedTarget, targetImage, maxDiff, comparisonImagePath)

    def test_ColorBlenderAlpha25(self):

        startPath = path.join(testFolder, 'StartSmallColor.png')
        endPath = path.join(testFolder, 'EndSmallColor.png')
        expectedPath = path.join(testFolder, 'Alpha25Color.png')

        startImage = imread(startPath)
        endImage = imread(endPath)

        blender = ColorBlender(startImage, self.data.startPoints, endImage, self.data.endPoints)

        expectedImage = imread(expectedPath)
        actualImage = blender.getBlendedImage(0.25)

        comparisonImagePath = path.join(testFolder, 'Alpha25ComparisonColor.png')
        self.assertArrayAlmostEqual(expectedImage, actualImage, maxDiff, comparisonImagePath)

    def test_ColorBlenderAlpha50(self):

        startPath = path.join(testFolder, 'StartSmallColor.png')
        endPath = path.join(testFolder, 'EndSmallColor.png')
        expectedPath = path.join(testFolder, 'Alpha50Color.png')

        startImage = imread(startPath)
        endImage = imread(endPath)

        blender = ColorBlender(startImage, self.data.startPoints, endImage, self.data.endPoints)

        expectedImage = imread(expectedPath)
        actualImage = blender.getBlendedImage(0.50)

        comparisonImagePath = path.join(testFolder, 'Alpha50ComparisonColor.png')
        self.assertArrayAlmostEqual(expectedImage, actualImage, maxDiff, comparisonImagePath)

    def test_ColorBlenderAlpha75(self):

        startPath = path.join(testFolder, 'StartSmallColor.png')
        endPath = path.join(testFolder, 'EndSmallColor.png')
        expectedPath = path.join(testFolder, 'Alpha75Color.png')

        startImage = imread(startPath)
        endImage = imread(endPath)

        blender = ColorBlender(startImage, self.data.startPoints, endImage, self.data.endPoints)

        expectedImage = imread(expectedPath)
        actualImage = blender.getBlendedImage(0.75)

        comparisonImagePath = path.join(testFolder, 'Alpha75ComparisonColor.png')
        self.assertArrayAlmostEqual(expectedImage, actualImage, maxDiff, comparisonImagePath)

    @classmethod
    def setUpClass(cls):
        cls.data = DataSupport()


class MorphingSequenceTestSuite(unittest.TestCase, ImageAssertion): # 5 Points

    def test_GraySequenceAndVideo(self):

        startPath = path.join(testFolder, 'StartSmallGray.png')
        endPath = path.join(testFolder, 'EndSmallGray.png')
        targetPath = path.join(testFolder, 'gray_sequence')

        startImage = imread(startPath)
        endImage = imread(endPath)

        blender = Blender(startImage, self.data.startPoints, endImage, self.data.endPoints)

        blender.generateMorphVideo(targetPath, 20, True)

        with self.subTest(key="Images"):

            fileList = glob(targetPath + "/*.jpg")

            self.assertEqual(len(fileList), 40)

        with self.subTest(key = "Video") :
            fileList = glob(targetPath + "/morph.mp4")

            self.assertEqual(len(fileList), 1)

        shutil.rmtree(targetPath)

    def test_ColorSequenceAndVideo(self):

        startPath = path.join(testFolder, 'StartSmallColor.png')
        endPath = path.join(testFolder, 'EndSmallColor.png')
        targetPath = path.join(testFolder, 'color_sequence')

        startImage = imread(startPath)
        endImage = imread(endPath)

        blender = ColorBlender(startImage, self.data.startPoints, endImage, self.data.endPoints)

        blender.generateMorphVideo(targetPath, 40, False)

        with self.subTest(key="Images"):

            fileList = glob(targetPath + "/*.jpg")

            self.assertEqual(len(fileList), 40)

        with self.subTest(key = "Video") :
            fileList = glob(targetPath + "/morph.mp4")

            self.assertEqual(len(fileList), 1)

        shutil.rmtree(targetPath)

    @classmethod
    def setUpClass(cls):
        cls.data = DataSupport()


class MorphingPerformanceTestSuite(unittest.TestCase, ImageAssertion): # 15 Points

    def test_GrayPerformance(self):

        startPath = path.join(testFolder, 'StartGray.png')
        endPath = path.join(testFolder, 'EndGray.png')

        startImage = imread(startPath)
        endImage = imread(endPath)

        average = checkGrayscalePerformance(startImage, self.data.startPointsLarge, endImage, self.data.endPointsLarge)

        with self.subTest(key="Good"):          # 5 Points

            self.assertLessEqual(average, 8.)

        with self.subTest(key="Better"):        # 5 Points

            self.assertLessEqual(average, 4.)

    def test_ColorPerformance(self):

        startPath = path.join(testFolder, 'StartColor.png')
        endPath = path.join(testFolder, 'EndColor.png')

        startImage = imread(startPath)
        endImage = imread(endPath)

        average = checkColorPerformance(startImage, self.data.startPointsLarge, endImage, self.data.endPointsLarge)

        with self.subTest(key="Good"):          # 2.5 Points

            self.assertLessEqual(average, 12.)

        with self.subTest(key="Better"):        # 2.5 Points

            self.assertLessEqual(average, 6.)

    @classmethod
    def setUpClass(cls):
        cls.data = DataSupport()


class DataSupport:

    def __init__(self):
        filePath = path.join(testFolder, 'Support.npz')
        with np.load(filePath) as dataFile:
            self.startTriangle1 = dataFile['startTriangle1']
            self.startTriangle2 = dataFile['startTriangle2']
            self.endTriangle1 = dataFile['endTriangle1']
            self.endTriangle2 = dataFile['endTriangle2']
            self.homography1 = dataFile['homography1']
            self.homography2 = dataFile['homography2']
            self.startPoints = dataFile['startPoints']
            self.endPoints = dataFile['endPoints']
            self.startPointsLarge = dataFile['startPointsLarge']
            self.endPointsLarge = dataFile['endPointsLarge']


if __name__ == '__main__':
    unittest.main()
