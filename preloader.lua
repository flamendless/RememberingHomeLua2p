local Lily = require("modules.lily.lily")
local Log = require("modules.log.log")

local format = string.format
local Preloader = {}
local keys = {
	image = "newImage"
}
local apply_filter = true

function Preloader.start(assets, container)
	assert(type(assets) == "table", "'assets' must be a table")
	assert(type(container) == "table", "'container' must be a table")

	local i = 1
	local data = {}
	local userdata = {}

	for kind, t in pairs(assets) do
		for j = 1, #t do
			local id = t[j][1]
			local path = t[j][2]
			data[i] = {keys[kind], path}
			userdata[i] = id
			i = i + 1
		end
	end

	local preloader = Lily.loadMulti(data)
		:setUserData(userdata)
		:onLoaded(function(id, i, data)
			local name = id[1]
			local data_type = data:type()

			if data_type == "Image" then
				assert(container.images ~= nil, "You must provide an 'images' table")
				assert(type(container.images) == "table", "'container.images' must be a table ")
				if (apply_filter) then
					data:setFilter("nearest", "nearest")
				end
				container.images[name] = data
			end

			local str = format("Loaded: #%i - %s : %s", i, data_type, name)
			Log.info(str)
		end)

	return preloader
end

return Preloader
