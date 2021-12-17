extern Image tex_noise;
extern number time;

vec4 effect(vec4 color, Image tex, vec2 uv, vec2 _)
{
	vec4 pixel = Texel(tex, uv);
	vec4 pixel2 = Texel(tex_noise, uv);
	return (pixel2.r < time) ? (pixel * color) : vec4(0.0);
}
