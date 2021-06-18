/* Lens Distortion - Bola extrema
 https://www.shadertoy.com/view/3tXczj
*/

#pragma shaderfilter set size__description Size
#pragma shaderfilter set size__step 0.01
#pragma shaderfilter set size__default 1.0
#pragma shaderfilter set size__min 0.0
#pragma shaderfilter set size__max 2.0
#pragma shaderfilter set size__slider true
uniform float size;


#define DARK_EDGES
#define TRANSPARENT 1

float4 render(vec2 uv )
{
   	vec2 disorsion = uv - 0.5;
	float aspect = 16.0 / 9.0; //builtin_uv_size.x/builtin_uv_size.y;
	
	disorsion[0] *= aspect; // aspect correction
	
	// take distance from center
   	float len = length(disorsion);
	
	// these are the lens parameters
	float k1 = 1.2;
	float k2 = 1.0;
	float k3 = -3.2;
	
	disorsion 
		= disorsion*k1
		+ disorsion*len*k2 
		+ disorsion*len*len*k3;
		// higher powers may be added if necessary

	// aspect correction
	disorsion[0] /= aspect;
	
	vec4 col = texture(image, disorsion + 0.5);
	
	#ifdef DARK_EDGES
	{
		float edge = 0.7;
		float dispersion = 0.03;
		float transp = pow(max(edge-len, 0.0), 0.05);
		// transp = 1; // Para negro
		col *= vec4(
			pow(max(edge-len, 0.0), 0.2),
			pow(max(edge-dispersion-len, 0.0), 0.2),
			pow(max(edge-dispersion*2.0-len, 0.0), 0.2),
			transp )*1.2;
	}
	#endif

	return col;
}
