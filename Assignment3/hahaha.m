delete('tmp.key');
[iR, dR, lR] = sift('toy.pgm');
delete('tmp.key');
[iT, dT, lT] = sift('01.pgm');
fprintf('Image 01.pgm\n');
question2(iR, dR, lR, iT, dT, lT)
