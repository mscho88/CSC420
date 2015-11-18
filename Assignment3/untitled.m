I = imread('toy.pgm');
J = imread('01.pgm');

[F1 D1] = vl_sift(I);
[F2 D2] = vl_sift(J);

[matches score] = vl_ubcmatch(D1,D2,1.5);
subplot(1,2,1);
imshow(uint8(I));
hold on;
plot(F1(1, matches(1, :)), F1(2, matches(1, :)), 'b*');
subplot(1, 2, 2);
imshow(uint8(J));
hold on;
plot(F2(1, matches(2, :)), F2(2, matches(2, :)), 'r*');