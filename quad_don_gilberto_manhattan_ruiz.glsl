/* Don Gilberto Manhattan Ruiz (cuadratico)
 */
#pragma shaderfilter set amp__description Amplitude
#pragma shaderfilter set amp__step 0.001
#pragma shaderfilter set amp__default 1.0
#pragma shaderfilter set amp__min 0.0
#pragma shaderfilter set amp__max 1.0
#pragma shaderfilter set amp__slider true

uniform float amp;

float4 render(float2 uv) {
    	float2 newuv;
    	newuv[0] = uv[0] - 0.5;
    	newuv[1] = uv[1];
		float deformation = (uv[1] - 1) * amp + 1;
    	newuv[0] = newuv[0] * deformation  + 0.5;
    	
    	float4 image_color = image.Sample(builtin_texture_sampler, newuv);
    	return image_color;
    }

