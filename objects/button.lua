local classic = require("modules.classic.classic")
local Button = classic:extend()

local Flux = require("modules.flux.flux")

function Button:new(image, x, y, rot, sx, sy, ox, oy)
	self.image = image
	self.isHovered = false
	self.isClicked = false
	self.x = x or 0
	self.y = y or 0
	self.rot = rot or 0
	self.sx = sx or 1
	self.sy = sy or 1
	self.original_sx = self.sx
	self.original_sy = self.sy
	if image:type() == "Image" then
		self.w = self.image:getWidth() * self.sx
		self.h = self.image:getHeight() * self.sy
		self:processOffsetImage(ox, oy)
	elseif image:type() == "Quad" then
		local x, y, w, h = image:getViewport()
		self.w = w * self.sx
		self.h = h * self.sy
		self:processOffsetQuad(ox, oy)
	end
end

function Button:processOffsetImage(ox, oy)
	if type(ox) == "string" then
		if ox == "center" then
			self.ox = self.image:getWidth()/2
		end
	else
		self.ox = ox or 0
	end
	if type(oy) == "string" then
		if ox == "center" then
			self.oy = self.image:getHeight()/2
		end
	else
		self.oy = oy or 0
	end
end

function Button:processOffsetQuad(ox, oy)
	if type(ox) == "string" then
		local x, y, w, h = self.image:getViewport()
		if ox == "center" then
			self.ox = w/2
		elseif ox == "left" then
			self.ox = 0
		elseif ox == "right" then
			self.ox = w
		end
	else
		self.ox = ox or 0
	end

	if type(oy) == "string" then
		local x, y, w, h = self.image:getViewport()
		if oy == "center" then
			self.oy = h/2
		elseif oy == "top" then
			self.oy = 0
		elseif oy == "bottom" then
			self.oy = h
		end
	else
		self.oy = oy or 0
	end
end

function Button:setCallbackOnPressed(cb_onPressed)
	self.cb_onPressed = cb_onPressed
end

function Button:setCallbackOnHovered(cb_onHovered, cb_onNotHovered)
	self.cb_onHovered = cb_onHovered
	self.cb_onNotHovered = cb_onNotHovered
	self.isCalled_onHovered = false
	self.isCalled_onNotHovered = false
end

function Button:update(dt)
	self:checkPointCollision()
end

function Button:checkPointCollision()
	local mx, my = love.mouse.getPosition()
	local x = self.x - (self.ox * self.sx)
	local y = self.y - (self.oy * self.sy)
	if mx > x and mx < x + self.w
		and my > y and my < y + self.h then
		if self.cb_onHovered and not self.isCalled_onHovered then
			self.cb_onHovered(self)
			self.isCalled_onHovered = true
		end
		self.isHovered = true
		self.isCalled_onNotHovered = false
	else
		if self.cb_onNotHovered and not self.isCalled_onNotHovered and self.isHovered then
			self.cb_onNotHovered(self)
			self.isCalled_onNotHovered = true
		end
		self.isHovered = false
		self.isCalled_onHovered = false
	end
end

function Button:draw()
	if self.isHovered then
		love.graphics.setColor(1, 0, 0, 1)
	else
		love.graphics.setColor(1, 1, 1, 1)
	end
	love.graphics.draw(self.image, self.x, self.y, self.rot, self.sx, self.sy, self.ox, self.oy)

	if __DEBUG then
		love.graphics.setColor(1, 0, 0, 1)
		love.graphics.rectangle("line",
			self.x - (self.ox * self.sx),
			self.y - (self.oy * self.sy),
			self.w + (self.sx/self.ox),
			self.h + (self.sy/self.oy))
	end
end

function Button:mousepressed(mx, my, mb)
	if mb == 1 then
		if self.isHovered then
			if self.cb_onPressed then
				self.cb_onPressed()
			end
		end
	end
end

function Button:resetScale(dur)
	Flux.to(self, dur, { sx = self.original_sx, sy = self.original_sy })
end

function Button:getIsHovered() return self.isHovered end

return Button
