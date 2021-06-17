extern Image tex_noise;

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc)
{
	vec4 px = Texel(tex, tc);
	vec2 tc_noise = tc;
	tc_noise.y -= 0.5f;

	vec4 px_noise = Texel(tex_noise, tc_noise);
	px.r *= px_noise.r * 2.0f;

	return px * color;
}
