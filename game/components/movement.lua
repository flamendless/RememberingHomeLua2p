Concord.component("movement")

Concord.component("random_walk", function(c, dir, distance, pos)
	ASSERT(type(dir) == "number" and (dir == -1 or dir == 1))
	ASSERT(type(distance) == "number" and distance > 0)
	ASSERT(pos:type() == "vec2")
	c.dir = dir
	c.distance = distance
	c.orig_pos = pos:copy()
end)
