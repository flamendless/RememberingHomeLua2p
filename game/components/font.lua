local c_font = Concord.component("font", function(c, resource_id)
	ASSERT(type(resource_id) == "string")
	c.resource_id = resource_id
	c.value = Resources.data.fonts[resource_id]
end)

function c_font:serialize()
	return {resource_id = self.resource_id}
end

function c_font:deserialize(data)
	self:__populate(data.resource_id)
end

local c_font_sdf = Concord.component("font_sdf", function(c, fnt, png)
	ASSERT(type(fnt) == "string")
	ASSERT(type(png) == "string")
	c.resource_fnt = fnt
	c.resource_png = png
	c.value = love.graphics.newFontMSDF(fnt, png)
end)

function c_font_sdf:serialize()
	return {
		resource_fnt = self.resource_fnt,
		resource_png = self.resource_png,
	}
end

function c_font_sdf:deserialize(data)
	self:__populate(data.resource_fnt, data.resource_png)
end

Concord.component("sdf", function(c, scale)
	SASSERT(scale, scale:type() == "vec2")
	c.value = scale or vec2(1, 1)
end)
