function [peak_value, peak_index] = find_peak(spec, low, high)
    
    %we want to find the peaks within low and high which are in Hz
    %we convert to the point number of the discrete DTFT
    N = 1024;
    f_s = 11025;

    n_low = floor(low/f_s * 1024);
    n_high = ceil(high/f_s * 1024);

    [peak_value, peak_index] = max(spec(n_low:n_high));
    peak_index = peak_index + n_low;

end

