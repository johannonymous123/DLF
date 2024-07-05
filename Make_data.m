
data = [];
for i=1:floor((t_fin-dt)/dt_observation)
    samp = sort(randsample(n,n_observation));
    data = [data; [(mvnrnd(u_true(samp,round(i*dt_observation/dt+1)),data_error*eye(length(n_observation)))),...
             x(samp),data_error*ones(n_observation,1),dt_observation*i*ones(n_observation,1)]];
    

end
dat=data;