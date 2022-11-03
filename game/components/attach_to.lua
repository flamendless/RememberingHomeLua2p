local c_attach_to = Concord.component("attach_to", function(c, e_target)
	ASSERT(e_target.__isEntity)
	e_target:ensure("key")
	c.key = e_target.key.value
end)

function c_attach_to:serialize()
	return {key = self.key}
end

function c_attach_to:deserialize(data)
	self.key = data.key
end

Concord.component("attach_to_offset", function(c, value)
	ASSERT(value:type() == "vec2")
	c.value = value
end)

Concord.component("attach_to_spawn_point", function(c, value)
	ASSERT(value:type() == "vec2")
	c.value = value
end)
