function h = hammingfilt(N, wc)

    n = (-(N-1)/2:(N-1)/2)';
    h_ideal = (wc/pi)*sinc(wc*n);

    w = 0.54+0.46*cos(2*pi*n/(N-1));
    %w = hamming(N);

    h = h_ideal .* w;
    h = h/sum(h);

end