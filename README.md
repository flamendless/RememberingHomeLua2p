# Going Home: Revisited

![](https://img.shields.io/badge/lua-on%20development-green.svg)
![Lua](https://img.shields.io/badge/Lua-JIT%2C%205.1-blue.svg)

Made with [LOVE](https://love2d.org)

## Building:

Run `./build init` to compile
Then `./build run` to run

When changing files in the `res/`, you should update with `./build rebuild`

For cleaning files and logs `./build clean && ./build clean_logs`

(see [buid.sh](build.sh) for more info)

## Libraries:

* [anim8](https://github.com/kikito/anim8) - for sprite animation
* [arson.lua](https://github.com/flamendless/arson.lua) - for registering custom data types for encoding and decoding
* [Batteries](https://github.com/1bardesign/batteries) - for class, vec2, vec3, math, string, table, etc.
* [bump-niji](https://github.com/oniietzschan/bump-niji) - for 2D collision detection
* [bump-3dpd](https://github.com/oniietzschan/bump-3dpd) - for 3D collision detection
* [Concord](https://github.com/Tjakka5/Concord) - for Entity Component System
* [Crush](modules/crush) - for error reporting
* [Enum](https://github.com/Tjakka5/Enum) - for Enums
* [gamera](https://github.com/kikito/gamera) - for camera
* [luajit-request](https://github.com/LPGhatguy/luajit-request) - for HTTPS requests
* [HUMP](https://github.com/vrld/hump) - for Timer
* [inspect](https://github.com/kikito/inspect.lua) - for debugging Lua tables
* [json.lua](https://github.com/kikito/json.lua) - for serialization/deserialization of json files
* [lily](https://github.com/MikuAuahDark/lily) - for asynchronous loading of assets
* [log](https://github.com/flamendless/log.lua) - for logging
* [lume](https://github.com/rxi/lume) - for linear interpolation and tweening
* [love-sdf-text](https://github.com/Tjakka5/love-sdf-text) - for SDF rendering
* [semver](https://github.com/kikito/semver) - for semantic versioning
* [Slab](https://github.com/coding-jackalope/Slab) - for GUI and in-game editor tools
* [splashes](https://github.com/love2d-community/splashes) - for löve splash screen
* [TimelineEvents](https://github.com/flamendless/TimelineEvents) - for coroutine based event system

## Tools:

* [Luapreprocess](https://github.com/ReFreezed/LuaPreprocess) - for preprocessing `.lua2p` files to `.lua`
* [makelove](https://github.com/pfirsich/makelove) - for packaging the game for other operating system
* [msdf-bmfont](https://www.npmjs.com/package/msdf-bmfont) - for converting `.ttf` font files to SDF

## LICENSE:

* Assets have a commercial license and thus can not be used without the permission from the artist
* Each library/module has their own license
