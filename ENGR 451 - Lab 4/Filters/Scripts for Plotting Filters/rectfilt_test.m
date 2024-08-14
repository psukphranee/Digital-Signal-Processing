clc
clear

N = 21;
wc = 0.5;

figure;
subplot(2,2,1);
h_rect_MATLAB = fir1(N-1, wc, rectwin(N));
plot(h_rect_MATLAB);
title("MATLAB's Window Filter");

subplot(2,2,2)
ph = magdb(h_rect_MATLAB);
title("MATLAB's Window Filter magdB");
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

h_rect_PANYA = rectfilt(N, wc);
subplot(2,2,3);
plot(h_rect_PANYA);
title("PANYA's Window Filter");

subplot(2,2,4)
ph = magdb(h_rect_PANYA);
title("PANYA's Window Filter magdB");
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
