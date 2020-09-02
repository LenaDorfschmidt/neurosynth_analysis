% This script generates a map to be uploaded for Neurosynth analysis
% @author Lena Dorfschmidt (ld548@cam.ac.uk)

% The script loads in a table of values to be analyzed in HCP parcellation
% Make sure to check that your data is ordered the same as specified in atlas.labels.csv

% Change this path to your directory
basepath = '~/Documents/GitHub/neurosynth_analysis/'

% Read in Atlas
HCP = MRIread([basepath, 'uchange_parcellation_to_MNI_quick.nii']);

% Read in data to analyze
to_analyze = table2array(readtable([basepath, 'test_data.txt']));
to_analyze(isnan(to_analyze)) = 0; % Setze alle NaNs auf 0

V = HCP; % Create dummy brain
% Loop through all labels in atlas and replace all occurances with data to
% analyze
for label = 1:sum(unique(V.vol)~=0)
    V.vol(find(V.vol==label)) = to_analyze(label);
end

% Write map
MRIwrite(V, [basepath, 'upload_to_neurosynth.nii.gz'],'float')


