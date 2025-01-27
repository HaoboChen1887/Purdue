#include "bmp.h"

#include <stdlib.h>
#include <string.h>

static unsigned char *** _extract_pixels(FILE * fp, BMPImage * bmp, char ** error);
static void _write_pixels(unsigned char *** pixel, BMPImage * bmp, char ** error);
static BMPHeader _modify_header(BMPHeader orihead, int x, int y, int w, int h);

BMPImage* read_bmp(FILE* fp, char** error) {
	BMPImage * bmp = malloc(sizeof(BMPImage));
	bmp -> data = NULL;
	if(bmp == NULL) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "read_bmp(FILE* fp, char** error) failed because malloc failed";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return NULL;
	}
	if(fp == NULL) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "read_bmp(FILE* fp, char** error) failed because file is empty";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		free(bmp);
		return NULL;
	}
	if(fread(&(bmp -> header), sizeof(BMPHeader), 1, fp) != 1) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "read_bmp(FILE* fp, char** error) failed because fread failed";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		free(bmp);
		return NULL;
	}
	if(check_bmp_header(&(bmp -> header), fp) == false) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "read_bmp(FILE* fp, char** error) failed because check_bmp_header failed";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		free(bmp);
		return NULL;
	}


	unsigned char *** pixels = _extract_pixels(fp, bmp, error);
	_write_pixels(pixels, bmp, error);

	return bmp;
}

bool check_bmp_header(BMPHeader* bmp_header, FILE* fp) {
	if(bmp_header -> type != 0x4d42) {
		return false;
	}
	if(bmp_header -> offset != BMP_HEADER_SIZE) {
		return false;
	}
	if(bmp_header -> dib_header_size != DIB_HEADER_SIZE) {
		return false;
	}
	if(bmp_header -> num_planes != 1) {
		return false;
	}
	if(bmp_header -> compression != 0) {
		return false;
	}
	if(bmp_header -> num_colors != 0 || bmp_header -> important_colors != 0) {
		return false;
	}
	if(bmp_header -> bits_per_pixel != 24 && bmp_header -> bits_per_pixel != 16) {
		return false;
	}
	unsigned int width = bmp_header -> width_px;
	unsigned int height = bmp_header -> height_px;
	int byte_per_pix = bmp_header -> bits_per_pixel / 8;
	int pad = (byte_per_pix * width) % 4 == 0 ? 0 : 4 - (byte_per_pix * width) % 4;
	unsigned int image_size = (pad + width * byte_per_pix) * height;
	if(bmp_header -> image_size_bytes != image_size) {
		return false;
	}
	if(bmp_header -> size != image_size + bmp_header -> offset) {
		return false;
	}
	fseek(fp, 0, SEEK_SET);
	fseek(fp, 0, SEEK_END);
	int size = ftell(fp);
	if(bmp_header -> size != size) {
		return false;
	}
	fseek(fp, bmp_header -> offset, SEEK_SET);
	return true;
}

bool write_bmp(FILE* fp, BMPImage* image, char** error) {
	if(image == NULL) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "write_bmp(FILE* fp, char** error) failed because image doesn't exist";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return false;
	}
	if(fwrite(&(image -> header), sizeof(BMPHeader), 1, fp) != 1) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "write_bmp(FILE* fp, char** error) failed because fwrite failed";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return false;
	}
	unsigned int data_size = image -> header.size - image -> header.offset;
	if(fwrite((image -> data), sizeof(unsigned char), data_size, fp) != data_size) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "write_bmp(FILE* fp, char** error) failed because fwrite failed";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return false;
	}
	return true;
}

void free_bmp(BMPImage* image) {
	if(image != NULL) {
		if(image->data != NULL) {
			free(image -> data);
		}
		free(image);
	}
	return;
}

BMPImage* crop_bmp(BMPImage* image, int x, int y, int w, int h, char** error) {
	if(image == NULL) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "crop_bmp(FILE* fp, char** error) failed because image was not read correctly";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return NULL;
	}
	if(x < 0 || x > image -> header.width_px) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "crop_bmp(FILE* fp, char** error) failed because x is invalid";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return NULL;
	}
	if(y < 0 || y > image -> header.height_px) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "crop_bmp(file* fp, char** error) failed because y is invalid";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return NULL;
	}
	if(w <= 0 || x + w > image -> header.width_px) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "crop_bmp(file* fp, char** error) failed because w is invalid";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return NULL;
	}
	if(h <= 0 || y + h > image -> header.height_px) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "crop_bmp(file* fp, char** error) failed because h is invalid";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return NULL;
	}
	BMPImage * new_bmp = malloc(sizeof(BMPImage));
	new_bmp -> data = NULL;
	if(new_bmp == NULL) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "crop_bmp(FILE* fp, char** error) failed because malloc failed";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return NULL;
	}
	new_bmp -> header = _modify_header(image -> header, x, y, w, h);

	unsigned char *** pixels = malloc(sizeof(unsigned char **) * h);
	if(pixels == NULL) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "read_bmp(FILE* fp, char** error) failed because malloc failed";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return NULL;
	}
	int byte_per_pix = image -> header.bits_per_pixel / 8;
	int width = image -> header.width_px;
	int ct = x * byte_per_pix + y * (byte_per_pix * width + width % 4);
	int pad = (byte_per_pix * w) % 4 == 0 ? 0 : 4 - (byte_per_pix * w) % 4;
	for(int row = h - 1; row >= 0; row --) {
		pixels[row] = malloc(sizeof(unsigned char *) * (w + 1));
		if(pixels[row] == NULL) {
			if(*error != NULL) {
				free(*error);
			}
			char * message = "read_bmp(FILE* fp, char** error) failed because malloc failed";
			*error = malloc((strlen(message) + 1) * sizeof(char));
			strcpy(*error, message);
			return NULL;
		}
		for(int col = 0; col < w; col ++) {
			pixels[row][col] = malloc(sizeof(unsigned char) * byte_per_pix);
			if(pixels[row][col] == NULL) {
				if(*error != NULL) {
					free(*error);
				}
				char * message = "read_bmp(FILE* fp, char** error) failed because malloc failed";
				*error = malloc((strlen(message) + 1) * sizeof(char));
				strcpy(*error, message);
				return NULL;
			}
			for(int rgb = 0; rgb < byte_per_pix; rgb ++) {
				pixels[row][col][rgb] = (image -> data)[ct ++];	
			}
			if(col == w - 1 && pad != 0) {
				col = w;
				pixels[row][col] = malloc(sizeof(unsigned char) * pad);
				for(int pad_c = 0; pad_c < pad; pad_c ++) {
					pixels[row][col][pad_c] = 0X00;
				}
			}
		}
		ct += (byte_per_pix * (width - w) + pad);
	}
	
	_write_pixels(pixels, new_bmp, error);
	
	return new_bmp;
}

static unsigned char *** _extract_pixels(FILE * fp, BMPImage * bmp, char ** error) {
	int width = bmp -> header.width_px;
	int height = bmp -> header.height_px;
	int byte_per_pix = bmp -> header.bits_per_pixel / 8;
	int pad = (byte_per_pix * width) % 4 == 0 ? 0 : 4 - (byte_per_pix * width) % 4;
	unsigned char *** pixels = malloc(sizeof(unsigned char **) * height);
	if(pixels == NULL) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "read_bmp(FILE* fp, char** error) failed because malloc failed";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return NULL;
	}
	for(int row = height - 1; row >= 0; row --) {
		pixels[row] = malloc(sizeof(unsigned char *) * (width + 1));
		if(pixels[row] == NULL) {
			if(*error != NULL) {
				free(*error);
			}
			char * message = "read_bmp(FILE* fp, char** error) failed because malloc failed";
			*error = malloc((strlen(message) + 1) * sizeof(char));
			strcpy(*error, message);
			return NULL;
		}
		for(int col = 0; col < width; col ++) {
			pixels[row][col] = malloc(sizeof(unsigned char) * byte_per_pix);
			if(pixels[row][col] == NULL) {
				if(*error != NULL) {
					free(*error);
				}
				char * message = "read_bmp(FILE* fp, char** error) failed because malloc failed";
				*error = malloc((strlen(message) + 1) * sizeof(char));
				strcpy(*error, message);
				return NULL;
			}
			for(int rgb = 0; rgb < byte_per_pix; rgb ++) {
			//for(int rgb = byte_per_pix - 1; rgb >= 0; rgb --) {
				if(fread(&(pixels[row][col][rgb]), sizeof(unsigned char), 1, fp) != 1) {
					if(*error != NULL) {
						free(*error);
					}
					char * message = "read_bmp(FILE* fp, char** error) failed because data is not read competely";
					*error = malloc((strlen(message) + 1) * sizeof(char));
					strcpy(*error, message);
					return NULL;
				}
			}
			if(col == width - 1 && pad != 0) {
				col = width;
				pixels[row][col] = malloc(sizeof(unsigned char) * pad);
				for(int pad_c = 0; pad_c < pad; pad_c ++) {
					if(fread(&(pixels[row][col][pad_c]), sizeof(unsigned char), 1, fp) != 1) {
						if(*error != NULL) {
							free(*error);
						}
						char * message = "read_bmp(FILE* fp, char** error) failed because data is not read competely";
						*error = malloc((strlen(message) + 1) * sizeof(char));
						strcpy(*error, message);
						return NULL;
					}
				}
			}
		}
	}
	return pixels;
}

static void _write_pixels(unsigned char *** pixels, BMPImage * bmp, char ** error) {
	if(bmp == NULL) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "read_bmp(FILE* fp, char** error) failed because image is not read correctly";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return;
	}
	int width = bmp -> header.width_px;
	int height = bmp -> header.height_px;
	int byte_per_pix = bmp -> header.bits_per_pixel / 8;
	int pad = (byte_per_pix * width) %4 == 0 ? 0 : 4 - (byte_per_pix * width) % 4;
	bmp -> data = malloc(sizeof(unsigned char) * (width * height * byte_per_pix + height * pad));
	if(bmp -> data == NULL) {
		if(*error != NULL) {
			free(*error);
		}
		char * message = "read_bmp(FILE* fp, char** error) failed because malloc failed";
		*error = malloc((strlen(message) + 1) * sizeof(char));
		strcpy(*error, message);
		return;
	}
	int ct = 0;

	for(int row = height - 1; row >= 0; row --) {
		for(int col = 0; col < width + 1; col ++) {
			if(col != width) {
				for(int rgb = 0; rgb < byte_per_pix; rgb ++) {
				//for(int rgb = byte_per_pix - 1; rgb >= 0; rgb --) {
					(bmp -> data)[ct ++] = pixels[row][col][rgb];
				}
				free(pixels[row][col]);
			}
			else if(pad != 0) {
				for(int pad_c = 0; pad_c < pad; pad_c ++) {
					(bmp -> data)[ct ++] = pixels[row][col][pad_c];
				}
				free(pixels[row][col]);
			}
		}
		free(pixels[row]);
	}
	free(pixels);
	return;
}

static BMPHeader _modify_header(BMPHeader orihead, int x, int y, int w, int h) {
	orihead.width_px = w;
	orihead.height_px = h;
	int width = w;
	int height = h;
	int byte_per_pix = orihead.bits_per_pixel / 8;
	int pad = (byte_per_pix * width) %4 == 0 ? 0 : 4 - (byte_per_pix * width) % 4;
	orihead.image_size_bytes = (pad + width * (byte_per_pix)) * height;
	orihead.size = orihead.image_size_bytes + orihead.offset;
	
	return orihead;
}

