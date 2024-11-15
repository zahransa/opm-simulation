%% This script prepares the head- and source models for placing and displaying the dipoles

%start by creating a new subject in the GUI --> New subject, default anatomy
%start brainstorm

%%%%%%%%%%%%SETTINGS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SubjectName = 'Subject26'; %specify the name of the subject that will be used in the brainstorm GUI
MAINPATH = 'C:\Users\arnd\Desktop\toolboxes_matlab\'; %path to brainstorm3
PROTOCOLNAME = 'Ana'; %name of your current protocol in brainstorm
RawFiles = {'O:\arm_testing\Experimente\cEEGrid_Sensitivity\raw.bst'}; %specify the raw signal file (128 channel cap, standard brainstorm)
%%%%%%%%%%%%SETTINGS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Input files
sFiles = [];
SubjectNames = {...
    SubjectName};

%import a raw signal file
sFiles = bst_process('CallProcess', 'process_import_data_time', sFiles, [], ...
    'subjectname',  SubjectNames{1}, ...
    'condition',    '', ...
    'datafile',     {{RawFiles{1}}, 'BST-BIN'}, ... %specify the data type; here, it is .bst
    'timewindow',   [], ...
    'split',        0, ...
    'ignoreshort',  1, ...
    'channelalign', 1, ...
    'usectfcomp',   1, ...
    'usessp',       1, ...
    'freq',         [], ...
    'baseline',     []);

% Input files
sFiles = {...
    'Subject26/raw/data_block001.mat'};

% Start a new report
bst_report('Start', sFiles);

% Process: Set channel file
sFiles = bst_process('CallProcess', 'process_import_channel', sFiles, [], ...
    'channelfile',  {RawFiles{1}, RawFiles{1}}, ...
    'usedefault',   21, ...  % Colin27: BrainProducts EasyCap 128
    'channelalign', 0, ...
    'fixunits',     1, ...
    'vox2ras',      0);

% Input files
sFiles = {...
    [SubjectName,'/raw/data_block001.mat']};

% Start a new report
bst_report('Start', sFiles);

sProcess = bst_process('GetInputStruct', sFiles);
db_reload_studies(sProcess.iStudy) %reload to get rid of the deleted files in the GUI#

% Process: Compute covariance (noise or data)
sFiles = bst_process('CallProcess', 'process_noisecov', sFiles, [], ...
    'baseline',       [0, 1.996], ...
    'datatimewindow', [0, 1.996], ...
    'sensortypes',    'MEG, EEG, SEEG, ECOG', ...
    'target',         1, ...  % Noise covariance     (covariance over baseline time window)
    'dcoffset',       1, ...  % Block by block, to avoid effects of slow shifts in data
    'identity',       0, ...
    'copycond',       0, ...
    'copysubj',       0, ...
    'copymatch',      0, ...
    'replacefile',    1);  % Replace
    
    % Process: Compute head model
    sFiles = bst_process('CallProcess', 'process_headmodel', sFiles, [], ...
        'Comment',     '', ...
        'sourcespace', 2, ...  % MRI volume
        'volumegrid',  struct(...
        'Method',        'isotropic', ...
        'nLayers',       17, ...
        'Reduction',     3, ...
        'nVerticesInit', 1000, ...
        'Resolution',    0.005, ...
        'FileName',      []), ...
        'meg',         1, ...  %
        'eeg',         3, ...  % OpenMEEG BEM
        'ecog',        1, ...  %
        'seeg',        1, ...  %
        'openmeeg',    struct(...
        'BemSelect',    [1, 1, 1], ...
        'BemCond',      [1, 0.0125, 1], ...
        'BemNames',     {{'Scalp', 'Skull', 'Brain'}}, ...
        'BemFiles',     {{}}, ...
        'isAdjoint',    0, ...
        'isAdaptative', 1, ...
        'isSplit',      0, ...
        'SplitLength',  4000));
    
    % Process: Compute sources [2018]
    sFiles = bst_process('CallProcess', 'process_inverse_2018', sFiles, [], ...
        'output',  3, ...  % Full results: one per file
        'inverse', struct(...
        'Comment',        'Dipoles: EEG', ...
        'InverseMethod',  'gls', ...
        'InverseMeasure', 'performance', ...
        'SourceOrient',   {{'free'}}, ...
        'Loose',          0.2, ...
        'UseDepth',       1, ...
        'WeightExp',      0.5, ...
        'WeightLimit',    10, ...
        'NoiseMethod',    'median', ...
        'NoiseReg',       0.1, ...
        'SnrMethod',      'rms', ...
        'SnrRms',         1e-06, ...
        'SnrFixed',       3, ...
        'ComputeKernel',  0, ...
        'DataTypes',      {{'EEG'}}));
    
listResult = dir([MAINPATH,'brainstorm_db\',PROTOCOLNAME,'\data\',SubjectName,'\raw\results_Dipoles*']);
% Input files
sFiles = {...
    [listResult(1).folder,'\',listResult(1).name]};

% Start a new report
bst_report('Start', sFiles);

% Process: Dipole scanning
sFiles = bst_process('CallProcess', 'process_dipole_scanning', sFiles, [], ...
    'timewindow', [0, 1.996], ...
    'scouts',     {'Desikan-Killiany', {'bankssts L'}});

    % Process: Compute sources [2018]
    sFiles = bst_process('CallProcess', 'process_inverse_2018', sFiles, [], ...
        'output',  3, ...  % Full results: one per file
        'inverse', struct(...
        'Comment',        'MN: EEG', ...
        'InverseMethod',  'minnorm', ...
        'InverseMeasure', 'amplitude', ...
        'SourceOrient',   {{'free'}}, ...
        'Loose',          0.2, ...
        'UseDepth',       1, ...
        'WeightExp',      0.5, ...
        'WeightLimit',    10, ...
        'NoiseMethod',    'reg', ...
        'NoiseReg',       0.1, ...
        'SnrMethod',      'fixed', ...
        'SnrRms',         1e-06, ...
        'SnrFixed',       3, ...
        'ComputeKernel',  0, ...
        'DataTypes',      {{'EEG'}})); 

% Save and display report
ReportFile = bst_report('Save', sFiles);
bst_report('Open', ReportFile);


