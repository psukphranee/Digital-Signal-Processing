[x, fs] = audioread('persevere_bad.wav'); % Load the audio file

% Calculate the number of full frames of 1024 points in the signal
num_samples = length(x);
num_frames = floor(num_samples / 1024); % This will ignore any partial frame at the end

% Initialize a vector to store the average FFT magnitudes
average_fft = zeros(1, 1024);

% FFT and averaging across frames
for frame = 1:num_frames
    % Select the frame of 1024 points
    frame_data = x((frame-1)*1024+1:frame*1024);

    % Compute the FFT of the frame
    frame_fft = fft(frame_data);

    % Update the average FFT magnitude
    average_fft = average_fft + abs(frame_fft);
end

% Divide by the number of frames to get the average
average_fft = average_fft / num_frames;

% Find the peak in the averaged FFT magnitudes
[peak_magnitude, peak_index] = max(average_fft);

% Convert the FFT bin index to the frequency in Hz
peak_frequency_hz = (peak_index-1) * fs / 1024;
disp(peak_frequency_hz); % Display the frequency of the corrupting tone in Hz

% Plot the spectrum
plot(linspace(0, fs/2, 512), average_fft(1:512));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Average FFT Magnitude');

% Define the radius for poles and calculate the angle for the given frequency
r = 0.95;
theta = 2*pi*peak_frequency_hz/fs;

% Calculate zeros and poles for the notch filter
zeros = [exp(j*theta), exp(-j*theta)];
poles = r * [exp(j*theta), exp(-j*theta)];

% Plot the pole-zero plot to check the placement of poles and zeros
zplane(zeros, poles);
title('Pole-Zero Plot of the Notch Filter');

% Check if poles are within the unit circle for stability
if any(abs(poles) >= 1)
    error('Poles must be inside the unit circle for the filter to be stable.');
end

% Get the filter coefficients
b = poly(zeros); % Numerator coefficients of the filter
a = poly(poles); % Denominator coefficients of the filter

% Normalize the input signal
max_val = max(abs(x));
if max_val > 1
    warning('Signal values exceed 1. Normalizing the signal.');
    x = x / max_val;
end

% Apply the filter to the normalized signal
filtered_signal = filter(b, a, x);

% Check for NaN or Inf in filtered signal
if any(isnan(filtered_signal)) || any(isinf(filtered_signal))
    error('Filtered signal contains NaN or Inf values. The filter might be unstable.');
end

% Normalize filtered signal before saving or playing
max_val_filtered = max(abs(filtered_signal));
if max_val_filtered > 1
    warning('Filtered signal values exceed 1. Normalizing the signal.');
    filtered_signal = filtered_signal / max_val_filtered;
end

% Save the normalized filtered signal to a file
audiowrite('filtered_persevere_bad.wav', filtered_signal, fs);

% Play the normalized filtered signal
soundsc(filtered_signal, fs);
