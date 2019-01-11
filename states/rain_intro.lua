local BaseState = require("states.base_state")
local RainIntro = BaseState:extend()

local Animation = require("modules.anim8.anim8")
local Flux = require("modules.flux.flux")

local AssetsManager = require("src.assets_manager")
local Button = require("objects.button")

local sources = {}
local images = {}
local font
local animations = {}
local str_intro = {
	"A Game By: \n Brandon",
	"Art by: \n Brandon",
	"Music by: \n Brandon",
}
local alpha = {
	car = -250,
	door = -250,
	home = -200,
}
local scale
local flag_text = false
local text_x, text_y
local show_car = true
local show_door = false
local in_house_show = false
local current_text = 1
local _timer = 2
local btn_skip

function RainIntro:new()
	RainIntro.super.new(self, "RainIntro")
end

function RainIntro:preload()
	AssetsManager:addImage(self:getID(),
		{
			{ id = "sheet_car", path = "assets/images/rain_intro/sheet_car.png" },
			{ id = "sheet_door", path = "assets/images/rain_intro/sheet_door.png" },
			{ id = "sheet_home", path = "assets/images/rain_intro/sheet_home.png" },
			{ id = "sheet_skip", path = "assets/images/rain_intro/sheet_skip.png" },
		}
	)
	AssetsManager:addSource(self:getID(),
		{
			{ id = "bgm_rain_intro", path = "assets/soundtracks/bgm_rain_intro.ogg", kind = "stream" }
		}
	)
	AssetsManager:addFont(
		{
			{ id = "rain_intro", path = "assets/fonts/Jamboree.ttf", size = 32 }
		}
	)
	AssetsManager:start(function() self:load() end)
end

function RainIntro:load()
	images = AssetsManager:getAllImages(self:getID())
	sources = AssetsManager:getAllSources(self:getID())
	font = AssetsManager:getFont("rain_intro")
	local grid_car = Animation.newGrid(32, 48, images.sheet_car:getDimensions())
	local grid_door = Animation.newGrid(16, 24, images.sheet_door:getDimensions())
	local grid_home = Animation.newGrid(128, 32, images.sheet_home:getDimensions())
	local grid_skip = Animation.newGrid(8, 8, images.sheet_skip:getDimensions())
	animations.skip = Animation.newAnimation(grid_skip('1-9', 1), 0.1)
	animations.car = Animation.newAnimation(grid_car('1-17', 1), 0.1, "pauseAtEnd")
	animations.door = Animation.newAnimation(grid_door('1-14', 1), 0.1, "pauseAtEnd")
	animations.home = Animation.newAnimation(grid_home('1-10', 1), 0.1, "pauseAtEnd")

	sources.bgm_rain_intro:play()
	sources.bgm_rain_intro:setLooping(false)

	scale = math.min(love.graphics.getWidth()/128, love.graphics.getHeight()/32)
	text_x = love.graphics.getWidth()/2 - 32 - font:getWidth(str_intro[current_text])/2
	text_y = love.graphics.getHeight()/2 - font:getHeight(str_intro[current_text])/2
	btn_skip = Button(animations.skip:getFrameInfo(), 0, 0, 0, 4, 4)
end

function RainIntro:update(dt)
	animations.skip:update(dt)
	btn_skip:update(dt)
	if show_car then
		if alpha.car < 255 then
			alpha.car = alpha.car + 40 * dt
		end
		if alpha.car >= 100 then
			text_flag = true
			animations.car:update(dt)
		end
		if alpha.car >= 255 then
			current_text = 2
			text_x = love.graphics.getWidth()/2 + 10 - font:getWidth(str_intro[current_text])/2
			show_door = true
			show_car = false
		end
	end

	if show_door then
		if alpha.door < 255 then
			alpha.door = alpha.door + 30 * dt
		end
		if alpha.door >= 40 then
			text_flag = true
		end
		if alpha.door >= 60 then
			text_flag = true
			animations.door:update(dt)
		end
		if alpha.door >= 200 then
			in_house_show = true
		end
	end

	if in_house_show then
		current_text = 3
		text_y = love.graphics.getHeight()/2 + 12 - font:getHeight(str_intro[3])/2
		animations.home:update(dt)
		if alpha.home < 255 then
			alpha.home = alpha.home + 40 * dt
		end
		if alpha.home >= 100 then
			show_door = false
		end
		if alpha.home >= 200 then
			in_house_show = false
			text_flag = false
		end
	end

	if text_flag == true then
		if _timer <= 2 then
			_timer = _timer - 1 * dt
		end
		if _timer <= 0 then
		 	text_flag = false
		 	_timer = 2
		end
	end
end

function RainIntro:draw()
	love.graphics.setColor(1, 1, 1, 1)
	if show_car then
		local width, height = animations.car:getDimensions()
		love.graphics.setColor(1, 1, 1, alpha.car)
		animations.car:draw(images.sheet_car, love.graphics.getWidth() - 48, love.graphics.getHeight()/2 - 24,
			0, scale, scale,
			width, height/2)
	end
	if show_door then
		love.graphics.setColor(1, 1, 1, alpha.door)
		animations.door:draw(images.sheet_door, 40, love.graphics.getHeight()/2 - 12, 0, scale, scale)
	end
	if in_house_show then
		animations.home:draw(images.sheet_home, 0, 0, 0, scale, scale)
	end

	if text_flag then
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.setFont(font)
		love.graphics.print(str_intro[current_text], text_x, text_y)
	end

	btn_skip:draw()
end

function RainIntro:exit()
	sources.bgm_rain_intro:stop()
end

return RainIntro
