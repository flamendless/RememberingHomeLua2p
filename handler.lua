local args = dataFromCommandLine

local function split(str)
	local t = {}
	for arg in string.gmatch(str, "([^%s]+)") do
		table.insert(t, arg)
	end
	return t
end

function assert(cond, msg)
	if _RELEASE then return "" end
	msg = msg or string.format("%q", "Assertion failed: " .. cond)
	return "if not (" .. cond .. ") then error(" .. msg ..") end"
end

function sassert(v, cond, msg)
	if _RELEASE then return "" end
	local str = assert(cond, msg)
	return "if " .. v .. " then " .. str .. " end"
end

args = split(args)

if args[1] == "dev" then
	_DEV = true
	_RELEASE = false
	_ASSERT = true
	_PROF = false
elseif args[1] == "release" then
	_DEV = false
	_RELEASE = true
	_PROF = false
elseif args[1] == "prof" then
	_DEV = true
	_RELEASE = false
	_PROF = true
end

_IDENTITY = "goinghomerevisited"
_LOVE_VERSION = "11.3"
_GAME_VERSION = { 0, 0, 1 }
_COMMIT_VERSION = args[2]

_MODE = args[1]
_REPORTING = false
_NETWORK = false
_LOG_SAVE = false

_OS = "Linux"
_PLATFORM = "desktop"
_GAME_TITLE  = "Going Home: Revisited"
_GAME_TITLE_SECRET  = "COMING SOON"
_GAME_SIZE = { x = 1024, y = 640 }
_GAME_BASE_SIZE = { x = 128, y = 32 }

_MIN_GL_VERSION = "2.1"

_DEFAULT_FILTER = "nearest"
_IMAGE_FILTER = "nearest"
_FONT_FILTER = "nearest"
_CANVAS_FILTER = "nearest"

_WINDOW_MODES = {
	{
		width = _GAME_SIZE.x,
		height = _GAME_SIZE.y
	}
}
_WINDOW_MODES_STR = {
	(_GAME_SIZE.x .. "x" .. _GAME_SIZE.y),
}

_GFX_QUALITY = nil
if _DEV then
	_GFX_QUALITY = "low"
else
	_GFX_QUALITY = "high"
end

_EMAIL = "flamendless.studio@gmail.com"
_GITHUB_URL = "https://github.com/flamendless/GoingHomeRevisited"
_GITHUB_URL_RELEASE = ""

_LOG_OUTPUT = "log_output.txt"
_LOG_INFO = "info.txt"
_SETTINGS_FILENAME = "user_settings.json"
_SAVE_FILENAME = "save_data"
_SAVE_KEY = "data_store"

_URL_TWITTER = "https://twitter.com/@flam8studio"
_URL_DISCORD = "https://discord.gg/2W4tyyV"
_URL_WEBSITE = "https://flamendless.itch.io"
_URL_MAIL = "mailto:flamendless.studio@gmail.com"

_ABOUT_LINKS = {
	_URL_TWITTER,
	_URL_DISCORD,
	_URL_WEBSITE,
	_URL_MAIL
}

_NAME_DEVELOPER = "Brandon"
_NAME_ARTIST = "Conrad"
_NAME_DESIGNER = "Piolo Maurice"
_NAME_MUSICIAN = "???"

_FULL_NAME_DEVELOPER = "Brandon Blanker Lim-it"
_FULL_NAME_ARTIST = "Conrad Reyes"
_FULL_NAME_DESIGNER = "Piolo Maurice Laudencia"

_TWITTER_DEVELOPER = "@flamendless"
_TWITTER_ARTIST = "@wits"
_TWITTER_DESIGNER = "@piotato"

_TOOLS = {
	"Manjaro", "i3-Gaps", "Discord", "Löve Framework",
	"Vim", "Trello", "Aseprite", "Audacity",
}

_LIBS = {
	"Anim8", "Arson", "Batteries", "Bump-niji", "Cartographer",
	"Concord", "Crush", "Enum", "Flux", "Gamera",
	"HTTPS", "HUMP", "jprof", "JSON", "Lily", "Log",
	"Luapreprocessor", "Lume", "NGrading", "ReflowPrint", "SDF",
	"Semver", "Slab", "Splashes", "strictness", "TimelineEvents",
}

return {}
