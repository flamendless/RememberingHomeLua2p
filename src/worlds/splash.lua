local Animation = require("modules.anim8.anim8")
local Enum = require("modules.enum.enum")
local Log = require("modules.log.log")
local LoveSplash = require("modules.splashes.o-ten-one")

local Preloader = require("preloader")
local Fade = require("fade")

local State_Splash = {
	id = "Splash",
	is_ready = false,
}

local states = Enum("splash_love", "splash_flam")
local current_state = states.splash_love
local assets_data = {
	image = {
		{ "ss_flamendless", "assets/images/splash/sheet_flamendless.png" }
	}
}
local assets = { images = {} }

local scale_x, scale_y = 4, 4
local splash_love, splash_flam
local sf_width, sf_height

local switch = function()
	Fade.fade_out(function()
		love_switch("Menu")
	end)
end

function State_Splash:load()
	Log.info("State Load: ", self.id)
	local p = Preloader.start(assets_data, assets)
	p:onComplete(function()
		self.is_ready = true
		local grid = Animation.newGrid(64, 32, assets.images.ss_flamendless:getDimensions())
		splash_flam = Animation.newAnimation(grid("1-5", 1), 0.25, function()
			splash_flam:pauseAtEnd()
			switch()
		end)
		sf_width, sf_height = splash_flam:getDimensions()
	end)

	splash_love = LoveSplash()
	splash_love.onDone = function()
		current_state = states.splash_flam
	end
end

function State_Splash:update(dt)
	if not self.is_ready then return end
	if current_state == states.splash_love then
		splash_love:update(dt)
	elseif current_state == states.splash_flam then
		splash_flam:update(dt)
	end
end

function State_Splash:draw()
	if not self.is_ready then return end
	love.graphics.setColor(Fade.getColor())
	if current_state == states.splash_love then
		splash_love:draw()
	elseif current_state == states.splash_flam then
		splash_flam:draw(assets.images.ss_flamendless,
			love.graphics.getWidth()/2, love.graphics.getHeight()/2,
			0, scale_x, scale_y, sf_width/2, sf_height/2)
	end
end

function State_Splash:keypressed(key)
	if key == "e" or key == "space" or key == "return" then
		if splash_love then
			splash_love:skip()
		end
		if current_state == states.splash_flam then
			switch()
		end
	end
end

return State_Splash
