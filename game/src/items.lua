local Items = {}

local list = require("data.items")
local acquired = {}

local function get_item(id)
	ASSERT(type(id) == "string")
	ASSERT(list[id], "no " .. id .. " in data.items")
	for _, item in ipairs(acquired) do
		if item.id == id then
			return item
		end
	end
	error(string.format("Item '%s' does not exist"))
end

function Items.add(id)
	ASSERT(type(id) == "string")
	ASSERT(list[id], "no " .. id .. " in data.items")
	ASSERT(Items.has(id) == false, id .. " was already added")
	table.insert(acquired, {id = id, equipped = false})
	Log.info("item:", id, "was added")
end

function Items.get_info(id)
	ASSERT(type(id) == "string")
	local info = list[id]
	ASSERT(info ~= nil)
	return info
end

function Items.get_acquired()
	return acquired
end

function Items.has(id)
	ASSERT(type(id) == "string")
	ASSERT(list[id], "no " .. id .. " in data.items")
	return get_item(id) ~= nil
end

function Items.toggle_equip(id)
	ASSERT(type(id) == "string")
	ASSERT(list[id], "no " .. id .. " in data.items")
	local item = get_item(id)
	item.equipped = not item.equipped
end

function Items.is_equipped(id)
	ASSERT(type(id) == "string")
	ASSERT(list[id], "no " .. id .. " in data.items")
	return get_item(id).equipped
end

return Items
