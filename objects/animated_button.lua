local Button = require("objects.button")
local AnimatedButton = Button:extend()

function AnimatedButton:new(obj_anim, ref_image, x, y, rot, sx, sy, ox, oy)
	self.obj_anim = obj_anim
	self.ref_image = ref_image
	AnimatedButton.super.new(self, obj_anim:getFrameInfo(), x, y, rot, sx, sy, ox, oy)
end

function AnimatedButton:update(dt)
	self:checkPointCollision()
	self.obj_anim:update(dt)
end

function AnimatedButton:draw()
	if self:getIsHovered() then
		love.graphics.setColor(1, 0, 0, 1)
	else
		love.graphics.setColor(1, 1, 1, 1)
	end
	self.obj_anim:draw(self.ref_image, self.x, self.y, self.rot, self.sx, self.sy, self.ox, self.oy)
end

return AnimatedButton
