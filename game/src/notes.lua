local Notes = {}

local list = require("data.notes")
local acquired = {}

local function get_note(id)
	ASSERT(type(id) == "string")
	ASSERT(list[id], "no " .. id .. " in data.notes")
	for _, note in ipairs(acquired) do
		if note.id == id then
			return note
		end
	end
	return nil
end

function Notes.add(id)
	ASSERT(type(id) == "string")
	ASSERT(list[id], "no " .. id .. " in data.notes")
	ASSERT(Notes.has(id) == false, id .. " was already added")
	table.insert(acquired, tablex.copy(list[id]))
	Log.info("note:", id, "was added")
end

function Notes.get_info(id)
	ASSERT(type(id) == "string")
	ASSERT(list[id])
	return list[id]
end

function Notes.has(id)
	ASSERT(type(id) == "string")
	ASSERT(list[id], "no " .. id .. " in data.notes")
	local has = get_note(id)
	return has ~= nil
end

function Notes.get_acquired()
	return acquired
end

return Notes
