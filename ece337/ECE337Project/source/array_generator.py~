import imageio as imio
from PIL import Image
import numpy as np

def arrayGen():
	mat = []
	for row in range(600):
		row_l = []
		for col in range(800):
			row_l.append(233)
		mat.append(row_l)
			
	return mat

def imageGen():
	# image = imio.imread("test_image.jpg")
	image = Image.open('test_image.jpg').convert('L')
	image = np.array(list(image.getdata(band=0)))
	print(len(image))
	image = image.reshape((600, 800))
	print(image)
	data_str = ""
	for col in range(800):
		if col == 0:
			data_str = data_str + '{{{{{0:4s}'.format(str(image[599][col]))
		elif col == 799:
			data_str = data_str + '{0:4s}}},'.format(str(image[599][col]))
		else:
			data_str = data_str + ',{0:4s}'.format(str(image[599][col]))
	for row in range(1, 599):
		for col in range(800):
			if col == 0:
				data_str = data_str + '{{{0:4s}'.format(str(image[row][col]))
			elif col == 799:
				data_str = data_str + '{0:4s}}},\n'.format(str(image[row][col]))
			else:
				data_str = data_str + ',{0:4s}'.format(str(image[row][col]))
	
	for col in range(800):
		if col == 0:
			data_str = data_str + '{{{0:4s}'.format(str(image[599][col]))
		elif col == 799:
			data_str = data_str + '{0:4s}}}}}'.format(str(image[599][col]))
		else:
			data_str = data_str + ',{0:4s}'.format(str(image[599][col]))
	with open("test_data.txt", 'w') as myFile:
		myFile.writelines(data_str)

def imageGenOneDim():
	image = Image.open('test_image.jpg').convert('L')
	image = np.array(list(image.getdata(band=0)))
	print(len(image))
	image = image.reshape((600, 800))
	print(image)
	data_str = ""
	for col in range(800):
		if col == 0:
			data_str = data_str + '{{{0:4s}'.format(str(image[599][col]))
		else:
			data_str = data_str + '{0:4s},'.format(str(image[599][col]))
	for row in range(0, 599):
		for col in range(800):
			data_str = data_str + '{0:4s},'.format(str(image[row][col]))
	
	for col in range(800):
		if col == 799:
			data_str = data_str + '{0:4s}}}'.format(str(image[599][col]))
		else:
			data_str = data_str + '{0:4s},'.format(str(image[599][col]))
	with open("test_data.txt", 'w') as myFile:
		myFile.writelines(data_str)

if __name__ == "__main__":
	imageGenOneDim()
	pass

