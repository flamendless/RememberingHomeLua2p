Concord.component("bump")
Concord.component("wall")
Concord.component("ground")
Concord.component("skip_collider_update")

Concord.component("req_col_dir", function(c, dir)
	ASSERT(type(dir) == "number" and (dir == -1 or dir == 1))
	c.value = dir
end)

Concord.component("collider", function(c, size, filter)
	ASSERT(size:type() == "vec2")
	SASSERT(filter, type(filter) == "string")
	c.size = size
	c.w_h = size.x * 0.5
	c.h_h = size.y * 0.5
	c.is_hit = false
	c.normal = vec2()
	c.filter = filter
end)

Concord.component("collider_offset", function(c, offset)
	ASSERT(offset:type() == "vec2")
	c.value = offset
end)

Concord.component("collider_circle", function(c, size, offset)
	ASSERT(type(size) == "number")
	ASSERT(offset:type() == "vec2")
	c.size = size
	c.offset = offset
	c.is_hit = false
end)

Concord.component("collide_with", function(c, e)
	ASSERT(e.__isEntity and e.collider)
	e:ensure("key")
	c.value = e.key.value
end)
