function intensities = generate_intensities(participant_id, threshold)

%% Load the participants adjustment file
try
    files_in_folder = dir('*');
    adjustment_file = '';
    for i=1:numel(files_in_folder)
       file_name = files_in_folder(i).name; 
       if(~isdir(file_name) && ~isempty(strfind(file_name, participant_id)) )
           adjustment_file = file_name;
           break;
       end
    end
   load(adjustment_file,'-mat');
catch Exception
    error('Could not load adjustment file');
end

%% Calculate the adjustment intensities for the 24 tactors
ref_index = isnan(A.Adj);
A.Adj(ref_index)=0;
intensities_adj = threshold + A.Adj - A.RefLev;
adj = min(0, 30 + intensities_adj);
intensities = 0.43*10.^(adj/20);
end