% changes from previous beta: multiply by hamming window

function output = dtmfdecode_beta5(x, fs)

    % depending on file, need to modify frame_len and energy thresholds
    
    %in milliseconds
    frame_len = 40;
    %How many points corresponds to frame_len seconds:
    M = floor(fs*(frame_len/1000));
    %flags for sliding frame being inside a digit
    inside_digit_flag = false;
    digit_counter = 0;
    %amount to slide window by. we want some overlap between frames
    delta_M = floor(.75*M);
    %calculate number of times to slide. this is a linear inequality
    slide_amount = floor((length(x)-M)/delta_M);
    
    %window
    w_n = kaiser(M);

    output = [];
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
        energy = sum(frame.^2); % calculate its energy
        frame = frame .* w_n;
        frame_fft = abs(fft(frame)); % get frames fft

        

        if inside_digit_flag==false
            % we are not inside of a digit

            if energy > 60
                % entering a digit
                % we will be entering a digit if energy is above a threshold.
                % we add the fft to the fft buffer
                inside_digit_flag=true;
                digit_counter = digit_counter + 1;
                % add the fft to the fft buffer
                frame_fft_buffer = frame_fft_buffer + frame_fft;
            end

        else
            % we are inside of a digit
            
            % add the fft to the buffer
            frame_fft_buffer = frame_fft_buffer + frame_fft;
            % normalize but prevent division by zero
            if max(frame_fft_buffer) ~= 0
                frame_fft_buffer = frame_fft_buffer/max(frame_fft_buffer);
            end

            % if we are exiting a digit, push the data to the output stack
            % and clear the buffer
            if energy < 22
                inside_digit_flag = false;
                
                % normalize but prevent division by zero
                % if max(frame_fft_buffer) ~= 0
                %     frame_fft_buffer = frame_fft_buffer/max(frame_fft_buffer);
                % end
                output = [output, sum(frame_fft_buffer)];
                frame_fft_buffer = zeros(size(x(1:M))); 
            end

            % otherwise we are not exiting
        end
        
        % normalize but prevent division by zero
        if max(frame_fft_buffer) ~= 0
            frame_fft_buffer = frame_fft_buffer/max(frame_fft_buffer);
        end

        %plot progress
        plot_progess(i, frame, frame_fft_buffer, frame_fft, output, digit_counter, energy);
    % end of current sliding frame
    end

    % clear final buffer
    if inside_digit_flag==true
        % normalize but prevent division by zero
        if max(frame_fft_buffer) ~= 0
            frame_fft_buffer = frame_fft_buffer/max(frame_fft_buffer);
        end
        output = [output, sum(frame_fft_buffer)];
        frame_fft_buffer = zeros(size(x(1:M)));
    end

    plot_progess(i, frame, frame_fft_buffer, frame_fft, output, digit_counter, energy);

    
end