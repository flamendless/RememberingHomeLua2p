local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

local function rgb_to_love(str, a)
	local r, g, b = hex_to_rgb(str)
	return {r/255, g/255, b/255, a or 1}
end

local format = string.format
local args = {...}

for i, v in ipairs(args) do
	local t = rgb_to_love(v)
	local str = format("{%f, %f, %f}", unpack(t))

	print(i, v, str)
end
