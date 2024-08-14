% Downsampling

% Load audio and play sound.
[x, fs] = audioread('seashell.wav');
soundsc(x, fs);

% PLot a spectrogram of this file. Rotate the plot so that we have a "top"
% view
plot_spectrogram(x, fs);
pause;
% Now we decimate by a factor of 2 and show that there is aliasing.
% Decimating results in aliasing if certain conditions are not met, see eqn
% 6.15 in Holton DSP. Decimating by a factor of 2 is also equivalent to
% sampling at half of the sampling rate. So we play back the sound at about
% 5.5 kHz and compare to 'seadown_bad.wav'. It should sound the same.
xD2 = x(1:2:end);
soundsc(xD2, 5513); 
pause;
[x_bad, fs_bad] = audioread('seadown_bad.wav');
soundsc(x_bad, fs_bad);

% Plot spectrogram for the decimated signal shows aliasing.
plot_spectrogram(xD2, fs/2);

% Now we resample using MATLABS function
x_resample = resample(x,1,2);
soundsc(x_resample, fs/2);

% To properly decimate, we have to attach an anti-aliasing filter before
% decimating. Refer to page 369 of Holton DSP. We will use a Kaiser filter.
% The implementation will be returned by "return_filter". We convolve the
% returned filter with the input signal and then decimate.

kaiser_filter = return_filter(pi/2);
x_filtered = conv(x, kaiser_filter);
x_filtered_decimated = x_filtered(1:2:end);
soundsc(x_filtered_decimated, fs/2);


% questions:
% 1) The bandwidth of the signal is half of the sampling frequency which is
% about 5513. Decimating by a factor of 2 is equivalent to sampling and
% half of the original frequency. In turn, the corresponding bandwidth is
% half of the original bandwidth 5513/2 = 2765.
% 2) The bandwidth of the filter used should depend on the downsampling
% factor D to get a w_b = pi/D; pi corresponds to the original bandwidth,
% we have to scale it by the decimating factor.
% 3) It sounds muffled because we are playing the audio back at a lower
% rate
% 4) The ideal filter is not realizable