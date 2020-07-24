function gp_qplot(x,y,legend,gpcmds,term,scale,fs,stem)

global gp_uniqid;

assert(nargin > 1,'Need at least an x and y argument!');
assert(~isempty(y) && ismatrix(y),'y must be a matrix');
if isempty(x)
	x = (1:size(y,1))';
else
	assert(isvector(x),'x must be a vector');
	if isrow(x)
		x = x'; % convert to column vector
		y = y'; % transpose
	end
end
assert(size(y,1) == length(x),'x and y must match');

ncols = size(y,2);
if nargin < 3 || isempty(legend)
	legend = cell(1,ncols);
	for c = 1:ncols
		legend{c} = sprintf('y%d',c);
	end
else
	if ischar(legend)
		legend = cellstr(legend);
	else
		assert(iscellstr(legend),'legend must be a string or cell string');
	end
	if iscolumn(legend), legend = legend'; end
	nlabs = length(legend);
	if nlabs < ncols
		fprintf(2,'WARNING: too few legends\n');
		legend = [legend cell(1,ncols-nlabs)];
		for c = nlabs+1:ncols
			legend{c} = sprintf('y%d',c);
		end
	elseif nlabs > ncols
		fprintf(2,'WARNING: too many legends\n');
	end
end

gp_pre  = '';
gp_post = '';
gp_ls   = 'lines';
if nargin >= 4 && ~isempty(gpcmds)
	if ischar(gpcmds)
		gp_pre  = [gpcmds '\n'];
	elseif iscellstr(gpcmds)
		gp_pre  = [gpcmds{1} '\n'];
		if length(gpcmds) > 1
			gp_ls = gpcmds{2};
			if length(gpcmds) > 2
				gp_post = [gpcmds{3} '\n'];
			end
		end
	else
		error('Gnuplot commands must be a string or a string');
	end
end

if nargin < 5, term   = []; end
if nargin < 6, scale  = []; end
if nargin < 7, fs     = []; end

if nargin < 8 || isempty(stem)
    if gp_uniqid
        stem = fullfile(tempdir,['gptmp_' datestr(now,'yyyy-mm-dd-HH:MM:SS:FFF')]);
    else
        stem = fullfile(tempdir,'gptmp');
    end
end

% Write the data

gp_write(stem,[x y]);

% Open the Gnuplot command file

gp = gp_open(stem,term,scale,fs);

% Write the Gnuplot command file

fprintf(gp,'datfile = "%s.dat"\n',stem);
fprintf(gp,'set xlabel "x"\n');
fprintf(gp,'set ylabel "y" norot\n');
fprintf(gp,gp_pre);
fprintf(gp,'plot \\\n');
for c = 1:ncols
    fprintf(gp,'\tdatfile u 1:%d w %s ls %d t "%s"',c+1,gp_ls,c,legend{c});
    if c < ncols, fprintf(gp,', \\\n'); else, fprintf(gp,'\n'); end
end
fprintf(gp,gp_post);

% Close the Gnuplot command file and plot

gp_close(gp,stem,term);
