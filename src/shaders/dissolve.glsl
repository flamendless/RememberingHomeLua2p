extern Image tex;
extern number time;

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 px)
{
	vec4 pixel = Texel(texture, uv);
	vec4 pixel2 = Texel(tex, uv);
	if (pixel2.r < time)
		return pixel * color;
	else
		return vec4(0.0);
}
