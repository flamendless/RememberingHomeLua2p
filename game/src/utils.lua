local Utils = {
	file = {},
	serial = {},
	hash = {},
	string = {},
	table = {},
	math = {},
}

function Utils.file.read(filename)
	ASSERT(type(filename) == "string")
	local file = love.filesystem.getInfo(filename)
	Log.info(filename, "exists:", file ~= nil)
	if file then
		local content = love.filesystem.read(filename)
		return content, true
	end
	return false
end

function Utils.file.write(filename, data)
	ASSERT(type(filename) == "string")
	ASSERT(type(data) == "table")
	love.filesystem.write(filename, data)
	Log.info(filename, "written")
end

function Utils.serial.write(filename, data)
	ASSERT(type(filename) == "string")
	ASSERT(type(data) == "table")
	local serialized = Bitser.dumps(data)
	Utils.file.write(filename, serialized)
	return serialized
end

function Utils.serial.read(filename)
	ASSERT(type(filename) == "string")
	local content, exists = Utils.file.read(filename)
	if exists then
		local data = Bitser.loads(content)
		return data, exists
	end
	return false
end

function Utils.serial.de(content)
	ASSERT(type(content) == "string")
	return Bitser.loads(content)
end

function Utils.hash.compare(a, b)
	ASSERT(type(a) == "string")
	ASSERT(type(b) == "string")
	local hashed_a = love.data.hash("md5", a)
	local hashed_b = love.data.hash("md5", b)
	return hashed_a == hashed_b
end

function Utils.math.lerp_range(range, t)
	ASSERT((type(range) == "table") and range.min and range.max)
	ASSERT(type(t) == "number")
	return mathx.lerp(range.min, range.max, t)
end

return Utils
