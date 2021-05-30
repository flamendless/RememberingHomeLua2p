# Going Home: Revisited

![](https://img.shields.io/badge/lua-on%20development-green.svg)
![Lua](https://img.shields.io/badge/Lua-JIT%2C%205.1-blue.svg)
![](https://img.shields.io/badge/made%20with-l%C3%B6ve-blueviolet)
![](https://img.shields.io/twitter/follow/flamendless?style=social)

Made with [LOVE](https://love2d.org)

## Building:

1. Go to the `scripts/` folder and then run `./generate_fonts generate_fonts`, `./generate_fonts convert_fonts`, and `./generate_fonts copy_fonts` first. This is only required once.
2. Then run `./build init` to setup the directories and copy the assets to the output directory.
3. Then `./build run` to preprocess and run the game.

When modifying files in the `res/` or in the `modules/` directory, you should update with `./build rebuild` before running again.

For cleaning files and logs `./build clean && ./build clean_logs`

(see [buid.sh](build.sh) for more info)

## Libraries:

* [anim8](https://github.com/kikito/anim8) - for sprite animation
* [arson.lua](https://github.com/flamendless/arson.lua) - for registering custom data types for encoding and decoding
* [Batteries](https://github.com/1bardesign/batteries) - for class, vec2, vec3, math, string, table, etc.
* [bump-niji](https://github.com/oniietzschan/bump-niji) - for 2D collision detection
* [cartographer](https://github.com/tesselode/cartographer/) - for Tilemaps
* [Concord](https://github.com/Tjakka5/Concord) - for Entity Component System
* [Crush](modules/crush) - for error reporting
* [Enum](https://github.com/Tjakka5/Enum) - for Enums
* [gamera](https://github.com/kikito/gamera) - for camera
* [HUMP](https://github.com/vrld/hump) - for Timer
* [jprof](https://github.com/pfirsich/jprof) - for profiling
* [json.lua](https://github.com/kikito/json.lua) - for serialization/deserialization of json files
* [lily](https://github.com/MikuAuahDark/lily) - for asynchronous loading of assets
* [log](https://github.com/flamendless/log.lua) - for logging
* [lume](https://github.com/rxi/lume) - for linear interpolation and tweening
* [love-sdf-text](https://github.com/Tjakka5/love-sdf-text) - for SDF rendering
* [ReflowPrint](https://github.com/josefnpat/reflowprint) - for alignment of text that is shown one character at a time.
* [semver](https://github.com/kikito/semver) - for semantic versioning
* [Slab](https://github.com/coding-jackalope/Slab) - for GUI and in-game editor tools
* [splashes](https://github.com/love2d-community/splashes) - for löve splash screen
* [strictness](https://github.com/Yonaba/strictness) - trackes accesses and assignments of undefined variables in Lua
* [TimelineEvents](https://github.com/flamendless/TimelineEvents) - for coroutine based event system

## Tools:

* [HotParticles](https://github.com/ReFreezed/HotParticles) - for testing/playing with particle systems.
* [Luapreprocess](https://github.com/ReFreezed/LuaPreprocess) - for preprocessing `.lua2p` files to `.lua`
* [makelove](https://github.com/pfirsich/makelove) - for packaging the game for other operating system
* [msdf-bmfont](https://www.npmjs.com/package/msdf-bmfont) - for converting `.ttf` font files to SDF

## Dependencies:

* [LOVE framework](https://love2d.org) - versions 11.0 to 11.3 are tested to work.

## Coding Style Guide

* [Look at my coding style guide for Lua](https://flamendless.github.io/lua-coding-style-guide/)

## LICENSE:

* Source code is under the GPL. See [COPYING](COPYING) file.
* Assets have a commercial license and thus can not be used without the permission from the artist
* Each library/module has their own license
