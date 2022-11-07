local Ants = Concord.system({
	pool = {"id", "bug", "ant"},
})

function Ants:init(world)
	self.world = world
end

function Ants:generate_ants(n, start_pos, end_pos, path_repeat, ms)
	ASSERT(type(n) == "number" and n > 0)
	ASSERT(start_pos:type() == "vec2")
	ASSERT(end_pos:type() == "vec2")
	ASSERT(type(path_repeat) == "boolean")
	ASSERT(type(ms) == "number")
	local np = love.math.random(2, 5) * 3
	local points = Generator.path_points_ants(start_pos, end_pos, np)
	local p = points[1]

	for i = 1, n do
		local speed = ms - (i - 1)
		local e = Concord.entity(self.world)
			:give("id", "ant" .. i)
			:give("ant")
			:give("bug")
			:give("color", {0, 0, 0, 1})
			:give("point", 4)
			:give("pos", p)
			:give("path", points)
			:give("path_speed", speed)
			:give("no_shader")

		if not DEV then
			e:give("hidden")
		end

		if path_repeat then
			e:give("path_repeat")
		else
			e:give("on_path_reached_end", "destroy_entity", 0, e)
		end
	end
end

function Ants:set_ants_visibility(bool)
	ASSERT(type(bool) == "boolean")
	if DEV and #self.pool == 0 then
		Log.warn("pool is 0")
	end
	for _, e in ipairs(self.pool) do
		if bool then
			e:remove("hidden")
		else
			e:give("hidden")
		end
	end
end

function Ants:move_ants()
	for _, e in ipairs(self.pool) do
		e:give("path_move")
	end
end

if DEV then
	local flags = {
		path = true,
		show = false,
	}
	local data = {
		n = 1,
		path_repeat = false,
		speed = 32,
	}

	function Ants:debug_update(dt)
		if not self.debug_show then return end
		self.debug_show = Slab.BeginWindow("Ants", {
			Title = "Ants",
			IsOpen = self.debug_show
		})
		data.n = UIWrapper.edit_range("n", data.n, 1, 256, true)
		data.dur = UIWrapper.edit_range("dur", data.dur, 0, 5)

		if Slab.Button("generate") then
			for _, e in ipairs(self.pool) do
				e:destroy()
			end
			flags.show = false
			self.world:emit("debug_toggle_path", flags.path, "bug")
			self:generate_ants(data.n, vec2(12, 28), vec2(56, 4), data.path_repeat, data.speed)
		end

		if Slab.Button("move") then
			self:move_ants()
		end

		if Slab.CheckBox(flags.show, "show") then
			flags.show = not flags.show
			self:set_ants_visibility(flags.show)
		end

		if Slab.CheckBox(flags.path_repeat, "repeat") then
			flags.path_repeat = not flags.path_repeat
		end
		Slab.EndWindow()
	end
end

return Ants
