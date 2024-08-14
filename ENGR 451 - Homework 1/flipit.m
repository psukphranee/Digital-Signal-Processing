function y = flipit(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    x_len = length(x.data);
    x_index_right = x.offset + (x_len-1);

    y.data = x.data(end:-1:1);
    y.offset = -x_index_right;
end