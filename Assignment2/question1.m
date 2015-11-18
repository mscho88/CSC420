original=imread('building.jpg');
im=double(rgb2gray(original));

% (a.1) Computing Ix2, Iy2 and IxIy
Ix = imfilter(im, fspecial('sobel')');
Iy = imfilter(im, fspecial('sobel'));
IxIy = imfilter(Ix, fspecial('sobel'));
imshow(uint8(Ix.^2));
figure, imshow(uint8(Iy.^2));
figure, imshow(uint8(IxIy));

% (a.2) Computing the matrix M and apply it to the image
[width, height] = size(im);
M = zeros(2, 2);
R = zeros(width, height);
Rmax = 0;
Ix = Ix.^2;
Iy = Iy.^2;
for i = 1:1:width
    for j = 1:1:height
        % (a.2) the matrix M in each pixel
        M = [Ix(i,j), IxIy(i,j); IxIy(i,j), Iy(i,j)];
        % (c) Computing R in each pixel
        R(i,j) = det(M) - 0.04 * (trace(M))^2; 
        if R(i,j) > Rmax
            Rmax = R(i,j); 
        end
    end
end
figure, imshow(uint8(R));

% (d) finding the corners of the image
result = zeros(width, height);

for i = 2:width-1
    for j = 2:height-1
        % Compare the adjacent pixel of the image and store the value 1 to
        % consider the pixel as an corner
        if R(i,j) > 0.01 * Rmax && R(i,j) > R(i - 1,j - 1) && R(i,j) > R(i - 1,j) && R(i,j) > R(i - 1,j + 1) && R(i,j) > R(i,j - 1) && R(i,j) > R(i,j + 1) && R(i,j) > R(i + 1,j - 1) && R(i,j) > R(i + 1,j) &&R(i,j) > R(i + 1,j + 1)
            result(j, i) = 1;
        end
    end
end

[X, Y] = find(result == 1);
figure, imshow(original);
hold on;
plot(X, Y, '+R');