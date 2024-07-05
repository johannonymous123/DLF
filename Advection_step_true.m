%Set up RI5 stoch RK
% Butcher tableau
c0 = [0 1 5/12];
c1 = [0 .25 .25];
c2 = [0 0 0];

A0 = [0 0 0; 1 0 0; 25/144 35/144 0];
A1 = [0 0 0; .25 0 0; .25 0 0];
A2 = zeros(3,3);

B0 = [0 0 0; 1/3 0 0; -5/6 0 0];
B1 = [0 0 0; .5 0 0; -.5 0 0];
B2 = [0 0 0; 1 0 0; -1 0 0];

alpha =  [.1 3/14 24/35];
beta1 = [1 -1 -1];
beta2 = [0 1 -1];
beta3 = [.5 -.25 -.25];
beta4 = [0 .5 -.5];
c_func2 = c_func;
if t==1
daddl = randn(1,time_steps)*dt_sqrt;
end
if dwc_const
    c_func = @(x,t) c_func(x,t)+sum(daddl(1:floor(t/dt)));
end
a_noise = @(t,uu) (c_func(x,t)-lambda*uu).*(CN*uu)/dt+((c_func(x,t)-lambda*uu).^2).*(0.5*FD2*uu)*dt^2+force_func(x,t) ;
b_noise = @(t,uu,cases) A*uu.^0*(cases==1)+ B*(CN*uu)/dt*(cases==2);

stages = 3;
noises = 2;


Yn = u_old; 
H0 = zeros(n,stages);
H = zeros(n,stages,noises);
Hhat = zeros(n,stages,noises);

Ihat = sqrt(3)*dt_sqrt*((rand(n,noises))<1/3).*(-1).^(rand(n,noises)<.5);
Itilde = dt_sqrt*(-1).^(rand(n,noises)<.5);
Idhat = zeros(n,noises,noises);

for k = 1:noises
    Idhat(:,k,k) = 0.5*(Ihat(:,k).^2-dt);
    for ll=1:noises
        if k ~= ll
            Idhat(:,k,ll) = 0.5*(Ihat(:,k).*Ihat(:,ll)+dt_sqrt*((-1)^(k<ll)).*Itilde(:,min(k,ll)));    

        end
    end
end


for i = 1:stages
    H0(:,i) = Yn;   %%
    for j=1:noises
    H(:,i,j) = Yn;
    Hhat(:,i,j) = Yn;
    end
    for j = 1:(i-1)
        H0(:,i) = H0(:,i) + A0(i,j).*a_noise(time+c0(j)*dt,H0(:,j))*dt;  %%%%


        for ll=1:noises
            H0(:,i) = H0(:,i) + B0(i,j)*b_noise(time+c1(j)*dt,H(:,j,ll),ll).*Ihat(:,ll);
            H(:,i,ll) = H(:,i,ll)+ A1(i,j)*a_noise(time+c0(j)*dt,H0(:,j))*dt...   %%%%%
            +B1(i,j)*b_noise(time+c1(j)*dt,H(:,j,ll),ll)*dt_sqrt;
            for k =1:noises
                if k ~= ll
                    Hhat(:,j,ll)= Hhat(:,j,ll) + B2(i,j).*b_noise(time+c1(j)*dt,H(:,j,k),k).*Idhat(:,ll,k)/dt_sqrt;
                end
            end
        end
    end

end

for i=1:stages
    Yn = Yn + alpha(i)*a_noise(time+c0(i)*dt,H0(:,i))*dt;   %%%%%%%%%%
    for k=1:noises
        Yn = Yn + (beta1(i)*Ihat(:,k)+beta2(i)*Idhat(:,k,k)/dt_sqrt).*b_noise(time+c1(i)*dt,H(:,i,k),k)...
            +(beta3(i)*Ihat(:,k)+Ihat(:,k)*beta4(k)*dt_sqrt).*b_noise(time+c2(i)*dt,Hhat(:,i,k),k);

    end
end
u_new = Yn;
u_old = Yn;
c_func = c_func2;
