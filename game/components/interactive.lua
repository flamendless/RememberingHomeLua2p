Concord.component("interactive")
Concord.component("locked")
Concord.component("is_door")

Concord.component("target_interactive", function(c, interactive_e)
	ASSERT(interactive_e.__isEntity and interactive_e.interactive)
	interactive_e:ensure("key")
	c.key = interactive_e.key.value
end)

Concord.component("within_interactive", function(c, e)
	ASSERT(e.__isEntity and e.id and e.interactive)
	e:ensure("key")
	c.key = e.key.value
end)

Concord.component("interactive_req_player_dir", function(c, dir)
	ASSERT(dir:type() == "vec2")
	c.value = dir
end)

