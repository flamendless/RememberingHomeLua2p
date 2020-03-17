local Concord = require("modules.concord.concord")
local StateMachine = require("modules.batteries.state_machine")
local Log = require("modules.log.log")

local State_Splash = {
	id = "Splash",
	world = nil,
}

function State_Splash:load()
	Log.info("State Load: ", self.id)
end

function State_Splash:update(dt)
end

function State_Splash:draw()
end

return State_Splash
