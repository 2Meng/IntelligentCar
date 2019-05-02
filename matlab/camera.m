clc;
clear;

image0 = imread('qidian.bmp');     %��ȡͼƬ
image1 = image0;                      %����˲���ͼƬ      
image2 = image0;                       %��Ŷ�ֵ����ͼƬ
[h,w]=size(image0);
%Ȩ�ؾ���
quanzhong = [ 0.0947416,0.118318, 0.0947416;0.118318,0.147761,0.118318;0.0947416,0.118318, 0.0947416 ];

%��ʾԭͼ
subplot(2,2,1);
imshow(image0);
title('ԭͼ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1�����صĸ�˹�˲�����
for i = 2:h-1
    for j = 2:w-1
        a = double(image0(i-1:i+1 , j-1:j+1)) .* quanzhong;
        image1(i,j) = sum(sum(a));
    end
end

subplot(2,2,2);
imshow(image1);  
title('��˹�˲�');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OSTU
%������ʼ��
pixelCount = [];        %���ؼ���
pixelPro =[];               %���ر���
pixelCount(256) = 1;
pixelPro(256) = 1;

%��ͬ�Ҷ����ص�ͳ��
for i = 1:h
    for j = 1:w
         k = image0(i,j) +1 ;  %matlab����1��ͷ
        pixelCount(k) = (pixelCount(k)) +1;
    end
end

%���ص��������
for i = 1:256
    pixelPro(i) = pixelCount(i)/(188*120);
end

% ��������
P1 = 0;
P2 = 0;
m1 = 0;
m2 = 0;
u0 = 0;
u1 = 0;
mG = 0;
Sigma = 0;
SigmaMax = 0;

%����0-255�Ҷȣ����㷽�����ĻҶ�ֵ
for i = 1:256
    P1 = 0;
    P2 = 0;
    m1 = 0;
    m2 = 0;
    for j = 1:256
        if j<=i             %��������
            P1 = P1 + pixelPro(j);                  %�����ۻ���
            m1 = m1 +  j*pixelPro(j);              %�����ۼƾ�ֵ
        else                %ǰ������
            P2 = P2 + pixelPro(j);                  %ǰ���ۻ���
            m2 =m2 + j*pixelPro(j);                 %ǰ���ۼƾ�ֵ
        end
    end
    
    
    u0 = m1 / P1;        %��һ��ƽ���Ҷ�
    u1 = m2 / P2;        %�ڶ���ƽ���Ҷ�
    mG = m1 + m2;       %ȫ�ֻҶ�
    Sigma = P1 * (u0 - mG)*(u0 - mG) + P2 * (u1 - mG)*(u1 - mG); %������䷽��
    
    if Sigma > SigmaMax          %
        SigmaMax = Sigma;
        threshold = i;
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ֵ������
for i = 1:h
    for j =1:w
        if(image1(i,j) >threshold)
            image2(i,j) = 255;
        else
            image2(i,j) = 0;
        end
    end
end

subplot(2,2,4);
imshow(image2);     
title('��̬��ֵ����');


mid = w/2;
%����Ѱ��
for k = 1:h
    i= h-k+1;
	
	left = 1;
    for j = 1:mid       %�������
        jj=mid-j+1;
            if image2(i,jj)==0
                left = jj;
                break
            end
    end

    right = w;
	for j = mid:w       %���ұ���
         if image2(i,j)==0
            right = j;
            break
         end
	end  

    mid = uint8((left+right)/2);
    image2(i,mid) = 0; %��������
end
    
subplot(2,2,3);
imshow(image2);     
title('����'); 
            
            
                



            
            


        