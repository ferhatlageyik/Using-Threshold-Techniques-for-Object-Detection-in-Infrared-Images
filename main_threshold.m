clc; clear all; close all;

Img = imread ('pic7.png');
figure,imshow(Img),title('orgIMG')
Img = rgb2gray(Img);
[x y]=size(Img);
level=0.2137;  % min threshold value 
Img= reshape(Img,x,y);
OM=imbinarize(Img,level);  %before threshold adjustment 
figure, imshow(OM),title('before th. adjustment') 
A=x*y/2.9;     % K1 in ge�memesi gereken s�n�r piksel say�s�
    

K1=0;    % K1 en b�y�k nesnenin sahip olabilece�i max piksel say�s�
   bool=true;
   while(bool) %en geni� objenin piksel say�s�n�, threshold de�erini artt�rarak A say�s�n�n alt�na �ekmek
        OB=imbinarize(Img,level);  % OB (otsu metodla binarize edilen g�r�nt� )
         level=level+0.03;
      [L,num]=bwlabel(OB);      % num ka� tane obje var onu tutuyor , L ise integer map
      K1=0;
      for n=1:1:num
         count=0; 
         
         for i=1:1:x
              for j=1:1:y
                if n == L(i,j)
                count=count+1;
                end
              end
           end
               if count>K1
                 K1=count;              
               end
       end
      
       if(K1<A)
          bool=false;
       end
   end

figure, imshow(OB),title('after th.adjustment')

  F=zeros(x,y);
  C=zeros(x,y);
  CMB=zeros(x,y);
ALT=zeros(x,y); %ALT(after local thresholding)
s1=150;      %s1-B ilgilendi�im nesnelerin boyut aral���
B=1000;      %B-A local threshold uygulanacak nesnelerin boyut aral���
A=x*y/20;
for m=1:1:num % ilgili boyuttaki nesneleri almak  
    count=0;
    for i=1:1:x
        for j=1:1:y
            if m==L(i,j)
                count=count+1;
            end
        end
    end  %hangi nesne ne kadar piksel say�s�na sahip
    if count<s1  %g�r�lt�leri s�f�ra �ek
        for i=1:1:x
          for j=1:1:y
             if L(i,j) == m
                 C(i,j)=0;
             end
           end
        end
    elseif count>s1 && count<B %istenilen boyut aral���ndaki nesneleri alma
             for i=1:1:x
               for j=1:1:y
                 if L(i,j) == m
                 C(i,j)=1;
                 end
           end
        end
    elseif count<A && count>B % local threshold i�in ayr�lan b�lge
        ALT=Locathresholding(Img);
              for i=1:1:x
               for j=1:1:y
                 if L(i,j)== m
                 F(i,j)=ALT(i,j);
                 end
               end
              end
    else  %piksel say�s� s�n�r de�erinden b�y�k olan yerleri s�f�ra �ek
          
            for i=1:1:x
                   for j=1:1:y
                       if L(i,j)==m
                       C(i,j)=0;
                       end
                   end
               end  
    end
end
CMB=C+F;
figure,imshow(C),title('temel grup')
figure,imshow(F),title('local')
figure,imshow(ALT),title('LTHusingintegralimage')
figure,imshow(CMB),title('combined method')
