function y = dtft(x, w)
% DTFT Evaluate the DTFT of Matlab structure x, at radial frequencies
% given by double array w. Return a double array, y.
    lenX = length(x.data);
    n = (x.offset:(lenX + x.offset - 1))';
    Q = n .* w;
    y = x.data * exp(-1j * Q);
end