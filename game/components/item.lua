Concord.component("usable_with_item")
Concord.component("item_preview")
Concord.component("room_item")

Concord.component("item_id", function(c, id)
	ASSERT(type(id) == "string")
	c.value = Enums.item[id]
end)

Concord.component("item", function(c, id, name, desc)
	ASSERT(type(id) == "string")
	ASSERT(type(name) == "string")
	ASSERT(type(desc) == "string")
	c.id = id
	c.name = name
	c.desc = desc
end)
