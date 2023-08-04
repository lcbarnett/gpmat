set term lua tikz latex size 24,18 fontscale 1.2 standalone

NAME = "gptikz_test"
TEX  = NAME.".tex"
PNG  = NAME.".pdf"

set out TEX

set xlabel "This is $x$"
set arrow from graph 0.1,graph 0.3 to graph 0.7,graph 0.8
set grid ls 1 lc "gray"
plot sin(x) w lines, x*cos(x) w points pt 6

set out

PDFCMD = "pdflatex --shell-escape --file-line-error --halt-on-error --interaction nonstopmode"
COMP = PDFCMD." ".TEX
system COMP

CLEAN = NAME.".tex ".NAME.".aux ".NAME.".log"
system "rm -f ".CLEAN

DISP = "mupdf ".PNG." &"
system DISP
