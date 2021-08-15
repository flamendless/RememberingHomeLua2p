extern VolumeImage lut;
extern VolumeImage lut2;
extern float dt;

vec4 ngrading(vec4 texCol)
{
	vec4 texCol = Texel(tex, tc);
	vec3 colorValue = mix(Texel(lut, texCol.rgb).rgb, Texel(lut2, texCol.rgb).rgb, dt);
	return vec4(colorValue, texCol.a);
}

vec4 ngrading(Image tex, vec2 tc)
{
	return ngrading(Texel(tex, tc));
}
