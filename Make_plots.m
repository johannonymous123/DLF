%%Plots and Evals
[X,T] = meshgrid(x+l/2, 0:dt:t_fin-dt);
X=X'; T=T';
ma =  max(max([u,u_true]))+.1;
mi =  min(min([u,u_true]))-.1;
figure()
surf(X,T,u)

shading interp
axis([0 l 0 t_fin mi ma])
caxis([mi ma])
view(0,90)
colorbar

if DLF
    title('Model-DLF')
    movegui([100,100])
    hold on
    scatter3(dat(:,2)+0.5,dat(:,4),ma*dat(:,2).^0,5,'black','.')

    scatter3(data(:,2)+0.5,data(:,4),ma*data(:,2).^0,'black',LineWidth=1.5)
    hold off
else
    title('Model-Kalman')
    movegui([100,600])
    hold on

    scatter3(data(:,2)+0.5,data(:,4),ma*data(:,2).^0,'black',LineWidth=1.5)
    hold off

end

if DLF
figure()
%waterfall(X,T,u_true)
surf(X,T,u_true)
shading interp
axis([0 l 0 t_fin mi ma])
caxis([mi ma])
view(0,90)
colorbar




    title('truth')
    movegui([700,100])
  
else
  
end


