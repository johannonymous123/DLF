save_file = './data/';

u_0 = @(x,al)  al*1.0*exp(-250*(x).^2);    %initial data and variacnce
sigma_u_0 =  0.000000*eye(n);

c_func = @(x,t) x.^0*cos(5*pi*t);
force_func = @(x,time)  0.*x.^0;  

dt = t_fin/time_steps;
dt_sqrt=sqrt(dt);
dx = l/n;
beta = 1;
D_s = D;

x = linspace(-l/2+dx,l/2,n)';
kernel = @(x,y) s1^2*exp(-(sin(pi/l*abs((x-y'))).^2)/s2^2) ;
K11 = kernel(x,x);

u = zeros(n,time_steps);
sigma_u = zeros(n,n,time_steps);
sigma_u(:,:,1) = sigma_u_0;

k = 2*pi/l*(-n/2:n/2-1);
k=fftshift(k);
upwind_pos = dt/dx*(eye(n)-diag(ones(n-1,1),-1));
upwind_pos(1,end)=-dt/dx;
upwind_neg=-upwind_pos';
CN =  0.5*dt/dx*(diag(ones(n-1,1),1)-diag(ones(n-1,1),-1));
CN(end,1) = 0.5*dt/dx;
CN(1,end)=-0.5*dt/dx;
FD2 = 1/dx^2*(-2*eye(n)+diag(ones(n-1,1),-1)+diag(ones(n-1,1),1));
FD2(1,end)= 1/dx^2;
FD2(end,1)= 1/dx^2;


rr = [-30;16;-1; zeros(n-5,1);-1;16];
FD2 = 1/12/dx^2*toeplitz(rr);
lambda = [0];               %eq. parameter for nonlinearity


s1 = .1;               %Gauss-regressor parameters    %s_1 big more correlation, s_2 big smoother
s2 = .1;
gauss_on = 'linear' ; %Options 'gauss', 'nearest', 'linear'
