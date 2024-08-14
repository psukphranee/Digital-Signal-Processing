function handle = plot_progess(i, frame, frame_fft_buffer, frame_fft, output, inside_digit_flag, energy)
    % plot the frame buffer and contents of the digit buffer
    subplot(2,2,1);
    plot(frame);
    title(sprintf('Frame Number %d: Sliding Frame, Inside Digit = %d, Frame Energy = %f', i, inside_digit_flag, energy));
    xlabel('Sample');
    ylabel('Amplitude');
    subplot(2,2,2);
    plot(abs(frame_fft));
    title(sprintf('Frame Number %d, FFT of Sliding Frame: Inside Digit = %d, Energy = %f', i, inside_digit_flag, energy));
    xlabel('Sample');
    ylabel('Amplitude');
    subplot(2,2,3);
    plot(abs(frame_fft_buffer));
    title(sprintf('Accumulated and Normalized FFT Values for Current Digit: Inside Digit = %d, Area = %f', inside_digit_flag, sum(frame_fft_buffer)));
    xlabel('Sample');
    ylabel('Amplitude');
    subplot(2,2,4);
    y = 1:length(output);
    bar(y./y);
    set(gca, 'XTick', 1:length(output), 'XTickLabel', output);
    %bar(output);
    title(sprintf('Digits Detected: Inside Digit = %d', inside_digit_flag));
    xlabel('Sample');
    ylabel('Amplitude');
    pause(.1);
end