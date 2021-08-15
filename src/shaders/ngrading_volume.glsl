extern VolumeImage lut;

vec4 ngrading(vec4 texCol)
{
	return vec4(Texel(lut, texCol.rgb).rgb, texCol.a);
}

vec4 ngrading(Image tex, vec2 tc)
{
	return ngrading(Texel(tex, tc));
}
