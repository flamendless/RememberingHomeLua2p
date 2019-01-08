local BaseState = require("states.base_state")
local Splash = BaseState:extend()

local Animation = require("modules.anim8.anim8")
local Flux = require("modules.flux.flux")
local AssetsManager = require("src.assets_manager")
local GSM = require("src.gamestate_manager")

local images = {}
local color = { 1, 1, 1, 1 }
local state = 0
local anim_splash
local width, height
local sx = 4
local sy = 4
local dur = 1.5
local delay = 1.25

local fadeIn, fadeOut

function Splash:new()
	Splash.super.new(self, "Splash")
end

function Splash:preload()
	AssetsManager:addImage(self:getID(),
		{
			{ id = "gigadrill", path = "assets/images/splash/gigadrill.png" },
			{ id = "sheet_flamendless", path = "assets/images/splash/sheet_flamendless.png"}
		}
	)
	AssetsManager:start(function() self:load() end)
end

function Splash:load()
	images = AssetsManager:getAllImages(self:getID())
	for k,v in pairs(images) do v:setFilter("nearest", "nearest") end
	local grid_splash = Animation.newGrid(64, 32, images.sheet_flamendless:getDimensions())
	anim_splash = Animation.newAnimation(grid_splash("1-5", 1), 0.25, function()
		fadeOut()
		anim_splash:pauseAtEnd()
	end)
end

function Splash:update(dt)
	if state == 0 then
		anim_splash:update(dt)
	end
end

function Splash:draw()
	love.graphics.setColor(color)
	if state == 0 then
		width, height = anim_splash:getDimensions()
		anim_splash:draw(images.sheet_flamendless,
			love.graphics.getWidth()/2,
			love.graphics.getHeight()/2,
			0, sx, sy, width/2, height/2)
	elseif state == 1 then
		love.graphics.draw(images.gigadrill,
			love.graphics.getWidth()/2,
			love.graphics.getHeight()/2,
			0, sx, sy,
			images.gigadrill:getWidth()/2,
			images.gigadrill:getHeight()/2)
	end
end

function Splash:keypressed(key)
	if key == "e" then
		if state == 0 then
			fadeOut(0.1)
		elseif state == 1 then
			fadeOut(0.1)
		end
	end
end

function Splash:exit()

end

function fadeOut(override_delay)
	Flux.to(color, dur, { [4] = 0 })
		:delay(override_delay or delay)
		:oncomplete(function()
			if state == 0 then
				state = 1
				fadeIn()
			elseif state == 1 then
				local States = require("states")
				GSM:switch(States.menu())
			end
		end)
end

function fadeIn()
	Flux.to(color, dur, { [4] = 1 })
		:delay(delay)
		:oncomplete(function() fadeOut() end)
end

return Splash
