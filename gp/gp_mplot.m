function gp_mplot(dat,ptitle,legend,gpcmds,term,scale,fs,stem)

global gp_uniqid;

assert(iscell(dat) && ismatrix(dat),'data must be a cell matrix');
[R,C] = size(dat);
for j = 1:C
	for i = 1:R
		assert(ismatrix(dat{i,j}),'data entries must be matrices');
	end
end

if nargin < 2
	ptitle = [];
elseif ~isempty(ptitle)
	assert(ischar(ptitle),'plot title must be a string');
end

if nargin < 3 || isempty(legend)
	for j = 1:C
		for i = 1:R
			ncols = size(dat{i,j},2)-1;
			legend{i,j} = cell(1,ncols);
			for c = 1:ncols
				legend{i,j}{c} = sprintf('y%d',c);
			end
		end
	end
else
	assert(iscell(legend) && ismatrix(legend),'legend must be a cell matrix of (cell) strings');
	assert(isequal(size(legend),size(dat)),'legends must match data');
	for j = 1:C
		for i = 1:R
			if ischar(legend{i,j})
				legend{i,j} = cellstr(legend{i,j});
			else
				assert(iscellstr(legend{i,j}),'legends must be strings or cell strings');
			end
			ncols = size(dat{i,j},2)-1;
			nlabs = length(legend{i,j});
			if iscolumn(legend{i,j}), legend{i,j} = legend{i,j}'; end
			if nlabs < ncols
				fprintf(2,'WARNING: too few legends\n');
				legend{i,j} = [legend{i,j} cell(1,ncols-nlabs)];
				for c = nlabs+1:ncols
					legend{i,j}{c} = sprintf('y%d',c);
				end
			elseif nlabs > ncols
				fprintf(2,'WARNING: too many legends\n');
			end
		end
	end
end

if nargin < 4 || isempty(gpcmds)
	gp_pre  = '';
	gp_post = '';
elseif ischar(gpcmds)
	gp_pre  = [gpcmds '\n'];
	gp_post = '';
elseif iscellstr(gpcmds) && length(gpcmds) == 2
	gp_pre  = [gpcmds{1} '\n'];
	gp_post = [gpcmds{2} '\n'];
else
	error('Gnuplot commands must be a string or a 2-cell string');
end

if nargin < 5, term   = []; end
if nargin < 6, scale  = 1;  end
if nargin < 7, fs     = []; end

if nargin < 8 || isempty(stem)
    if gp_uniqid
        stem = fullfile(tempdir,['gptmp_' datestr(now,'yyyy-mm-dd-HH:MM:SS:FFF')]);
    else
        stem = fullfile(tempdir,'gptmp');
    end
end

% Write the data

gp_write(stem,dat(:));

% Open the Gnuplot command file

%gp = gp_open(stem,term,[1.5*scale,C/R],fs);
gp = gp_open(stem,term,scale,fs);

% Write the Gnuplot command file

fprintf(gp,'datfile = "%s.dat"\n',stem);
fprintf(gp,'set xlabel "x"\n');
fprintf(gp,'set ylabel "y" norot\n');
fprintf(gp,gp_pre);
if isempty(ptitle)
	fprintf(gp,'\nset multiplot layout %d,%d columnsfirst\n\n',R,C);
else
	fprintf(gp,'\nset multiplot title "%s" layout %d,%d columnsfirst\n\n',ptitle,R,C);
end
k = 0;
for j = 1:C
	for i = 1:R
		ncols = size(dat{i,j},2)-1;
		fprintf(gp,'plot \\\n');
		for c = 1:ncols
			fprintf(gp,'\tdatfile index %d u 1:%d w l ls %d t "%s"',k,c+1,c,legend{i,j}{c});
			if c < ncols, fprintf(gp,', \\\n'); else, fprintf(gp,'\n'); end
		end
		k = k+1;
	end
end
fprintf(gp,gp_post);
fprintf(gp,'\nunset multiplot\n');

% Close the Gnuplot command file and plot

gp_close(gp,stem,term,2);
