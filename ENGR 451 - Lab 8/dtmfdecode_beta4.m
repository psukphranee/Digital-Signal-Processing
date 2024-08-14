% changes from previous beta: normalize the fft_buffer

function output = dtmfdecode_beta4(x, fs)
    
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
        frame_fft = abs(fft(frame)); % get frames fft

        

        if inside_digit_flag==false
            % we are not inside of a digit

            % we will be entering a digit if energy is above a threshold.
            % we add the fft to the fft buffer
            if energy > 45
                inside_digit_flag=true;
                % add the fft to the fft buffer
                frame_fft_buffer = frame_fft_buffer + frame_fft;
            end

        else
            % we are inside of a digit
            
            % add the fft to the buffer
            frame_fft_buffer = frame_fft_buffer + frame_fft;

            % if we are exiting a digit, push the data to the output stack
            % and clear the buffer
            if energy < 20
                inside_digit_flag = false;
                

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
        plot_progess(i, frame, frame_fft_buffer, frame_fft, output, inside_digit_flag, energy);
    % end of current sliding frame
    end

    % clear final buffer
    if inside_digit_flag==true
        output = [output, sum(frame_fft_buffer)];
        frame_fft_buffer = zeros(size(x(1:M)));
    end

    
end