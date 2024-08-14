% Part 1: Find the frequency of the corrupting tone
[x, fs] = audioread('persevere_bad.wav'); % Load the audio file
frame_size = 1024; % Frame size for FFT
num_frames = floor(length(x)/frame_size); % Number of complete frames in the audio

% Initialize average magnitude vector
avg_magnitude = zeros(frame_size, 1);

% Compute the average magnitude of FFTs
for i = 1:num_frames
    frame = x((i-1)*frame_size+1 : i*frame_size);
    X_frame = fft(frame);
    avg_magnitude = avg_magnitude + abs(X_frame)/num_frames;
end

f = (0:frame_size-1)*(fs/frame_size); % Frequency vector
[peak_magnitude, idx] = max(avg_magnitude(1:frame_size/2)); % Find the index of the peak in the first half of the FFT spectrum
frequency_hz = f(idx); % Convert index to frequency in Hz
frequency_rad = frequency_hz * (2 * pi / fs); % Convert frequency to radians per sample

% Plot the average magnitude spectrum
figure;
plot(f(1:frame_size/2), avg_magnitude(1:frame_size/2)); % Plot only up to Nyquist frequency
title('Average Magnitude of FFTs');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
% Part 2: Design the notch filter
notch_freq = frequency_hz; % The frequency to notch out, in Hz
Q_factor = 35; % Quality factor for the notch - adjust this as needed
bw = notch_freq / Q_factor; % Bandwidth of the notch

% Adjust bandwidth if needed, ensuring it's not too broad to affect the desired signal
bw = max(bw, fs/frame_size); % At minimum, the bandwidth should be one FFT bin width
[b, a] = iirnotch(notch_freq/(fs/2), bw/(fs/2)); % Design the notch filter

% Plot the pole-zero plot
figure;
zplane(b, a);
title('Pole-Zero Plot of the Notch Filter');

% Display the pole and zero values
[p, z] = tf2zpk(b, a);
disp('Pole and Zero values:');
disp('Poles:');
disp(p);
disp('Zeros:');
disp(z);
% Part 3: Implement the filter and test
y = filter(b, a, x); % Apply the filter to the signal
soundsc(y, fs); % Play the filtered audio

% Take FFT of the first frame of the filtered signal for analysis
Y_filtered = fft(y(1:frame_size));
% Plot the magnitude spectrum of the filtered signal
figure;
plot(f(1:frame_size/2), abs(Y_filtered(1:frame_size/2)));
title('Magnitude of FFT of Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');