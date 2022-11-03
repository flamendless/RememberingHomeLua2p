Concord.component("bounding_box", function(c, pos, size)
	ASSERT(pos:type() == "vec2")
	ASSERT(size:type() == "vec2")
	c.pos = pos
	c.size = size
	c.screen_pos = pos:copy()
end)
