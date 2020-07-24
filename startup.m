% Startup stuff

config;

fprintf('[gpmat startup] Initialising gpmat\n');

% Add gpmat root dir + all subdirs to path

addpath(genpath(gpmat_root));
fprintf('[gpmat startup] Added path %s and all subdirectories\n',gpmat_root);

fprintf('[gpmat startup] Initialised (you may re-run `startup'' at any time)\n');
