
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

%R = reshape(R, [3 3]);
%R = inv(R');

% 3D Translation
t_x = 2.5031875059141302e-02;
t_z = -2.9342312935846411e-04;
t_y = 6.6238747008330102e-04;

load('rgbd.mat');

[x, y] = meshgrid(1:640, 1:480);

Z = depth;
X = (x - px_d) .* Z / fx_d;
Y = (y - py_d) .* Z / fy_d;

%x,y,z average. sqrt(x.^2 + y.^2 + z.^2)
%Pw = R-1*Pc - R-1*T = [u,v,w]'

surf(double(-X), double(-Y), double(Z), 'Cdata', double(im)/255 , 'EdgeColor', 'none')

colormap hsv
colorbar

