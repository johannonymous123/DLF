
    u_hat = fft(u_old);
    u_hat = exp(-0.5*D*k'.^2*dt).*u_hat;
    u_new = real(ifft(u_hat));
    
    u_old =  u_new;
