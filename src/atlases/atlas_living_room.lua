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
			x = 78,
			y = 59,
			w = 56,
			h = 48
		},
		["door"] = {
			x = 157,
			y = 4,
			w = 38,
			h = 70
		},
		["painting"] = {
			x = 78,
			y = 4,
			w = 71,
			h = 47
		},
		["table"] = {
			x = 89,
			y = 119,
			w = 87,
			h = 11
		},
		["light"] = {
			x = 203,
			y = 78,
			w = 17,
			h = 23
		},
		["plant"] = {
			x = 157,
			y = 82,
			w = 16,
			h = 29
		},
		["stool"] = {
			x = 4,
			y = 160,
			w = 22,
			h = 16
		},
		["chair"] = {
			x = 46,
			y = 119,
			w = 35,
			h = 31
		},
		["fireplace_inner"] = {
			x = 4,
			y = 119,
			w = 34,
			h = 33
		},
		["clock"] = {
			x = 203,
			y = 4,
			w = 23,
			h = 66
		}
	},
	meta = {
		padding = 4,
		extrude = 0,
		atlasWidth = 230,
		atlasHeight = 180,
		quadCount = 11
	}
}
return Data
