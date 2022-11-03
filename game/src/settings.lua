local window_modes = {
	sizes = {
		{
			width = WINDOW_WIDTH,
			height = WINDOW_HEIGHT,
		}
	},
	displays = {},
}

local defaults = {
	window_mode_index = 1,
	key_map = 1,
	muted = false,
	volume = 1,
	gfx_quality = Enums.gfx_quality.high,
	show_keys = true,
}

local Settings = {
	current = tablex.copy(defaults),
	available_graphics_quality = {"low", "high"},
}

local FILENAME = "user_settings"

function Settings.init()
	for _, mode in ipairs(window_modes.sizes) do
		local str = string.format("%dx%d", mode.width, mode.height)
		table.insert(window_modes.displays, str)
	end

	local content, exists = Utils.serial.read(FILENAME)
	if exists then
		Settings.current = content
		pretty.print(Settings.current)
	else
		Settings.create_new()
	end
end

function Settings.create_new()
	Settings.current = tablex.copy(defaults)
	local gl_version = string.sub(SystemInfo.data.renderer.version, 1, 3)
	if gl_version == "2.1" then
		Settings.current.gfx_quality = Enums.gfx_quality.low
	else
		Settings.current.gfx_quality = Enums.gfx_quality.high
	end
	Settings.save()
end

function Settings.save()
	Utils.serial.write(FILENAME, Settings.current)
end

function Settings.set(id, value, save)
	ASSERT(type(id) == "string")
	ASSERT(type(value) == "boolean" or type(value) == "number")
	SASSERT(save, type(save) == "boolean")
	save = save or false

	local prev = Settings.current[id]
	if prev ~= value then
		Settings.current[id] = value
		Log.info("set", id, "to", value)
		if save then
			Settings.save()
		end
	end
end

function Settings.set_from_table(tbl, save)
	ASSERT(type(tbl) == "table")
	ASSERT(type(save) == "boolean")
	for k, v in pairs(tbl) do
		ASSERT(Settings.current[k] ~= nil, string.format("invalid %s key", k))
		Settings.current[k] = v
		Log.info(string.format("set %s to %s", k, v))
	end
	if save then
		Settings.save()
	end
end

return Settings
