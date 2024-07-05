clear all
close all 
Input;  %Contains user defined variables

pars =  combvec_no_add_ons_needed(D,n_observation);  %Assembles all combination of input parameters

for parameters = 1:size(pars,2) 
Combine; 
close all
Init;                   %Initializes non-user defined parameters
for runs = 1:max_run
    Solve_true;         %Simulates Truth
    Make_data;          %Samples Observations from truth
    if alpha_const
        alpha = 1;      %Sets initial amplitude
    else
        alpha=rand()+0.5;
    end
    if ~phase_const 
        shift = randi([1,n]);  %Sets initial phase   
    else
        shift = 0;
    end
    for DLF = [ true false]    %Loops over DLF and KF 
        data_old = [];
        Solve_model;           %Generates DLF/KF prediction            
        Evaluate;
        if runs == max_run && plot_heat_on
            Make_plots;
        end
    end
end
Post_processing;


end 

if safe_on
    boxing;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pars = combvec_no_add_ons_needed(varargin)
    n = nargin;
    pars=[];

    pars = varargin{1};
    for i=2:n
        j=1:size(pars,2);
        [a,b] = meshgrid(varargin{i},j);
        c=cat(2,a',b');
        d=reshape(c,[],2);
        pars = [pars(:,d(:,2)');d(:,1)'];
    end

end

