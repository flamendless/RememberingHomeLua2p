extern VolumeImage lut;
extern VolumeImage lut2;
extern float dt;

vec4 ngrading(vec4 color)
{
	vec3 color_value = mix(Texel(lut, color.rgb).rgb, Texel(lut2, color.rgb).rgb, dt);
	return vec4(color_value, color.a);
}

vec4 ngrading(Image tex, vec2 uv)
{
	return ngrading(Texel(tex, uv));
}
