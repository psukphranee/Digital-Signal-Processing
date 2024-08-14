function y = even(x)
% EVEN Take a Matlab structure x, which is possibly complex and create
% a Matlab structure, y, that corresponds to the even part
xFlip = flipit(x);
y = addit(x, xFlip);
y.data = y.data ./ 2;
end