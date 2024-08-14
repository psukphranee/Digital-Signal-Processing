clc
clear

[N, beta] = kaiserparams(pi/12, .01);
wc = 0.5;

%make 2 kaiser filters for comparision. One from my function and the other
%from MATLAB's Signal Processing Toolbox

w_kaiser_M = fir1(N-1, wc, kaiser(N, beta));
w_kaiser_P = kaiserfilt(N, wc, beta);

%Subplots to compare filter responses side-by-side
figure;
subplot(1,3,1)
plot(w_kaiser_M)
title("MATLAB's Filter");
subplot(1,3,2)
plot(w_kaiser_P)
title("Panya's Filter");
subplot(1,3,3)
plot(w_kaiser_P, '--')
hold on
plot(w_kaiser_P, '.')
title("Superimposed Filters");
sgtitle('Kaiser Filter Comparison: MATLAB vs Panya');
