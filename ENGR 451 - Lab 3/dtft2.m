function y = dtft2(x, w)
% DTFT2 Evaluate the DTFT of Matlab structure x at frequencies given
% by array w. Return values are a structure with
% y.real (real part) and y.imag (imaginary part)

lenX = length(x.data);
n = (x.offset:(lenX + x.offset - 1))';
Q = n .* w;
X = x.data * exp(-1j * Q);
y.real = real(X);
y.imag = imag(X);
end