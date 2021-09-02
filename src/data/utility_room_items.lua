local Data = {
	{
		id = "bulb",
		x = 90, y = 16,
		no_col = true,
	},
	{
		id = "bulb",
		name = "bulb2",
		x = 240, y = 16,
		no_col = true,
	},

	{
		id = "shelf",
		x = 136, y = 57, z = 4,
		dialogue = {"utility_room", "shelf"},
	},
	{
		id = "electrical_box",
		x = 88, y = 48, z = 4,
		dialogue = {"utility_room", "electrical_box"},
	},
	{
		id = "ironing_board",
		x = 128, y = 69, z = 6,
		scale = 0.75,
		no_col = true,
	},

	{
		id = "washing_machine",
		x = 260, y = 76, z = 4,
		dialogue = {"utility_room", "washing_machine"},
	},

	{
		id = "basket",
		grouped = true,
		dialogue = {"utility_room", "basket"},
		{
			name = "basket_left",
			x = 218, y = 85, z = 4,
		},
		{
			name = "basket_right",
			x = 216, y = 92, z = 5,
			scale = 0.75,
		},
	},

	{
		id = "woods",
		name = "woods1",
		x = 74, y = 95, z = 2,
		no_col = true,
	},
	{
		id = "woods",
		name = "woods2",
		x = 89, y = 95, z = 3,
		no_col = true,
	},
	{
		id = "woods",
		name = "woods3",
		x = 79, y = 78, z = 4,
		no_col = true,
	},
	{
		id = "woods",
		name = "woods4",
		x = 194, y = 95, z = 2,
		no_col = true,
	},
	{
		id = "woods",
		name = "woods5",
		x = 222, y = 95, z = 2,
		no_col = true,
	},
	{
		id = "woods",
		name = "woods6",
		x = 284, y = 95, z = 2,
		no_col = true,
	},
}

return Data