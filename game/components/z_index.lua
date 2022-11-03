Concord.component("z_index", function(c, z, sortable)
	ASSERT(type(z) == "number")
	SASSERT(sortable, type(sortable) == "boolean")
	c.value = z
	c.sortable = sortable ~= false
end)
