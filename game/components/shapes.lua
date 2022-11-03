Concord.component("textured_line")

Concord.component("draw_mode", function(c, draw_mode)
	ASSERT(type(draw_mode) == "string")
	c.value = draw_mode
end)

Concord.component("point", function(c, size)
	ASSERT(type(size) == "number" and size >= 1)
	c.value = size
end)

Concord.component("circle", function(c, radius, segments, start_angle, end_angle)
	ASSERT(type(radius) == "number")
	SASSERT(segments, type(segments) == "number")
	SASSERT(start_angle, type(start_angle) == "number")
	SASSERT(end_angle, type(end_angle) == "number")
	c.radius = radius
	c.segments = segments or radius

	if start_angle and end_angle then
		c.start_angle = start_angle or -HALF_PI
		c.end_angle = end_angle or TWO_PI
		c.is_arc = true
	end
end)

Concord.component("rect", function(c, size)
	ASSERT(size:type() == "vec2")
	c.size = size
	c.half_size = size:sdiv(2)
end)

Concord.component("rect_border", function(c, border)
	ASSERT(border:type() == "vec2")
	c.value = border
end)

Concord.component("line_width", function(c, line_width)
	ASSERT(type(line_width) == "number")
	c.value = line_width
end)

Concord.component("arc_type", function(c, arc_type)
	ASSERT(type(arc_type) == "string")
	c.value = arc_type
end)
