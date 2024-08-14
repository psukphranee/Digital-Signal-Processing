function z = trimit(x)
	% TRIMIT Remove leading and trailing zeros from sequence x and adjust offset appropriately.

	%edge case: if vector is full of zeros 
	if all(~x.data)
		z.data = x.data;
		z.offset = x.offset;
		return;
	end
	while x.data(1) == 0
		x.offset = x.offset + 1;
		x.data(1) = [];
	end
	while x.data(end) == 0
		x.data(end) = [];
	end
	z.data = x.data;
	z.offset = x.offset;
end