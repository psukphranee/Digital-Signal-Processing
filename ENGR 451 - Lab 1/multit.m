function z=multit(x,y)

    if ~isstruct(x)
        z.data = y.data * x;
        z.offset = y.offset;
    elseif ~isstruct(y)
        z.data = x.data * y;
        z.offset = x.offset;
    else

        x_len = length(x.data);
        y_len = length(y.data);

        x_index_left = x.offset;
        x_index_right = x.offset + (x_len - 1);

        y_index_left = y.offset;
        y_index_right = y.offset + (y_len - 1);

        %construct z vector
        min_index = min(x_index_left, y_index_left);
        max_index = max(x_index_right, y_index_right);
        z_length = max_index-min_index+1;
        z.data = ones(1,z_length);
        %ok
    
        %pad x
        left_size = x_index_left-min_index;
        right_size = max_index-x_index_right;
        left_pad = zeros(1, left_size);
        right_pad = zeros(1, right_size);
        x.data = [left_pad, x.data, right_pad];
        
        %pad y
        left_size = y_index_left-min_index;
        right_size = max_index-y_index_right;
        left_pad = zeros(1, left_size);
        right_pad = zeros(1, right_size);
        y.data = [left_pad, y.data, right_pad];
        
        z.data = x.data .* y.data;
        z.offset = min(x.offset, y.offset);
    end

end