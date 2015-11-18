function q2b(imageR, descripsR, locsR, imageT, descripsT, locsT)
    NUM_LINE = ;

    M = dist2(descripsR, descripsT);

    im = appendimages(imageR,imageT);

    ratio = zeros(4, size(M, 1));
    for i = 1 : size(M, 1)
        aRow = M(i, :);
        [min_val1, min_ind1] = min(aRow);
        [max_val, ind] = max(aRow);
        aRow(min_ind1) = max_val;
        [min_val2, min_ind2] = min(aRow);
        
        if(min_val2 == 0)
            ratio(1, i) = max;
        else
            ratio(1, i) = min_val1 / min_val2;
        end
        ratio(2, i) = i;
        ratio(3, i) = min_ind1;
        ratio(4, i) = min_ind2;
    end

    figure, imshow(im);
    [max_val, ind] = max(ratio(1, :));
    drawn = zeros(2, 10);
    j = 1;
    while j ~= NUM_LINE + 1
        [min_rat1, min_ind1] = min(ratio(1, :));
        if(~(ismember(locsT(ratio(3, min_ind1), 2)+size(imageR, 2), drawn(1, :)) && ismember(locsT(ratio(3, min_ind1), 1), drawn(2, :))))
            drawn(1, j) = locsT(ratio(3, min_ind1), 2)+size(imageR, 2);
            drawn(2, j) = locsT(ratio(3, min_ind1), 1);
        
            line([locsR(ratio(2, min_ind1), 2) locsT(ratio(3, min_ind1), 2)+size(imageR, 2)], ...
                 [locsR(ratio(2, min_ind1), 1) locsT(ratio(3, min_ind1), 1)], 'Color', 'r');
            j = j + 1; 
        end
        ratio(1, min_ind1) = max_val;
    end

    % Find the three smallest ratios from the matrix I have calculated before.
    figure, imshow(im);
    [max_val, ind] = max(ratio(1, :));

    x1 = zeros(3, 1);
    y1 = zeros(3, 1);
    x2 = zeros(3, 1);
    y2 = zeros(3, 1);
    for j = 1 : 3
        [min_rat1, min_ind1] = min(ratio(1, :));
        x1(j) = locsR(ratio(2, min_ind1), 2)
        y1(j) = locsR(ratio(2, min_ind1), 1)
        x2(j) = locsT(ratio(3, min_ind1), 2)+size(imageR, 2)
        y2(j) = locsT(ratio(3, min_ind1), 1)
%        line([locsR(ratio(2, min_ind1), 2) locsT(ratio(3, min_ind1), 2)+size(imageR, 2)], ...
%             [locsR(ratio(2, min_ind1), 1) locsT(ratio(3, min_ind1), 1)], 'Color', 'r');
        ratio(1, min_ind1) = max_val;
    end

    tform = maketform('affine',[x1,y1],[x2,y2]);
    imw = imtransform(imageR, tform, 'bicubic', 'fill', 0);
%    [imrec] = imtransform(im, tform, 'bicubic',...
%    'xdata', [1,max(x2)],...
%    'ydata', [1,max(y2)],...
%    'size', [max(y2), max(x2)],...
%    'fill', 0);
%    figure('position', [150,150,size(imrec,2)*0.6,size(imrec,1)*0.6]);
%    subplot('position', [0,0,1,1]);
    imshow(imw)
    ransac(
    
end