clc;
clear;

IMG_HIGH = 240; 
IMG_WIDTH = 376; 

Image = imread('��С��.bmp');

 subplot(2,2,1);
 imshow(Image);
 title('ԭʼͼ��');
 
 
 
 
 
 
 
 
 %/* ����������Ϣ */
midline(IMG_HIGH)   = int16(0);
leftline(IMG_HIGH)    = int16(0);
rightline(IMG_HIGH) = int16(0);
