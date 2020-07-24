function gp_close(gp,name,term,plotit,interactive)

global gp_gnuplot gp_defterm gp_imviewer gp_epsviewer gp_pdfviewer gp_svgviewer gp_eps2pdf gp_imconv gp_pdf2svg gp_pdfcrop gp_pdftoeps gp_pdflatex;

if nargin < 2 || isempty(name)
	name = [tempdir filesep 'gplot'];
	fprintf(2,'WARNING: no plot filename specified - defaulting to ''%s''\n',name);
end

if nargin < 3 || isempty(term)
    term = gp_defterm;
end

if nargin < 4 || isempty(plotit)
	plotit = 2; % generate image file & display
end

if nargin < 5 || isempty(interactive)
	interactive = false;
end

term = lower(term);
xterm = isequal(term([1 2]),'x-');

if xterm
	imsufx = term(3:end);
	xpdf = isequal(imsufx,'pdf');
	xeps = isequal(imsufx,'eps');
	xsvg = isequal(imsufx,'svg');
	fprintf(gp,'\nset out\n');
	fprintf(gp,'set term pop\n');
    fprintf(gp,'\n### output files\n\n');
	fprintf(gp,'PDF = FNAME.".pdf"\n');
	if xpdf
		fprintf(gp,'# IMG = FNAME.".XXX"\n');
	else
		fprintf(gp,'IMG = FNAME.".%s"\n',imsufx);
	end
    fprintf(gp,'\n### generate PDF, clean up\n\n');
	fprintf(gp,'system "%s ".FNAME."-inc.eps"\n',gp_eps2pdf);
	fprintf(gp,'system "%s ".FNAME.".tex"\n',gp_pdflatex);
	fprintf(gp,'system "rm -f ".FNAME.".tex ".FNAME.".aux ".FNAME.".log ".FNAME."-inc.eps ".FNAME."-inc.pdf"\n');
    fprintf(gp,'\n### transform PDF/generate image\n\n');
	fprintf(gp,'# system "%s ".PDF." ".PDF\n',gp_pdfcrop);
	if xpdf
		fprintf(gp,'# system "%s ".PDF." ".IMG # png, jpg, etc.\n',gp_imconv);
	elseif xeps
		fprintf(gp,'# system "%s ".PDF." ".IMG # png, jpg, etc.\n',gp_imconv);
		fprintf(gp,'system "%s ".PDF." ".IMG\n',gp_pdftoeps);
	elseif xsvg
		fprintf(gp,'# system "%s ".PDF." ".IMG # png, jpg, etc.\n',gp_imconv);
		fprintf(gp,'system "%s ".PDF." ".IMG\n',gp_pdf2svg);
	else
		fprintf(gp,'system "%s ".PDF." ".IMG # png, jpg, etc.\n',gp_imconv);
	end
	if plotit > 1
		fprintf(gp,'\n### display PDF/image\n\n');
		if xpdf
			fprintf(gp,'# system "%s ".IMG." &"\n',gp_imviewer);
			fprintf(gp,'system "%s ".PDF." &"\n',gp_pdfviewer);
		elseif xeps
			fprintf(gp,'# system "%s ".IMG." &"\n',gp_imviewer);
			fprintf(gp,'# system "%s ".PDF." &"\n',gp_pdfviewer);
			fprintf(gp,'system "%s ".IMG." &"\n',gp_epsviewer);
		elseif xsvg
			fprintf(gp,'# system "%s ".IMG." &"\n',gp_imviewer);
			fprintf(gp,'# system "%s ".PDF." &"\n',gp_pdfviewer);
			fprintf(gp,'system "%s ".IMG." &"\n',gp_svgviewer);
		else
			fprintf(gp,'system "%s ".IMG." &"\n',gp_imviewer);
			fprintf(gp,'# system "%s ".PDF." &"\n',gp_pdfviewer);
		end
	else
		fprintf(gp,'\n### display PDF/image\n\n');
		if xpdf
			fprintf(gp,'# system "%s ".IMG." &"\n',gp_imviewer);
			fprintf(gp,'# system "%s ".PDF." &"\n',gp_pdfviewer);
		elseif xeps
			fprintf(gp,'# system "%s ".IMG." &"\n',gp_imviewer);
			fprintf(gp,'# system "%s ".PDF." &"\n',gp_pdfviewer);
			fprintf(gp,'# system "%s ".IMG." &"\n',gp_epsviewer);
		elseif xsvg
			fprintf(gp,'# system "%s ".IMG." &"\n',gp_imviewer);
			fprintf(gp,'# system "%s ".PDF." &"\n',gp_pdfviewer);
			fprintf(gp,'# system "%s ".IMG." &"\n',gp_svgviewer);
		else
			fprintf(gp,'# system "%s ".IMG." &"\n',gp_imviewer);
			fprintf(gp,'# system "%s ".PDF." &"\n',gp_pdfviewer);
		end
	end
    fprintf(gp,'\n');
	if interactive
		fprintf(2,'WARNING: No interactive mode!');
	end
else
	switch term
	case 'x11'
		fprintf(gp,'\nset term pop\n');
		if plotit == 1
			fprintf(2,'WARNING: No image file!');
		end
	case 'png'
		fprintf(gp,'\nset out\n');
		fprintf(gp,'set term pop\n\n');
		if plotit > 1
			fprintf(gp,'system "%s ".(pngfile)." &"\n',gp_imviewer);
		else
			fprintf(gp,'# system "%s ".(pngfile)." &"\n',gp_imviewer);
		end
		if interactive
			fprintf(2,'WARNING: No interactive mode!');
		end
	case 'svg'
		fprintf(gp,'\nset out\n');
		fprintf(gp,'set term pop\n\n');
		if plotit > 1
			fprintf(gp,'system "%s ".(svgfile)." &"\n',gp_svgviewer);
		else
			fprintf(gp,'# system "%s ".(svgfile)." &"\n',gp_svgviewer);
		end
		if interactive
			fprintf(2,'WARNING: No interactive mode!');
		end
	case'eps'
		fprintf(gp,'\nset out\n');
		fprintf(gp,'set term pop\n\n');
		if plotit > 1
			fprintf(gp,'system "%s ".(epsfile)." &"\n',gp_epsviewer);
		else
			fprintf(gp,'# system "%s ".(epsfile)." &"\n',gp_epsviewer);
		end
		if interactive
			fprintf(2,'WARNING: No interactive mode!');
		end
	case 'pdf'
		fprintf(gp,'\nset out\n');
		fprintf(gp,'set term pop\n\n');
		fprintf(gp,'system "%s ".(epsfile)\n',gp_eps2pdf);
		if plotit > 1
			fprintf(gp,'system "%s ".(pdffile)." &"\n',gp_pdfviewer);
		else
			fprintf(gp,'# system "%s ".(pdffile)." &"\n',gp_pdfviewer);
		end
		if interactive
			fprintf(2,'WARNING: No interactive mode!');
		end
	case 'wxt'
		fprintf(gp,'\nset term pop\n');
		if plotit == 1
			fprintf(2,'WARNING: No image file!');
		end
	otherwise
		error('gp_plot: unknown terminal type');
	end
end

fclose(gp);

if plotit > 0
	gp_plot([name '.gp'],interactive);
end
