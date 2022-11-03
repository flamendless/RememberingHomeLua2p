Concord.component("bg")
Concord.component("array_image")

local c_sprite = Concord.component("sprite", function(c, resource_id, container)
	ASSERT(type(resource_id) == "string")
	SASSERT(container, type(container) == "string")
	c.resource_id = resource_id
	c.container = container or "images"
	c.image = Resources.data[c.container][resource_id]
	c.image_size = vec2(c.image:getDimensions())
end)

function c_sprite:serialize()
	return {
		resource_id = self.resource_id,
		container = self.container,
	}
end

function c_sprite:deserialize(data)
	self:__populate(data.resource_id, data.container)
end

--TODO remove with fog?
local c_noise_tex = Concord.component("noise_texture", function(c, size)
	ASSERT(size:type() == "vec2")
	c.size = size
	c.texture = love.graphics.newImage(Generator.generate_noise(size:unpack()))
	c.texture:setWrap("repeat", "repeat")
	c.texture:setFilter("linear", "linear")
end)

function c_noise_tex:serialize()
	return {size = self.size}
end

function c_noise_tex:deserialize(data)
	self:__populate(data.size)
end
