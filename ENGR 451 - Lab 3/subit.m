function z = subit(x, y)
	% SUBIT Subtract x and y. Either x and y will both be sequence structures or one of them may be a number.

	%checks if any of the inputs is an integer
	%if yes... perform integer addition on vector and trimit
	if ~isstruct(x)
		z.data = x - y.data;
		z.offset = y.offset;
		z = trimit(z);
		return;
	elseif ~isstruct(y)
		z.data = x.data - y;
		z.offset = x.offset;
		z = trimit(z);
		return;
	end

	%if no... perform vector addition and trimit 

	%variables used to make sure size of arrays are the same for
	%calculation (padding at the end of the array)
	yfix = x.offset + length(x.data) - 1;
	xfix = y.offset + length(y.data) - 1;

	padbegx = zeros(1, (x.offset - y.offset));
	padendx = zeros(1, (xfix - yfix));

	padbegy = zeros(1, y.offset - x.offset);
	padendy = zeros(1, yfix - xfix);
	
	%creates vectors with offsets taken into account
	x.data = [padbegx x.data padendx];
	y.data = [padbegy y.data padendy];
	
	z.offset = min(x.offset, y.offset);
	z.data = x.data - y.data;
	z = trimit(z);
end