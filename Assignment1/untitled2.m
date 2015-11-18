im0 = imread('waldo.png'); 
filter = fspecial('gaussian', [3 3], 1.0);
g = imfilter(im, filter); 
imshow(g)

im1 = imresize(im0, .5);
g1 = imfilter(im1, filter);
figure, imshow(g1)

im2 = imresize(im1, .5);
g2 = imfilter(im2, filter);
figure, imshow(g2)

im3 = imresize(im2, .5);
g3 = imfilter(im3, filter);
figure, imshow(g3)