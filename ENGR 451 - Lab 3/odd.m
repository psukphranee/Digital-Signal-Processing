function y = odd(x)
% ODD Take a Matlab structure x, which is possibly complex and create
% a Matlab structure y, that corresponds to the odd part
xFlip = flipit(x);
y = subit(x, xFlip);
y.data = y.data ./ 2;
end