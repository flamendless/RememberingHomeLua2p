Concord.component("light_disabled")

Concord.component("light_id", function(c, n)
	ASSERT(type(n) == "number")
	c.value = n
end)

Concord.component("light_group", function(c, id)
	ASSERT(type(id) == "string")
	c.value = id
end)

Concord.component("light_switch_id", function(c, id)
	ASSERT(type(id) == "string")
	c.value = id
end)

Concord.component("point_light", function(c, size)
	ASSERT(type(size) == "number")
	c.value = size
	c.orig_value = size
end)

Concord.component("light_dir", function(c, t)
	ASSERT(type(t) == "table")
	c.value = t
	c.orig_value = tablex.copy(t)
end)

Concord.component("diffuse", function(c, t)
	ASSERT(type(t) == "table")
	c.value = t
	c.orig_value = tablex.copy(t)
end)

Concord.component("light_fading", function(c, amount, dir)
	ASSERT(type(amount) == "number")
	ASSERT(type(dir) == "number" and (dir == -1 or dir == 1))
	c.amount = amount
	c.dir = dir
end)

Concord.component("d_light_flicker_remove_after")
Concord.component("d_light_flicker_sure_on_after")
Concord.component("d_light_flicker", function(c, during, on_chance, off_chance)
	ASSERT(type(during) == "number")
	ASSERT(type(on_chance) == "number" and on_chance >= 0 and on_chance <= 1)
	ASSERT(type(off_chance) == "number" and off_chance >= 0 and off_chance <= 1)
	c.during = during
	c.on_chance = on_chance
	c.off_chance = off_chance
end)

Concord.component("d_light_flicker_repeat", function(c, count, delay)
	SASSERT(count, type(count) == "number")
	SASSERT(delay, type(delay) == "number")
	c.count = count or 0
	c.delay = delay or 0
	c.inf = c.count == -1
end)
