function ss = gp_get_screensize(pfx)

% Get physical screen size in pixels, and resolution in DPI
%
% All bets are off for multiple displays!

if nargin < 1 || isempty(pfx), pfx = ''; end

if ispc

	fprintf(2,'%sWARNING: If anyone knows how to get the physical screen size\n',pfx);
	fprintf(2,'%saccurately in MS Windows please let the maintainer know!\n',pfx);
	ss = get_screensize(pfx);

elseif ismac

	fprintf(2,'%sWARNING: If anyone knows how to get the physical screen size\n',pfx);
	fprintf(2,'%accurately in macOS please let the maintainer know!\n',pfx);
	ss = get_screensize(pfx);

elseif isunix

	[status,cmdout] = system('xdpyinfo | grep dimensions'); % get pixels
	if status == 0 % success
		subs = extract(cmdout,digitsPattern);
		ss.pixels = [str2double(subs{1}) str2double(subs{2})];
		[status,cmdout] = system('xdpyinfo | grep resolution'); % get dpi
		if status == 0 % success
			subs = extract(cmdout,digitsPattern);
			if length(subs) == 1
				ss.dpi = str2double(subs{1});
			else
				ss.dpi(1) = str2double(subs{1});
				ss.dpi(2) = str2double(subs{2});
			end
		else
			fprintf(2,'%sWARNING: system screen size query failed\n',pfx);
			ss = get_screensize(pfx);
		end
	else
		fprintf(2,'%sWARNING: system screen size query failed\n',pfx);
		ss = get_screensize(pfx);
	end

else

	fprintf(2,'%sWARNING: Failed to identify OS\n',pfx);
	ss = get_screensize(pfx);

end

end

function ss = get_screensize(pfx)

	if usejava('awt') % Java method (experimental)

		% Not sure if this works correctly; it is "undocumented Matlab" and
		% I haven't been able to test it properly. See
		%
		% https://undocumentedmatlab.com/articles/working-with-non-standard-dpi-displays

		fprintf(2,'%sUsing experimental Java screen size query\n',pfx);

		dtk = java.awt.Toolkit.getDefaultToolkit;
		jss = dtk.getScreenSize;
		ss.pixels = [jss.getWidth jss.getHeight];
		ss.dpi = dtk.getScreenResolution;

	else % Matlab method (possibly bogus)

		% The problem is that Matlab does not always report the PHYSICAL
		% screen size (which Gnuplot will use). This is in particular a
		% problem if Matlab is using software GL rendering, and (reportedly)
		% on MacOS with some Retina displays. Thus this function may return
		% an incorrect result. See
		%
		% https://uk.mathworks.com/help/matlab/ref/matlab.ui.root-properties.html
		%
		% In particular the sections on CreenSize and ScreenPixelsPerInch (insane).

		fprintf(2,'%sUsing potentially inaccurate Matlab screen size query\n',pfx);
		fprintf(2,'%s(If JVM is running you may get a better result)\n',pfx);

		oldunits = get(0,'units');
		set(0,'units','pixels');
		gr = groot; % Matlab graphics root object
		ss.pixels = gr.ScreenSize([3 4]);
		ss.dpi = gr.ScreenPixelsPerInch;
		set(0,'units',oldunits);

	end

end
