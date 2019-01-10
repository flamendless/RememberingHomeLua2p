local classic = require("modules.classic.classic")
local Button = classic:extend()

function Button:new(image, x, y, rot, sx, sy, ox, oy)
	self.image = image
	self.isHovered = false
	self.isClicked = false
	self.x = x or 0
	self.y = y or 0
	self.rot = rot or 0
	self.sx = sx or 1
	self.sy = sy or 1
	self.w = self.image:getWidth() * self.sx
	self.h = self.image:getHeight() * self.sy
	self:processOffset(ox, oy)
end

function Button:processOffset(ox, oy)
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

function Button:setCallbackOnPressed(cb_onPressed)
	self.cb_onPressed = cb_onPressed
end

function Button:update(dt)
	local mx, my = love.mouse.getPosition()
	local x = self.x - (self.ox * self.sx)
	local y = self.y - (self.oy * self.sy)
	if mx > x and mx < x + self.w
		and my > y and my < y + self.h then
		self.isHovered = true
	else
		self.isHovered = false
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
		love.graphics.rectangle("line", self.x - (self.ox * self.sx), self.y - (self.oy * self.sy), self.w, self.h)
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

return Button
