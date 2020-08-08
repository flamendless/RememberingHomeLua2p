local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

local args = {...}

for i, v in ipairs(args) do
	local r, g, b = hex_to_rgb(v)
	print(i, v, r/255, g/255, b/255)
end
