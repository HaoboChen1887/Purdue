from math import sqrt
from PIL import Image
import imageio
import numpy as np

def gaussianBlur(row, column, image):
    imageo = np.zeros((row, column), dtype=np.int64)
    for i in range(1, row-1):
        for j in range(1,column-1):
            # temp = (image[i-1][j-1] + image[i-1][j] + image[i-1][j+1] + image[i][j-1] + image[i][j] + image[i][j+1] + image[i+1][j-1] + image[i+1][j] + image[i+1][j+1]) / 9
            # print(temp)
            imageo[i][j] = np.round((image[i-1][j-1] + image[i-1][j] + image[i-1][j+1] + image[i][j-1] + image[i][j] + image[i][j+1] + image[i+1][j-1] + image[i+1][j] + image[i+1][j+1]) / 9).astype(np.int64)

    return imageo

def Sobel(row, column, image):
    x = np.zeros((row, column), dtype=np.int64)
    y = np.zeros((row, column), dtype=np.int64)
    for i in range(1, row-1):
        for j in range(1, column-1):
            x[i][j] = np.round(image[i][j+1] - image[i][j-1]).astype(np.int64)
            y[i][j] = np.round(image[i+1][j] - image[i-1][j]).astype(np.int64)

    return x, y

def Gradient(x, y, row, column):
    imageo = np.zeros((row, column), dtype=np.int64)
    for i in range(row):
        for j in range(column):
            if sqrt(x[i][j]**2 + y[i][j]**2) > 50:
                imageo[i][j] = 255
            else:
                imageo[i][j] = 0

    return imageo


if __name__ == "__main__":
    im = Image.open("source.jpg").convert('L')
    image = np.array(im, dtype=np.int64)
    temp = np.array([[2, 2, 1], [2, 1, 1], [1, 1, 1]], dtype=np.int64)
    Gresult = gaussianBlur(image.shape[0], image.shape[1], image)
    imageio.imwrite('D:\Purdue\Homework\Spring 2018\ECE 337\Project\Gaus.jpg', Gresult)
    x, y = Sobel(image.shape[0], image.shape[1], Gresult)
    imageo = Gradient(x, y, image.shape[0], image.shape[1])
    imageio.imwrite('D:\Purdue\Homework\Spring 2018\ECE 337\Project\output.jpg', imageo)