function h = kaiserfilt(N, wc, beta)

    n = (-(N-1)/2:(N-1)/2)';
    h_ideal = (wc/pi)*sinc(wc*n);

    w = kaiser(N, beta);
    
    h = h_ideal.*w;
    h = h/sum(h);

end