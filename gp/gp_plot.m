function gp_plot(gpcmdfile,interactive)

global gp_gnuplot;

if nargin < 2 || isempty(interactive), interactive = false; end
gpcmd = gp_gnuplot;

assert(exist(gpcmdfile,'file') == 2,'Couldn''t find Gnuplot command file: ''%s''',gpcmdfile);
[gppath,gpname,gpext] = fileparts(gpcmdfile);
gpscript = [gpname gpext];

% Linux: clearing Matlab's LD_LIBRARY_PATH seems to fix a lot of library nonsense
% Should probably retrieve your system's original library path, but that's a pain...
% Not sure how this issue pans out on non-Linux systems.

if isunix
	cmdstr = ['cd ' gppath ' && LD_LIBRARY_PATH= ' gpcmd ' -raise -persist ' gpscript];
else
	cmdstr = ['cd ' gppath ' && ' gpcmd ' -raise -persist ' gpscript];
end

fprintf('*** running command ''%s''\n',cmdstr);
if interactive
	cmdstr = [cmdstr ' -'];
	fprintf('\nEnter "q" or ^D to exit: ');
end
[status, result] = system(cmdstr);
if interactive, fprintf('\n'); end
assert(~status,result);
