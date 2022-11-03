MODE = ""
DEV = false
PROF = false
GAME_VERSION = "0.1.0"
WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 640
GAME_BASE_SIZE = {x = 128, y = 32}

local args = love.arg.parseGameArguments(arg)
for _, v in pairs(args) do
	if v == "dev" then
		MODE = v
		DEV = true
	elseif v == "prof" then
		MODE = v
		PROF = true
	end
end

if DEV then
	love.filesystem.setRequirePath(love.filesystem.getRequirePath() .. ";modules/?.lua")
	require("jit.p").start("lz")
end

if PROF then
	--TODO replace with AppleCake profiler
	PROF_CAPTURE = true
	JPROF = require("modules.jprof.jprof")
end

--LOAD LIBRARIES/MODULES
UTF8 = require("utf8")

require("modules.sdf").mount()
local Batteries = require("modules.batteries")
mathx = Batteries.mathx
pretty = Batteries.pretty
stringx = Batteries.stringx
tablex = Batteries.tablex
vec2 = Batteries.vec2

Bitser = require("modules.bitser.bitser")
Concord = require("modules.concord.concord")
Cron = require("modules.cron.cron")
Enum = require("modules.enum.enum")
--TODO replace
Flux = require("modules.flux.flux")
Lily = require("modules.lily.lily")
Log = require("modules.log.log")
Log.lovesave = true
Slab = require("modules.slab")
Tle = require("modules.tle.timeline")

--LOAD SOURCES
Audio = require("src.audio")
Cache = require("src.cache")
Ecs = require("src.ecs")
Enums = require("src.enums")
ErrorHandler = require("src.error_handler")
love.errhand = ErrorHandler.callback
GameStates = require("src.gamestates")
Generator = require("src.generator")
SystemInfo = require("src.system_info")
Inputs = require("src.inputs")
Items = require("src.items")
LoadingScreen = require("src.loading_screen")
Notes = require("src.notes")
Preloader = require("src.preloader")
Resources = require("src.resources")
Save = require("src.save")
Settings = require("src.settings")
Shaders = require("src.shaders")
Shaders.load_shaders()
UIWrapper = require("src.ui_wrapper")
Utils = require("src.utils")

if DEV then
	--NOTE strict should be loaded last
	require("modules.strict")
	DevTools = require("devtools")
end

if DEV then
	function ASSERT(cond, msg)
		assert(type(cond) == "boolean")
		if msg then assert(type(msg) == "string") end
		if not cond then error(msg or "") end
	end
	function SASSERT(var, cond, msg)
		if var == nil then return end
		ASSERT(cond, msg)
	end
else
	local noop = function() end
	ASSERT = noop
	SASSERT = noop
end
