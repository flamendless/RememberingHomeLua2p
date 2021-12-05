local args = dataFromCommandLine --from build.sh

local function split(str)
	local t = {}
	for arg in string.gmatch(str, "([^%s]+)") do
		table.insert(t, arg)
	end
	return t
end

function assert(cond, msg)
	if not _DEV then return "" end
	msg = msg or string.format("%q", "Assertion failed: " .. cond)
	return "if not (" .. cond .. ") then error(" .. msg ..") end"
end

function sassert(v, cond, msg)
	if not _DEV then return "" end
	local str = assert(cond, msg)
	return "if " .. v .. " then " .. str .. " end"
end

function profb(a, b)
	if not _PROF then return "" end
	if b then
		return string.format("JPROF.push(%s, %s)", a, b)
	else
		return "JPROF.push(" .. a .. ")"
	end
end

function profe(a)
	if not _PROF then return "" end
	return "JPROF.pop(" .. a .. ")"
end

local bit = require("bit")
local band, bor = bit.band, bit.bor
local lshift, rshift = bit.lshift, bit.rshift
function hex_to_rgb(hex)
	local r = rshift(band(hex, 0x00ff0000), 16) / 255.0
	local g = rshift(band(hex, 0x0000ff00), 8)  / 255.0
	local b = rshift(band(hex, 0x000000ff), 0)  / 255.0
	return string.format("{%f, %f, %f}", r, g, b)
end

args = split(args)
assert(type(args[1]) == "string")
assert(type(args[2]) == "string")
assert(type(args[3]) == "number" and args[3] > 0)

if args[1] == "dev" then
	_DEV = true
	_PROF = false
elseif args[1] == "release" then
	_DEV = false
	_PROF = false
elseif args[1] == "prof" then
	_DEV = true
	_PROF = true
end

_IDENTITY = toLua("goinghomerevisited")
_LOVE_VERSION = toLua("11.3")
_GAME_VERSION = toLua("0.0.1")
_COMMIT_VERSION = toLua(args[2])

_MODE = toLua(args[1])
_LOG_SAVE = true
_CACHED_PRELOAD = true
_PADDING = toLua(args[3])
_GLSL_NORMALS = false

_OS = "Linux"
_PLATFORM = "desktop" --mobile
_GAME_TITLE  = toLua("Going Home: Revisited")
_GAME_TITLE_SECRET  = toLua("COMING SOON")
_GAME_SIZE = {x = 1024, y = 640}
_GAME_BASE_SIZE = toLua({x = 128, y = 32})

_MIN_GL_VERSION = toLua("2.1")

_DEFAULT_FILTER = toLua("nearest")
_IMAGE_FILTER = toLua("nearest")
_FONT_FILTER = toLua("nearest")
_CANVAS_FILTER = toLua("nearest")

_WINDOW_MODES = toLua({
	{
		width = _GAME_SIZE.x,
		height = _GAME_SIZE.y
	}
})
_WINDOW_MODES_STR = toLua({
	(_GAME_SIZE.x .. "x" .. _GAME_SIZE.y),
})

_GFX_QUALITY = nil
if _DEV then
	_GFX_QUALITY = toLua("low")
else
	_GFX_QUALITY = toLua("high")
end

_EMAIL = "flamendless.studio@gmail.com"
_GITHUB_URL = "https://github.com/flamendless/GoingHomeRevisited"
_GITHUB_URL_RELEASE = ""

_LOG_OUTPUT = toLua("log")
_LOG_INFO = toLua("info.txt")
_SETTINGS_FILENAME = toLua("user_settings")
_SAVE_FILENAME = toLua("save_data")
_SAVESTATE_FILENAME = toLua("save_state")
_SAVE_KEY = toLua("data_store")

_URL_TWITTER = "https://twitter.com/@flam8studio"
_URL_DISCORD = "https://discord.gg/2W4tyyV"
_URL_WEBSITE = "https://flamendless.itch.io"
_URL_MAIL = "mailto:flamendless.studio@gmail.com"

_ABOUT_LINKS = toLua({
	_URL_TWITTER,
	_URL_DISCORD,
	_URL_WEBSITE,
	_URL_MAIL,
})

_NAME_DEVELOPER = "Brandon"
_NAME_ARTIST = "Conrad"
_NAME_DESIGNER = "Piolo Maurice"
_NAME_MUSICIAN = "???"

_FULL_NAME_STUDIO = "flamendless studio"
_FULL_NAME_DEVELOPER = "Brandon Blanker Lim-it"
_FULL_NAME_ARTIST = "Conrad Reyes"
_FULL_NAME_DESIGNER = "Piolo Maurice Laudencia"
_FULL_NAME_MUSICIAN = "???"

_TWITTER_STUDIO = "@flam8studio"
_TWITTER_DEVELOPER = "@flamendless"
_TWITTER_ARTIST = "@Shizzy619"
_TWITTER_DESIGNER = "@piotato"
_TWITTER_MUSICIAN = "@???"

_TOOLS = toLua({
	"Manjaro", "i3-Gaps", "Discord", "Löve Framework",
	"Luapreprocess", "Vim", "Aseprite", "Audacity", "Export-TextureAtlas",
	"makelove", "msdf-bmfont",
})

_LIBS = toLua({
	"Anim8", "Batteries", "Bitser", "Bump-niji", "Concord", "Enum", "Flux",
	"Gamera", "HUMP", "JProf", "Lily", "Log", "Lume", "ngrading", "Outliner",
	"ReflowPrint", "SDF", "Semver", "Slab", "Splashes", "strict",
	"TimelineEvents",
})

--PRE CALCULATED
_HALF_PI = toLua(math.pi * 0.5)
_TWO_PI = toLua(math.pi * 2)
_T_H_PI = toLua(3 * _HALF_PI)
_RA = toLua({math.cos(math.pi/32), math.sin(math.pi/32)})

--IDS
_ITEMS_ACTION_USE = toLua("Use")
_ITEMS_ACTION_EQUIP = toLua("Equip")
_ITEMS_ACTION_CANCEL = toLua("Cancel")

_LIST_MAIN_MENU = toLua("main_menu")
_LIST_SUB_MENU = toLua("sub_menu")
_LIST_DIALOGUE_CHOICES = toLua("dialogue_choices")
_LIST_NOTES = toLua("notes")
_LIST_INVENTORY_CELLS = toLua("inventory_cells")
_LIST_INVENTORY_CHOICES = toLua("inventory_choices")
_LIST_PAUSE_CHOICES = toLua("pause_choices")

--SIGNALS
_SIGNAL_LIST_REMOVE = toLua("on_list_cursor_remove_")
_SIGNAL_LIST_INTERACT = toLua("on_list_item_interact_")
_SIGNAL_LIST_UPDATE = toLua("on_list_cursor_update_")

return {}
