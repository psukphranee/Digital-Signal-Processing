function [N, beta] = kaiserparams(delta_omega, delta)
    
    A = -20*log10(delta);

    if A > 50
        beta = 0.1102*(A-8.7);
    elseif A < 21
        beta = 0;
    else
        beta = 0.5842*((A - 21)^(0.4)) + 0.07886*(A-21);
    end
    
    %N is order
    N = ceil((A-7.95)/(2.285*delta_omega*pi));

end