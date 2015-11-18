function question2(imageR, descripsR, locsR, imageT, descripsT, locsT)
    NUM_LINE = 10;
    threshold = 60 * size(imageT, 1) / size(imageR, 1) * size(imageT, 2) / size(imageR, 2);

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
    figure, imshow(im)

    %figure, imshow(im);
    [max_val, ind] = max(ratio(1, :));
    % The fifth row is meant to show whether the points of the match is
    % inlier or not.
    drawn = zeros(5, NUM_LINE);
    j = 1;
    color = 'r';
    while j ~= NUM_LINE + 1
        [min_rat1, min_ind1] = min(ratio(1, :));
        %locsT(ratio(3, min_ind1), 2)+size(imageR, 2)
        if(~(ismember(locsT(ratio(3, min_ind1), 2)+size(imageR, 2), drawn(3, :)) && ismember(locsT(ratio(3, min_ind1), 1), drawn(4, :))))
            drawn(1, j) = locsR(ratio(2, min_ind1), 2);
            drawn(2, j) = locsR(ratio(2, min_ind1), 1);
            drawn(3, j) = locsT(ratio(3, min_ind1), 2)+size(imageR, 2);
            drawn(4, j) = locsT(ratio(3, min_ind1), 1);
            if j > 3
                color = 'b';
            end
            % Question 2 (a)
            line([locsR(ratio(2, min_ind1), 2) locsT(ratio(3, min_ind1), 2)+size(imageR, 2)], ...
                 [locsR(ratio(2, min_ind1), 1) locsT(ratio(3, min_ind1), 1)], 'Color', color);
            j = j + 1; 
        end
        ratio(1, min_ind1) = max_val;
    end
    
    % Question 2 (b)
    tform = maketform('affine',[drawn(1, 1:3)', drawn(2, 1:3)'], [drawn(3, 1:3)', drawn(4, 1:3)']);
    imw = imtransform(imageR, tform, 'bicubic', 'fill', 0);
    
    % Question 2 (c)
    P = [drawn(1, 1), drawn(2, 1), 0, 0, 1, 0;
        0, 0, drawn(1, 1), drawn(2, 1), 0, 1;
        drawn(1, 2), drawn(2, 2), 0, 0, 1, 0;
        0, 0, drawn(1, 2), drawn(2, 2), 0, 1;
        drawn(1, 3), drawn(2, 3), 0, 0, 1, 0;
        0, 0, drawn(1, 3), drawn(2, 3), 0, 1];
    T = [drawn(3, 1); drawn(4, 1); drawn(3, 2); drawn(4, 2); drawn(3, 3); drawn(4, 3)];
    transfer = inv(P' * P) * P' * T;

    num_inlier = 0;
    for k = 1 : size(drawn, 2)
        xs = drawn(1, k);
        ys = drawn(2, k);
        target_points = [xs, ys, 0, 0, 1, 0; 0, 0, xs, ys, 0, 1] * transfer;
        xt1 = target_points(1);
        yt1 = target_points(2);
        xt2 = drawn(3, k);%-size(imageR, 2);
        yt2 = drawn(4, k);
        distance = sqrt((xt2 - xt1)^2 + (yt2 - yt1)^2);
        if(distance < threshold)
            num_inlier = num_inlier + 1;
        end
    end
    num_inlier
    
    % Question 2 (d)
    P = [1, 1, 0, 0, 1, 0;
        0, 0, 1, 1, 0, 1;
        size(imageR, 2), 1, 0, 0, 1, 0;
        0, 0, size(imageR, 2), 1, 0, 1;
        size(imageR, 2), size(imageR, 1), 0, 0, 1, 0;
        0, 0, size(imageR, 2), size(imageR, 1), 0, 1;
        1, size(imageR, 1), 0, 0, 1, 0;
        0, 0, 1, size(imageR, 1), 0, 1];
    result = P * transfer;

    [result(1, 1) result(3, 1)]
    line([result(1, 1)-size(imageR, 2) result(3, 1)-size(imageR, 2)], ...
         [result(2, 1) result(4, 1)], 'Color', 'y');
    line([result(3, 1)-size(imageR, 2) result(5, 1)-size(imageR, 2)], ...
         [result(4, 1) result(6, 1)], 'Color', 'y');
    line([result(5, 1)-size(imageR, 2) result(7, 1)-size(imageR, 2)], ...
         [result(6, 1) result(8, 1)], 'Color', 'y');
    line([result(7, 1)-size(imageR, 2) result(1, 1)-size(imageR, 2)], ...
         [result(8, 1) result(2, 1)], 'Color', 'y');
     
    figure, imshow(imw)

end