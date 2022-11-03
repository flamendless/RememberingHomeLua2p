local AnimationData = require("data.animation_data")
local AnimationSyncData = require("data.animation_sync_data")

local Animation = {}

function Animation.get_multi_by_id(id, tbl)
	ASSERT(type(id) == "string")
	ASSERT(type(tbl) == "table")
	ASSERT(AnimationData[id])
	local data, mods = {}, {}
	for _, v in ipairs(tbl) do
		ASSERT(type(v) == "string")
		data[v] = tablex.copy(AnimationData[id][v])
		mods[v] = {v .. "_left", "flipH"}
	end
	return data, mods
end

function Animation.get(id)
	ASSERT(type(id) == "string")
	ASSERT(AnimationData[id])
	return tablex.copy(AnimationData[id])
end

function Animation.get_sync_data(id)
	ASSERT(type(id) == "string")
	ASSERT(AnimationSyncData[id])
	return tablex.copy(AnimationSyncData[id])
end

return Animation
