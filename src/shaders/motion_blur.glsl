extern float angle;
extern float strength;
const int samples = 25;

vec4 blur(Image texture, vec2 uv, vec2 dir)
{
	vec4 l = vec4(0);
	float delta = 1.0/float(samples);
	for (float i = 0.0; i < 1.0; i += delta)
	{
		l += Texel(texture, uv - vec2(dir.x * i, dir.y * i));
	}
	return vec4(l * delta * 0.5);
}

vec4 effect(vec4 color, Image texture, vec2 tex_coords, vec2 screen_coords)
{
	vec2 blur_vec = vec2(cos(radians(angle)), sin(radians(angle))) * strength;
	vec4 mb = blur(texture, tex_coords, blur_vec);
	return mb;
}
