function h = rectfilt(N, wc)
    
    w = ones(N, 1);
    %w2 = rectwin(N);

    n = -(N-1)/2:(N-1)/2;
    h_ideal = (wc/pi)*sinc(wc*n);
    h = h_ideal/sum(h_ideal);

end