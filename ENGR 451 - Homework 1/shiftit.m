function y = shiftit(x, n0)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    y.data = x.data;
    y.offset = x.offset + n0;
end