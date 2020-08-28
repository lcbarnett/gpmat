function gp = gp_open(name,term,scale,fs)

global gp_gnuplot gp_defterm gp_imviewer gp_epsviewer gp_pdfviewer gp_svgviewer gp_eps2pdf gp_imconv gp_pdf2svg gp_pdfcrop gp_pdftoeps gp_pdflatex;

if nargin < 1 || isempty(name)
	name = [tempdir filesep 'gplot'];
	fprintf(2,'WARNING: no plot file name specified - defaulting to ''%s''\n',name);
end

if nargin < 2 || isempty(term)
    term = gp_defterm;
end

term = lower(term);
xterm = isequal(term([1 2]),'x-');

oldunits = get(0,'units');

if xterm
	set(0,'units','inches');
else
	switch term
		case {'xll', 'png','svg','wxt'}, set(0,'units','pixels');
		case {'pdf','eps'             }, set(0,'units','inches');
	end
end
screensize = get(0,'screensize');
screensize = screensize([3 4]); % screen size in pixels/inches
set(0,'units',oldunits);

darat = 4/3;  % default x/y aspect ratio
dfsch = 1/2;  % default fraction of screen height
xsadj = 0.97; % leave a little space for desktop furniture
ysadj = 0.94; % leave a little space for desktop furniture

if nargin < 3 || isempty(scale), scale = 1; end

assert(isnumeric(scale) && isvector(scale),'scale must be a scalar or 2-vector');

xscreen  = xsadj*screensize(1); % plot window max screen width
yscreen  = ysadj*screensize(2); % plot window max screen height
dyscreen = dfsch*screensize(2); % plot window default screen height

if     length(scale) == 1
	if     scale > 0 % scale default height, default x/y aspect ratio
		if isinf(scale)
			ysize = yscreen;
		else
			ysize = scale*dyscreen;
		end
	elseif scale < 0 % -scale is y-pixels; use default x/y aspect ratio
		if isinf(scale)
			ysize = yscreen;
		else
			ysize = -scale;
		end
	else
		error('bad scale parameters')
	end
	xsize = darat*ysize; % apply aspect ratio
elseif length(scale) == 2
	if     scale(1) > 0 && scale(2) > 0  %  scale(1) is scale,     scale(2) is x/y aspect ratio
		if isinf(scale(1))
			ysize = yscreen;
		else
			ysize = scale(1)*dyscreen;
		end
		if isinf(scale(2))
			xsize = xscreen;
		else
			xsize = scale(2)*ysize;
		end
	elseif scale(1) < 0 && scale(2) > 0  % -scale(1) is y-pixels,  scale(2) x/y aspect ratio
		if isinf(scale(1))
			ysize = yscreen;
		else
			ysize = -scale(1);
		end
		xsize = scale(2)*ysize;
	elseif scale(1) < 0 && scale(2) < 0  % -scale(1) is x-pixels, -scale(2) is y-pixels
		if isinf(scale(1))
			xsize = xscreen;
		else
			xsize = -scale(1);
		end
		if isinf(scale(2))
			ysize = yscreen;
		else
			ysize = -scale(2);
		end
	else
		error('bad scale parameters')
	end
else
	error('scale must be a scalar or 2-vector');
end

if xsize >  xscreen
	fprintf(2,'WARNING: plot bigger than screen horizontally!\n');
	xsize = xscreen;

end

if ysize > yscreen
	fprintf(2,'WARNING: plot bigger than screen vertically!\n');
	ysize = yscreen;

end

if nargin < 4 || isempty(fs)
    fs = 12;
end

[gp,emsg] = fopen([name '.gp'],'w+t');
assert(gp ~= -1,'failed to open Gnuplot script file ''%'': %s',[name '.gp'],emsg);

[fdir,fname,fext] = fileparts(name);
fname = strrep([fname fext],'.','_'); % dots in filenames tend to bork stuff; best avoided

if xterm
	fprintf(gp,'cd "%s"\n\n',fdir);
	fprintf(gp,'set term epslatex standalone color solid size %f,%f %d\n\n',xsize,ysize,fs);
    fprintf(gp,'FNAME = "%s"\n\n',fname);
    fprintf(gp,'set out FNAME.".tex"\n\n');
else
	switch term
	case 'x11'
		fprintf(gp,'set term x11 enhanced solid persist size %d,%d\n\n',round(xsize),round(ysize));
	case 'png'
		fprintf(gp,'cd "%s"\n\n',fdir);
		fprintf(gp,'set term png font "Times,%d" size %d,%d enhanced\n',fs,round(xsize),round(ysize));
		fprintf(gp,'pngfile = "%s.png"\n',fname);
		fprintf(gp,'set out pngfile\n\n');
	case 'svg'
		fprintf(gp,'cd "%s"\n\n',fdir);
	%	fprintf(gp,'set term svg size %d,%d dynamic mouse standalone font "Times,%d" enhanced\n',round(xsize),round(ysize),fs);
		fprintf(gp,'set term svg size %d,%d dynamic font "Times,%d" enhanced\n',round(xsize),round(ysize),fs);
		fprintf(gp,'svgfile = "%s.svg"\n',fname);
		fprintf(gp,'set out svgfile\n\n');
	case 'eps'
		fprintf(gp,'cd "%s"\n\n',fdir);
		fprintf(gp,'set term post eps enhanced color solid size %f,%f font "Times,%d"\n',xsize,ysize,2*fs);
		fprintf(gp,'epsfile = "%s.eps"\n',fname);
		fprintf(gp,'set out epsfile\n\n');
	case 'pdf'
		fprintf(gp,'cd "%s"\n\n',fdir);
		fprintf(gp,'set term post eps enhanced color solid size %f,%f font "Times,%d"\n',xsize,ysize,2*fs);
		fprintf(gp,'epsfile = "%s.eps"\n',fname);
		fprintf(gp,'pdffile = "%s.pdf"\n',fname);
		fprintf(gp,'set out epsfile\n\n');
	case 'wxt'
		fprintf(gp,'set term wxt size %d,%d enhanced font "Times,%d" persist\n\n',round(xsize),round(ysize),fs);
	case ''
		% do nothing %
	otherwise
		error('gp_plot: unknown terminal type');
	end
end
