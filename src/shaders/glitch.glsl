//https://github.com/steincodes/godot-shader-tutorials/blob/master/Shaders/displace.shader

extern Image tex_displace;
extern float dis_amount = 0.1;
extern float dis_size = 0.1;
extern float abb_amount_x = 0.1;
extern float abb_amount_y = 0.1;
extern float max_a = 0.5;

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 screen_coords)
{
	vec4 disp = Texel(tex_displace, uv * dis_size);
	vec2 new_uv = uv + disp.xy * dis_amount;
	color.r = Texel(texture, new_uv - vec2(abb_amount_x, abb_amount_y)).r;
	color.g = Texel(texture, new_uv).g;
	color.b = Texel(texture, new_uv + vec2(abb_amount_x, abb_amount_y)).b;
	color.a = Texel(texture, new_uv).a * max_a;
	return color;
}
