function out = convWithoutSep()
    % 2.c convolution without separable
    im = im2double(imread('lena.png'));
    filter = fspecial('gaussian', [3 3], 1.0);
    tic; result = conv2(im, filter); toc
    imshow(result);
end

function out = convWithSep()
    % 2.d convolution with separable
    im = im2double(imread('lena.png'));
    filter = fspecial('gaussian', [3 3], 1.0);
    K1 = U(:,1) * sqrt(S(1,1));
    K2 = V(:,1)' * sqrt(S(1, 1));
    tic; result2 = conv2(K1, K2, im); toc
    figure, imshow(result2)
end

function out = magGrad()
    % 3.a magnitude of gradients
    im=rgb2gray(imread('waldo.png'));
    Iy = imfilter(double(im), fspecial('sobel'));
    Ix = imfilter(double(im), fspecial('sobel')');
    gradmag = sqrt(Ix.^2 + Iy.^2);
    figure, imshow(uint8(gradmag))
end

function out = localize()
    im = rgb2gray(imread('waldo.png'));
    filter = imread('template.png');
    
    Iy = imfilter(double(im), fspecial('sobel'));
    Ix = imfilter(double(im), fspecial('sobel')');
    gradmag = sqrt(Ix.^2 + Iy.^2);
    im = uint8(gradmag);
    
    Iy = imfilter(double(filter), fspecial('sobel'));
    Ix = imfilter(double(filter), fspecial('sobel')');
    gradmag = sqrt(Ix.^2 + Iy.^2);
    filter = uint8(gradmag);
    
    result = im;
    filter = double(rgb2gray(filter))/sqrt(sum(sum(double(rgb2gray(filter)).^2)));

    out = normxcorr2(filter, im);

    [y,x] = find(out == max(out(:)));
    y = y(1) - size(filter, 1) + 1;
    x = x(1) - size(filter, 2) + 1;

    figure, imshow(result)
    rectangle('position', [x,y,size(filter,2),size(filter,1)], 'edgecolor', [0.1,0.2,1], 'linewidth', 3.5);
end

function out = imagePyramid()
    % 3.c Gaussian Filter
    filter = fspecial('gaussian', [3 3], 1.0);

    % Original Image
    im0 = imread('waldo.png'); 
    g = imfilter(im0, filter); 
    figure, imshow(g)

    im1 = imresize(im0, .5);
    g1 = imfilter(im1, filter);
    figure, imshow(g1)

    im2 = imresize(im1, .5);
    g2 = imfilter(im2, filter);
    figure, imshow(g2)

    im3 = imresize(im2, .5);
    g3 = imfilter(im3, filter);
    figure, imshow(g3)

end

function out = magGrad5()
    im=rgb2gray(imread('Broadway_tower.jpg'));
    Iy = imfilter(double(im), fspecial('sobel'));
    Ix = imfilter(double(im), fspecial('sobel')');
    gradmag = sqrt(Ix.^2 + Iy.^2);
    figure, imshow(uint8(gradmag))
end