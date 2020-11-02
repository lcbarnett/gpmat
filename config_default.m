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

% Internal options

if ~exist('include_testing','var'), include_testing = false; end

% Globals (used in some functions)
%
% Stuff (especially image creation and viewing) will not work if thesese environmental variables are not set!

if ~exist('gp_cfg_uniqid',    'var'), gp_cfg_uniqid    = false;                     end % if true, append unique (time-sequential) id on temp plot files
if ~exist('gp_cfg_gnuplot',   'var'), gp_cfg_gnuplot   = getenv('GPMAT_GNUPLOT');   end
if ~exist('gp_cfg_defterm',   'var'), gp_cfg_defterm   = getenv('GPMAT_DEFTERM');   end
if ~exist('gp_cfg_imviewer',  'var'), gp_cfg_imviewer  = getenv('GPMAT_IMVIEWER');  end
if ~exist('gp_cfg_epsviewer', 'var'), gp_cfg_epsviewer = getenv('GPMAT_EPSVIEWER'); end
if ~exist('gp_cfg_pdfviewer', 'var'), gp_cfg_pdfviewer = getenv('GPMAT_PDFVIEWER'); end
if ~exist('gp_cfg_svgviewer', 'var'), gp_cfg_svgviewer = getenv('GPMAT_SVGVIEWER'); end
if ~exist('gp_cfg_eps2pdf',   'var'), gp_cfg_eps2pdf   = getenv('GPMAT_EPS2PDF');   end
if ~exist('gp_cfg_pdf2svg',   'var'), gp_cfg_pdf2svg   = getenv('GPMAT_PDF2SVG');   end
if ~exist('gp_cfg_imconv',    'var'), gp_cfg_imconv    = getenv('GPMAT_IMCONV');    end
if ~exist('gp_cfg_pdfcrop',   'var'), gp_cfg_pdfcrop   = getenv('GPMAT_PDFCROP');   end
if ~exist('gp_cfg_pdftoeps',  'var'), gp_cfg_pdftoeps  = getenv('GPMAT_PDFTOEPS');  end
if ~exist('gp_cfg_pdflatex',  'var'), gp_cfg_pdflatex  = getenv('GPMAT_PDFLATEX');  end

% Example (Linux: set in ~/.bash_profile or equivalent)
%
% export GPMAT_GNUPLOT="gnuplot"
% export GPMAT_DEFTERM="x11"
% export GPMAT_IMVIEWER="feh"
% export GPMAT_EPSVIEWER="gv -antialias -resize"
% export GPMAT_PDFVIEWER="mupdf"
% export GPMAT_SVGVIEWER="inkview"
% export GPMAT_EPS2PDF="epstopdf"
% export GPMAT_PDF2SVG="pdf2svg"
% export GPMAT_IMCONV="convert -flatten -quality 100 -density 90"
% export GPMAT_PDFCROP="pdfcrop --margins 2"
% export GPMAT_PDFTOEPS="pdftops -eps -level3"
% export GPMAT_PDFLATEX="pdflatex --shell-escape --file-line-error --halt-on-error --interaction nonstopmode"

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
