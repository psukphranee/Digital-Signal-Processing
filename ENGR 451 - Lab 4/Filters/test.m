clc
clear

[y, fs] = audioread('phonetone.wav');

fc = 1075;
wc = fc/fs;
delta_omega = 2*pi*300/fs;
delta = .01;

[N, beta] = kaiserparams(delta_omega, delta);
%make sure N is odd
N = ceil(N);
if mod(N,2) == 0
    N = N+1;
end

%create lowpass filter
h_LP = kaiserfilt(N,wc, beta);
%create delta function to subtract with the lowpass impulse response
d_n = zeros(1, N)';
d_n((N+1)/2) = 1;
h_HP = d_n - h_LP;

% Plot the lowpass and highpass filters
figure;
subplot(3,2,1);
plot(h_LP);
title("Low Pass Filter Impulse Response");

subplot(3,2,2);
plot(h_HP);
title("High Pass Filter Impulse Response");

subplot(3,2,3);
magdb(h_LP);
title("Low Pass Filter Frequency Response");

subplot(3,2,4);
magdb(h_HP);
title("High Pass Filter Frequency Response");

% Separate Tones

sr = conv(h_LP, y);
sc = conv(h_HP, y);

subplot(3,2,5);
plot(sr);
title("Row Tones");

subplot(3,2,6);
plot(sc);
title("Column Tones");

disp('Press any key to hear row tones...');
waitforbuttonpress;
disp('Key pressed!');
sound(sr, fs);

disp('Press any key to hear column tones...');
waitforbuttonpress;
disp('Key pressed!');
sound(sc, fs);
