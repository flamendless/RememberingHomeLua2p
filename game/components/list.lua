Concord.component("list_item_skip")

Concord.component("list_item", function(c)
	c.on_current_page = false
end)

Concord.component("list_cursor", function(c, cursor_index)
	ASSERT(type(cursor_index) == "number")
	c.value = cursor_index
end)

Concord.component("list_group", function(c, group_id)
	ASSERT(type(group_id) == "string")
	c.value = group_id
	c.is_focused = false
end)
