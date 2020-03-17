--[[
Project: Going Home Revisit
Author: Brandon Blanker Lim-it @flamendless
Start Date: Mon Jan  7 15:28:53 PST 2019
--]]

__DEBUG = true
if __DEBUG then
	io.stdout:setvbuf("no")
end

local Flux = require("modules.flux.flux")
local Timer = require("modules.hump.timer")

function love.load()
end

function love.update(dt)
	Timer.update(dt)
	Flux.update(dt)
end

function love.draw()
end

function love.keypressed(key)
end

function love.keyreleased(key)
end

function love.mousepressed(mx, my, mb)
end

function love.mousereleased(mx, my, mb)
end

function love.quit()
end
