Concord.component("flashlight")
Concord.component("flashlight_light")

Concord.component("battery", function(c, pct)
	SASSERT(pct, type(pct) == "number" and pct > 0 and pct <= 100)
	c.pct = pct
	c.orig_pct = pct
end)

Concord.component("battery_state", function(c, state)
	ASSERT(type(state) == "string")
	c.value = state
end)

Concord.component("fl_spawn_offset", function(c, offset)
	SASSERT(offset, offset:type() == "vec2")
	c.offset = offset or vec2()
	c.dy = 0
	c.orig_offset = c.offset:copy()
	c.orig_dy = c.dy
end)
