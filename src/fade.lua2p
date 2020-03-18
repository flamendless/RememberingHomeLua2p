local Flux = require("modules.flux.flux")

local Fade = {}

local duration = 1
local delay = 0.5
local color = { 1, 1, 1, 1 }

function Fade.fade_out(on_complete)
	local f = Flux.to(color, duration, { [4] = 0 }):delay(delay)
	if on_complete then
		f:oncomplete(on_complete)
	end
end

function Fade.fade_in(on_complete)
	local f = Flux.to(color, duration, { [4] = 1 }):delay(delay)
	if on_complete then
		f:oncomplete(on_complete)
	end
end

function Fade.getColor() return color end

return Fade
