function plot_spectrogram(x, fs)
    % Function to plot a spectrogram of the input signal x
    % Segments of length 512 with 448 point overlap (64 point step)
    
    n = length(x);
    m = floor((n - 512) / 64);

    % Pre-allocate a matrix to store the spectrogram data
    spectrogram_data = zeros(257, m+1);

    for i = 0:m
        startIdx = i * 64 + 1;
        endIdx = 512 + i * 64;
        
        frame_i = x(startIdx:endIdx);
        frame_i_FFT = fft(frame_i);

        % Truncate to the first 257 points (as FFT is symmetric)
        frame_i_FFT_truncated = frame_i_FFT(1:257);
        
        % Convert magnitude to dB
        frame_i_FFT_truncated_magdb = 20 * log10(abs(frame_i_FFT_truncated));
        
        % Store the magnitude in dB
        spectrogram_data(:, i+1) = frame_i_FFT_truncated_magdb;
    end

    % Define time and frequency axes for the plot
    %fs = 11025;
    time = (0:m) * 64 / fs; % assuming a sampling rate of fs Hz for time in seconds
    freq = (0:256) * fs / 512; % assuming a sampling rate of fs Hz for frequency in Hz

    % Create the 3D plot
    [T, F] = meshgrid(time, freq);
    figure;
    mesh(T, F, spectrogram_data);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    zlabel('Magnitude (dB)');
    title('Spectrogram');
    colorbar;
end
