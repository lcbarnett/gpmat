function str = gp_symbol(str,term)

switch term
case {'eps','pdf','epsl'}
    str = sprintf('$\\\\%s$',str);
case 'png'
    str = sprintf('{/symbol %c}',str(1));
case {'x11','wxt',''}
	% do nothing %
otherwise
	error('gp_greek: unknown terminal type');
end
