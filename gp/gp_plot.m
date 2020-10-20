function gp_plot(gpcmdfile,interactive)

global gp_gnuplot;

if nargin < 2 || isempty(interactive), interactive = false; end
gpcmd = gp_gnuplot;

assert(exist(gpcmdfile,'file') == 2,'Couldn''t find Gnuplot command file: ''%s''',gpcmdfile);
[gppath,gpname,gpext] = fileparts(gpcmdfile);
gpscript = [gpname gpext];

cmdstr = ['cd ' gppath ' && ' gpcmd ' -raise -persist ' gpscript];

fprintf('*** running command ''%s''\n',cmdstr);
if interactive
	cmdstr = [cmdstr ' -'];
	fprintf('\nEnter "q" or ^D to exit: ');
end
[status, result] = system(cmdstr);
if interactive, fprintf('\n'); end
assert(~status,result);
