Concord.component("pos", function(c, pos)
	ASSERT(pos:type() == "vec2")
	c.pos = pos
	c.orig_pos = pos:copy()
end)

Concord.component("ref_pos", function(c, pos)
	ASSERT(pos:type() == "vec2")
	c.value = pos
end)

Concord.component("size", function(c, size)
	ASSERT(size:type() == "vec2")
	c.size = size
end)
