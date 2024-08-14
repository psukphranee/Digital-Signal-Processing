function [sr, sc] = separate(s, fs)
    % SEPARATE: Separates row and column tones for DTMF signals
    %
    % INPUTS:
    % - s: Input audio signal (vector)
    % - fs: Sampling frequency of the input signal (scalar)
    %
    % OUTPUTS:
    % - sr: Row tone signal (vector)
    % - sc: Column tone signal (vector)
    
    %% Part 1: Make filters
    fc = 1075;
    wc = fc/fs;
    delta_omega = 2*pi*300/fs;
    delta = .01;


    % Define filter parameters (order and beta)
    [N, beta] = kaiserparams(delta, delta_omega); % You need to define kaiserparams function
    %adjust N so it will be an odd integer
    N = ceil(N);
    if mod(N,2) == 0
        N = N+1;
    end

    %create lowpass filter
    h_LP = kaiserfilt(N,wc, beta);
    %create delta function to subtract with the lowpass impulse response
    d_n = zeros(1, N)';
    d_n((N+1)/2) = 1;
    h_HP = d_n - h_LP;

    % Perform filtering
    sr = conv(h_LP, s);
    sc = conv(h_HP, s);
end
