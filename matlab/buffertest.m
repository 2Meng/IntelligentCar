clc;clear;
%7/8 ��·�����ж�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�յ���ͼ������ﵼ��
cameraReceiver = imread('IMGtest.bmp');
%bin_image = textread('ֱ��.txt','%c');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,1);
imshow(cameraReceiver);
%ʵ��ʹ�õ�ͼ�����鴴��
IMG_HIGH = 240; 
IMG_WIDTH = 376 ; 

Image(IMG_HIGH,IMG_WIDTH) = uint8(0);

%�������������bmp���ݣ��������Ƿ���
if exist('cameraReceiver','var')
    %ģ��ӻ�����ȡ����
    [IMG_BUF_HIGH,IMG_BUF_WIDTH] = size(cameraReceiver);
    %ת����C�е�ַ����ʽ
    fullCameraBufferAddr(IMG_BUF_HIGH*IMG_BUF_WIDTH) = uint8(0);
    for i = 1:IMG_BUF_HIGH
        fullCameraBufferAddr(IMG_BUF_WIDTH*(i-1)+1:IMG_BUF_WIDTH*i) = cameraReceiver(i,:);
    end

    %���ӻ�������ַȡ��ͼ��
    for i = 1:IMG_HIGH
        for j = 1:IMG_WIDTH
            if i==1 || i==IMG_HIGH ||j==1 || j==IMG_WIDTH
                 Image(i,j) = fullCameraBufferAddr( (i-1)*IMG_WIDTH+j );
            else
                 Image(i,j) = ...
                      fullCameraBufferAddr( (i-1-1)*IMG_WIDTH+j-1 )/9 +  fullCameraBufferAddr( (i-1-1)*IMG_WIDTH+j )/9 +  fullCameraBufferAddr( (i-1-1)*IMG_WIDTH+j+1 )/9 +...
                      fullCameraBufferAddr( (i-1)*IMG_WIDTH+j-1 )/9 +  fullCameraBufferAddr( (i-1)*IMG_WIDTH+j )/9 +  fullCameraBufferAddr( (i-1)*IMG_WIDTH+j+1 )/9 +...
                      fullCameraBufferAddr( (i-1+1)*IMG_WIDTH+j-1 )/9 +  fullCameraBufferAddr( (i-1+1)*IMG_WIDTH+j )/9 + fullCameraBufferAddr( (i-1+1)*IMG_WIDTH+j+1 )/9;
            end
        end
    end
    
end
subplot(2,2,2);
imshow(Image);

%�������������txt���ݣ��������Ƿ���
if exist('bin_image','var')
    
	image_data_length = size(bin_image);
    frame_size = IMG_HIGH*IMG_WIDTH/8;
    %��������    dec2hex(image(1))    dec2hex(abs(a(1)))
    ImageByteCount = 1;
    %֡ͷ�ж� 0x55 0x55
    if hex2dec('55') == bin_image(ImageByteCount) && hex2dec('55') == bin_image(ImageByteCount+1)
        ImageByteCount = ImageByteCount + 2; %����֡ͷ
        for high = 0:6                     %�������ĸ߶ȳ�8
            for j = 1:IMG_WIDTH        %�������ӣ��������Ŀ��
                for i = 1:8         %ת��һ���ֽ�
                    PixleTemp = bitget(abs(bin_image(ImageByteCount)),i) * 255;
                    Image(i+high*8,j) = PixleTemp;
                end
                ImageByteCount = ImageByteCount + 1;
            end
        end
    end
end


%%%%%%%%�յ���ͼ���Ѿ����뵽��Image������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 subplot(2,2,1);
 imshow(Image);
 title('ԭʼͼ��');


 
%/* ����������Ϣ */
midline(IMG_HIGH)   = int16(0);
leftline(IMG_HIGH)    = int16(0);
rightline(IMG_HIGH) = int16(0);


%����У��ǰ��Ԥ��������򵥵� ����ҳ��Զ�
mid = int16(IMG_WIDTH/2);
for i = IMG_HIGH:-1:1
	leftline(i) = 1;
    for j = mid:-1:1       %�������
            if Image(i,j) == 0
                leftline(i) = j;
                break
            end
    end

    rightline(i) = IMG_WIDTH;
    for j = mid:IMG_WIDTH   %���ұ���
         if Image(i,j) == 0
            rightline(i) = j;
            break
         end  
    end

    mid = uint16((leftline(i)+rightline(i))/2);

    if leftline(i) == rightline(i)
        midline(i) = -1;    %%��Ч�������Ѿ�Ѱ�ҽ���  ���ߺͱ��߽���
    else
        midline(i) = mid;       
    end
    
end


%��б��
% 1.ѡ��Ƚϳ��ı�����Ϊб�ʵĲο���
%     --1 �ҳ���·�Ĺ�ϵ
%��һ������ ��ͨ���Ƚ������Ҳ������߽�����Ұ�Ľ�������
% for i = IMG_HIGH:-1:1
%     if leftline(i) ~= 1
%         leftbound = i;
%         break;
%     end
% end
% 
% for i = IMG_HIGH:-1:1
%     if rightline(i) ~= IMG_WIDTH
%         rightbound = i;
%         break;
%     end
% end

%�ڶ������� ��ֱ�ӱȽ�����ͷ�е��Ԥ�����õ��е㡣
if midline(IMG_HIGH/8*3) < int16(IMG_WIDTH/2)   %�Ƚ��м俿�Կ��ϵĵ�
    disp('·���󣬳�����');
    %ѡ�Ҳ��߶��ж�·������
    k1 = rightline(8) - rightline(16);
    k2 = rightline(16) - rightline(24); 
end

if midline(IMG_HIGH/8*3) > int16(IMG_WIDTH/2)   %�Ƚ��м俿�Կ��ϵĵ�
    disp('·���ң�������');
    k1 = leftline(8) - leftline(16);       
    k2 = leftline(16) - leftline(24);
end
    deltaK = k1 - k2;
    
   %�����Զ����б��k1,������б��k2,����б�ʵı仯��deltaK
   if deltaK >= -3 && deltaK <= 3
       roadfalg = 1;
       disp('ֱ��');
   else
       disp('���');
       if k1 < 0
           roadfalg = 2;
           disp('����');
       else
           roadfalg = 2;
           disp('����');
       end
   end 
    
   % k1,k2,deltaK



%imcolorshow









