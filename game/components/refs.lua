Concord.component("ref_e_key", function(c, e)
	ASSERT(e.__isEntity)
	e:ensure("key")
	c.value = e.key.value
end)

Concord.component("refs", function(c, ...)
	local t = {...}
	ASSERT(#t > 0)
	local v = {}
	for i, e in ipairs(t) do
		ASSERT(e.__isEntity)
		e:ensure("key")
		v[i] = e.key.value
	end
	ASSERT(#t == #v)
	c.value = v
end)
