function z = addit(x,y)
    
    if ~isstruct(x)
        z.data = y.data + x;
        z.offset = y.offset;
    elseif ~isstruct(y)
        z.data = x.data + y;
        z.offset = x.offset;
    else
        
        %construct z vector
        min_index = min(x.offset, y.offset);
        max_index = max(x.offset + (length(x.data)-1), y.offset + (length(y.data)-1));
        z_length = max_index-min_index+1;
        z.data = zeros(1,z_length);

        x_len = length(x.data);
        y_len = length(y.data);
    
    
        %calculate offsets in z
        x_start_in_z = x.offset-min_index+1;
        y_start_in_z = y.offset-min_index+1;
    
        x_end_in_z = x_start_in_z + x_len - 1;
        y_end_in_z = y_start_in_z + y_len - 1;
    
        z.data(x_start_in_z:x_end_in_z) = z.data(x_start_in_z:x_end_in_z) + x.data;
        z.data(y_start_in_z:y_end_in_z) = z.data(y_start_in_z:y_end_in_z) + y.data;

        z.offset = min(x.offset, y.offset);
    end
    
end