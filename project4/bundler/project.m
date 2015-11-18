bundle_out = fileread('./bundle/bundle.init.out');
bundle_out = strsplit(bundle_out, {'\n'});

element = bundle_out(2);
num_camera = strsplit(element{1}, {' '});
num_points = str2num(num_camera{2});
num_camera = str2num(num_camera{1});

bundle_out = bundle_out(1, 3:size(bundle_out, 2) - 1);


i = 1;
while i <= size(bundle_out, 2)
%for i = 1:interval:size(bundle_out, 2)
    if i >= 1 & i <= num_camera * 5
        % Cameras (5 lines)
        arow1 = strsplit(bundle_out{i}, {' '});
        arow2 = strsplit(bundle_out{i+1}, {' '});
        arow3 = strsplit(bundle_out{i+2}, {' '});
        arow4 = strsplit(bundle_out{i+3}, {' '});
        arow5 = strsplit(bundle_out{i+4}, {' '});
        temp.('fk1k2') = arow1;
        temp.('R') = [arow2; arow3; arow4];
        temp.('t') = arow5;
        
        cameras.(strcat('camera', int2str(floor(i / 5) + 1))) = temp;
        i = i + 5;
    else
        % Points (3 lines)
        arow1 = strsplit(bundle_out{i}, {' '});
        arow2 = strsplit(bundle_out{i+1}, {' '});
        arow3 = strsplit(bundle_out{i+2}, {' '});
        
        temp1.('position') = arow1;
        temp1.('color') = arow2;
        temp1.('viewlist') = arow3;
        
        points.(strcat('point', int2str(floor((i - (num_camera * 5)) / 3) + 1))) = temp1;
        i = i + 3;
    end
end

X = [];
Y = [];
Z = [];
C = [];
for i = 1: num_points
    point = points.(strcat('point', int2str(i)));
	x = str2num(point.position{1});
	y = str2num(point.position{2});
    z = str2num(point.position{3});
    R = str2num(point.color{1}) / 256;
    G = str2num(point.color{2}) / 256;
    B = str2num(point.color{3}) / 256;
    if ~(x == 0) | ~(y == 0) | ~(z == 0)
        X = [X, x];
        Y = [Y, y];
        Z = [Z, z];
        temp = [R, G, B];
        C = [C; temp];
    end
end

scatter3(X, Y, Z, 25, C, 'filled');