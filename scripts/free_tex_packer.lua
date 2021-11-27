-- https://github.com/odrick/free-tex-packer
-- padding: 4 (check build.sh)
-- no extrude
-- power of two
-- remove file ext
local Data = {
	frames = {
		{{#rects}}
		{{{name}}} = {
			frame = {
				x = {{frame.x}},
				y = {{frame.y}},
				w = {{frame.w}},
				h = {{frame.h}}
			},
			rotated = {{rotated}},
			trimmed = {{trimmed}},
			spriteSourceSize = {
				x = {{spriteSourceSize.x}},
				y = {{spriteSourceSize.y}},
				w = {{spriteSourceSize.w}},
				h = {{spriteSourceSize.h}}
			},
			sourceSize = {
				w = {{sourceSize.w}},
				h = {{sourceSize.h}}
			},
			pivot = {
				x = 0.5,
				y = 0.5
			}
		}{{^last}},{{/last}}
		{{/rects}}
	},
	meta = {
		app = "{{{appInfo.url}}}",
		version = "{{appInfo.version}}",
		image = "{{config.imageFile}}",
		format = "{{config.format}}",
		size = {
			w = {{config.imageWidth}},
			h = {{config.imageHeight}}
		},
		scale = {{config.scale}}
	}
}
return Data
