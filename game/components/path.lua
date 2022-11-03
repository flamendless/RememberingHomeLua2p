Concord.component("path_loop")
Concord.component("path_repeat")
Concord.component("path_move")

Concord.component("path", function(c, points, max)
	ASSERT(type(points) == "table")
	SASSERT(max, type(max) == "number" and max > 0)
	if DEV then
		for _, v in ipairs(points) do
			ASSERT(v:type() == "vec2")
		end
	end
	c.points = points
	c.n_points = #points
	c.current_point = 1
	c.max = max or 1
end)

Concord.component("path_speed", function(c, speed)
	ASSERT(type(speed) == "number")
	c.value = speed
end)

Concord.component("apply_bezier_curve", function(c)
	c.dt = 0
end)
