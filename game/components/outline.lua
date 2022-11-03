Concord.component("outline", function(c, size)
	SASSERT(size, type(size) == "number" and size >= 1)
	c.value = size or 1
end)
