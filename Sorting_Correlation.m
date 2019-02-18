% @author: Madeline Shao
clearvars;
close all;
% go into folder that holds data 
cd('Data');
counter = 1;% start a counter at 1 
result=zeros(3,20);
for i = 1:3 % for i through the number of subjects 
    data = xlsread([num2str(i) '_Global_All']); % use the xlsread command to read the subjects datasheets...
    %Remember that you can use num2str to convert i and call each of the different subjects datasheets
    
    data_sorted = sortrows(data,2); %use the sortrows command
    hardcode=1;
    for k = 1:5 % create a loop for the number of timing conditions (5 in total)
        
        separate_cells{k}=data_sorted(hardcode:hardcode+207,:);
        hardcode=hardcode+208;
        tmp_cell=separate_cells{k};
        tmp_cell=sortrows(tmp_cell,1);
        
        
%        ; % sort the number of objects (using row 1 (default)) by the number
        %of trials in the timing conditions  ...
 %       tmp_cell = separate_cells{k}; % designate a temporary cell for each timing condition (5)   
        trial=1;         
        for t = 1:4 % now create a new loop to perform a correlation for the number of objects in each tmp cell   
             % use the correlation command(corr) in each tmp cell-- for every object condition (4 total)
             
             small=tmp_cell(trial:trial+51,:);
             [r,pval]=corr(small(:,3),small(:,4)); % use the number of trials (52 each) to perform the correlation for each object condition 
               % remember: the variables that correlate are in column 3
               % (participant's response) and column 4 (actual lifelikeness)
           z=0.5*(log(1+r)-log(1-r)); % transform the correlation into a fisher z
           trial=trial+52;
            if counter > 20 % if the counter is greater than the number of total correlations you want (5 timing conditions *4 number of objects) 
                counter = 1; % set the counter back to 1
            end
            result(i,counter)=z; % make a final result that holds all of the data (20 correlations for each subject) in a cell
            counter = counter + 1; % add one to the counter 
        end
    end
end

save('Result','result'); 
