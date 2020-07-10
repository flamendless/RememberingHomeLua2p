vec4 effect(vec4 color, Image texture, vec2 tex_coords, vec2 screen_coords)
{
	vec4 px = Texel(texture, tex_coords);
	return px * vec4(1.0, 0, 0, 1.0);
}
