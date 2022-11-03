Concord.component("light", function(c, light_shape, power)
	ASSERT(type(power) == "number")
	ASSERT(power >= 0 and power <= 4)
	c.light_shape = light_shape
	c.power = power
end)

Concord.component("light_timer", function(c, timer)
	SASSERT(timer, type(timer) == "number")
	c.value = timer or 0
	c.orig_value = c.value
end)

Concord.component("light_flicker", function(c, off_chance)
	ASSERT(type(off_chance) == "number")
	c.off_chance = off_chance
end)
