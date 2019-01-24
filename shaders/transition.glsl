extern float dt;
extern Image tex_transition;

vec4 effect(vec4 color, Image texture, vec2 tex_coords, vec2 screen_coords)
{
	vec4 pixel_tex_transition = Texel(tex_transition, tex_coords);

	if (pixel_tex_transition.b < dt)
		return vec4(0, 0, 0, 1);

	vec4 pixel = Texel(texture, tex_coords);
	return pixel * color;
}
