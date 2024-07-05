for i = 0:(dt_dlf/dt-1) 
    Bs=B;
    %B=0;
    t_old = time-dt_dlf+i*dt;
    t_new = t_old+dt;
    y_old = data_old(:,2);
    Y_old = data_old(:,1);
    n_old = length(Y_old);
    if new_dat
        Sigma_Y_old = diag(data_old(:,3));
        new_dat = false;
    else 
        Sigma_Y_old = Sigma_Y_new;
    end
    i_cur = t - dt_dlf/dt+i; 
    i_nex = i_cur+1;
    gauss_off = gauss_on;
    gauss_on = 'gauss';
    switch gauss_on
        case 'linear'
            H = linearInterpolationMatrix(x,y_old);
            Laplace_u_old = H*(D_s+B^2/2)*(FD2*u(:,i_cur));
            Sigma_Laplace_old =  (D_s+B^2/2)^2*H*FD2*sigma_u(:,:,i_cur)*FD2'*H';
            Laplace_u_new = H*(D_s+B^2/2)*(FD2*u(:,i_cur+1));
            Sigma_Laplace_new =  (D_s+B^2/2)^2*H*FD2*sigma_u(:,:,i_cur+1)*FD2'*H';
        Laplace_u_new = Laplace_u_old;
            Sigma_Laplace_new =  Sigma_Laplace_old;
        case 'nearest'
            H = (((mod(y_old+5,10)-5) <= x'+dx/2)&((mod(y_old+5,10)-5)) > x'-dx/2);
            %H = y_old == x';
            Laplace_u_old = H*(D_s+B^2/2)*(FD2*u(:,i_cur));
            Sigma_Laplace_old =  (D_s+B^2/2)^2*H*FD2*sigma_u(:,:,i_cur)*FD2'*H';
            Laplace_u_new = H*(D_s+B^2/2)*(FD2*u(:,i_cur+1));
            Sigma_Laplace_new =  (D_s+B^2/2)^2*H*FD2*sigma_u(:,:,i_cur+1)*FD2'*H';
        case 'gauss'
            K12 = kernel(y_old,x);    
            H = K12/(K11+sigma_u(:,:,i_cur)+CN/dt*u(:,i_cur)*(CN/dt*u(:,i_cur))'*B^2*mod(t_old,dt_observation));
            Laplace_u_old = (D_s+B^2/2)*K12/(K11+FD2*sigma_u(:,:,i_cur)*FD2)*FD2*u(:,i_cur);
            Sigma_Laplace_old =  (D_s+B^2/2)*((kernel(y_old,y_old))-(H*K12'));
            Laplace_u_new = (D_s+B^2/2)*K12/(K11+FD2*sigma_u(:,:,i_cur+1)*FD2)*FD2*u(:,i_cur);
            Sigma_Laplace_new =  (D_s+B^2/2)*((kernel(y_old,y_old))-(H*K12'));
    end
    gauss_on = gauss_off;
  
    
    
   

    y_new = y_old - dt*(c_func(y_old,t_old)+...
               -lambda*Y_old);
    Y_new = Y_old + dt*(force_func(y_old,t_old)+0.5*(Laplace_u_old+Laplace_u_new));
                              
    Sigma_Y_new = diag(diag( (1)*Sigma_Y_old + dt*((A^2)*eye(n_old)+dt*0.5*(Sigma_Laplace_old+Sigma_Laplace_new))));
         
    

    data_old = [Y_new, y_new, diag(Sigma_Y_new)];
    dat = [dat; [data_old, t_new*ones(n_observation,1)]];
    B=Bs;
end


function H = linearInterpolationMatrix(x,  y)
    % Check if the input vectors have the same length
    % if length(x) ~= length(u)
    %     error('Vectors x and u must have the same length.');
    % end

    % Initialize the interpolation matrix H
    H = zeros(length(y), length(x));

    for i = 1:length(y)
        % Find the two closest points in x to the point y(i)
        [~, idx1] = min(mod(abs(x - y(i)), numel(x)));
        idx2 = mod(idx1, numel(x)) + 1;

        % Perform linear interpolation with periodic boundaries
        dx1 = mod(x(idx2) - y(i), numel(x));
        dx2 = mod(y(i) - x(idx1), numel(x));
        H(i, idx1) = dx1 / (dx1 + dx2);
        H(i, idx2) = dx2 / (dx1 + dx2);
    end
end