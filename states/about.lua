local BaseState = require("states.base_state")
local About = BaseState:extend()

local Flux = require("modules.flux.flux")

local AssetsManager = require("src.assets_manager")
local GSM = require("src.gamestate_manager")
local Button = require("objects.button")

local str = {
	"GOING HOME - REVISIT",
	"a game by",
	"Brandon Blanker Lim-it",
	"@flamendless",
	"",
	"",
	"Softwares Used",
	"Text Editor: Vim",
	"Pixel Art: Aseprite",
	"Source Control: Git",
	"OS: Manjaro Linux",
	"Audio: Musescore",
	"Sounds: Audacity",
}
local str_guide = {
	"W/UP for speed up",
	"S/DOWN for speed down",
	"ENTER/ESCAPE for skip",
}
local color_guide = { 1, 0, 0, 1 }
local dur_guide = 2

local images = {}
local font, font_guide
local buttons = {}
local switch, changeSpeed, guideFade, onHover, onNotHover
local base_y, total_h
local pad = 16
local max_speed = 256
local min_speed = 64
local speed = min_speed
local speed_inc = 64
local flag_canEscape = false

local url_website = "https://brbl.gamejolt.io"
local url_twitter = "https://twitter.com/flamendless"
local url_email = "mailto:flamendless8@gmail.com"

function About:new()
	About.super.new(self, "About")
end

function About:preload()
	AssetsManager:addImage(self:getID(),
		{
			{ id = "gui_return", path = "assets/images/gui/gui_return.png" },
			{ id = "gui_twitter", path = "assets/images/gui/gui_twitter.png" },
			{ id = "gui_email", path = "assets/images/gui/gui_email.png" },
			{ id = "gui_website", path = "assets/images/gui/gui_website.png" },
		}
	)
	AssetsManager:addFont(
		{
			{ id = "about", path = "assets/fonts/Jamboree.ttf", size = 32 },
			{ id = "guide", path = "assets/fonts/Jamboree.ttf", size = 16 }
		}
	)
	AssetsManager:start(function() self:load() end)
end

function About:load()
	--set up assets
	images = AssetsManager:getAllImages(self:getID())
	font = AssetsManager:getFont("about")
	font_guide = AssetsManager:getFont("guide")

	--set up buttons
	buttons.escape = Button(images.gui_return, 32, 32, 0, 4, 4, "center", "center")
	buttons.escape:setCallbackOnPressed(switch)
	local pad_x = 128
	local base_x = love.graphics.getWidth()/2
	local y = love.graphics.getHeight()/2
	buttons.website = Button(images.gui_website, base_x, y, 0, 4, 4, "center", "center")
	buttons.website:setCallbackOnHovered(onHover, onNotHover)
	buttons.twitter = Button(images.gui_twitter, base_x - images.gui_twitter:getWidth() - pad_x, y, 0, 4, 4, "center", "center")
	buttons.twitter:setCallbackOnHovered(onHover, onNotHover)
	buttons.email = Button(images.gui_email, base_x + images.gui_email:getWidth() + pad_x, y, 0, 4, 4, "center", "center")
	buttons.email:setCallbackOnHovered(onHover, onNotHover)

	buttons.website:setCallbackOnPressed(function() love.system.openURL(url_website) end)
	buttons.twitter:setCallbackOnPressed(function() love.system.openURL(url_twitter) end)
	buttons.email:setCallbackOnPressed(function() love.system.openURL(url_email) end)

	--set up scrolling text
	base_y = love.graphics.getHeight() * 1.25
	total_h = 0
	for i, text in ipairs(str) do
		total_h = total_h + font:getHeight(text) + pad
	end

	guideFade()
end

function About:update(dt)
	if flag_canEscape then
		for k, btn in pairs(buttons) do
			btn:update(dt)
		end
	else
		base_y = base_y - speed * dt
	end
end

function About:draw()
	love.graphics.setColor(1, 1, 1, 1)
	if not flag_canEscape then
		--Scrolling text
		love.graphics.setFont(font)
		love.graphics.push()
		love.graphics.translate(0, base_y)
		for i, text in ipairs(str) do
			local base_y = love.graphics.getHeight()/2 - (#str/2 * font:getHeight(text)) - (pad * #str/2)
			local x = love.graphics.getWidth()/2 - font:getWidth(text)/2
			local y = base_y + ((i-1) * font:getHeight(text)) + (pad * (i-1))
			love.graphics.print(text, x, y)
		end
		love.graphics.pop()

		--Guide text
		love.graphics.setFont(font_guide)
		for i, text in ipairs(str_guide) do
			local pad = 4
			local x = love.graphics.getWidth() - font_guide:getWidth(text) - pad
			local base_y = love.graphics.getHeight() - (#str_guide * font_guide:getHeight(text))- (pad * #str_guide)
			local y = base_y + ((i-1) * font_guide:getHeight(text) + (pad * (i-1)))
			love.graphics.setColor(color_guide)
			love.graphics.print(text, x, y)
		end
	else
		for k, btn in pairs(buttons) do
			btn:draw()
		end
	end
end

function About:keypressed(key)
	if key == "escape" or key == "return" then
		if flag_canEscape then
			switch()
		else
			flag_canEscape = true
		end
	elseif key == "w" or key == "up" then
		changeSpeed(1)
	elseif key == "s" or key == "down" then
		changeSpeed(-1)
	end
end

function About:mousepressed(mx, my, mb)
	if flag_canEscape then
		for k, btn in pairs(buttons) do
			btn:mousepressed(mx, my, mb)
		end
	end
end

switch = function()
	local status = GSM:switchToPrevious()
	if not status then
		local States = require("states")
		GSM:switch(States.menu())
	end
end

changeSpeed = function(sign)
	speed = speed + speed_inc * sign
	if speed > max_speed then
		speed = min_speed
	elseif speed < min_speed then
		speed = max_speed
	end
end

guideFade = function()
	if color_guide[4] == 1 then
		Flux.to(color_guide, dur_guide, { [4] = 0 })
			:oncomplete(function()
				guideFade()
			end)
	elseif color_guide[4] == 0 then
		Flux.to(color_guide, dur_guide, { [4] = 1 })
			:oncomplete(function()
				guideFade()
			end)
	end
end

onHover = function(button)
	Flux.to(button, 0.5, { sx = button.sx + 1.25 })
	Flux.to(button, 0.5, { sy = button.sy + 1.25 })
end

onNotHover = function(button)
	button:resetScale(0.5)
end

return About
