--TODO maybe this is not needed anymore
Concord.component("no_shader")

Concord.component("fog", function(c, speed)
	ASSERT(type(speed) == "number")
	c.shader = love.graphics.newShader(Shaders.paths.fog)
	c.speed = speed
end)
