function y = mag_phase(x)
% MAG_PHASE Input argument is a structure with x.real and x.imag
% Return values are y.mag (magnitude) and y.phase (phase in radians)
tempVal = x.real .^ 2 + x.imag .^ 2;
y.mag  = sqrt(tempVal);
y.phase = atan2(x.imag,x.real);
end