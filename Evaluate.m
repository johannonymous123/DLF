RMS_error = [];
Mass_error = [];
CoM_error = [];
Calibration = [];

err = zeros(n,time_steps);

for i = 1: time_steps
    err(:,i) = 2*sqrt(diag(sigma_u(:,:,i)));
    RMS_error(i) = sqrt(dx*sum((u(:,i)-u_true(:,i)).^2,'all'));
    Mass_error(i) = sqrt(dx^2*sum((sum(abs(u(:,i)))-sum(abs(u_true(:,i)))).^2));
    CoM_error(i) = sqrt(sum((sum(abs(u(:,i).*(x+5))/sum(abs(u(:,i))))- ...
                sum(abs(u_true(:,i).*(x+5))/sum(abs(u_true(:,i))))  ).^2));
    Calibration(i) = 1/n*sum((abs(u(:,i)-u_true(:,i))<err(:,i)),'all');
end


if DLF 
    RMS_DLF(runs,:) = RMS_error;
    Mass_DLF(runs,:) = Mass_error;
    CoM_DLF(runs,:) = CoM_error;
    Calibration_DLF(runs,:) =  Calibration;
    
    RMS_DLF_tot(runs,:) = dt_sqrt*norm(RMS_error);
    Mass_DLF_tot(runs,:) = dt_sqrt*norm(Mass_error);
    CoM_DLF_tot(runs,:) = dt_sqrt*norm(CoM_error);
    Calibration_DLF_tot(runs,:) =  mean(Calibration);
    u_DLF = u;
else
    RMS_Kalman(runs,:) = RMS_error;
    Mass_Kalman(runs,:) = Mass_error;
    CoM_Kalman(runs,:) = CoM_error; 
    Calibration_Kalman(runs,:) =  Calibration;
    
    RMS_Kalman_tot(runs,:) = dt_sqrt*norm(RMS_error);
    Mass_Kalman_tot(runs,:) = dt_sqrt*norm(Mass_error);
    CoM_Kalman_tot(runs,:) = dt_sqrt*norm(CoM_error); 
    Calibration_Kalman_tot(runs,:) =  mean(Calibration);
    u_Kalman = u;
end


if (max_run) ~=1 && (runs==max_run)
    if DLF
        RMS_DLF    = mean(RMS_DLF);
        Mass_DLF    = mean(Mass_DLF);    
        CoM_DLF    = mean(CoM_DLF);   
        Calibration_DLF    = mean(Calibration_DLF);
        
        RMS_DLF_mean = mean(RMS_DLF_tot);
        Mass_DLF_mean = mean(Mass_DLF_tot);
        CoM_DLF_mean = mean(CoM_DLF_tot);
        Calibration_DLF_mean = mean(Calibration_DLF_tot);


        RMS_DLF_median    = median(RMS_DLF_tot);
        Mass_DLF_median    = median(Mass_DLF_tot);    
        CoM_DLF_median    = median(CoM_DLF_tot);   
        Calibration_DLF_median    = median(Calibration_DLF_tot);
    
        RMS_DLF_var    = var(RMS_DLF_tot);
        Mass_DLF_var    = var(Mass_DLF_tot);    
        CoM_DLF_var    = var(CoM_DLF_tot);   
        Calibration_DLF_var    = var(Calibration_DLF_tot);
    
        Q1_RMS_DLF = quantile(RMS_DLF_tot, 0.25);
        Q3_RMS_DLF = quantile(RMS_DLF_tot, 0.75);
        
        
        Q1_Mass_DLF = quantile(Mass_DLF_tot, 0.25);
        Q3_Mass_DLF = quantile(Mass_DLF_tot, 0.75);
        
        
        Q1_CoM_DLF = quantile(CoM_DLF_tot, 0.25);
        Q3_CoM_DLF = quantile(CoM_DLF_tot, 0.75);
        
        
        Q1_Calibration_DLF = quantile(Calibration_DLF_tot, 0.25);
        Q3_Calibration_DLF = quantile(Calibration_DLF_tot, 0.75);

        RMS_DLF_max    = max(RMS_DLF_tot);
        Mass_DLF_max    = max(Mass_DLF_tot);    
        CoM_DLF_max    = max(CoM_DLF_tot);   
        Calibration_DLF_max    = max(Calibration_DLF_tot);
    
        RMS_DLF_min    = min(RMS_DLF_tot);
        Mass_DLF_min    = min(Mass_DLF_tot);    
        CoM_DLF_min    = min(CoM_DLF_tot);   
        Calibration_DLF_min    = mean(Calibration_DLF_tot);


    else
        RMS_Kalman = mean(RMS_Kalman);
        Mass_Kalman = mean(Mass_Kalman);
        CoM_Kalman = mean(CoM_Kalman);
        Calibration_Kalman = mean(Calibration_Kalman);
        
        RMS_Kalman_mean = mean(RMS_Kalman_tot);
        Mass_Kalman_mean = mean(Mass_Kalman_tot);
        CoM_Kalman_mean = mean(CoM_Kalman_tot);
        Calibration_Kalman_mean = mean(Calibration_Kalman_tot);

        RMS_Kalman_median = median(RMS_Kalman_tot);
        Mass_Kalman_median = median(Mass_Kalman_tot);
        CoM_Kalman_median = median(CoM_Kalman_tot);
        Calibration_Kalman_median = median(Calibration_Kalman_tot);
        
        RMS_Kalman_var = var(RMS_Kalman_tot);
        Mass_Kalman_var = var(Mass_Kalman_tot);
        CoM_Kalman_var = var(CoM_Kalman_tot);
        Calibration_Kalman_var = var(Calibration_Kalman_tot);
        
        Q1_RMS_Kalman = quantile(RMS_Kalman_tot, 0.25);
        Q3_RMS_Kalman = quantile(RMS_Kalman_tot, 0.75);
        
        
        Q1_Mass_Kalman = quantile(Mass_Kalman_tot, 0.25);
        Q3_Mass_Kalman = quantile(Mass_Kalman_tot, 0.75);
        
        
        Q1_CoM_Kalman = quantile(CoM_Kalman_tot, 0.25);
        Q3_CoM_Kalman = quantile(CoM_Kalman_tot, 0.75);
        
        
        Q1_Calibration_Kalman = quantile(Calibration_Kalman_tot, 0.25);
        Q3_Calibration_Kalman = quantile(Calibration_Kalman_tot, 0.75);

        RMS_Kalman_max = max(RMS_Kalman_tot);
        Mass_Kalman_max = max(Mass_Kalman_tot);
        CoM_Kalman_max = max(CoM_Kalman_tot);
        Calibration_Kalman_max = max(Calibration_Kalman_tot);
        
        RMS_Kalman_min = min(RMS_Kalman_tot);
        Mass_Kalman_min = min(Mass_Kalman_tot);
        CoM_Kalman_min = min(CoM_Kalman_tot);
        Calibration_Kalman_min = min(Calibration_Kalman_tot);
    end    
end