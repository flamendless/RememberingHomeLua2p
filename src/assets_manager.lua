local AssetsManager = {
	isFinished = false,
	isFadeIn = false,
	images = {},
	sfx = {},
	music = {},
	fonts = {},
	alpha = 1,
	in_alpha = 1,
}

local Log = require("modules.log.log")
local Loader = require("modules.love-loader.love-loader")
local Flux = require("modules.flux.flux")
local str, str_x, str_y
local canvas
local dur = 1.5
if __DEBUG then
	dur = 0.25
end

function AssetsManager:init()
	self.fonts.main = love.graphics.newFont("assets/fonts/Jamboree.ttf", 48)
	self.fonts.menu = love.graphics.newFont("assets/fonts/Jamboree.ttf", 16)
	self.fonts.about = love.graphics.newFont("assets/fonts/Jamboree.ttf", 32)
	for k, font in pairs(self.fonts) do font:setFilter("nearest", "nearest") end
	canvas = love.graphics.newCanvas()
	Log.trace("Initialized")
end

function AssetsManager:addImage(container, images)
	if not self.images[container] then
		self.images[container] = {}
	end
	for i, v in ipairs(images) do
		assert(v.id, "No ID is passed at index .. " .. i)
		assert(v.path, "No path is passed at index .." .. i)
		Loader.newImage(self.images[container], v.id, v.path)
	end
end

function AssetsManager:start(cb)
	self.isFinished = false
	Loader.start(function()
		Flux.to(self, dur, { alpha = 0 })
			:oncomplete(function()
				self.isFinished = true
				self.isFadeIn = true
				Flux.to(self, dur, { in_alpha = 0 })
					:oncomplete(function()
						self.isFadeIn = false

						--reset
						self.alpha = 1
						self.in_alpha = 1
					end)
			end)
		--FINISHED
		if cb then cb() end
		Log.trace("Finished Loading")
	end)
end

function AssetsManager:update(dt)
	if not self.isFinished then
		Loader.update()
		local percent = 0
		if Loader.resourceCount ~= 0 then percent = Loader.loadedCount / Loader.resourceCount end
		str = "Loading.." .. (percent * 100) .. "%"
		str_x = love.graphics.getWidth() - self.fonts.main:getWidth(str) - 4
		str_y = love.graphics.getHeight() - self.fonts.main:getHeight(str) - 4
	end
end

function AssetsManager:draw()
	if not self.isFinished then
		love.graphics.setCanvas(canvas)
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.setFont(self.fonts.main)
		love.graphics.print(str, str_x, str_y)
		love.graphics.setCanvas()

		love.graphics.setColor(1, 1, 1, self.alpha)
		love.graphics.draw(canvas)
	end
end

function AssetsManager:drawOverlay()
	if self.isFadeIn then
		love.graphics.setColor(0, 0, 0, self.in_alpha)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	end
end

function AssetsManager:getIsFinished() return self.isFinished end
function AssetsManager:getFont(id)
	assert(self.fonts[id], ("Font '%s' does not exist"):format(id))
	return self.fonts[id]
end
function AssetsManager:getImage(container, id)
	assert(self.images[container], ("Container '%s' does not exist"):format(container))
	assert(self.images[container][id], ("Image '%s' does not exist"):format(id))
	return self.images[container][id]
end

function AssetsManager:getAllImages(container)
	assert(self.images[container], ("Container '%s' does not exist"):format(container))
	return self.images[container]
end

return AssetsManager
