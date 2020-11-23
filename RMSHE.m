clc;clear all;close all;

PicOri=imread('cat_org1.jpg');
if numel(size(PicOri))>2
    PicGray=rgb2gray(PicOri);
else
    PicGray=PicOri;
end

h=imhist(PicGray); 
[m,n]=size(PicGray); PicHEt=zeros(m,n);
maxx = double(max(max(PicGray)));	 
minn = double(min(min(PicGray)));
MeanImage = round(double(mean(mean(PicGray))));	
MedianImage=round(double(median(median(PicGray))));
HarmmeanImage=round(double(harmmean(harmmean(PicGray))));
ModeImage = double(mode(mode(PicGray)));	
StandardImage=round(double(std2(PicGray(:))));
alpha=round(abs(tand((maxx/ModeImage)-(StandardImage/2))));
r=1; length=2^r; Xm=zeros(1,length); Xm(1)=maxx+1; Xm(2)=minn+1;
c=abs(StandardImage-MeanImage);
for i=1:r 
    for j=1:2^(i-1) 
        
            Xm(2^(i-1)+j+1)=alpha*(ModeImage);
            
    end 
    Xm=sort(Xm,'descend'); 
end 
Xm=sort(Xm);

for i=2:2^r 
    [row,col]=find((PicGray>=Xm(i-1)-1)&(PicGray<=Xm(i)-2)); 
    PicHEt=FuncHE(PicGray,PicHEt,row,col,h,Xm(i-1)-1,Xm(i)-2,m,n); 
    
end 
[row,col]=find((PicGray>=Xm(2^r)-1)&(PicGray<=Xm(2^r+1)-1)); 
PicHEt=FuncHE(PicGray,PicHEt,row,col,h,Xm(2^r)-1,Xm(2^r+1)-1,m,n);
PicHE=uint8(PicHEt); 
h1=imhist(PicHE); 
figure,imshow(PicGray);title('Orignal Gray Scal Image')
figure();hold on; imhist(PicGray);title('Gray')

figure,imshow(PicHE); title('Result Image')
figure();hold on; imhist(PicHE);title('Result');
%figure,imhist(PicHE),title('Histogram')


 
