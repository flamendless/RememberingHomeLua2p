--TODO make parallax stop system signal?
Concord.component("parallax_stop")

Concord.component("parallax", function(c, vel)
	ASSERT(vel:type() == "vec2")
	c.value = vel
end)

Concord.component("parallax_multi_sprite", function(c, tag)
	ASSERT(type(tag) == "string")
	c.value = tag
end)

Concord.component("parallax_gap", function(c, gap)
	ASSERT(type(gap) == "number")
	c.value = gap
end)
