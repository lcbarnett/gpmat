function gp_write_matrix(name,dat,griddata,revwrite,precstr)

if nargin < 3 || isempty(griddata), griddata = true;       end
if nargin < 4 || isempty(revwrite), revwrite = true;       end
if nargin < 5 || isempty(precstr),  precstr  = ' %24.16f'; end

if iscell(dat)
	assert(isvector(dat),'data must be a be 2D matrix or a cell vector of 2D matrices');
	c = length(dat);
	for s=1:c
		assert(ismatrix(dat{s}),'data must be a be 2D matrix or a cell vector of 2D matrices');
	end
else
	assert(ismatrix(dat),'data must be a be 2D matrix or a cell vector of 2D matrices');
end

fd = fopen([name '.dat'],'w');
assert(fd>0,'failed to open file ''%s.dat'' for writing',name);

if iscell(dat)
	for s=1:c
		gp_write_block(fd,dat{s},revwrite,precstr);
		if s < c
			if griddata
				fprintf(fd,'\n');
			else
				fprintf(fd,'\n\n');
			end
		end
	end
else
	gp_write_block(fd,dat,revwrite,precstr);
end

fclose(fd);

function gp_write_block(fd,dat,revwrite,precstr)

r = size(dat,1);
if revwrite
	for i=r:-1:1
		fprintf(fd,precstr,dat(i,:));
		fprintf(fd,'\n');
	end
else
	for i=1:r
		fprintf(fd,precstr,dat(i,:));
		fprintf(fd,'\n');
	end
end
