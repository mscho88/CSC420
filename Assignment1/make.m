
I=imread('Broadway_tower.jpg');
[rmax, cmax, tmp] = size(I);
I = rgb2gray(double(I));
Iy = imfilter(I, fspecial('sobel'));
Ix = imfilter(I, fspecial('sobel')');
Gimg = sqrt(Ix.^2 + Iy.^2);


%I = rgb2gray(im);%/255;
%img = rgb2gray(img);
%[Ix,Iy]=gradient(img);
%Gimg=Ix+Iy;
%Gimg=abs(Gimg);

%calculating sum of pixels value in each column
test2=zeros(rmax,cmax);
for row = 1 :rmax
    for col = 1:cmax
        if row == 1
            test2(row,col)=Gimg(row,col);
        end
        if row>1
            if col ==1
                tmp=[test2(row-1,col),test2(row-1,col+1)];
                test2(row,col)= Gimg(row,col)+min(tmp);
            end
            if col>1 && col<cmax
                tmp1=[test2(row-1,col),test2(row-1,col+1),test2(row-1,col-1)];
                test2(row,col)= Gimg(row,col)+min(tmp1);
            end
            if col == cmax
                tmp2=[test2(row-1,col),test2(row-1,col-1)];
                test2(row,col)= Gimg(row,col)+min(tmp2);
            end
        end
    end
end
minval=min(test2(rmax,:));
locations=find(test2(rmax,:)==minval);
[x,y]=size(locations);
%back traking to find the seam
for loc=1:y
    j = locations(1,loc);
    for row=rmax:-1:1
        if row==rmax
            I(row,j,1)=255;
            I(row,j,2)=0;
            I(row,j,3)=0;
        end
        if row < rmax
            if j==1
                tmp=[test2(row+1,j),test2(row+1,j+1)];
                [C,index]=min(tmp);
                if index==1
                    I(row+1,j,1)=255;
                    I(row+1,j,2)=0;
                    I(row+1,j,3)=0;
                end
                if index==2
                    I(row+1,j+1,1)=255;
                    I(row+1,j+1,2)=0;
                    I(row+1,j+1,3)=0;
                    j=j+1;
                end
            end
            if j>1 && j<cmax
                tmp1=[test2(row+1,j),test2(row+1,j+1),test2(row+1,j-1)];
                [C,index]=min(tmp1);
                if index==1
                    I(row+1,j,1)=255;
                    I(row+1,j,2)=0;
                    I(row+1,j,3)=0;
                end
                if index==2
                    I(row+1,j+1,1)=255;
                    I(row+1,j+1,2)=0;
                    I(row+1,j+1,3)=0;
                    j=j+1;
                end
                if index==3
                    I(row+1,j-1,1)=255;
                    I(row+1,j-1,2)=0;
                    I(row+1,j-1,3)=0;
                    j=j-1;
                end
            end
            if j == cmax
                tmp2=[test2(row+1,j),test2(row+1,j-1)];
                [C,index]=min(tmp2);
                if index==1
                    I(row+1,j,1)=255;
                    I(row+1,j,2)=0;
                    I(row+1,j,3)=0;
                end
                if index==2
                    I(row+1,j-1,1)=255;
                    I(row+1,j-1,2)=0;
                    I(row+1,j-1,3)=0;
                    j=j-1;
                end
            end
        end
    end
end
figure, imshow(I);