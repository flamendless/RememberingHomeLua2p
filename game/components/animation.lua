Concord.component("override_animation")

local c_anim = Concord.component("animation", function(c, stop_on_last)
	SASSERT(stop_on_last, type(stop_on_last) == "boolean")
	c.grid = nil
	c.anim8 = nil
	c.base_tag = "default"
	c.current_tag = "default"
	c.is_playing = true
	c.stop_on_last = (stop_on_last == true) or false
end)

function c_anim:serialize()
	return {
		base_tag = self.base_tag,
		current_tag = self.current_tag,
		is_playing = self.is_playing,
		stop_on_last = self.stop_on_last,
	}
end

function c_anim:deserialize(data)
	self:__populate(data.stop_on_last)
end

Concord.component("change_animation_tag", function(c, new_tag, override)
	ASSERT(type(new_tag) == "string")
	SASSERT(override, type(override) == "boolean")
	c.new_tag = new_tag
	c.override = override
end)

Concord.component("animation_pause_at", function(c, at_frame)
	ASSERT(type(at_frame) == "string" or type(at_frame) == "number")
	ASSERT(type(at_frame) == "string")
	c.at_frame = at_frame
end)

Concord.component("animation_stop", function(c, event)
	c.event = event
end)

Concord.component("current_frame", function(c, limit)
	SASSERT(limit, type(limit) == "number" and limit > 0)
	c.value = 0
	c.limit = limit
end)

Concord.component("animation_ev_update", function(c, ev_update)
	ASSERT(type(ev_update) == "string")
	c.value = ev_update
end)
