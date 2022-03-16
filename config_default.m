%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gpmat Toolbox default configuration script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is the default gpmat configuration script. To set user configuration options,
% copy this file to "config.m" in this directory and edit to taste.
%
% The configuration script is run by 'startup'; any of these configuration options
% may be overriden on the command line before 'startup' is called.
%
% (C) Lionel Barnett, 2015. See file LICENSE in installation directory for
% licensing terms.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Global options

if ~exist('include_testing','var'), include_testing = false; end
if ~exist('gp_cfg_uniqid',  'var'), gp_cfg_uniqid   = false; end % if true, append unique (time-sequential) id on temp plot files

% Some image creation/viewing functionality will not work if these variables are not set!

if ~exist('gp_cfg_gnuplot',    'var'), gp_cfg_gnuplot     = ''; end % Gnuplot executable
if ~exist('gp_cfg_defterm',    'var'), gp_cfg_defterm     = ''; end % Default Gnuplot terminal
if ~exist('gp_cfg_imviewer',   'var'), gp_cfg_imviewer    = ''; end % Raster image viewer (png, etc.)
if ~exist('gp_cfg_epsviewer',  'var'), gp_cfg_epsviewer   = ''; end % Encapsulated Postscript (EPS) viewer
if ~exist('gp_cfg_pdfviewer',  'var'), gp_cfg_pdfviewer   = ''; end % PDF viewer
if ~exist('gp_cfg_svgviewer',  'var'), gp_cfg_svgviewer   = ''; end % SVG viewer
if ~exist('gp_cfg_eps2pdf',    'var'), gp_cfg_eps2pdf     = ''; end % EPS -> PDF converter
if ~exist('gp_cfg_pdf2svg',    'var'), gp_cfg_pdf2svg     = ''; end % PDF -> SVG converter
if ~exist('gp_cfg_imconv',     'var'), gp_cfg_imconv      = ''; end % image conversion utility
if ~exist('gp_cfg_pdfcrop',    'var'), gp_cfg_pdfcrop     = ''; end % PDF cropping utility
if ~exist('gp_cfg_pdftoeps',   'var'), gp_cfg_pdftoeps    = ''; end % PDF -> EPS converter
if ~exist('gp_cfg_pdflatex',   'var'), gp_cfg_pdflatex    = ''; end % LaTeX call
if ~exist('gp_cfg_screensize', 'var'), gp_cfg_screensize  = []; end % Screen size: vector [width, height, DPI] (pixels) - if empty, calculated automatically in 'startup.m'

% Example (Linux)
%
% if ~exist('gp_cfg_gnuplot',    'var'), gp_cfg_gnuplot    = 'gnuplot';               end
% if ~exist('gp_cfg_defterm',    'var'), gp_cfg_defterm    = 'x11';                   end
% if ~exist('gp_cfg_imviewer',   'var'), gp_cfg_imviewer   = 'feh';                   end
% if ~exist('gp_cfg_epsviewer',  'var'), gp_cfg_epsviewer  = 'gv -antialias -resize'; end
% if ~exist('gp_cfg_pdfviewer',  'var'), gp_cfg_pdfviewer  = 'mupdf';                 end
% if ~exist('gp_cfg_svgviewer',  'var'), gp_cfg_svgviewer  = 'inkview';               end
% if ~exist('gp_cfg_eps2pdf',    'var'), gp_cfg_eps2pdf    = 'epstopdf';              end
% if ~exist('gp_cfg_pdf2svg',    'var'), gp_cfg_pdf2svg    = 'pdf2svg';               end
% if ~exist('gp_cfg_imconv',     'var'), gp_cfg_imconv     = 'convert -flatten -quality 100 -density 90'; end
% if ~exist('gp_cfg_pdfcrop',    'var'), gp_cfg_pdfcrop    = 'pdfcrop --margins 2';   end
% if ~exist('gp_cfg_pdftoeps',   'var'), gp_cfg_pdftoeps   = 'pdftops -eps -level3';  end
% if ~exist('gp_cfg_pdflatex',   'var'), gp_cfg_pdflatex   = 'pdflatex --shell-escape --file-line-error --halt-on-error --interaction nonstopmode'; end
% if ~exist('gp_cfg_screensize', 'var'), gp_cfg_screensize =  [];                     end % if empty, calculated automatically in 'startup.m'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Automatic calculation of screen size is potentially flaky in non-Linux systems
% (this is a Matlab "feature"!) so you might want to set it explicitly; e.g.,
%
% gp_cfg_screensize.pixels = [2560,1440];
% gp_cfg_screensize.dpi    = 96;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% An interesting strategy to convert pdf to svg (alternative to pdf2svg), which
% basically converts all PDF fonts to glyphs so that Inkscape handles them okay.
% In fact pdf2svg handles this similarly, I think. The problem is that Inkscape
% generally won't find good matching fonts.
%
% http://www.cityinthesky.co.uk/opensource/pdf2svg/
% https://stackoverflow.com/questions/10288065/convert-pdf-to-clean-svg
% https://stackoverflow.com/questions/28797418/replace-all-font-glyphs-in-a-pdf-by-converting-them-to-outline-shapes
%
% gs -o testo.pdf -dNoOutputFonts -sDEVICE=pdfwrite test.pdf && inkscape --without-gui --file=testo.pdf --export-plain-svg=testo.svg
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
