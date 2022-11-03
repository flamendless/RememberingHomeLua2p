local Resources = {
	meta = {},
	data = {},
}

local mt

if DEV then
	mt = {}
	mt.__index = function(t, i)
		local id
		for k, v in pairs(Resources.data) do
			if t == v then
				id = k
				break
			end
		end
		error(i .. " is invalid key for Resources:" .. id)
	end
end

Resources.meta = require("data.resources_list")

function Resources.get_meta(key)
	ASSERT(type(key) == "string")
	ASSERT(Resources.meta[key], key .. " is invalid")
	local t = tablex.copy(Resources.meta[key])
	t.images = tablex.append({}, t.images, t.array_images)
	if t.array_images then
		tablex.clear(t.array_images)
		t.array_images = nil
	end
	return t
end

function Resources.set_resources(t)
	ASSERT(type(t) == "table")
	tablex.clear(Resources.data)
	ASSERT(#Resources.data == 0)
	for k, _ in pairs(t) do
		Resources.data[k] = t[k]
		if DEV then
			setmetatable(Resources.data[k], mt)
		end
	end
end

function Resources.clean()
	for k, t in pairs(Resources.data) do
		for name, _ in pairs(t) do
			if not Cache.has_resource(name) then
				Resources.data[k][name]:release()
				Resources.data[k][name] = nil
				Log.trace("Cleaned:", k, name)
			else
				Log.trace("Cached, skipping:", k, name)
			end
		end
		Resources.data[k] = nil
	end
	Cache.clean_resources()
end

return Resources
