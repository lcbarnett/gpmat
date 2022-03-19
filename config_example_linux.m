%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gpmat user configuration example script for Linux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% See config_default.m for more detail.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Global options

gp_cfg_testing     = false;                                       % include test directory?
gp_cfg_uniqid      = false;                                       % append unique (time-sequential) id on temp plot files?
gp_cfg_screensize  = [];                                          % Screen size: vector [width, height, DPI] (pixels) - if empty, calculated automatically in 'startup.m'
gp_cfg_gnuplot     = 'gnuplot';                                   % Gnuplot executable
gp_cfg_defterm     = 'x11';                                       % Default Gnuplot terminal

% Some image creation/viewing functionality will not work if these variables are not set!

gp_cfg_imviewer    = 'feh';                                       % Raster image viewer (png, etc.)
gp_cfg_epsviewer   = 'gv -antialias -resize';                     % Encapsulated Postscript (EPS) viewer
gp_cfg_pdfviewer   = 'mupdf';                                     % PDF viewer
gp_cfg_svgviewer   = 'inkview';                                   % SVG viewer
gp_cfg_eps2pdf     = 'epstopdf';                                  % EPS -> PDF converter
gp_cfg_pdf2svg     = 'pdf2svg';                                   % PDF -> SVG converter
gp_cfg_imconv      = 'convert -flatten -quality 100 -density 90'; % image conversion utility
gp_cfg_pdfcrop     = 'pdfcrop --margins 2';                       % PDF cropping utility
gp_cfg_pdftoeps    = 'pdftops -eps -level3';                      % PDF -> EPS converter
gp_cfg_pdflatex    = 'pdflatex --shell-escape --file-line-error --halt-on-error --interaction nonstopmode'; % LaTeX call

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% An interesting strategy to convert pdf to svg (alternative to pdf2svg), which
% basically converts all PDF fonts to glyphs so that Inkscape handles them okay.
% In fact pdf2svg handles this similarly, I think. The problem is that Inkscape
% generally doesn't seem to find good matching fonts.
%
% http://www.cityinthesky.co.uk/opensource/pdf2svg/
% https://stackoverflow.com/questions/10288065/convert-pdf-to-clean-svg
% https://stackoverflow.com/questions/28797418/replace-all-font-glyphs-in-a-pdf-by-converting-them-to-outline-shapes
%
% gs -o testo.pdf -dNoOutputFonts -sDEVICE=pdfwrite test.pdf && inkscape --without-gui --file=testo.pdf --export-plain-svg=testo.svg
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
