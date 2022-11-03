Concord.component("menu_text")
Concord.component("option_disabled")

Concord.component("option_key", function(c, id, page)
	ASSERT(type(id) == "number")
	ASSERT(type(page) == "number")
	c.id = id
	c.page = page
end)
