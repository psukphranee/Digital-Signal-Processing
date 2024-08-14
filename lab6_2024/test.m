% Part 1: Find the frequency of the corrupting tone
[x, fs] = audioread('persevere_bad.wav'); % Load the audio file
N = 1024; % Number of points in FFT
X = fft(x(1:N)); % Take FFT of the first N samples
f = (0:N-1)*(fs/N); % Frequency vector
magnitude = abs(X); % Magnitude of the FFT
[peak_magnitude, idx] = max(magnitude); % Find the index of the peak
frequency_hz = f(idx); % Convert index to frequency in Hz
frequency_rad = frequency_hz *(2 * pi / fs); % Convert frequency to radians per sample

% Plot the average magnitude spectrum
figure;
plot(f, magnitude);
title('Magnitude of FFT');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');

% Part 2: Design the notch filter
% Placeholder for filter design - You will replace this with the actual design
% You will need to replace 'notch_freq' with the frequency you found in Part 1
notch_freq = frequency_hz; % The frequency to notch out, in Hz
bw = 10; % The bandwidth around the notch frequency to remove
[b, a] = iirnotch(notch_freq/(fs/2), bw/(fs/2)); % Design the notch filter

% Plot the pole-zero plot
figure;
zplane(b, a);
title('Pole-Zero Plot of the Notch Filter');

% Part 3: Implement the filter and test
y = filter(b, a, x); % Apply the filter to the signal
soundsc(y, fs); % Play the filtered audio

% Assuming you have to plot the pole-zero plot and provide the pole and zero values
[p, z] = tf2zpk(b, a);
disp('Pole and Zero values:');
disp('Poles:');
disp(p);
disp('Zeros:');
disp(z);