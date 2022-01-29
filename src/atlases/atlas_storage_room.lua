-- https://github.com/EngineerSmith/Export-TextureAtlas
-- check build.sh create_atlas
local Data = {
	frames = {
		["left_door"] = {
			x = 123,
			y = 82,
			w = 4,
			h = 65
		},
		["right_door"] = {
			x = 135,
			y = 82,
			w = 4,
			h = 65
		},
		["tires"] = {
			x = 71,
			y = 150,
			w = 35,
			h = 22
		},
		["filing_cabinet"] = {
			x = 82,
			y = 82,
			w = 19,
			h = 44
		},
		["bulb"] = {
			x = 109,
			y = 82,
			w = 5,
			h = 18
		},
		["light_switch"] = {
			x = 44,
			y = 198,
			w = 13,
			h = 17
		},
		["ladder"] = {
			x = 4,
			y = 4,
			w = 111,
			h = 70
		},
		["table"] = {
			x = 4,
			y = 150,
			w = 59,
			h = 40
		},
		["shelf"] = {
			x = 4,
			y = 82,
			w = 70,
			h = 60
		},
		["shelf_side"] = {
			x = 123,
			y = 4,
			w = 27,
			h = 70
		},
		["barrell"] = {
			x = 4,
			y = 198,
			w = 32,
			h = 22
		}
	},
	meta = {
		padding = 4,
		extrude = 0,
		atlasWidth = 154,
		atlasHeight = 224,
		quadCount = 11
	}
}
return Data
