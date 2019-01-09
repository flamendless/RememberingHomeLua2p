local BaseState = require("states.base_state")
local About = BaseState:extend()

local AssetsManager = require("src.assets_manager")
local GSM = require("src.gamestate_manager")

local str = {
	"Softwares Used",
	"Text Editor: Vim",
	"Pixel Art: Aseprite",
	"Source Control: Git",
	"OS: Manjaro Linux",
	"Audio: Musescore",
	"Sounds: Audacity"
}
local images = {}
local font

function About:new()
	About.super.new(self, "About")
end

function About:preload()
	AssetsManager:addImage(self:getID(),
		{
			{ id = "gui_return", path = "assets/images/gui/gui_return.png" }
		}
	)
	AssetsManager:start(function() self:load() end)
end

function About:load()
	images = AssetsManager:getAllImages(self:getID())
	for k,v in pairs(images) do v:setFilter("nearest", "nearest") end
	font = AssetsManager:getFont("about")
end

function About:update(dt)

end

function About:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(font)
	for i, text in ipairs(str) do
		local pad = 16
		local base_y = love.graphics.getHeight()/2 - (#str/2 * font:getHeight(text)) - (pad * #str/2)
		local x = love.graphics.getWidth()/2 - font:getWidth(text)/2
		local y = base_y + ((i-1) * font:getHeight(text)) + (pad * (i-1))
		love.graphics.print(text, x, y)
	end
	love.graphics.draw(images.gui_return, 32, 32, 0, 4, 4, images.gui_return:getWidth()/2, images.gui_return:getHeight()/2)
end

function About:keypressed(key)
	if key == "escape" then
		local status = GSM:switchToPrevious()
		if not status then
			local States = require("states")
			GSM:switch(States.menu())
		end
	end
end

return About
