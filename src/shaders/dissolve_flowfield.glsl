extern Image tex_flowfield;
extern number time;

vec4 effect(vec4 color, Image texture, vec2 tex_coords, vec2 screen_coords)
{
	vec4 px = Texel(texture, tex_coords);
	vec4 px2 = Texel(tex_flowfield, tex_coords);
	if (px2.r < time)
		return px * color;
	else
		return vec4(0.0);
}
