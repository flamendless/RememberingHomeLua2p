local base_path = "src.worlds."
local req = function(id)
	return require(base_path .. id)
end

return {
	Splash = req("splash"),
}
