% Clear the environment
close all;  % Close all figures
clearvars;  % Clear all variables
clc;        % Clear the command window

% Load the audio file
[x, fs] = audioread('persevere_bad.wav');

% Ensure the audio is in a column vector
x = x(:);

% Calculate the number of full frames of 1024 points in the signal
num_samples = length(x);
num_frames = floor(num_samples / 1024);

% Initialize a vector to store the average FFT magnitudes
average_fft = zeros(1, 1024);

% FFT and averaging across frames
for frame_num = 1:num_frames
    %separate start and end indices for better debugging
    start_index = (frame_num-1)*1024+1;
    end_index = start_index+1024-1;
    frame_data = x(start_index:end_index);
    frame_fft = fft(frame_data);
    average_fft = average_fft + abs(frame_fft);
end

average_fft = average_fft / num_frames;

% Find the peak in the averaged FFT magnitudes
[peak_magnitude, peak_index] = max(average_fft);
peak_frequency_hz = (peak_index-1) * fs / 1024;

% Normalize the input signal if necessary
max_val = max(abs(x));
if max_val == 0 || isnan(max_val) || isinf(max_val)
    error('The input signal is not valid.');
end
x = x / max_val;  % Normalize signal to prevent potential overflow

% Define the radius for poles and calculate the angle for the given frequency
r = 0.95;
theta = 2*pi*peak_frequency_hz/fs;

% Calculate zeros and poles for the notch filter
zeros = [exp(j*theta), exp(-j*theta)];
poles = r * [exp(j*theta), exp(-j*theta)];

% Get the filter coefficients
b = poly(zeros);
a = poly(poles);

% Check if poles are within the unit circle for stability
if any(abs(poles) >= 1)
    error('The filter is unstable. Poles must be inside the unit circle.');
end

% Apply the filter to the normalized signal
filtered_signal = filter(b, a, x);

% Check for NaN or Inf in the filtered signal
if any(isnan(filtered_signal)) || any(isinf(filtered_signal))
    error('Filtered signal contains NaN or Inf values. The filter might be unstable.');
end

% Normalize filtered signal before saving or playing if necessary
max_val_filtered = max(abs(filtered_signal));
if max_val_filtered > 1
    filtered_signal = filtered_signal / max_val_filtered;
end

% Save the normalized filtered signal to a file
audiowrite('filtered_persevere_bad.wav', filtered_signal, fs);

% Play the normalized filtered signal
soundsc(filtered_signal, fs);

% Plot the spectrum
figure;
plot(linspace(0, fs/2, 512), average_fft(1:512));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Average FFT Magnitude');

% Plot the pole-zero plot
figure;
zplane(zeros, poles);
title('Pole-Zero Plot of the Notch Filter');
