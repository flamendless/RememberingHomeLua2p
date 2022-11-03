Concord.component("angle", function(c, radius, angle)
	ASSERT(type(radius) == "number")
	SASSERT(angle, type(angle) == "number")
	c.radius = radius
	c.angle = angle or 0
	c.orig_radius = radius
end)

Concord.component("angular_speed", function(c, speed, dir)
	ASSERT(type(speed) == "number")
	ASSERT(type(dir) == "number")
	c.speed = speed
	c.dir = dir
end)
