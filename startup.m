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

fprintf('[gpmat startup] Initialising toolbox\n');

% Set configuration options: look first for config.m in this directory, else run default

% if exist('config.m','file') == 2 is unreliable, as there might already be
% a config.m on the PATH, which 'exist' will pick up!!! Thus we simply look
% up the actual filename in directory listing 'ls'.

if any(strcmpi(split(ls),'config.m'))
	fprintf('[gpmat startup] Setting user configuration options\n');
	config;
else
	fprintf('[gpmat startup] Setting default configuration options\n');
	config_default;
end

% Globals settings (used in some functions)

global gp_uniqid gp_gnuplot gp_defterm gp_imviewer gp_epsviewer gp_pdfviewer gp_svgviewer gp_eps2pdf gp_imconv gp_pdf2svg gp_pdfcrop gp_pdftoeps gp_pdflatex;
gp_uniqid    = gp_cfg_uniqid;
gp_gnuplot   = gp_cfg_gnuplot;
gp_defterm   = gp_cfg_defterm;
gp_imviewer  = gp_cfg_imviewer;
gp_epsviewer = gp_cfg_epsviewer;
gp_pdfviewer = gp_cfg_pdfviewer;
gp_svgviewer = gp_cfg_svgviewer;
gp_eps2pdf   = gp_cfg_eps2pdf;
gp_pdf2svg   = gp_cfg_pdf2svg;
gp_imconv    = gp_cfg_imconv;
gp_pdfcrop   = gp_cfg_pdfcrop;
gp_pdftoeps  = gp_cfg_pdftoeps;
gp_pdflatex  = gp_cfg_pdflatex;
clear gp_cfg_uniqid gp_cfg_gnuplot gp_cfg_defterm gp_cfg_imviewer gp_cfg_epsviewer gp_cfg_pdfviewer gp_cfg_svgviewer gp_cfg_eps2pdf gp_cfg_imconv gp_cfg_pdf2svg gp_cfg_pdfcrop gp_cfg_pdftoeps gp_cfg_pdflatex;

% Add Gpmat root dir + appropriate subdirs to path

addpath(gpmat_root);
addpath(fullfile(gpmat_root,'gp'));
addpath(fullfile(gpmat_root,'demos'));

if include_testing
	addpath(genpath(fullfile(gpmat_root,'testing')));
end
clear include_testing

fprintf('[gpmat startup] Paths set\n');

fprintf('[gpmat startup] Initialisation complete (you may re-run ''startup'' at any time)\n');
