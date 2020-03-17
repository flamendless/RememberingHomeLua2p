local base_path = "src.worlds."
local req = function(id)
	return require(base_path .. id)
end

local worlds = {
	Splash = req("splash"),
	Menu = req("menu"),
}

local format = string.format
for k, v in pairs(worlds) do
	assert(v.id, format("'%s' must have an `id`", k))
end

return worlds
