Concord.component("auto_scale", function(c, target_size, is_proportion, is_floored)
	ASSERT(target_size:type() == "vec2")
	SASSERT(is_proportion, type(is_proportion) == "boolean")
	SASSERT(is_floored, type(is_floored) == "boolean")
	c.value = target_size
	c.is_proportion = not not is_proportion
	c.is_floored = not not is_floored
end)
