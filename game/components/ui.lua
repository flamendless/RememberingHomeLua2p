Concord.component("ui_element")

Concord.component("layer", function(c, id, n)
	ASSERT(type(id) == "string")
	SASSERT(n, type(n) == "number")
	c.id = id
	c.n = n or 0
end)
