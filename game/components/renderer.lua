Concord.component("custom_renderer", function(c, str)
	ASSERT(type(str) == "string")
	c.value = str
end)
