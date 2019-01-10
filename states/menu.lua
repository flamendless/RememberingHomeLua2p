local BaseState = require("states.base_state")
local Menu = BaseState:extend()

local GSM = require("src.gamestate_manager")
local AssetsManager = require("src.assets_manager")
local images = {}
local scale
local font
local color_hovered = { 1, 0, 0, 1 }
local color_normal = { 1, 1, 1, 1 }
local cursor = 1
local menu_options = {
	[1] = "Start",
	[2] = "Options",
	[3] = "About",
	[4] = "Quit",
}

function Menu:new()
	Menu.super.new(self, "Menu")
end

function Menu:preload()
	AssetsManager:addImage(self:getID(),
		{
			{ id = "title", path = "assets/images/menu/title.png" },
		}
	)
	AssetsManager:addFont(
		{
			{ id = "menu", path = "assets/fonts/Jamboree.ttf", size = 16 }
		}
	)
	AssetsManager:start(function() self:load() end)
end

function Menu:load()
	images = AssetsManager:getAllImages(self:getID())
	font = AssetsManager:getFont("menu")
	scale = math.min(love.graphics.getWidth()/images.title:getWidth(), love.graphics.getHeight()/images.title:getHeight())
end

function Menu:update(dt)

end

function Menu:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(images.title,
		0, love.graphics.getHeight()/2,
		0, scale, scale,
		0, images.title:getHeight()/2)

	--draw menu options
	for i, text in ipairs(menu_options) do
		if cursor == i then
			love.graphics.setColor(color_hovered)
		else
			love.graphics.setColor(color_normal)
		end
		love.graphics.setFont(font)
		local base_y = love.graphics.getHeight()/2 + (images.title:getHeight()/2 * scale) + 8
		local pos_x = love.graphics.getWidth()/2 - font:getWidth(text)/2
		local pos_y = ((i - 1) * (font:getHeight(text) + 8))
		love.graphics.print(text, pos_x, base_y + pos_y)
	end
end

function Menu:keypressed(key)
	if key == "up" or key == "w" then
		cursor = cursor - 1
	elseif key == "down" or key == "s" then
		cursor = cursor + 1
	end
	if cursor <= 0 then
		cursor = #menu_options
	elseif cursor > #menu_options then
		cursor = 1
	end
end

function Menu:keyreleased(key)
	if key == "return" then
		local selected = string.lower(menu_options[cursor])
		if selected == "start" then
		elseif selected == "options" then
		elseif selected == "about" then
			local States = require("states")
			GSM:switch(States.about())
		elseif selected == "quit" then
			love.event.quit()
		end
	end
end

function Menu:quit()
end

return Menu
