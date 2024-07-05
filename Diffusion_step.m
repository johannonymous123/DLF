

    u_hat = fft(u_old);
    u_hat = exp(-D*k'.^2*dt).*u_hat;
    u_new = real(ifft(u_hat))+dt*forcing;
    
if true_sol
    u_new = u_new+A*dt_sqrt*randn(n,1);
end    
    u_old =  u_new;


if ~true_sol
    sigma_hat = fft(sigma_u_old);
    sigma_hat = fft(sigma_hat');
    sigma_hat = exp(-D*(k.^2+k'.^2)*dt).*sigma_hat;
    sigma_hat = ifft(sigma_hat);
    sigma_u_new = real(ifft(sigma_hat')) + A^2*dt*eye(n);
    sigma_u_old =  sigma_u_new;
end

