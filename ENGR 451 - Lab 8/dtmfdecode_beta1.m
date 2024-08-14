%this version of the dtmfdecode beta iterates through frames, displays them
%and shows their energy in the title

function output = dtmfdecode_beta1(x, fs)
    
    %in milliseconds
    frame_len = 30;
    %How many points corresponds to frame_len seconds:
    M = floor(fs*(frame_len/1000));
    %flags for sliding frame being inside a digit
    inside_digit_flag = false;
    %amount to slide window by. we want some overlap between frames
    delta_M = floor(.75*M);
    %calculate number of times to slide. this is a linear inequality
    slide_amount = floor((length(x)-M)/delta_M);
    
    digit_buffer = [];
    frame_fft_buffer = zeros(size(x(1:M)));

    for i=0:slide_amount

        %define the start and ending indices of the frame
        startIdx = 1+i*delta_M;
        endIdx = M+i*delta_M;

        % Ensure the end index does not exceed the length of the signal
        if endIdx > length(x)
            endIdx = length(x);
        end
        
        %define frame
        frame = x(startIdx:endIdx);
        energy = sum(frame.^2);

        % measure power
        % code to plot frame to see what we're looking at.
        plot(frame);
        title(sprintf('Frame %d: Variance = %f, Energy = %f', i, var(frame), energy));
        xlabel('Sample');
        ylabel('Amplitude');
        pause(1.5);
 
end