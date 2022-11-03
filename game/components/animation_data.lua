local c_anim_data = Concord.component("animation_data", function(c, data)
	ASSERT(type(data) == "table")
	ASSERT(data.resource_id and type(data.resource_id) == "string")
	ASSERT(type(data.frames) == "table")
	ASSERT(type(data.rows_count) == "number")
	ASSERT(type(data.columns_count) == "number")
	SASSERT(data.n_frames, type(data.n_frames) == "number")
	SASSERT(data.start_frame, data.start_frame >= 1 and data.start_frame <= data.n_frames)
	SASSERT(data.delay, type(data.delay) == "table" or type(data.delay) == "number")

	c.resource_id = data.resource_id
	c.spritesheet = Resources.data.images[c.resource_id]
	c.frames = data.frames
	c.delay = data.delay
	c.rows_count = data.rows_count
	c.columns_count = data.columns_count
	c.n_frames = data.n_frames
	c.start_frame = data.start_frame

	c.sheet_width, c.sheet_height = c.spritesheet:getDimensions()
	c.frame_width = math.floor(c.sheet_width/c.columns_count)
	c.frame_height = math.floor(c.sheet_height/c.rows_count)

	c.data = data
end)

function c_anim_data:serialize()
	return {
		data = self.data,
	}
end

function c_anim_data:deserialize(data)
	self:__populate(data.data)
end
