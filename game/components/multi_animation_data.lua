local c = Concord.component("multi_animation_data", function(c, first, data, modifier)
	ASSERT(type(first) == "string")
	ASSERT(type(data) == "table")
	ASSERT(data[first], "no " .. first .. " found in data")
	if DEV then
		for _, v in pairs(data) do
			ASSERT(type(v.resource_id) == "string")
			ASSERT(type(v.delay) == "number" or type(v.delay) == "table")
			ASSERT(type(v.rows_count) == "number")
			ASSERT(type(v.columns_count) == "number")
			ASSERT(type(v.n_frames) == "number")
		end

		SASSERT(modifier, type(modifier) == "table")
		if modifier then
			for id, v in pairs(modifier) do
				ASSERT(data[id])
				ASSERT(type(v[1]) == "string")
				ASSERT(type(v[2]) == "string")
			end
		end
	end

	c.orig_data = data

	for _, v in pairs(data) do
		v.spritesheet = Resources.data.images[v.resource_id]
		v.sheet_width, v.sheet_height = v.spritesheet:getDimensions()
		v.frame_width = math.floor(v.sheet_width/v.columns_count)
		v.frame_height = math.floor(v.sheet_height/v.rows_count)
	end

	if modifier then
		for id, v in pairs(modifier) do
			local target = v[1]
			-- local action = v[2]
			data[target] = tablex.copy(data[id])
			data[target].is_flipped = true
		end
	end

	c.first = first
	c.data = data
	c.modifier = modifier
end)

function c:serialize()
	return {
		first = self.first,
		data = self.orig_data,
		modifier = self.modifier,
	}
end

function c:deserialize(data)
	self:__populate(data.first, data.data, data.modifier)
end
