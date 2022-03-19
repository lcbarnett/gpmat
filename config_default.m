%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gpmat Toolbox default configuration script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is the default gpmat configuration script. To set user configuration options,
% copy this file to "config.m" in this directory and edit to taste. On Linux, copy
% and edit config_example_linux.m.
%
% If anyone succeeds in creating good working configuration scripts on Windows or
% macOS, the maintainers would be grateful if you could share them!
%
% (C) Lionel Barnett, 2015. See file LICENSE in installation directory for
% licensing terms.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Global options

gp_cfg_testing     = false;     % include test directory?
gp_cfg_uniqid      = false;     % append unique (time-sequential) id on temp plot files?
gp_cfg_screensize  = [];        % Screen size: vector [width, height, DPI] (pixels) - if empty, calculated automatically in 'startup.m'
gp_cfg_gnuplot     = 'gnuplot'; % Gnuplot executable
gp_cfg_defterm     = '';        % Default Gnuplot terminal

% Some image creation/viewing functionality will not work if these variables are not set!

gp_cfg_imviewer    = '';        % Raster image viewer (png, etc.)
gp_cfg_epsviewer   = '';        % Encapsulated Postscript (EPS) viewer
gp_cfg_pdfviewer   = '';        % PDF viewer
gp_cfg_svgviewer   = '';        % SVG viewer
gp_cfg_eps2pdf     = '';        % EPS -> PDF converter
gp_cfg_pdf2svg     = '';        % PDF -> SVG converter
gp_cfg_imconv      = '';        % image conversion utility
gp_cfg_pdfcrop     = '';        % PDF cropping utility
gp_cfg_pdftoeps    = '';        % PDF -> EPS converter
gp_cfg_pdflatex    = '';        % LaTeX call

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Automatic calculation of screen size is potentially flaky in non-Linux systems
% (this is a Matlab "feature"!) so you might want to set it explicitly; e.g.,
%
% gp_cfg_screensize.pixels = [2560,1440];
% gp_cfg_screensize.dpi    = 96;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
