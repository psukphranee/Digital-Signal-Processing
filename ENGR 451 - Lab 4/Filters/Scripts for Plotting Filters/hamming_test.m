clc
clear

N = 21;
wc = 0.5;


figure;
subplot(2,2,1);
h_hamming_MATLAB = fir1(N-1, wc, hamming(N));
plot(h_hamming_MATLAB);
title("MATLAB's Hamming Filter");

subplot(2,2,2)
ph = magdb(h_hamming_MATLAB);
title("MATLAB's Hamming Filter");
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');


h_hamming_PANYA = hammingfilt(N, wc);
subplot(2,2,3);
plot(h_hamming_PANYA);
title("PANYA's Hamming Filter");

subplot(2,2,4)
ph = magdb(h_hamming_PANYA);
title("PANYA's Hamming Filter");
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
