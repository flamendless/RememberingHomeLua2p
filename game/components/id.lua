Concord.component("id", function(c, id, sub_id)
	ASSERT(type(id) == "string")
	SASSERT(sub_id, type(sub_id) == "string")
	c.value = id
	c.sub_id = sub_id
end)

Concord.component("preserve_id")
Concord.component("hidden")
