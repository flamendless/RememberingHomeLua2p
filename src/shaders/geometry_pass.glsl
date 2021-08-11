varying vec4 world_pos;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position ){
	world_pos = TransformMatrix * vertex_position;
	return transform_projection * vertex_position;
}
#endif

#ifdef PIXEL
uniform ArrayImage MainTex;
void effect(){
	love_Canvases[0] = Texel(MainTex, vec3(VaryingTexCoord.xy, 0.));
	love_Canvases[1] = Texel(MainTex, vec3(VaryingTexCoord.xy, 1.));
}
#endif
