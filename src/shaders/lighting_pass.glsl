//credits to @a13X_B over at Discord

varying vec2 ndc_p;
varying vec3 w_p;
varying float scale;
varying vec3 diff;
varying vec3 dir;
varying float angle;

#ifdef VERTEX
attribute vec4 lpos;
attribute vec4 ldir;
attribute vec3 diffuse;

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
	ndc_p = (transform_projection * vec4(lpos.xy, 0.0, 1.0)).xy;
	scale = lpos.w;
	diff = diffuse;
	dir = normalize(ldir.xyz);
	angle = ldir.w;
	w_p = lpos.xyz;
	vec4 vp = vec4(vertex_position.xyz * lpos.w, vertex_position.w);
	return transform_projection * (vp + vec4(lpos.xy, 0.0, 0.0));
}
#endif

#ifdef PIXEL
uniform Image cb;
uniform Image nb;

vec4 effect(vec4 col, Image tex, vec2 uv, vec2 sc)
{
	sc /= love_ScreenSize.xy;
	vec2 ndc = (sc - vec2(0.5)) * 2.0;
	vec3 c = Texel(cb, sc).xyz;
	vec3 n = normalize(Texel(nb, sc).xyz - vec3(0.5));
	n.y = -n.y;

	vec3 tl = vec3(normalize(ndc_p - ndc) * col.x, w_p.z/scale); //vector towards the light
	float ld = length(tl);
	vec3 l = normalize(tl);

	vec3 lpos = vec3(ndc_p, w_p.z);

	if ((length(tl)/scale > 1.0) || (dot(-l, dir) < angle)) discard;
	c = c * dot(n, l) * max(1.0 - ld * ld, 0.0) * diff;

	return vec4(c, 1.0);
}
#endif
