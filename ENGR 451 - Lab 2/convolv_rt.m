function y = convolv_rt(x,h)

    lh = length(h);             %get length of h

    h_buffer = h(:)';           %make h into a row vector
    h_buffer = flip(h_buffer);
    x = [x(:); zeros(lh-1,1)];  %pad x vector
    y = zeros(1,length(x));           %pre-allocate output array
    
    x_buffer = zeros(lh,1);     %make a buffer for x values
    
    for i=1:length(x)
        
        x_buff_ptr = mod(i-1, lh) + 1;
        x_buffer(x_buff_ptr) = x(i);
        
        h_buffer = [h_buffer(end), h_buffer(1:end-1)];
        y(i) = h_buffer*x_buffer;
        
    end
    
end