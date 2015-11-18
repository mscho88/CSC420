function bill_reader(annotate_pts)
if nargin < 1
    annotate_pts = 0;
end;
im = imread('shoe.jpg');

if annotate_pts
   imshow(im);
   disp('click on the four corners of the screen. Double click the last point');
   [x,y] = getpts();
   close all;
   imshow(im);
else
   % The points of the shoe is calculated by the code from the tutorial.
   x = [756.7643, 992.1645, 311.4530, 2.5839]';
   y = [221.7, 274.1, 1016.3, 774.9]';
end;

shoeWid = sqrt((x(1) - x(2))^2 + (y(1) - y(2))^2);
shoeHei = sqrt((x(2) - x(3))^2 + (y(2) - y(3))^2);
% The points of the bill is calculated by the code from the tutorial.
xBill = [1067.1, 1367.0, 1164.6, 774.8]';
yBill = [511.0, 584.8, 1130.3, 981.8]';
xx = 698.5/sqrt((xBill(1) - xBill(2))^2 + (yBill(1) - yBill(2))^2);
yy = 1524/sqrt((xBill(2) - xBill(3))^2 + (yBill(2) - yBill(3))^2);

figure('position', [100,100,size(im,2)*0.3,size(im,1)*0.3]);
subplot('position', [0,0,1,1]);
imshow(im);
hold on;
plot([xBill(:); xBill(1)], [yBill(:); yBill(1)], '-o', 'linewidth', 2, 'color', [1,0.1,0.1], 'Markersize', 10, 'markeredgecolor', [0,0,0], 'markerfacecolor', [0.5,0.0,1])
plot([x(:); x(1)], [y(:); y(1)], '-o', 'linewidth', 2, 'color', [1,0.1,0.1], 'Markersize', 10, 'markeredgecolor', [0,0,0], 'markerfacecolor', [0.5,0.0,1])

% Scale the actual size of the five dollar bill into pixel units
width = round(xx*shoeWid)
height = round(yy*shoeHei)

x2 = [1, width, width, 1]';
y2 = [1, 1, height, height]';

tform = maketform('projective',[x,y],[x2,y2]);

[imrec] = imtransform(im, tform, 'bicubic',...
    'xdata', [1,max(x2)],...
    'ydata', [1,max(y2)],...
    'size', [max(y2), max(x2)],...
    'fill', 0);
figure('position', [150,150,size(imrec,2)*0.6,size(imrec,1)*0.6]);
subplot('position', [0,0,1,1]);
imshow(imrec)
end