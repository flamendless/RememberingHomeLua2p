Concord.component("text_can_proceed")
Concord.component("text_skipped")

Concord.component("has_choices", function(c, ...)
	c.value = {...}
	if DEV then
		ASSERT(#c.value ~= 0)
		for _, str in ipairs(c.value) do
			ASSERT(type(str) == "string")
		end
	end
	ASSERT(#c.value ~= 0)
end)

Concord.component("dialogue_item")
Concord.component("dialogue_meta", function(c, main, sub)
	ASSERT(type(main) == "string")
	ASSERT(type(sub) == "string")
	ASSERT(Dialogues.get(main, sub))
	c.main = main
	c.sub = sub
end)
