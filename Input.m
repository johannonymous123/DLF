%%This file contains all user defined variables.
%Pick you parameters of choice then run the script main.m
%Parameters D and n_observation accept lists as inputs, the script will
%then loop through all combinations of these lists.

D = [ 0.01];               %diffusion constant             
n_observation = [20];      %Number of observation at each observationb time
max_run = 10;              %Number of runs for each set of parameters, metrics will be averaged over all these runs

dwc_const = false;         %If false noise of phase speed is uncorrelated, if true uncertainty is added to phase speed 
alpha_const = true;        %If true initial amplitude is 1, if false initial amplitude is random
phase_const = true;        %If true initial phase is 0.5, if false initial phase is random

if length(D)*length(n_observation)==1
plot_heat_on = true;       %plot heat map of first individual run if true
plot_stats_on = true;      %plot RMS,Mass,COM and Calibration time series
end
if max_run~=1
    safe_on = true;
end
l = 1;                  %Domain length
n = 100;                %number of spatial nodes
t_fin = 0.5;              %final time 
time_steps = 1000;      %number of time steps
dt_observation = .05;      %disance between observation times
dt_dlf = .005;            %time step for DLF  
data_error = .0001;      %Cov of observations


A = .05;   %Force noise (stdev)
B = 0.01;  %speed noise  (stdev)


