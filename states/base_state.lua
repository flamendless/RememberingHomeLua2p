local classic = require("modules.classic.classic")
local BaseState = classic:extend()

function BaseState:new(id)
	self.__id = id
	self.__isPreloaded = false
end

function BaseState:getID() return self.__id end
function BaseState:hasPreloaded() return self.__isPreloaded end
function BaseState:setPreload(bool) self.__isPreloaded = bool end

function BaseState:load() end
function BaseState:update(dt) end
function BaseState:draw() end
function BaseState:keypressed(key) end
function BaseState:keyreleased(key) end
function BaseState:mousepressed(mx, my, mb) end
function BaseState:mousereleased(mx, my, mb) end
function BaseState:exit() end

return BaseState
