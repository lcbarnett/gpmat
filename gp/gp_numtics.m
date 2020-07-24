function tics = gp_numtics(num,pos)

assert(isvector(num),'numbers must be a vector');
assert(isvector(pos),'positions must be a vector');
n = length(num);
assert(length(pos) == n,'numbers must match positions');

tics = ['"' num2str(num(1)) '" ' num2str(pos(1))];
for i = 2:n
	tics = [tics ', "' num2str(num(i)) '" ' num2str(pos(i))];
end
