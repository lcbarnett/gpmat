function s = gp_get_screensize(pfx)

if nargin < 1 || isempty(pfx), pfx = ''; end

if isunix
	[status,cmdout] = system('xdpyinfo | grep dimensions');
	if status ~= 0 % command failed
		fprintf(2,'%sWARNING: system screen size query failed; using\n',pfx);
		fprintf(2,'%spossibly inaccurate Matlab screen size query\n',pfx);
		s = mat_get_screensize;
	else
		subs = extract(cmdout,digitsPattern);
		s.pixels = [str2double(subs{1}) str2double(subs{2})];
		s.inches = [str2double(subs{3}) str2double(subs{4})]/25.4;
	end
elseif ispc
	fprintf(2,'%sWARNING: using possibly inaccurate Matlab screen size query\n',pfx);
	fprintf(2,'%sIf anyone knows how to get the screen size accurately in\n',pfx);
	fprintf(2,'%sWindows please let the maintainer know!\n',pfx);
	s = mat_get_screensize;
elseif ismac
	fprintf(2,'%sWARNING: using possibly inaccurate Matlab screen size query\n',pfx);
	fprintf(2,'%sIf anyone knows how to get the screen size accurately in\n',pfx);
	fprintf(2,'%smacOS please let the maintainer know!\n',pfx);
	s = mat_get_screensize;
else
	fprintf(2,'%sWARNING: Failed to identify OS; using possibly inaccurate\n',pfx);
	fprintf(2,'%sMatlab screen size query\n',pfx);
	s = mat_get_screensize;
end

fprintf('%sScreen size = %dx%d pixels (%.2fx%.2f inches)\n',pfx,s.pixels(1),s.pixels(2),s.inches(1),s.inches(2));

end

function s = mat_get_screensize

	oldunits = get(0,'units');
	set(0,'units','pixels');
	screensize = get(0,'screensize');
	s.pixels = screensize([3 4]); % screen size in pixels/inches
	set(0,'units','inches');
	screensize = get(0,'screensize');
	s.inches = screensize([3 4]); % screen size in pixels/inches
	set(0,'units',oldunits);

end
