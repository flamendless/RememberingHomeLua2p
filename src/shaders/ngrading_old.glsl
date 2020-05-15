extern Image lut;
extern number cell_size;
extern vec2 tile_size;

vec4 ngrading(Image tex, vec2 tc)
{
	number cdim = tile_size.x * tile_size.y - 1.0;
	number cw = cell_size * tile_size.x;
	vec4 texCol = Texel(tex, tc);

	// Sampling must be done at 0.5-increments
	vec2 cpos = clamp(texCol.rg * cell_size, 0.0, cell_size - 1.0) + 0.5;
	number z = clamp(texCol.b * cdim, 0.0, cdim);
	number zf = fract(z);
	number zp = floor(z);

	// Calculate cell position
	vec2 tp1 = vec2(mod(zp, tile_size.x), floor(zp / tile_size.x)) * cell_size + cpos;
	vec2 tp2 = vec2(mod((zp + 1.0), tile_size.x), floor((zp + 1.0) / tile_size.x)) * cell_size + cpos;

	// Sample
	vec4 p1 = Texel(lut, tp1 / cw);
	vec4 p2 = Texel(lut, tp2 / cw);
	return vec4(mix(p1.rgb, p2.rgb, zf), texCol.a);
}

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc)
{
	return ngrading(tex, tc) * color;
}
