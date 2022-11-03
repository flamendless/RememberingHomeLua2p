Concord.component("bg_tree", function(c, is_cover)
	SASSERT(is_cover, type(is_cover) == "boolean")
	c.is_cover = is_cover
end)
