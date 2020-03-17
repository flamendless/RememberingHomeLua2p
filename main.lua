--[[
Project: Going Home Revisit
Author: Brandon Blanker Lim-it @flamendless
Start Date: Mon Jan  7 15:28:53 PST 2019
--]]

io.stdout:setvbuf("no")
local format = string.format

local Concord = require("modules.concord.concord")
local Flux = require("modules.flux.flux")
local Log = require("modules.log.log")
local Timer = require("modules.hump.timer")

local Worlds = require("src.worlds")
local current_world

function love_switch(next_id)
	local str_err = format("State '%s' doest not exist in 'Worlds'", next_id)
	assert(Worlds[next_id], str_err)
	local prev_id = current_world.id
	current_world = Worlds[next_id]
	local str = format("Switched from %s to %s", prev_id, current_world.id)
	Log.trace(str)
	current_world:load()
end

function love.load()
	current_world = Worlds.Splash
	Log.trace("Starting scene: ", current_world.id)
	current_world:load()
end

function love.update(dt)
	Timer.update(dt)
	Flux.update(dt)
	current_world:update(dt)
end

function love.draw()
	current_world:draw()
end

function love.keypressed(key)
	current_world:keypressed(key)
end

function love.keyreleased(key)
end

function love.mousepressed(mx, my, mb)
end

function love.mousereleased(mx, my, mb)
end

function love.quit()
end
