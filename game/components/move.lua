Concord.component("move_by", function(c, delta, duration, delay)
	ASSERT(delta:type() == "vec2")
	ASSERT(type(duration) == "number")
	SASSERT(delay, type(delay) == "number")
	c.delta = delta
	c.duration = duration
	c.delay = delay or 0
end)

Concord.component("move_repeat")

Concord.component("move_to_x", function(c, dx, duration, delay)
	ASSERT(type(dx) == "number")
	ASSERT(type(duration) == "number")
	SASSERT(delay, type(delay) == "number")
	c.target_x = dx
	c.duration = duration
	c.delay = delay or 0
end)

Concord.component("move_to_original", function(c, duration, delay)
	ASSERT(type(duration) == "number")
	SASSERT(delay, type(delay) == "number")
	c.duration = duration
	c.delay = delay or 0
end)
