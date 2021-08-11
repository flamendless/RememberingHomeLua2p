varying vec3 lp;
varying float scale;
varying vec3 diff;

#ifdef VERTEX
attribute vec4 lpos;
attribute vec3 diffuse;

vec4 position( mat4 transform_projection, vec4 vertex_position ){
	vec3 _lp = (transform_projection * vec4(lpos.xyz,1.)).xyz;
	lp = vec3(_lp.x, -_lp.y, _lp.z);
	scale = lpos.w;
	diff = diffuse;
	return transform_projection * (vec4(vertex_position.xyz*lpos.w,vertex_position.w) + vec4(lpos.xyz,0.));
}
#endif

#ifdef PIXEL
uniform Image cb;
uniform Image nb;

vec4 effect(vec4 col, Image tex, vec2 uv, vec2 sc){
	sc /= love_ScreenSize.xy;
	vec3 ndc = vec3((sc - vec2(.5)) * 2., 0.);
	vec4 c = Texel(cb, sc);
	vec3 n = normalize(Texel(nb, sc).xyz - vec3(.5));
	n.y = -n.y;
	vec3 lpos = lp;
	if(col.x == .0){
		lpos = n + ndc;
	}
	vec3 l = c.xyz * dot(n, normalize(lpos-ndc))*diff*(1.-col.x);
	return vec4( l, 1.);
}
#endif
