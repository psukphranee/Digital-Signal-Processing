function h = rectfilt(N, wc)
    window.data = ones(1, N);
    window.offset = -(N-1)/2;
    
    w = linspace(-pi, pi, 13);

    h = dtft()
end