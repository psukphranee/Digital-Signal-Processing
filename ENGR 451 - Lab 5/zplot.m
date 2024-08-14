function h = zplot(b,a)
    
    %Set initial unit circle with axes canvas
    h = rectangle('Position', [-1,-1,2,2], 'Curvature', [1,1]);
    axis([-1.2, 1.2, -1.2, 1.2]);
    axis equal;
    hold on;
    
    % Title
    title('Pole-Zero Plot');
    xlabel('Real');
    ylabel('Imaginary');
    
    
    xlim_values = xlim; % Get x-axis limits
    ylim_values = ylim; % Get y-axis limits
    plot([xlim_values(1), xlim_values(2)], [0, 0], 'k' , 'LineWidth', 1); % x-axis
    plot([0, 0], [ylim_values(1), ylim_values(2)], 'k', 'LineWidth', 1); % y-axis

    %make vectors of the same length by appending 0's ------------------
    % Determine the lengths of vectors a and b
    len_a = length(a);
    len_b = length(b);
    max_len = max(len_a, len_b);

    % Extend vector a if it's shorter
    if len_a < max_len
        a_extended = [a, zeros(1, max_len - len_a)];
    else
        a_extended = a;
    end

    % Extend vector b if it's shorter
    if len_b < max_len
        b_extended = [b, zeros(1, max_len - len_b)];
    else
        b_extended = b;
    end

    %use MATLAB to find roots of the numerator and denominator
    %reverse the order of b_extended and a_extended since they are in terms
    %of z^{-1}
    zeros_vect = roots(b_extended);
    poles_vect = roots(a_extended);

    %loop through elements and plot them
    % Plot each complex number
    
    for i = 1:length(zeros_vect)
        z = zeros_vect(i); % Extract the complex number at index i
        plot(real(z), imag(z), 'bo', 'MarkerSize', 8, 'LineWidth', 2); % Plot the real and imaginary parts
    end

    for i = 1:length(poles_vect)
        z = poles_vect(i); % Extract the complex number at index i
        plot(real(z), imag(z), 'rx', 'MarkerSize', 8, 'LineWidth', 2); % Plot the real and imaginary parts
    end
    
    
end