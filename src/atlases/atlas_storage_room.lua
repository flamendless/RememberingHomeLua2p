-- https://github.com/EngineerSmith/Export-TextureAtlas
-- check build.sh create_atlas
local Data = {
	frames = {
		["left_door"] = {
			x = 370,
			y = 4,
			w = 4,
			h = 65
		},
		["right_door"] = {
			x = 382,
			y = 4,
			w = 4,
			h = 65
		},
		["tires"] = {
			x = 201,
			y = 52,
			w = 35,
			h = 22
		},
		["filing_cabinet"] = {
			x = 303,
			y = 4,
			w = 19,
			h = 44
		},
		["bulb"] = {
			x = 244,
			y = 52,
			w = 5,
			h = 18
		},
		["light_switch"] = {
			x = 303,
			y = 56,
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
			x = 201,
			y = 4,
			w = 59,
			h = 40
		},
		["shelf"] = {
			x = 123,
			y = 4,
			w = 70,
			h = 60
		},
		["shelf_side"] = {
			x = 268,
			y = 4,
			w = 27,
			h = 70
		},
		["barrell"] = {
			x = 330,
			y = 4,
			w = 32,
			h = 22
		}
	},
	meta = {
		padding = 4,
		extrude = 0,
		atlasWidth = 390,
		atlasHeight = 78,
		quadCount = 11
	}
}
return Data
