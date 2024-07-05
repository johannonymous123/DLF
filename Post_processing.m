if plot_stats_on
    xax = dt*(1:time_steps);
    figure()
    plot(xax,RMS_DLF,xax,RMS_Kalman,'LineWidth',2)
    legend('DLF' ,'Kalman')
    title('RMS')
    movegui([1100+1200,600])
    figure()
    plot(xax,Mass_DLF,xax,Mass_Kalman,'LineWidth',2)
    legend('DLF' ,'Kalman')
    title('Mass')
    movegui([1100+3*600,600])
    
    figure()
    plot(xax,CoM_DLF,xax,CoM_Kalman,'LineWidth',2)
    legend('DLF' ,'Kalman')
    title('CoM')
    movegui([1100+2*600,50])
    
    figure()
    plot(xax,Calibration_DLF,xax,Calibration_Kalman,'LineWidth',2)
    legend('DLF' ,'Kalman')
    title('Calibration')
    movegui([1100+3*600,50])
end
if safe_on
folder = save_file;

filename = strcat(folder,'RMS_DLF.txt');
VariableNames = {'Regressor','n_observation','Diffusion', 'lambda', 'mean','var','median','Q1','Q3','max','min'};
if exist(filename, 'file') == 2
    % Load the existing table
    existingTable = readtable(filename);
else
    % Create a new table if it doesn't exist
    existingTable = table();
end

% Create new data
newData = {gauss_on, n_observation, D, lambda, RMS_DLF_mean,RMS_DLF_var, RMS_DLF_median,  Q1_RMS_DLF, Q3_RMS_DLF, RMS_DLF_max, RMS_DLF_min};

% Convert new data to a table
newVariables = cell2table(newData, 'VariableNames', VariableNames);

% Add new data to the existing or new table
existingTable = [existingTable; newVariables];

% Save the updated table to a file
writetable(existingTable, filename,'WriteMode', 'overwrite','Delimiter','\t');

filename = strcat(folder, 'Mass_DLF.txt');  % Change 'RMS' to 'Mass' in the filename

if exist(filename, 'file') == 2
    % Load the existing table
    existingTable = readtable(filename);
else
    % Create a new table if it doesn't exist
    existingTable = table();
end

% Create new data
newData = {gauss_on, n_observation, D, lambda, Mass_DLF_mean, Mass_DLF_var, Mass_DLF_median,  Q1_Mass_DLF, Q3_Mass_DLF,Mass_DLF_max, Mass_DLF_min};  % Change 'RMS' to 'Mass'

% Convert new data to a table
newVariables = cell2table(newData, 'VariableNames', VariableNames);

% Add new data to the existing or new table
existingTable = [existingTable; newVariables];

% Save the updated table to a file
writetable(existingTable, filename, 'WriteMode', 'overwrite','Delimiter','\t');

filename = strcat(folder, 'CoM_DLF.txt');  % Change 'RMS' to 'CoM' in the filename

if exist(filename, 'file') == 2
    % Load the existing table
    existingTable = readtable(filename);
else
    % Create a new table if it doesn't exist
    existingTable = table();
end

% Create new data
newData = {gauss_on, n_observation, D, lambda, CoM_DLF_mean, CoM_DLF_var,CoM_DLF_median,  Q1_CoM_DLF, Q3_CoM_DLF, CoM_DLF_max, CoM_DLF_min};  % Change 'RMS' to 'CoM'

% Convert new data to a table
newVariables = cell2table(newData, 'VariableNames', VariableNames);

% Add new data to the existing or new table
existingTable = [existingTable; newVariables];

% Save the updated table to a file
writetable(existingTable, filename, 'WriteMode', 'overwrite','Delimiter','\t');


filename = strcat(folder, 'Calibration_DLF.txt');  % Change 'RMS' to 'Calibration' in the filename

if exist(filename, 'file') == 2
    % Load the existing table
    existingTable = readtable(filename);
else
    % Create a new table if it doesn't exist
    existingTable = table();
end

% Create new data
newData = {gauss_on, n_observation, D, lambda, Calibration_DLF_mean, Calibration_DLF_var, Calibration_DLF_median,  Q1_Calibration_DLF, Q3_Calibration_DLF, Calibration_DLF_max, Calibration_DLF_min};  % Change 'RMS' to 'Calibration'

% Convert new data to a table
newVariables = cell2table(newData, 'VariableNames', VariableNames);

% Add new data to the existing or new table
existingTable = [existingTable; newVariables];

% Save the updated table to a file
writetable(existingTable, filename, 'WriteMode', 'overwrite','Delimiter','\t');



filename = strcat(folder,'RMS_Kalman.txt');  % Change 'DLF' to 'Kalman' in the filename

if exist(filename, 'file') == 2
    % Load the existing table
    existingTable = readtable(filename);
else
    % Create a new table if it doesn't exist
    existingTable = table();
end

% Create new data
newData = {gauss_on, n_observation, D, lambda, RMS_Kalman_mean,RMS_Kalman_var, RMS_Kalman_median,  Q1_RMS_Kalman, Q3_RMS_Kalman, RMS_Kalman_max, RMS_Kalman_min};  % Change 'DLF' to 'Kalman'

% Convert new data to a table
newVariables = cell2table(newData, 'VariableNames', VariableNames);

% Add new data to the existing or new table
existingTable = [existingTable; newVariables];

% Save the updated table to a file
writetable(existingTable, filename, 'WriteMode', 'overwrite','Delimiter','\t');


filename = strcat(folder, 'Mass_Kalman.txt');  % Change 'RMS' to 'Mass' and 'DLF' to 'Kalman' in the filename

if exist(filename, 'file') == 2
    % Load the existing table
    existingTable = readtable(filename);
else
    % Create a new table if it doesn't exist
    existingTable = table();
end

% Create new data
newData = {gauss_on, n_observation, D, lambda, Mass_Kalman_mean, Mass_Kalman_var, Mass_Kalman_median,  Q1_Mass_Kalman, Q3_Mass_Kalman,Mass_Kalman_max, Mass_Kalman_min};  % Change 'RMS' to 'Mass' and 'DLF' to 'Kalman'

% Convert new data to a table
newVariables = cell2table(newData, 'VariableNames', VariableNames);

% Add new data to the existing or new table
existingTable = [existingTable; newVariables];

% Save the updated table to a file
writetable(existingTable, filename, 'WriteMode', 'overwrite','Delimiter','\t');

filename = strcat(folder, 'CoM_Kalman.txt');  % Change 'RMS' to 'CoM' and 'DLF' to 'Kalman' in the filename

if exist(filename, 'file') == 2
    % Load the existing table
    existingTable = readtable(filename);
else
    % Create a new table if it doesn't exist
    existingTable = table();
end

% Create new data
newData = {gauss_on, n_observation, D, lambda, CoM_Kalman_mean, CoM_Kalman_var,CoM_Kalman_median,  Q1_CoM_Kalman, Q3_CoM_Kalman, CoM_Kalman_max, CoM_Kalman_min};  % Change 'RMS' to 'CoM' and 'DLF' to 'Kalman'

% Convert new data to a table
newVariables = cell2table(newData, 'VariableNames', VariableNames);

% Add new data to the existing or new table
existingTable = [existingTable; newVariables];

% Save the updated table to a file
writetable(existingTable, filename, 'WriteMode', 'overwrite','Delimiter','\t');

filename = strcat(folder, 'Calibration_Kalman.txt');  % Change 'RMS' to 'Calibration' and 'DLF' to 'Kalman' in the filename

if exist(filename, 'file') == 2
    % Load the existing table
    existingTable = readtable(filename);
else
    % Create a new table if it doesn't exist
    existingTable = table();
end

% Create new data
newData = {gauss_on, n_observation, D, lambda, Calibration_Kalman_mean, Calibration_Kalman_var, Calibration_Kalman_median,  Q1_Calibration_Kalman, Q3_Calibration_Kalman,Calibration_Kalman_max, Calibration_Kalman_min};  % Change 'RMS' to 'Calibration' and 'DLF' to 'Kalman'

% Convert new data to a table
newVariables = cell2table(newData, 'VariableNames', VariableNames);

% Add new data to the existing or new table
existingTable = [existingTable; newVariables];

% Save the updated table to a file
writetable(existingTable, filename, 'WriteMode', 'overwrite','Delimiter','\t');
end
