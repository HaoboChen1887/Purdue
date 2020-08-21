import time
import os
import numpy as np
from scipy import spatial, interpolate
import imageio as imio
from PIL import Image, ImageDraw

class Affine:
    def __init__(self, source, destination):
        if not isinstance(source, np.ndarray) or not isinstance(destination, np.ndarray):
            raise TypeError("One or more arguement is not np.ndarray")
        elif len(source) != 3 or len(source[0]) != 2:
            raise ValueError("Dimension of 'source' is not valid")
        elif len(destination) != 3 or len(destination[0]) != 2:
            raise ValueError("Dimension of 'destination' is not valid")
        elif all(not isinstance(pix, np.float64) for row in source for pix in row):
            raise ValueError("One or more value in 'source' is not np.float64")
        elif all(not isinstance(pix, np.float64) for row in destination for pix in row):
            raise ValueError("One or more value in 'destination' is not np.float64")

        self.source = source
        self.destination = destination
        self.matrix = self.getMat()

    def getMat(self):
        mat_l = np.vstack(([self.destination[0][0], self.destination[0][1], 1, 0, 0, 0],
                           [0, 0, 0, self.destination[0][0], self.destination[0][1], 1]))
        for idx in range(1, 3):
            mat_l = np.vstack((mat_l, [self.destination[idx][0], self.destination[idx][1], 1, 0, 0, 0]))
            mat_l = np.vstack((mat_l, [0, 0, 0, self.destination[idx][0], self.destination[idx][1], 1]))
        mat_r = np.vstack((self.source[0][0],
                           self.source[0][1],
                           self.source[1][0],
                           self.source[1][1],
                           self.source[2][0],
                           self.source[2][1]))
        result = np.linalg.solve(mat_l, mat_r)
        matrix = np.vstack((result.reshape((2, 3)), np.array([0, 0, 1], np.float64)))
        return matrix

    def transform(self, sourceImage, destinationImage):
        if not isinstance(sourceImage, np.ndarray) or not isinstance(destinationImage, np.ndarray):
            raise TypeError("One or more arguement is not np.ndarray")
        else:
            img = Image.new('L', (sourceImage.shape[1], sourceImage.shape[0]), 0)
            ImageDraw.Draw(img).polygon([self.destination[0, 0], self.destination[0, 1],
                                         self.destination[1, 0], self.destination[1, 1],
                                         self.destination[2, 0], self.destination[2, 1]], outline=255, fill=255)
            mask = np.array(img)

            row_min = max(0, int(min([self.source[0][1], self.source[1][1], self.source[2][1]])))
            col_min = max(0, int(min([self.source[0][0], self.source[1][0], self.source[2][0]])))
            row_max = min(len(sourceImage), int(max([self.source[0][1], self.source[1][1], self.source[2][1]]) + 2))
            col_max = min(len(sourceImage[0]), int(max([self.source[0][0], self.source[1][0], self.source[2][0]])) + 2)

            width = col_max - col_min
            height = row_max - row_min
            y, x = np.where(mask == 255)
            inter = interpolate.RectBivariateSpline(range(height), range(width), sourceImage[row_min:row_max, col_min:col_max], kx=1, ky=1)

            dim = len(y)
            det_p = np.vstack((x[np.arange(dim)], y[np.arange(dim)], np.ones(dim, np.float64)))
            src_p = np.matmul(self.matrix, det_p[:, np.arange(dim)])
            destinationImage[y[np.arange(dim)], x[np.arange(dim)]] = np.round(inter.ev(src_p[1, np.arange(dim)] - row_min, src_p[0, np.arange(dim)] - col_min))


class Blender:
    def __init__(self, startImage, startPoints, endImage, endPoints):
        for array in [startImage, startPoints, endImage, endPoints]:
            if not isinstance(array, np.ndarray):
                print(type(array))
                raise TypeError('One or more argument is not np.ndarray')

        self.startImage = startImage
        self.startPoints = startPoints
        self.endImage = endImage
        self.endPoints = endPoints

    def getBlendedImage(self, alpha):
        targetPoints = self.startPoints * (1 - alpha) + self.endPoints * alpha
        targetImage1 = np.zeros(self.startImage.shape, np.uint8)
        targetImage2 = np.zeros(self.startImage.shape, np.uint8)
        tri_ob = spatial.Delaunay(self.startPoints)

        aff_l = self.getAffine(tri_ob.simplices, self.startPoints, targetPoints)
        for tri in aff_l:
            tri.transform(self.startImage, targetImage1)

        aff_l = self.getAffine(tri_ob.simplices, self.endPoints, targetPoints)
        for tri in aff_l:
            tri.transform(self.endImage, targetImage2)
        finalImage = np.round(targetImage1 * (1 - alpha) + targetImage2 * alpha).astype(np.uint8)
        return finalImage


    def getAffine(self, vertices, srcPoints, targetPoints):
        aff_l = []
        for tri in vertices:
            aff_l.append(Affine(srcPoints[tri], targetPoints[tri]))
        return aff_l

    def generateMorphVideo(self, targetFolderPath, sequenceLength, includeReversed=True):
        seq = np.r_[0:1:1 / (sequenceLength - 1), 1]
        if includeReversed is True:
            seq = np.r_[seq, 1:0:-1 / (sequenceLength - 1), 0]
        ct = 0
        for percent in seq:
            img = self.getBlendedImage(percent)
            try:
                imio.imwrite('{0}/frame{1:03d}.jpg'.format(targetFolderPath, ct), img)
            except:
                os.makedirs(targetFolderPath)
                imio.imwrite('{0}/frame{1:03d}.jpg'.format(targetFolderPath, ct), img)
            ct += 1
        os.system('ffmpeg -f image2 -r 5 -i {}/frame%03d.jpg -vcodec mpeg4 -y {}/morph.mp4'.format(targetFolderPath, targetFolderPath))

class ColorAffine:
    def __init__(self, source, destination):
        if not isinstance(source, np.ndarray) or not isinstance(destination, np.ndarray):
            raise TypeError("One or more arguement is not np.ndarray")
        elif len(source) != 3 or len(source[0]) != 2:
            raise ValueError("Dimension of 'source' is not valid")
        elif len(destination) != 3 or len(destination[0]) != 2:
            raise ValueError("Dimension of 'destination' is not valid")
        elif all(not isinstance(pix, np.float64) for row in source for pix in row):
            raise ValueError("One or more value in 'source' is not np.float64")
        elif all(not isinstance(pix, np.float64) for row in destination for pix in row):
            raise ValueError("One or more value in 'destination' is not np.float64")

        self.source = source
        self.destination = destination
        self.matrix = self.getMat()

    def getMat(self):
        mat_l = np.vstack(([self.destination[0][0], self.destination[0][1], 1, 0, 0, 0],
                           [0, 0, 0, self.destination[0][0], self.destination[0][1], 1]))
        for idx in range(1, 3):
            mat_l = np.vstack((mat_l, [self.destination[idx][0], self.destination[idx][1], 1, 0, 0, 0]))
            mat_l = np.vstack((mat_l, [0, 0, 0, self.destination[idx][0], self.destination[idx][1], 1]))
        mat_r = np.vstack((self.source[0][0],
                           self.source[0][1],
                           self.source[1][0],
                           self.source[1][1],
                           self.source[2][0],
                           self.source[2][1]))
        result = np.linalg.solve(mat_l, mat_r)
        matrix = np.vstack((result.reshape((2, 3)), np.array([0, 0, 1], np.float64)))
        return matrix

    def transform(self, sourceImage, destinationImage):
        if not isinstance(sourceImage, np.ndarray) or not isinstance(destinationImage, np.ndarray):
            raise TypeError("One or more arguement is not np.ndarray")
        else:
            height, width, rgb = sourceImage.shape
            img = Image.new('L', (width, height), 0)
            ImageDraw.Draw(img).polygon([self.destination[0, 0], self.destination[0, 1],
                                         self.destination[1, 0], self.destination[1, 1],
                                         self.destination[2, 0], self.destination[2, 1]], outline=255, fill=255)
            mask = np.array(img)

            row_min = max(0, int(min([self.source[0][1], self.source[1][1], self.source[2][1]])))
            col_min = max(0, int(min([self.source[0][0], self.source[1][0], self.source[2][0]])))
            row_max = min(len(sourceImage), int(max([self.source[0][1], self.source[1][1], self.source[2][1]]) + 2))
            col_max = min(len(sourceImage[0]), int(max([self.source[0][0], self.source[1][0], self.source[2][0]])) + 2)

            width = col_max - col_min
            height = row_max - row_min
            y, x = np.where(mask == 255)
            inter_r = interpolate.RectBivariateSpline(range(height), range(width), sourceImage[row_min:row_max, col_min:col_max, 0], kx=1, ky=1)
            inter_g = interpolate.RectBivariateSpline(range(height), range(width), sourceImage[row_min:row_max, col_min:col_max, 1], kx=1, ky=1)
            inter_b = interpolate.RectBivariateSpline(range(height), range(width), sourceImage[row_min:row_max, col_min:col_max, 2], kx=1, ky=1)

            dim = len(y)
            det_p = np.vstack((x[np.arange(dim)], y[np.arange(dim)], np.ones(dim, np.float64)))
            src_p = np.matmul(self.matrix, det_p[:, np.arange(dim)])
            destinationImage[y[np.arange(dim)], x[np.arange(dim)], 0] = np.round(inter_r.ev(src_p[1, np.arange(dim)] - row_min, src_p[0, np.arange(dim)] - col_min))
            destinationImage[y[np.arange(dim)], x[np.arange(dim)], 1] = np.round(inter_g.ev(src_p[1, np.arange(dim)] - row_min, src_p[0, np.arange(dim)] - col_min))
            destinationImage[y[np.arange(dim)], x[np.arange(dim)], 2] = np.round(inter_b.ev(src_p[1, np.arange(dim)] - row_min, src_p[0, np.arange(dim)] - col_min))
            # y, x = np.nonzero(mask)
            # if self.inter_r is None or self.inter_g is None or self.inter_b is None:
            #     self.inter_r = interpolate.RectBivariateSpline(range(height), range(width), sourceImage[:, :, 0], kx=1, ky=1)
            #     self.inter_g = interpolate.RectBivariateSpline(range(height), range(width), sourceImage[:, :, 1], kx=1, ky=1)
            #     self.inter_b = interpolate.RectBivariateSpline(range(height), range(width), sourceImage[:, :, 2], kx=1, ky=1)
            #
            # dim = len(y)
            # det_p = np.vstack((x[np.arange(dim)], y[np.arange(dim)], np.ones(dim, np.float64)))
            # src_p = np.matmul(self.matrix, det_p[:, np.arange(dim)])
            # destinationImage[y[np.arange(dim)], x[np.arange(dim)], 0] = np.round(self.inter_r.ev(src_p[1, np.arange(dim)], src_p[0, np.arange(dim)]))
            # destinationImage[y[np.arange(dim)], x[np.arange(dim)], 1] = np.round(self.inter_g.ev(src_p[1, np.arange(dim)], src_p[0, np.arange(dim)]))
            # destinationImage[y[np.arange(dim)], x[np.arange(dim)], 2] = np.round(self.inter_b.ev(src_p[1, np.arange(dim)], src_p[0, np.arange(dim)]))

class ColorBlender:
    def __init__(self, startImage, startPoints, endImage, endPoints):
        for array in [startImage, startPoints, endImage, endPoints]:
            if not isinstance(array, np.ndarray):
                print(type(array))
                raise TypeError('One or more argument is not np.ndarray')

        self.startImage = startImage
        self.startPoints = startPoints
        self.endImage = endImage
        self.endPoints = endPoints

    def getBlendedImage(self, alpha):
        targetPoints = self.startPoints * (1 - alpha) + self.endPoints * alpha
        targetImage1 = np.zeros(self.startImage.shape, np.uint8)
        targetImage2 = np.zeros(self.startImage.shape, np.uint8)
        tri_ob = spatial.Delaunay(self.startPoints)
        aff_l = self.getAffine(tri_ob.simplices, self.startPoints, targetPoints)

        for tri in aff_l:
            tri.transform(self.startImage, targetImage1)
        aff_l = self.getAffine(tri_ob.simplices, self.endPoints, targetPoints)
        for tri in aff_l:
            tri.transform(self.endImage, targetImage2)
        finalImage = np.round(targetImage1 * (1 - alpha) + targetImage2 * alpha).astype(np.uint8)
        return finalImage

    def getAffine(self, vertices, srcPoints, targetPoints):
        aff_l = []
        for tri in vertices:
            aff_l.append(ColorAffine(srcPoints[tri], targetPoints[tri]))
        return aff_l

    def generateMorphVideo(self, targetFolderPath, sequenceLength, includeReversed=True):
        seq = np.r_[0:1:1 / (sequenceLength - 1), 1]
        if includeReversed is True:
            seq = np.r_[seq, 1:0:-1 / (sequenceLength - 1), 0]
        ct = 0
        for percent in seq:
            img = self.getBlendedImage(percent)
            try:
                imio.imwrite('{0}/frame{1:03d}.jpg'.format(targetFolderPath, ct), img)
            except:
                os.makedirs(targetFolderPath)
                imio.imwrite('{0}/frame{1:03d}.jpg'.format(targetFolderPath, ct), img)
            ct += 1
        # os.chdir(targetFolderPath)
        os.system('ffmpeg -f image2 -r 5 -i {}/frame%03d.jpg -vcodec mpeg4 -y {}/morph.mp4'.format(targetFolderPath, targetFolderPath))
        # os.system('ffmpeg -f image2 -r 5 -i frame%03d.jpg -vcodec mpeg4 -y {}/morph.mp4'.format(targetFolderPath))
        # os.system('cd ..')



if __name__ == '__main__':
    start_time = time.time()

    startPoints = np.loadtxt('wolf.jpg.txt', np.float64)
    endPoints = np.loadtxt('tiger2.jpg.txt', np.float64)
    startImage = imio.imread('WolfGray.jpg')
    endImage = imio.imread('Tiger2Gray.jpg')
    blender = Blender(startImage, startPoints, endImage, endPoints)
    target = blender.getBlendedImage(0.4)
    imio.imwrite('test.png', target)
    # blender.generateMorphVideo("myVideoGray", 20, True)
    print("--- %s seconds ---" % (time.time() - start_time))

    # TODO: diff function
    expected = imio.imread('gray_results/frame017.png')
    actual = imio.imread('test.png')
    diff = np.absolute(actual - expected)
    img = np.array(Image.new('L', (800, 600), 0))
    ct = 0
    for x in range(800):
        for y in range(600):
            if abs(diff[y, x]) > 1:
                ct += 1
                img[y, x] = 255
    imio.imwrite('diff.png', img)
    print("difference = {}, percentage = {}%".format(ct, (ct * 100 / 480000)))


    start_time = time.time()
    startColor = imio.imread('WolfColor.jpg')
    endColor = imio.imread('Tiger2Color.jpg')
    color_blender = ColorBlender(startColor, startPoints, endColor, endPoints)
    imio.imwrite('test_color.jpg', color_blender.getBlendedImage(0.5))
    # color_blender.generateMorphVideo("myVideoColor", 20, True)
    print("--- %s seconds ---" % (time.time() - start_time))
    pass

