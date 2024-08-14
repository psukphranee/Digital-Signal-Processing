function [b,a] = find_coeffs(omega)
    
    z_c = exp(j*omega);

    b = poly([z_c, conj(z_c)]);
    a = poly([0.9*z_c, 0.9*conj(z_c)]);
    
end