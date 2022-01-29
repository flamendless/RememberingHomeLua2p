-- https://github.com/EngineerSmith/Export-TextureAtlas
-- check build.sh create_atlas
local Data = {
	frames = {
		["frontdoor"] = {
			x = 4,
			y = 60,
			w = 33,
			h = 67
		},
		["car"] = {
			x = 4,
			y = 4,
			w = 126,
			h = 48
		},
		["backdoor"] = {
			x = 45,
			y = 60,
			w = 10,
			h = 67
		}
	},
	meta = {
		padding = 4,
		extrude = 0,
		atlasWidth = 134,
		atlasHeight = 131,
		quadCount = 3
	}
}
return Data
