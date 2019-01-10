local GSM = {
	previous_state,
	current_state,
}

local Log = require("modules.log.log")
local BaseState = require("states.base_state")

function GSM:initState(state)
	assert(state:is(BaseState), "Passed state must extend from base state")
	self.current_state = state
	self:load()
end

function GSM:load()
	if self.current_state.preload and not self.current_state:hasPreloaded() then
		self.current_state:preload()
		self.current_state:setPreload(true)
		Log.trace(("State: '%s' preload..."):format(self.current_state:getID()))
	else
		self.current_state:load()
		Log.trace(("State: '%s' load..."):format(self.current_state:getID()))
	end
end

function GSM:switch(state)
	assert(state:is(BaseState), "Passed state must extend from base state")
	self.current_state:exit()
	Log.trace(("State: '%s' exit..."):format(self.current_state:getID()))
	self.previous_state = self.current_state
	self.current_state = state
	self:load()
	Log.trace(("Switched from '%s' to '%s'"):format(self.previous_state:getID(), self.current_state:getID()))
end

function GSM:switchToPrevious()
	if self.previous_state then
		self:switch(self.previous_state)
	else
		return nil
	end
end

function GSM:update(dt)
	self.current_state:update(dt)
end

function GSM:draw()
	self.current_state:draw()
end

function GSM:keypressed(key)
	self.current_state:keypressed(key)
end

function GSM:keyreleased(key)
	self.current_state:keyreleased(key)
end

function GSM:mousepressed(mx, my, mb)
	self.current_state:mousepressed(mx, my, mb)
end

function GSM:mousereleased(mx, my, mb)
	self.current_state:mousereleased(mx, my, mb)
end

return GSM
