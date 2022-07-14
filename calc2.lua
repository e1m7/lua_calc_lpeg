
local lpeg = require('lpeg')
setmetatable(_ENV, { __index = lpeg })

number = R('09')^1 / tonumber
space = S(' \t\n\r')^0

function eval(num1, op, num2)
	if op == '+' then
		return num1 + num2
	elseif op == '-' then
		return num1 - num2
	elseif op == '*' then
		return num1 * num2
	elseif op == '/' then
		if num2 == 0 then
			return 'Divide by zero'
		else
			return num1 / num2
		end
	else
		return num1
	end
end

expr = P {
	"EXPRESSION";
	EXPRESSION = (V('TERMIN') * C(S('+-')) * V('EXPRESSION') + V('TERMIN')) / eval,
	TERMIN = (V('FACTOR') * C(S('/*')) * V('TERMIN') + V('FACTOR')) / eval,
	FACTOR = (space * '(' * V('EXPRESSION') * ')' * space + number) / eval
}

local text = 'start'
while text ~= '' do
	text = io.read()
	print(expr:match(text))
end	

