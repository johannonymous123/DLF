data_t =  data(((data(:,4)<=time+0.001*dt) & (data(:,4)>=time-0.001*dt)),1:3);   %new observations

if ~isempty(data_t)   %some data
    if isempty(data_old)  %Kalman only
        H = data_t(:,2) == x';
        K = sigma_u_new*H'/(H*sigma_u_new*H'+diag(data_t(:,3)));
        u_new = u_old+K*(data_t(:,1)-H*u_old);
        sigma_u_new = sigma_u_new - K*H*sigma_u_new;
        if DLF
            data_old = data_t;
            new_dat = true;
        end
    else   %new data + old data => MDLF
        
        Propagate_data;
        switch gauss_on

            case  'gauss'
        K12 = kernel(data_old(:,2),x);    
        H_old = K12/(K11+sigma_u_new+CN/dt*u_old*(CN/dt*u_old)'*B^2*dt_observation); %Gaussian regressor
        sig_u_star = kernel(data_old(:,2),data_old(:,2))-H*K12';
            case 'linear'
        
        H_old = linearInterpolationMatrix(x,data_old(:,2));
                sig_u_star = 0;%*kernel(data_old(:,2),data_old(:,2))';

            case 'nearest'
        H_old = (((mod(data_old(:,2)+5,10)-5) <= x'+dx/2)&((mod(data_old(:,2)+5,10)-5)) > x'-dx/2); %only C=0
                sig_u_star = 0*kernel(data_old(:,2),data_old(:,2))';

        end

        H_t = data_t(:,2) == x';
        K_t = sigma_u_new*H_t'/(diag(data_t(:,3))+H_t*sigma_u_new*H_t');
        
        DD = sigma_u_new*H_old'/(Sigma_Y_new+sig_u_star+H_old*sigma_u_new*H_old'-H_old*K_t*H_t*sigma_u_new*H_old');
         
        K = K_t-DD*H_old*K_t+K_t*H_t*DD*H_old*K_t; 
        J =(DD - K_t*H_t*DD);
        u_new =  u_old + K*(data_t(:,1)-H_t*(u_old)) + J * (data_old(:,1)-H_old*(u_old));
        sigma_u_new = sigma_u_new -K*H_t*sigma_u_new; %-J*H_old*sigma_u_new;   
        if DLF
            data_old = data_t;
            new_dat = true;
        end
    end
else
    dlf_time = (mod(time,dt_dlf)<1e-4 & mod(time,dt_dlf)>-1e-4) | (mod(time,dt_dlf)<dt_dlf+1e-4 & mod(time,dt_dlf)>dt_dlf-1e-4);
    if ~isempty(data_old) && dlf_time   % DLF only
         
             Propagate_data;
             switch gauss_on
                 case 'gauss'            
                 K12 = kernel(data_old(:,2),x);    
                 H = K12/(K11+sigma_u_new+CN/dt*u_old*(CN/dt*u_old)'*B^2*mod(time,dt_observation)); %Gaussian regressor
                 sig_u_star = kernel(data_old(:,2),data_old(:,2))-H*K12';
                 K = sigma_u_new*H'/(H*sigma_u_new*H'+Sigma_Y_new+sig_u_star);
        
                 u_new = u_old+K*(data_old(:,1)-H*u_old);
                 sigma_u_new = sigma_u_new - K*H*sigma_u_new; 
                 case 'linear'    
                
                 H = linearInterpolationMatrix(x,data_old(:,2));
                
                 K = sigma_u_new*H'/(H*sigma_u_new*H'+Sigma_Y_new);
                 u_new = u_old+K*(data_old(:,1)-H*u_old);
                % sigma_u_new = sigma_u_new - K*H*sigma_u_new;
                 case 'nearest'
                 H = (((mod(data_old(:,2)+5,10)-5) <= x'+dx/2)&((mod(data_old(:,2)+5,10)-5)) > x'-dx/2);                   
                 K = sigma_u_new*H'/(H*sigma_u_new*H'+Sigma_Y_new);
                 u_new = u_old+K*(data_old(:,1)-H*u_old);
                 sigma_u_new = sigma_u_new - K*H*sigma_u_new;
             end
     end
end

u_old=u_new;


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


