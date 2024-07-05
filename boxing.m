file_1 = {'./data/RMS_DLF.txt','./data/Mass_DLF.txt','./data/CoM_DLF.txt','./data/Calibration_DLF.txt'};
file_2 = {'./data/RMS_Kalman.txt','./data/Mass_Kalman.txt','./data/CoM_Kalman.txt','./data/Calibration_Kalman.txt'};
tit = {'RMS','Mass','CoM','Calibration'};

for j=1:4
file = file_1{j};
color = 'b';
figure()
title(strcat(tit{j},'  (DLF: blue, Kalman: red)'))
bmax = 0;
 grid on
for i = 1:2
    summary = readtable(file);
    Box = summary{:, 7:end};
    Box = [Box, Box(:, 2:3)]; 

%    Labels = summary{:, 2:4};
    Labels = extractColumnStrings(summary);

    hold on
    % Adjust positions slightly for each iteration
    positions = (1:size(Box, 1)) + (-1)^i*0.1;
   
    h=boxplot(Box', 'Whisker', inf, 'Colors', color, 'Labels', Labels,  ...
            'positions', positions);
    set(h,{'linew'},{1.5})
    bmax = max(bmax,max(max(Box')));
    ylim([0+(j==4)*0.3, bmax*1.1]);
    fig = gcf; 
    fontsize(fig, 14, "points")
    hAx=gca;
    hAx.XAxis.TickLabelInterpreter='tex';
    hold off
    file = file_2{j};
    color = 'r';
    
end




end



function resultStrings = extractColumnStrings(inputTable)
    numRows = height(inputTable);
    resultStrings = cell(numRows, 1);

    for i = 1:numRows
        rowString = '';
        for j = 2:3
            colName = inputTable.Properties.VariableNames{j};

            colValue = inputTable.(colName)(i);
            colName = colName(1);
            if colName == 'D'
                colName = '\alpha';
            % Check if the column contains a numeric or logical value
            if isnumeric(colValue) || islogical(colValue)
                colString = [colName ' = ' num2str(colValue)];
                if j == 1
                    rowString = colString;
                else
                    rowString = [rowString  colString  ','];
                end
            end
            else
            colName = 'M';

            % Check if the column contains a numeric or logical value
            if isnumeric(colValue) || islogical(colValue)
                colString = [ colName ' = ' num2str(colValue) ];
                if j == 1
                    rowString = colString;
                else
                    rowString = [rowString  colString  ','];
                end
            end

            end
        end
        resultStrings{i} = rowString;
    end
end

