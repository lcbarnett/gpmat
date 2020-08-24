function gp_write(name,dat,precstr,griddata,colhead)

if nargin < 3 || isempty(precstr)
	precstr = ' %24.16f';
end

if nargin < 4 || isempty(griddata)
	griddata = false;
end

if iscell(precstr)
	assert(~griddata,'sorry, grid data does not support variable precision specs');
	assert(isvector(precstr) && length(precstr) == size(dat,2),'variable precision specs must match data columns');
end

if nargin < 5
	ch = false;
else
	ch = true;
	assert(~griddata,'column headers won''t work with grid data');
end

if iscell(dat)
	assert(isvector(dat),'data must be a be 2D matrix or a cell vector of 2D matrices');
	c = length(dat);
	for s=1:c
		assert(ismatrix(dat{s}),'data must be a be 2D matrix or a cell vector of 2D matrices');
	end
	if ch
		assert(iscell(colhead) && length(colhead) == c,'column headers must be a cell vector of cell strings matching the data');
		for s=1:c
			assert(iscellstr(colhead{s}),'each column headers must be a cell string');
		end
	end
else
	assert(ismatrix(dat),'data must be a be 2D matrix or a cell vector of 2D matrices');
	if ch
		assert(iscellstr(colhead),'column header must be a cell string');
	end
end

fd = fopen([name '.dat'],'w');
assert(fd>0,'failed to open file ''%s.dat'' for writing',name);

if iscell(dat)
	for s=1:c
		if ch
			for h = 1:length(colhead{s})
				fprintf(fd,' %24s',colhead{s}{h});
			end
			fprintf(fd,'\n');
		end
		gp_write_block(fd,dat{s},precstr);
		if s < c
			if griddata
				fprintf(fd,'\n');
			else
				fprintf(fd,'\n\n');
			end
		end
	end
else
	if ch
		for h = 1:length(colhead)
			fprintf(fd,'%24s',colhead{h});
		end
		fprintf(fd,'\n');
	end
	gp_write_block(fd,dat,precstr);
end

fclose(fd);

function gp_write_block(fd,dat,precstr)

[r,c] = size(dat);
if iscell(precstr)
	for i=1:r
		for j=1:c
			fprintf(fd,precstr{j},dat(i,j));
		end
		fprintf(fd,'\n');
	end
else
	for i=1:r
		fprintf(fd,precstr,dat(i,:));
		fprintf(fd,'\n');
	end
end
