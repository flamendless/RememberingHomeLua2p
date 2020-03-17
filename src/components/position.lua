local Concord = require("modules.concord.concord")
local Vec2 = require("modules.batteries.vec2")

Concord.component("position", function(c, x, y)
	if type(x) == "table" then
		assert(x.type == "vec2", "Passed argument must be of type 'vec2'")
		c.pos = x:copy()
	elseif type(x) == "number" then
		c.pos = Vec2:new(x, y)
	end
end)
