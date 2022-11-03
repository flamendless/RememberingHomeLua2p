Concord.component("typewriter_timer")

Concord.component("typewriter", function(c, every)
	ASSERT(type(every) == "number")
	c.every = every
end)

Concord.component("reflowprint", function(c, width, alignment, speed)
	ASSERT(type(width) == "number")
	ASSERT(type(alignment) == "string")
	SASSERT(speed, type(speed) == "number")
	c.width = width
	c.alignment = alignment
	c.dt = 0
	c.current = 1
	if DEV then
		c.speed = speed or 2.5
	else
		c.speed = speed or 1
	end
end)
