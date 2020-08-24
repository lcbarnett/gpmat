%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gpmat Toolbox start-up script
%
% Initialise Gpmat Toolbox. This script is run automatically if Matlab is started
% in the toolbox root (installation) directory.
%
% Set configuration options in "config.m".
%
% (C) Lionel Barnett, 2015. See file LICENSE in installation
% directory for licensing terms.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global gpmat_root
gpmat_root = fileparts(mfilename('fullpath')); % directory containing this file

fprintf('[Gpmat startup] Initialising toolbox\n');

% Set configuration options: look first for user-local configuration file in
% MATLAB preferences directory, else run default

user_config = fullfile(prefdir,'gpmat_config.m');
if exist(user_config,'file') == 2
	fprintf('[Gpmat startup] Setting user-local configuration options\n');
	run(user_config);
else
	fprintf('[Gpmat startup] Setting default configuration options\n');
	config;
end
clear user_config

% Add Gpmat root dir + appropriate subdirs to path

addpath(gpmat_root);
addpath(fullfile(gpmat_root,'gp'));
addpath(fullfile(gpmat_root,'demos'));

if include_testing
	addpath(genpath(fullfile(gpmat_root,'testing')));
end
clear include_testing

fprintf('[Gpmat startup] Paths set\n');

fprintf('[Gpmat startup] Initialisation complete (you may re-run ''startup'' at any time)\n');
