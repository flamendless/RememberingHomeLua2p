local Cache = {
	entities = {},
	calculated = {},
	resources = {},
}

function Cache.add_entity(e)
	ASSERT(e.__isEntity)
	local id = e.id.value
	Cache.entities[id] = e
	Log.info(id, "added to cache")
end

function Cache.has_entity(e)
	return Cache.get_entity(e.id.value) ~= nil
end

function Cache.get_entity(id)
	ASSERT(type(id) == "string")
	return Cache.entities[id]
end

function Cache.remove_entity(e)
	ASSERT(e.__isEntity)
	local id = e.id.value
	if Cache.entities[id] then
		Cache.entities[id] = nil
		Log.info(id, "removed from cache")
	end
end

function Cache.get(t_id, id)
	ASSERT(type(t_id) == "string")
	ASSERT(type(id) == "string")
	ASSERT(Cache[t_id], t_id .. " is not valid")
	return Cache[t_id][id]
end

function Cache.store(t_id, id, ref)
	ASSERT(type(t_id) == "string")
	ASSERT(type(id) == "string")
	ASSERT(ref ~= nil)
	Cache[t_id][id] = ref
end

function Cache.has_resource(id)
	ASSERT(type(id) == "string")
	return Cache.resources[id] ~= nil
end

function Cache.clean_resources()
	tablex.clear(Cache.resources)
	ASSERT(#Cache.resources == 0)
end

function Cache.manage_resources(resources, list, prev_res)
	ASSERT(type(resources) == "table")
	ASSERT(type(list) == "table")
	ASSERT(type(prev_res) == "table")
	for kind, t in pairs(list) do
		local res = prev_res[kind]
		if res then
			if DEV then
				setmetatable(res, nil)
			end
			for i = #t, 1, -1 do
				local id = t[i][1]
				if res[id] then
					Cache.resources[id] = res[id]
					resources[kind][id] = res[id]
					table.remove(list[kind], i)
				end
			end
		end
	end
end

return Cache
