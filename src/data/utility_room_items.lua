local data = {
	frames = {
		shelf = {
			frame = {
				x = 4,
				y = 4,
				w = 67,
				h = 55
			},
			rotated = false,
			trimmed = false,
			spriteSourceSize = {
				x = 0,
				y = 0,
				w = 67,
				h = 55
			},
			sourceSize = {
				w = 67,
				h = 55
			},
			pivot = {
				x = 0.5,
				y = 0.5
			}
		},
		ironing_board = {
			frame = {
				x = 4,
				y = 67,
				w = 30,
				h = 57
			},
			rotated = false,
			trimmed = false,
			spriteSourceSize = {
				x = 0,
				y = 0,
				w = 30,
				h = 57
			},
			sourceSize = {
				w = 30,
				h = 57
			},
			pivot = {
				x = 0.5,
				y = 0.5
			}
		},
		washing_machine = {
			frame = {
				x = 79,
				y = 4,
				w = 33,
				h = 36
			},
			rotated = false,
			trimmed = false,
			spriteSourceSize = {
				x = 0,
				y = 0,
				w = 33,
				h = 36
			},
			sourceSize = {
				w = 33,
				h = 36
			},
			pivot = {
				x = 0.5,
				y = 0.5
			}
		},
		basket = {
			frame = {
				x = 79,
				y = 48,
				w = 27,
				h = 27
			},
			rotated = false,
			trimmed = false,
			spriteSourceSize = {
				x = 0,
				y = 0,
				w = 27,
				h = 27
			},
			sourceSize = {
				w = 27,
				h = 27
			},
			pivot = {
				x = 0.5,
				y = 0.5
			}
		},
		electrical_box = {
			frame = {
				x = 42,
				y = 67,
				w = 14,
				h = 21
			},
			rotated = false,
			trimmed = false,
			spriteSourceSize = {
				x = 0,
				y = 0,
				w = 14,
				h = 21
			},
			sourceSize = {
				w = 14,
				h = 21
			},
			pivot = {
				x = 0.5,
				y = 0.5
			}
		},
		bulb = {
			frame = {
				x = 64,
				y = 67,
				w = 5,
				h = 18
			},
			rotated = false,
			trimmed = false,
			spriteSourceSize = {
				x = 0,
				y = 0,
				w = 5,
				h = 18
			},
			sourceSize = {
				w = 5,
				h = 18
			},
			pivot = {
				x = 0.5,
				y = 0.5
			}
		},
		wood = {
			frame = {
				x = 42,
				y = 96,
				w = 17,
				h = 16
			},
			rotated = false,
			trimmed = false,
			spriteSourceSize = {
				x = 0,
				y = 0,
				w = 17,
				h = 16
			},
			sourceSize = {
				w = 17,
				h = 16
			},
			pivot = {
				x = 0.5,
				y = 0.5
			}
		},
		wood2 = {
			frame = {
				x = 67,
				y = 93,
				w = 16,
				h = 17
			},
			rotated = false,
			trimmed = false,
			spriteSourceSize = {
				x = 0,
				y = 0,
				w = 16,
				h = 17
			},
			sourceSize = {
				w = 16,
				h = 17
			},
			pivot = {
				x = 0.5,
				y = 0.5
			}
		}
	},
	meta = {
		app = "http://free-tex-packer.com",
		version = "0.6.7",
		image = "atlas_utility_room_items.png",
		format = "RGBA8888",
		size = {
			w = 128,
			h = 128
		},
		scale = 1
	}
}

local list = {
	{
		id = "bulb",
		name = "bulb_left",
		x = 182, y = 16,
		no_col = true,
	},
	{
		id = "bulb",
		name = "bulb_right",
		x = 364, y = 16,
		no_col = true,
	},

	{
		id = "shelf",
		x = 136, y = 57, z = 4,
		dialogue = {"utility_room", "shelf"},
	},
	{
		id = "electrical_box",
		x = 412, y = 48, z = 4,
		dialogue = {"utility_room", "electrical_box"},
	},
	{
		id = "ironing_board",
		x = 120, y = 55, z = 4,
		dialogue = {"utility_room", "ironing_board"},
	},

	{
		id = "washing_machine",
		grouped = true,
		dialogue = {"utility_room", "washing_machine"},
		{
			name = "washing_machine_left",
			x = 256, y = 76, z = 4,
		},
		{
			name = "washing_machine_right",
			x = 294, y = 76, z = 5,
		},
	},

	{
		id = "basket",
		grouped = true,
		dialogue = {"utility_room", "basket"},
		{
			name = "basket_left",
			x = 343, y = 85, z = 4,
		},
		{
			name = "basket_right",
			x = 338, y = 92, z = 5,
			scale = 0.75,
		},
	},
}

return {data, list}
