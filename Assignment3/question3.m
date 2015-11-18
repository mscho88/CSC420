% Depth Intrinsic Parameters
fx_d = 5.8262448167737955e+02;
fy_d = 5.8269103270988637e+02;
px_d = 3.1304475870804731e+02;
py_d = 2.3844389626620386e+02;

% Rotation
R = -[ 9.9997798940829263e-01, 5.0518419386157446e-03, ...
    4.3011152014118693e-03, -5.0359919480810989e-03, ...
    9.9998051861143999e-01, -3.6879781309514218e-03, ...
    -4.3196624923060242e-03, 3.6662365748484798e-03, ...
    9.9998394948385538e-01 ];

R = reshape(R, [3 3]);
R = inv(R');

% 3D Translation
t_x = 2.5031875059141302e-02;
t_z = -2.9342312935846411e-04;
t_y = 6.6238747008330102e-04;
 load('rgbd.mat');
[x, y] = meshgrid(1:640, 1:480);

Z = depth;
X = (x - px_d).*Z / fx_d;
Y = (y - py_d).*Z / fy_d;

surf(double(-X), double(-Y), double(Z),'Cdata', double(im) / 255, 'EdgeColor', 'none');

[laY laX] = find(labels == 4);
gap = zeros(1, 3);
v = 0;
tt = 0;
for i = 1 : size(laY, 1)
    gap(1) = gap(1) + X(laY(i), laX(i));
    gap(2) = gap(2) + Y(laY(i), laX(i));
    gap(3) = gap(3) + Z(laY(i), laX(i));
    k = R * [X(laY(i), laX(i)) Y(laY(i), laX(i)) Z(laY(i), laX(i))]';
    t = R * [t_x, t_y, t_z]';
    v = v + k(2);
    tt = tt + t(2);
end;

gap(1) = gap(1) / size(laY, 1); % xgap
gap(2) = gap(2) / size(laY, 1); % ygap
gap(3) = gap(3) / size(laY, 1); % zgap

how_far_it_is = sqrt(gap(1)^2 + gap(2)^2 + gap(3)^2)

height = v / size(laY, 1) - tt / size(laY, 1)
