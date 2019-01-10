local BaseState = require("states.base_state")
local About = BaseState:extend()

local AssetsManager = require("src.assets_manager")
local GSM = require("src.gamestate_manager")
local Button = require("objects.button")

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
local btn_return
local switch

function About:new()
	About.super.new(self, "About")
end

function About:preload()
	AssetsManager:addImage(self:getID(),
		{
			{ id = "gui_return", path = "assets/images/gui/gui_return.png" }
		}
	)
	AssetsManager:addFont(
		{
			{ id = "about", path = "assets/fonts/Jamboree.ttf", size = 32 }
		}
	)
	AssetsManager:start(function() self:load() end)
end

function About:load()
	images = AssetsManager:getAllImages(self:getID())
	font = AssetsManager:getFont("about")
	btn_return = Button(images.gui_return, 32, 32, 0, 4, 4, "center", "center")
	btn_return:setCallbackOnPressed(switch)
end

function About:update(dt)
	btn_return:update(dt)
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
	btn_return:draw()
end

function About:keypressed(key)
	if key == "escape" or key == "backspace" then
		switch()
	end
end

function About:mousepressed(mx, my, mb)
	btn_return:mousepressed(mx, my, mb)
end

switch = function()
	local status = GSM:switchToPrevious()
	if not status then
		local States = require("states")
		GSM:switch(States.menu())
	end
end

return About
