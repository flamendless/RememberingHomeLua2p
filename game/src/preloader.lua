local Preloader = {
	percent = 0
}

local keys = {
	images = "newImage",
	image_data = "newImageData",
	array_images = "newArrayImage",
	sources = "newSource",
	fonts = "newFont",
}

function Preloader.start(resources, container, on_complete)
	ASSERT(type(resources) == "table")
	ASSERT(type(container) == "table")
	ASSERT(type(on_complete) == "function")
	Preloader.percent = 0
	local i = 1
	local data, userdata = {}, {}
	for kind, t in pairs(resources) do
		for j = 1, #t do
			local d = t[j]
			local id, path = d[1], d[2]

			if kind == "images" or kind == "image_data" then
				data[i] = {keys[kind], path}
			elseif kind == "array_images" then
				data[i] = {keys[kind], {path}}
			elseif kind == "sources" then
				local source_type = d[3]
				data[i] = {keys[kind], path, source_type}
			elseif kind == "fonts" then
				local font_size, font_sub = d[3], d[4]
				if not font_sub then
					id = string.format("%s_%d", id, font_size)
				end
				data[i] = {keys[kind], path, font_size}
			end
			userdata[i] = id
			i = i + 1
		end
	end

	Preloader.load(data, userdata, container, on_complete)
end

function Preloader.load(data, userdata, container, on_complete)
	ASSERT(type(data) == "table")
	ASSERT(type(userdata) == "table")
	ASSERT(type(container) == "table")
	ASSERT(type(on_complete) == "function")
	local preloader = Lily.loadMulti(data)
	preloader:setUserData(userdata)
	preloader:onLoaded(function()
		local to_load = preloader:getCount()
		local completed = preloader:getLoadedCount()
		Preloader.percent = (completed/to_load) * 100
	end)

	preloader:onComplete(function(id, tbl_data)
		for i, tbl in ipairs(tbl_data) do
			local key = id[i]
			local res = tbl[1]
			local data_type = res:type()

			if data_type == "Image" then
				local tt = res:getTextureType()
				res:setFilter("nearest", "nearest")
				if tt == "array" then
					ASSERT(type(container.array_images) == "table")
					container.array_images[key] = res
				end
				ASSERT(type(container.images) == "table")
				container.images[key] = res
			elseif data_type == "ImageData" then
				ASSERT(type(container.image_data) == "table")
				container.image_data[key] = res
			elseif data_type == "Source" then
				ASSERT(type(container.sources) == "table")
				container.sources[key] = res
			elseif data_type == "Font" then
				ASSERT(type(container.fonts) == "table")
				res:setFilter("nearest", "nearest")
				container.fonts[key] = res
			end

			local str = string.format("Loaded: #%i - %s : %s", i, data_type, id)
			Log.trace(str)
		end

		on_complete()
	end)
end

return Preloader
