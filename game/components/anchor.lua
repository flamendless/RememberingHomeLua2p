local c_anchor = Concord.component("anchor", function(c, e, anchor, padding)
	ASSERT(e.__isEntity)
	ASSERT(anchor:type() == "vec2")
	ASSERT(padding, padding:type() == "vec2")
	e:ensure("key")
	c.key = e.key.value
	c.anchor = anchor
	c.padding = padding
end)

function c_anchor:serialize()
	return {
		key = self.key,
		anchor = self.anchor,
		padding = self.padding,
	}
end

function c_anchor:deserialize(data)
	self.key = data.key
	self.anchor = data.anchor
	self.padding = data.padding
end
