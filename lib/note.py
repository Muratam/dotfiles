import cv2, matplotlib
import numpy as np
import subprocess,uuid
import sys
#hough

def adaptive(img):
    img = grayScale(img)
    img = blur(img)
    img = cv2.adaptiveThreshold(img,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,cv2.THRESH_BINARY,11,2)
    return img

def canny(img,th1 = 90,th2 = 110):
    img = grayScale(img)
    img = blur(img)
    img = cv2.Canny(img, threshold1=th1, threshold2=th2)
    img = bitnot(img)
    return rgbScale(img)


def bitnot(img):
    return cv2.bitwise_not(img) 
def grayScale(img):
    if len(img.shape) == 2 : return img
    return cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

def rgbScale(img):
    if len(img.shape) == 3 : return img
    return cv2.cvtColor(img,cv2.COLOR_GRAY2RGB)

def gray(img):
    img = grayScale(img)
    return rgbScale(img)

def threshold(img,th = 120):
    img = grayScale(img)
    img = cv2.threshold(img,th,255,cv2.THRESH_BINARY)[1]
    return rgbScale(img)

def inRange(img,hsvmin = [0,60,100],hsvmax = [100,255,255]):
    img = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    hsvmin = np.array(hsvmin, np.uint8)
    hsvmax = np.array(hsvmax, np.uint8)
    img = cv2.inRange(img, hsvmin, hsvmax)
    return rgbScale(img)

def masking(img,mask,inverseNot = False,replaceWhite = False):
    if inverseNot : mask = cv2.bitwise_not(mask) 
    masked = cv2.bitwise_and(img,mask)
    if replaceWhite : masked = cv2.addWeighted(masked, 1, mask, 1, 0) 
    return masked

def blur(img,size = 5):
    return cv2.GaussianBlur(img, (size,size), 0)

def imshow(img,base = 400):
    height = img.shape[0]
    width  = img.shape[1]
    aspect = height / width
    resized = cv2.resize(img,(base,int(base * aspect)))
    cv2.imshow("image",resized)
    key = cv2.waitKey(0)
    if key == 13 : #enter
        name = "__" + str(uuid.uuid4())[0:8] +  ".jpg"
        cv2.imwrite(name,img)       
        print(name + " saved")

def save(img,path):
    cv2.imwrite(path,img)



if __name__ == "__main__" :
    filename = sys.argv[1]
    print(filename)
    img = cv2.imread(filename)
    img = masking(img,inRange(img),True)
    img = adaptive(img)
    save(img,filename)
    #$ convert ./*.jpg hoge.pdf