/* Radial Blur
 */

#pragma shaderfilter set density__description Density
#pragma shaderfilter set density__step 0.01
#pragma shaderfilter set density__default 0.2
#pragma shaderfilter set density__min 0.0
#pragma shaderfilter set density__max 0.5
#pragma shaderfilter set density__slider true

#pragma shaderfilter set zoom__description Zoom
#pragma shaderfilter set zoom__step 0.01
#pragma shaderfilter set zoom__default 1.0
#pragma shaderfilter set zoom__min 1.0
#pragma shaderfilter set zoom__max 2.0
#pragma shaderfilter set zoom__slider true

uniform float density;
uniform float zoom;

vec4 render(vec2 uv) {
	int samples = 30;

    vec2 deltaTexCoord = uv - vec2(0.5,0.5);
	float zoom2 = zoom * -0.5 + 1.5;
	vec2 texCoo = (uv - 0.5) * zoom2 + 0.5;
	deltaTexCoord *= 1.0 / float(samples) * density;
	vec4 sample = vec4(1.0);
	float decay = 1.0;
  
	for(int i=0; i < samples ; i++) {
		texCoo -= deltaTexCoord;
		sample += texture2D(image, texCoo);
		}

	return vec4(sample/float(samples));
}
