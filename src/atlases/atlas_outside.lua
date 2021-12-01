-- https://github.com/EngineerSmith/Export-TextureAtlas
-- check build.sh create_atlas
local Data = {
	frames = {
		["frontdoor"] = {
			x = 22,
			y = 4,
			w = 33,
			h = 67
		},
		["car"] = {
			x = 63,
			y = 4,
			w = 126,
			h = 48
		},
		["backdoor"] = {
			x = 4,
			y = 4,
			w = 10,
			h = 67
		}
	},
	meta = {
		padding = 4,
		extrude = 0,
		atlasWidth = 193,
		atlasHeight = 75,
		quadCount = 3
	}
}
return Data
