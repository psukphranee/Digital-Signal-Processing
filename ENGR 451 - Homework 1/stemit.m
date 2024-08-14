function z = stemit(x)
    n = length(x.data);
    x_vector = (x.offset:((n-1) + x.offset));
    z = stem(x_vector, x.data);
end