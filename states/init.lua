local req = function(filename)
	return require("states." .. filename)
end

return {
	splash = req("splash"),
	menu = req("menu"),
}
