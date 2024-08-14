function y = conjit(x)
% CONJIT Take a Matlab structure and return the complex conjugate
y.data = conj(x.data);
y.offset = x.offset;
end