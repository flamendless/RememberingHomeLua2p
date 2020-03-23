extern float samplesF;
extern float radius;
extern vec2 dir;

vec4 effect(vec4 color, Image texture, vec2 tex_coords, vec2 screen_coords)
{
	float hstep = dir.x;
	float vstep = dir.y;
	float total = 0.0;
	int samplesI = int(samplesF);
	vec4 sum = vec4(0.0);

	for (int i = 1; i <= samplesI; i++)
	{
		float floatI = float(i);
		float counter = samplesF - floatI + 1.0;
		float p = floatI/samplesF;
		float t = (p * 0.1783783784) + 0.0162162162;
		total += t;
		sum += Texel(texture, vec2(tex_coords.x - counter * radius * hstep, tex_coords.y - counter * radius * vstep)) * t;
	}

	sum += Texel(texture, vec2(tex_coords.x, tex_coords.y)) * 0.2270270270;

	for (int i = samplesI; i >= 1; i--)
	{
		float floatI = float(i);
		float counter = samplesF - floatI + 1.0;
		float p = floatI/samplesF;
		float t = (p * 0.1783783784) + 0.0162162162;
		total += t;
		sum += Texel(texture, vec2(tex_coords.x + counter * radius * hstep, tex_coords.y + counter * radius * vstep)) * t;
	}

	vec4 px = Texel(texture, tex_coords);
	// return px * (sum/total);
	return (sum/total);
}
