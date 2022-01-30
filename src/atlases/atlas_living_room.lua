-- https://github.com/EngineerSmith/Export-TextureAtlas
-- check build.sh create_atlas
local Data = {
	frames = {
		["fireplace"] = {
			x = 4,
			y = 4,
			w = 66,
			h = 107
		},
		["table2"] = {
			x = 4,
			y = 174,
			w = 56,
			h = 48
		},
		["door"] = {
			x = 4,
			y = 230,
			w = 38,
			h = 70
		},
		["painting"] = {
			x = 4,
			y = 119,
			w = 71,
			h = 47
		},
		["table"] = {
			x = 4,
			y = 388,
			w = 87,
			h = 11
		},
		["light"] = {
			x = 47,
			y = 349,
			w = 17,
			h = 23
		},
		["plant"] = {
			x = 46,
			y = 308,
			w = 16,
			h = 29
		},
		["stool"] = {
			x = 4,
			y = 407,
			w = 22,
			h = 16
		},
		["chair"] = {
			x = 4,
			y = 349,
			w = 35,
			h = 31
		},
		["fireplace_inner"] = {
			x = 4,
			y = 308,
			w = 34,
			h = 33
		},
		["clock"] = {
			x = 50,
			y = 230,
			w = 23,
			h = 66
		}
	},
	meta = {
		padding = 4,
		extrude = 0,
		atlasWidth = 95,
		atlasHeight = 427,
		quadCount = 11
	}
}
return Data
