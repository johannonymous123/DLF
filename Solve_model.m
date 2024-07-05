true_sol = false;
data_old = [];
time = 0;
c_advection_new = c_func(x,time);

u = zeros(n,time_steps);
u(:,1) = circshift(mvnrnd(u_0(x,alpha),0*sigma_u_0),shift);

for t = 1:time_steps-1
   time = time + dt; 
   u_old = u(:,t);
   sigma_u_old = sigma_u(:,:,t);
   
   forcing = force_func(x,time);
   Diffusion_step;

   c_advection_old = c_advection_new;
   c_advection_new = c_func(x,time);
   Advection_step;
  % if DLF
   Assimilation;
  % end
    
   u(:,t+1) = u_new;
   sigma_u(:,:,t+1) = sigma_u_new;
  
end