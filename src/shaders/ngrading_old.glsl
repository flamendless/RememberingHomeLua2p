extern Image lut;
extern number cell_size;
extern vec2 tile_size;

vec4 ngrading(vec4 texCol)
{
	number cdim = cellDimensions.x * cellDimensions.y - 1.0;
	number cw = cellPixels * cellDimensions.x;
	// Sampling must be done at 0.5-increments
	vec2 cpos = clamp(texCol.rg * cellPixels, 0.0, cellPixels - 1.0) + 0.5;
	number z = clamp(texCol.b * cdim, 0.0, cdim);
	number zf = fract(z);
	number zp = floor(z);
	// Calculate cell position
	vec2 tp1 = vec2(mod(zp, cellDimensions.x), floor(zp / cellDimensions.x)) * cellPixels + cpos;
	vec2 tp2 = vec2(mod((zp + 1.0), cellDimensions.x), floor((zp + 1.0) / cellDimensions.x)) * cellPixels + cpos;
	// Sample
	vec4 p1 = Texel(lut, tp1 / cw);
	vec4 p2 = Texel(lut, tp2 / cw);
	return vec4(mix(p1.rgb, p2.rgb, zf), texCol.a);
}

vec4 ngrading(Image tex, vec2 tc)
{
	return ngrading(Texel(tex, tc));
}
