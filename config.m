gpmat_root = fileparts(mfilename('fullpath')); % directory containing this file

% Globals (used in some functions)

global  gp_uniqid gp_gnuplot gp_defterm gp_imviewer gp_epsviewer gp_pdfviewer gp_svgviewer gp_eps2pdf gp_imconv gp_pdf2svg gp_pdfcrop gp_pdftoeps gp_pdflatex;

gp_uniqid    = false; % if true, append unique (time-sequential) id on temp plot files
gp_gnuplot   = 'gnuplot';
gp_defterm   = 'x11';
gp_imviewer  = 'feh';
gp_epsviewer = 'gv -antialias -resize';
gp_pdfviewer = 'mupdf';
gp_svgviewer = 'inkview';
gp_eps2pdf   = 'epstopdf';
gp_pdf2svg   = 'pdf2svg';
gp_imconv    = 'convert -flatten -quality 100 -density 90'; % density is dpi
gp_pdfcrop   = 'pdfcrop --margins 2'; % pixels
gp_pdftoeps  = 'pdftops -eps -level3';
gp_pdflatex  = 'pdflatex --shell-escape --file-line-error --halt-on-error --interaction nonstopmode';

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
