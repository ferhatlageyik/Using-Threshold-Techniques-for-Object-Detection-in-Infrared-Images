function BinImgALT = Locathresholding(Img)

[x y]=size(Img);
g=integralImage(Img);
g =g(2:end,2:end); %crop

BinImgALT=zeros(x,y);
w=5;
k=-0.0001;
d=round(w/2);
LMD=ones(w,w); %local mean deviation

for i=d+1:d:x-d
   for j=d+1:d:y-d
    s=(g(i+d-1,j+d-1)+g(i-d,j-d))-(g(i-d,j+d-1)+g(i+d-1,j-d));  %local mean  
    m=s/(w*w);  %arithmetic mean
    LMD=Img(i-d:i+d-1,j-d:j+d-1)-m;
     % BinImgALT(i-d:i+d-1,j-d:j+d-1)=m*(1+k*((LMD/1-LMD)-1));
     BinImgALT(i-d:i+d-1,j-d:j+d-1)=LMD;
    end
end

end