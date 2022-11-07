local AnimationSync = Concord.system({
	pool = {"anim_sync_with", "anim_sync_data"},
})

function AnimationSync:init(world)
	self.world = world

	if DEV then
		self.pool.onAdded = function(_, e)
			local e_target = self.world:getEntityByKey(e.anim_sync_with.key)
			local c_name = e.anim_sync_data.c_name
			local target_c = e_target[c_name]
			ASSERT(target_c, "sync target must have component: " .. c_name)
			local c_props = e.anim_sync_data.c_props
			for _, prop in ipairs(c_props) do
				ASSERT(target_c[prop], "target component must have property: " .. prop)
			end

			local md = e_target.multi_animation_data
			if md then
				md = md.data
				local data = e.anim_sync_data.data
				for k, v in pairs(data) do
					ASSERT(md[k], "multi_animation_data must have key: " .. k)
					for _, t in ipairs(v) do
						for _, prop in ipairs(c_props) do
							ASSERT(t[prop], "subdata must have property: " .. prop)
						end
					end
				end
			end
		end
	end
end

function AnimationSync:update(dt)
	for _, e in ipairs(self.pool) do
		local e_target = self.world:getEntityByKey(e.anim_sync_with.key)
		local animation = e_target.animation
		local anim_sync_data = e.anim_sync_data
		local data = anim_sync_data.data[animation.base_tag]
		if data then
			local c_props = anim_sync_data.c_props
			local frame = e_target.current_frame.value
			for _, prop in ipairs(c_props) do
				local target_data = data[frame]
				if target_data then
					local target_c = e_target[anim_sync_data.c_name]
					target_c[prop] = target_data[prop]
				end
			end
		elseif DEV then
			Log.warn("there is no animation tag in sync data:", animation.base_tag)
		end
	end
end

return AnimationSync
