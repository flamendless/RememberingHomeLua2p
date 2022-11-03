local Save = {
	data = {
		splash_done = false,
		intro_done = false,
		outside_intro_done = false,
	},
	checkpoints = {},
	valid_checkpoints = false,
	exists = false,
}

local FILENAME = "save_ata"
local KEY = "data_store"

local function validate_checkpoints(data)
	ASSERT(type(data) == "table")
end

function Save.init()
	local content, exists = Utils.file.read(FILENAME)
	local key, exists_key = Utils.file.read(KEY)

	if exists and exists_key then
		local hashed = love.data.hash("sha256", content)
		if key == hashed then
			local data = Utils.serial.de(content)
			Save.data = data
			validate_checkpoints(data)
		else
			error(string.format(
				"Data integrity is not valid.\n\
				Please do not modify the files: '%s' and '%s'.\n\
				Please delete the files in '%s' and restart the game",
				FILENAME, KEY, love.filesystem.getSaveDirectory()
			))
		end
	else
		Save.save()
	end

	Save.exists = exists
	Log.info("Save Data:", pretty.string(Save.data))
end

function Save.save()
	local data = Utils.serial.write(FILENAME, Save.data)
	local hashed = love.data.hash("sha256", data)
	Utils.file.write(KEY, hashed)
	Log.info("Save overwritten")
end

function Save.toggle_flag(id, save)
	ASSERT(type(id) == "string")
	ASSERT(Save.data[id] ~= nil)
	SASSERT(save, type(save) == "boolean")
	Save.data[id] = not Save.data[id]
	if save then
		Save.save()
	end
end

function Save.set_flag(id, value, save)
	ASSERT(type(id) == "string")
	ASSERT(Save.data[id] ~= nil)
	ASSERT(type(value) == "boolean")
	SASSERT(save, type(save) == "boolean")
	Save.data[id] = value
	if save then
		Save.save()
	end
end

return Save
