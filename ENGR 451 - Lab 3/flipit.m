function y = flipit(x)
	% FLIPIT Flip a Matlab sequence structure x so y = x[-n]
	y.data = x.data(end:-1:1);
	y.offset = -(length(x.data) + (x.offset - 1));
end