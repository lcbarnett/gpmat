function gp_splotwrite(name,x,y,z,precstr)

if nargin < 5 || isempty(precstr)
	precstr = '\t%8d\t%8d\t%24.12f\n';
end

[fd,emsg] = fopen([name '.dat'],'w+t');
assert(fd ~= -1,'failed to open Gnuplot data file ''%'': %s',[name '.dat'],emsg);

assert(isvector(x) && isvector(y),'x, y must be vectors');

nx = length(x);
ny = length(y);

assert(ismatrix(z) && isequal(size(z),[ny nx]),'z must be a matrix matching the x, y vectors');

for i=1:nx
	for j=1:ny
		fprintf(fd,precstr,x(i),y(j),z(j,i));
	end
	fprintf(fd,'\n');
end

fclose(fd);
