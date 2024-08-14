function h = return_filter(wc)
    %wc is cut-off frequency (in radians)?
    fn = wc/pi;
    N = round(1 + 20/fn);
    h = fir1(N-1, fn, kaiser(N, 5));
end