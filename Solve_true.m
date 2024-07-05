u_true = zeros(n,time_steps);
u_true(:,1) = mvnrnd(u_0(x,1),sigma_u_0);%u_0(1,x);

true_sol = true;
time = 0;
c_advection_new = c_func(x,time);
for t = 1:time_steps-1
    u_old = u_true(:,t);
    Diffusion_step_true;

    
    Advection_step_true;

    Diffusion_step_true;
    u_true(:,t+1)=u_new;
    time = time + dt;

end

