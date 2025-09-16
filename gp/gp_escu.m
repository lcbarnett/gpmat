function str = gp_escu(str,squote)

% Escape underscores in strings

if nargin < 2 || isempty(squote)
	str = replace(str,'_','\\\\_');  % for double-quoted (Gnuplot) strings
else
	str = replace(str,'_','\\_');    % for single-quoted (Gnuplot) strings
end
