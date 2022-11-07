local Click = Concord.system({
	pool = {"bounding_box", "clickable", "on_click", "!ui_element"},
	pool_ui = {"bounding_box", "clickable", "on_click", "ui_element"},
})

function Click:init(world)
	self.world = world
end

function Click:mousepressed(mx, my, mb)
	for _, e in ipairs(self.pool) do
		if not e.hidden and not e.ui_element then
			local on_click = e.on_click
			if mb == on_click.mb then
				local box = e.bounding_box
				local bpos = Utils.math.get_real_pos_box(e)
				local bw, bh = box.size:unpack()
				local result = Utils.math.check_point_rect(mx, my, bpos.x, bpos.y, bw, bh)
				if result then
					self.world:emit(on_click.signal, unpack(on_click.args))
				end
			end
		end
	end
end

function Click:mousepressed_ui(mx, my, mb)
	for _, e in ipairs(self.pool_ui) do
		if not e.hidden then
			local on_click = e.on_click
			if mb == on_click.mb then
				local box = e.bounding_box
				local bpos = box.screen_pos:unpack()
				local bw, bh = box.size:unpack()
				local result = Utils.math.check_point_rect(mx, my, bpos.x, bpos.y, bw, bh)
				if result then
					self.world:emit(on_click.signal, unpack(on_click.args))
				end
			end
		end
	end
end

return Click
