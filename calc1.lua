
local lpeg = require('lpeg')
setmetatable(_ENV, { __index = lpeg })

function eval(n1, op, n2)
	if op == '+' then 
		return n1 + n2
	elseif op == '-' then 
		return n1 - n2
	elseif op == '*' then 
		return n1 * n2
	elseif op == '/' then 
		if n2 == 0 then
			return 'Divide by zero'
		else
			return n1 / n2
		end
	else return n1
	end
end

number = R('09')^1 / tonumber
space = S(' \t\n\r')^0
expr = (space * number * space * C('+') * space * number * space * -1 +
        space * number * space * C('-') * space * number * space * -1 +
        space * number * space * C('*') * space * number * space * -1 +
        space * number * space * C('/') * space * number * space * -1) / eval

local enter = 'start'
while enter ~= '' do
	enter = io.read()
	print(expr:match(enter))
end	