extern VolumeImage lut;

vec4 ngrading(Image tex, vec2 tc)
{
	vec4 texCol = Texel(tex, tc);
	return vec4(Texel(lut, texCol.rgb).rgb, texCol.a);
}

vec4 effect(vec4 color, Image tex, vec2 tc, vec2 sc)
{
	return ngrading(tex, tc) * color;
}
