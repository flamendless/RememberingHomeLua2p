extern int quality;
extern vec2 canvas_size;
extern vec2 dir;
extern float length;

vec4 effect(vec4 color, Image texture, vec2 tex_coords, vec2 screen_coords)
{
	vec4 blur;
	vec2 c = vec2(0, 0)/canvas_size;
	vec2 pos = vec2(0.0, 0.0);

	for (float i = 0.0; i < 1.0; i += 1.0/float(quality))
	{
		pos.x = (length * dir.x + c.x * dir.x) * i;
		pos.y = (length * dir.y + c.y * dir.y) * i;
		blur += Texel(texture, tex_coords - pos);
	}
	blur /= float(quality);

	return color * blur;
}
