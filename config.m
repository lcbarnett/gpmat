%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gpmat Toolbox default configuration script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is the default Gpmat configuration script. To set user-local configuration
% options, copy this file to "gpmat_config.m" in your MATLAB preferences directory
% (output of the 'prefdir' command) and customise.
%
% The configuration script is run by 'startup'; any of these configuration options
% may be overriden on the command line before 'startup' is called.
%
% (C) Lionel Barnett, 2015. See file LICENSE in installation directory for
% licensing terms.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Internal options

if ~exist('include_testing','var'), include_testing = false; end

% Globals (used in some functions)

global gp_uniqid gp_gnuplot gp_defterm gp_imviewer gp_epsviewer gp_pdfviewer gp_svgviewer gp_eps2pdf gp_imconv gp_pdf2svg gp_pdfcrop gp_pdftoeps gp_pdflatex;

% Example configuration (Linux)
%
% if ~exist('gp_uniqid',    'var'), gp_uniqid    = false;                   end % if true, append unique (time-sequential) id on temp plot files
% if ~exist('gp_gnuplot',   'var'), gp_gnuplot   = 'gnuplot';               end
% if ~exist('gp_defterm',   'var'), gp_defterm   = 'x11';                   end
% if ~exist('gp_imviewer',  'var'), gp_imviewer  = 'feh';                   end
% if ~exist('gp_epsviewer', 'var'), gp_epsviewer = 'gv -antialias -resize'; end
% if ~exist('gp_pdfviewer', 'var'), gp_pdfviewer = 'mupdf';                 end
% if ~exist('gp_svgviewer', 'var'), gp_svgviewer = 'inkview';               end
% if ~exist('gp_eps2pdf',   'var'), gp_eps2pdf   = 'epstopdf';              end
% if ~exist('gp_pdf2svg',   'var'), gp_pdf2svg   = 'pdf2svg';               end
% if ~exist('gp_imconv',    'var'), gp_imconv    = 'convert -flatten -quality 100 -density 90'; end % density is dpi
% if ~exist('gp_pdfcrop',   'var'), gp_pdfcrop   = 'pdfcrop --margins 2';   end % pixels
% if ~exist('gp_pdftoeps',  'var'), gp_pdftoeps  = 'pdftops -eps -level3';  end
% if ~exist('gp_pdflatex',  'var'), gp_pdflatex  = 'pdflatex --shell-escape --file-line-error --halt-on-error --interaction nonstopmode'; end

% Image creation and viewing will not work in default configuration!

if ~exist('gp_uniqid',    'var'), gp_uniqid    = false;     end % if true, append unique (time-sequential) id on temp plot files
if ~exist('gp_gnuplot',   'var'), gp_gnuplot   = 'gnuplot'; end
if ~exist('gp_defterm',   'var'), gp_defterm   = '';        end
if ~exist('gp_imviewer',  'var'), gp_imviewer  = '';        end
if ~exist('gp_epsviewer', 'var'), gp_epsviewer = '';        end
if ~exist('gp_pdfviewer', 'var'), gp_pdfviewer = '';        end
if ~exist('gp_svgviewer', 'var'), gp_svgviewer = '';        end
if ~exist('gp_eps2pdf',   'var'), gp_eps2pdf   = '';        end
if ~exist('gp_pdf2svg',   'var'), gp_pdf2svg   = '';        end
if ~exist('gp_imconv',    'var'), gp_imconv    = '';        end
if ~exist('gp_pdfcrop',   'var'), gp_pdfcrop   = '';        end
if ~exist('gp_pdftoeps',  'var'), gp_pdftoeps  = '';        end
if ~exist('gp_pdflatex',  'var'), gp_pdflatex  = '';        end

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
