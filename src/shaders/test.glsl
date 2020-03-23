extern int quality;
extern vec2 mv;
extern vec2 canvas_size;

vec4 effect(vec4 color, Image texture, vec2 tex_coords, vec2 screen_coords)
{
	vec4 blur;
	vec2 c = mv/canvas_size;
	for (float i = 0.0; i < 1.0; i += 1.0/float(quality))
	{
		blur += Texel(texture, tex_coords + (0.5 - c) * i);
	}
	blur /= float(quality);

	vec4 tex_color = Texel(texture, tex_coords);
	return tex_color * blur;
}
