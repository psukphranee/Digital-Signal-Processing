function [row_i, col_i] = freq_to_index(freqs)
    rows = [697, 770, 852, 941];
    cols = [1209, 1336, 1447];

    i = 1;
    j = 1;
    
    % find closest freq
    rows_diff = abs(rows - freqs(1));
    [min_row, row_i] = min(rows_diff);

    cols_diff = abs(cols - freqs(2));
    [min_col, col_i] = min(cols_diff);
end