[x, fs] = audioread('persevere_bad.wav'); % Step 1

% Calculate the number of full frames of 1024 points in the signal
num_samples = length(x);
num_frames = floor(num_samples / 1024); % This will ignore any partial frame at the end

% Initialize a vector to store the average FFT magnitudes
average_fft = zeros(1, 1024);

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

% Step 4: Find the peak in the averaged FFT magnitudes
[peak_magnitude, peak_index] = max(average_fft);

% Step 5: Convert the FFT bin index to the frequency in Hz
peak_frequency_hz = (peak_index-1) * fs / 1024;

% Display the frequency of the corrupting tone in Hz
disp(peak_frequency_hz);

% Display the frequency of the corrupting tone in rad/s
peak_frequency_rad = peak_frequency_hz * (2 * pi);
disp(peak_frequency_rad);

% Plot the spectrum
plot(linspace(0, fs/2, 512), average_fft(1:512)); % Plot only the first half of frequencies
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Average FFT Magnitude');

% Assuming you have calculated the frequency of the tone to be removed as f0
f0 = peak_frequency_hz; % The frequency in Hz found from the previous part
r = 0.95; % The radius for poles, slightly less than 1 for stability

% Calculate the angle for the given frequency
theta = 2*pi*f0/fs;

% Calculate zeros and poles
zeros = [exp(j*theta), exp(-j*theta)];
poles = r * [exp(j*theta), exp(-j*theta)];

% Plot the pole-zero plot
zplane(zeros, poles);
title('Pole-Zero Plot of the Notch Filter');

% Calculate and display the angles and magnitudes
zero_angles = angle(zeros);
zero_magnitudes = abs(zeros);
pole_angles = angle(poles);
pole_magnitudes = abs(poles);

fprintf('Zeros:\n');
fprintf('Angle: %f rad, Magnitude: %f\n', zero_angles, zero_magnitudes);

fprintf('Poles:\n');
fprintf('Angle: %f rad, Magnitude: %f\n', pole_angles, pole_magnitudes);

% Given values from the previous section
r = 0.95; % Radius for poles
theta = 2*pi*f0/fs; % Angle for the frequency

% Zeros and poles as calculated before
z = [exp(j*theta), exp(-j*theta)]; % Zeros on the unit circle at the frequency to be notched out
p = r * [exp(j*theta), exp(-j*theta)]; % Poles inside the unit circle to maintain stability

% Get the filter coefficients
b = poly(z); % This will give the coefficients of the numerator
a = poly(p); % This will give the coefficients of the denominator

% Display the coefficients
disp('Numerator coefficients (b): ');
disp(b);
disp('Denominator coefficients (a): ');
disp(a);

% Apply the filter to the signal
filtered_signal = filter(b, a, x);

% You may want to save the filtered signal to a file or plot it to inspect the results
audiowrite('filtered_persevere_bad.wav', filtered_signal, fs);

y = filter(b, a, x);
soundsc(y, fs);