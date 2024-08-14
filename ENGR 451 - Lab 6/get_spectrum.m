function output = get_spectrum(x, fs)
    
    %chunk size
    N = 1024;

    num_of_chunks = floor(11025/N);
    
    fft_accumulator = zeros(N,1);

    for i = 1:num_of_chunks

        %get subseqence of size N
        start_index = N*(i-1)+1;
        end_index = start_index + (N-1);

        subsequence = x(start_index: end_index);

        fft_of_chunk = abs(fft(subsequence));

        fft_accumulator = fft_accumulator + fft_of_chunk;

    end
    
    %average out the fft
    fft_accumulator = fft_accumulator / num_of_chunks;
    
    %return
    output = fft_accumulator;

end

