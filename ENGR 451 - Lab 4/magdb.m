function ph = magdb(h)
    
    H = fft(h, 1024);

    x_ = linspace(0,2,1024);
    
    H = abs(H);
    P_0 = max(H); %find max value
    H = H./P_0; 
    H = 20*log10(H);
    
    ph = plot(x_, H);
    xlim([0,1]);
    ylim([-60 0]);
    xlabel('\omega (rad/\pi)'); % Labeling the x-axis with omega (rad/pi);
    ylabel('$|H(\omega)|$', 'Interpreter', 'latex'); % Labeling the y-axis
    grid on;

end

