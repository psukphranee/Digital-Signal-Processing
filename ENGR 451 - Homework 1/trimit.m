function z = trimit(x)

    find_i_left = find(x.data, 1, 'first');
    find_i_right = find(x.data, 1, 'last');

    z.offset = find_i_left + x.offset - 1;
    z.data = x.data(find_i_left:find_i_right);
end