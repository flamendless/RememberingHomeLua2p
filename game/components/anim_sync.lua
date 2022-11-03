Concord.component("anim_sync_with", function(c, e_target)
	ASSERT(e_target.__isEntity and e_target.animation and e_target.current_frame)
	e_target:ensure("key")
	c.key = e_target.key.value
end)

Concord.component("anim_sync_data", function(c, c_name, c_props, data)
	ASSERT(type(c_name) == "string")
	ASSERT(type(c_props) == "table")
	ASSERT(type(data) == "table")
	c.c_name = c_name
	c.c_props = c_props
	c.data = data
end)
