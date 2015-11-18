delete('tmp.key')
[imageR, descripsR, locsR]=sift('reference.pgm');
delete('tmp.key')
[imageT, descripsT, locsT]=sift('test.pgm');

% 2.(a) This question is basically finding the first 100 keypoints of two
% different images. The 100 keypoints can be used to solve the furthure
% questions. 
showkeys(imageR, locsR)
showkeys(imageT, locsT)

% 2.(b)

% Finds the difference between two vectors (this function is given from the
% instructor)
M = dist2(descripsR, descripsT);

% Combine two images
im = appendimages(imageR,imageT);
figure, imshow(im);

% For each row in the matrix from dist2 function, find the smallest and the
% second smallest values for each row and save the ratios and the indices.
ratio = zeros(4, size(M, 1))
for i = 1 : size(M, 1)
    aRow = M(i, :);
    [min_val1, min_ind1] = min(aRow);
    aRow(min_ind1) = max(aRow);
    [min_val2, min_ind2] = min(aRow);
    ratio(1, i) = min_val1 / min_val2;
    ratio(2, i) = i;
    ratio(3, i) = min_ind1;
    ratio(4, i) = min_ind2;
end

% Find the three smallest ratios from the matrix I have calculated before.
[min_rat1, min_ind1] = min(ratio(1, :));
ratio(1, min_ind1) = max(ratio(1, :));
[min_rat2, min_ind2] = min(ratio(1, :));
ratio(1, min_ind2) = max(ratio(1, :));
[min_rat3, min_ind3] = min(ratio(1, :));
ratio(1, min_ind3) = max(ratio(1, :));

% Draw the three lines that match
figure, imshow(im)
line([locsR(ratio(2, min_ind1), 2) locsT(ratio(3, min_ind1), 2)+size(imageR, 2)], ...
         [locsR(ratio(2, min_ind1), 1) locsT(ratio(3, min_ind1), 1)], 'Color', 'y');
line([locsR(ratio(2, min_ind2), 2) locsT(ratio(3, min_ind2), 2)+size(imageR, 2)], ...
         [locsR(ratio(2, min_ind2), 1) locsT(ratio(3, min_ind2), 1)], 'Color', 'r');
line([locsR(ratio(2, min_ind3), 2) locsT(ratio(3, min_ind3), 2)+size(imageR, 2)], ...
         [locsR(ratio(2, min_ind2), 1) locsT(ratio(3, min_ind3), 1)], 'Color', 'c');
     
% 2.(c)
P = [locsR(ratio(2, min_ind1), 2), locsR(ratio(2, min_ind1), 1), 0, 0, 1, 0;
    0, 0, locsR(ratio(2, min_ind1), 2), locsR(ratio(2, min_ind1), 1), 0, 1;
    locsR(ratio(2, min_ind2), 2), locsR(ratio(2, min_ind2), 1), 0, 0, 1, 0;
    0, 0, locsR(ratio(2, min_ind2), 2), locsR(ratio(2, min_ind2), 1), 0, 1;
    locsR(ratio(2, min_ind3), 2), locsR(ratio(2, min_ind3), 1), 0, 0, 1, 0;
    0, 0, locsR(ratio(2, min_ind3), 2), locsR(ratio(2, min_ind3), 1), 0, 1];
T = [locsT(ratio(3, min_ind1), 2), locsT(ratio(3, min_ind1), 1), locsT(ratio(3, min_ind2), 2), locsT(ratio(3, min_ind2), 1), locsT(ratio(3, min_ind3), 2), locsT(ratio(3, min_ind3), 1)];
transform = inv(P)*T'

imshow(imtransform(imageR, transform))