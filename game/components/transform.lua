Concord.component("transform", function(c, rotation, scale, offset, shear)
	SASSERT(rotation, type(rotation) == "number")
	SASSERT(scale, scale:type() == "vec2")
	SASSERT(offset, scale:type() == "vec2")
	SASSERT(shear, scale:type() == "vec2")
	c.rotation = rotation or 0
	c.scale = scale or vec2(1, 1)
	c.offset = offset or vec2()
	c.shear = shear or vec2()
	c.orig_scale = c.scale:copy()
end)

Concord.component("quad_transform", function(c, rotation, scale, offset, shear)
	SASSERT(rotation, type(rotation) == "number")
	SASSERT(scale, scale:type() == "vec2")
	SASSERT(offset, scale:type() == "vec2")
	SASSERT(shear, scale:type() == "vec2")
	c.rotation = rotation or 0
	c.scale = scale or vec2(1, 1)
	c.offset = offset or vec2()
	c.shear = shear or vec2()
	c.orig_scale = c.scale:copy()
end)

Concord.component("depth_zoom", function(c, zoom_factor)
	ASSERT(type(zoom_factor) == "number")
	c.value = zoom_factor
end)
