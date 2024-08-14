function fplot(b,a)
    
    N = 512;

    % w=pi corresponds to index N/2 + 1

    w = 0:(2*pi)/N:2*pi*(N-1)/N;

    H = fft(b, N) ./ fft(a, N);

    % plot(w(1:N/2 - 1), abs(H(1:N/2 + 1)));
    plot(w/pi,abs(H))
    xlim([0 1])
    % plot(w/pi,angle(H))

end