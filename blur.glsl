/* Simple Box Blur - with Mask
 */

#pragma shaderfilter set amount__description Amount
#pragma shaderfilter set amount__default 2
#pragma shaderfilter set amount__min 0
#pragma shaderfilter set amount__max 8
#pragma shaderfilter set amount__slider true

#pragma shaderfilter set multiplier__description Multiplier
#pragma shaderfilter set multiplier__default 5.0
#pragma shaderfilter set multiplier__min 1.0
#pragma shaderfilter set multiplier__max 20.0
#pragma shaderfilter set multiplier__slider true

#pragma shaderfilter set left__description Left
#pragma shaderfilter set left__step 0.01
#pragma shaderfilter set left__default 0.0
#pragma shaderfilter set left__min 0.0
#pragma shaderfilter set left__max 1.0
#pragma shaderfilter set left__slider true

#pragma shaderfilter set right__description Right
#pragma shaderfilter set right__step 0.01
#pragma shaderfilter set right__default 1.0
#pragma shaderfilter set right__min 0.0
#pragma shaderfilter set right__max 1.0
#pragma shaderfilter set right__slider true

#pragma shaderfilter set top__description Top
#pragma shaderfilter set top__step 0.01
#pragma shaderfilter set top__default 0.0
#pragma shaderfilter set top__min 0.0
#pragma shaderfilter set top__max 1.0
#pragma shaderfilter set top__slider true

#pragma shaderfilter set bottom__description Bottom
#pragma shaderfilter set bottom__step 0.01
#pragma shaderfilter set bottom__default 1.0
#pragma shaderfilter set bottom__min 0.0
#pragma shaderfilter set bottom__max 1.0
#pragma shaderfilter set bottom__slider true

uniform int amount;
uniform float multiplier;

uniform float left;
uniform float right;
uniform float top;
uniform float bottom;

vec4 render(vec2 uv) {
	vec2 pix = vec2(1.0 / builtin_uv_size.x, 1.0 / builtin_uv_size.y) * multiplier;
	vec4 sum = vec4(0);
	
	vec4 orig = texture(image,uv);
	vec4 box  = vec4(0.0);
	
	int i, j;
	for(i = -amount; i <= amount; i++){
		for(j = -amount; j <= amount; j++){
			
			sum += texture(image, uv + vec2(float(i), float(j)) * pix);

			float l =  left   + float(i) * pix.x;
			float r =  right  + float(i) * pix.x;
			float t =  top    + float(j) * pix.y;
			float b =  bottom + float(j) * pix.y;
			float a = float(int(((uv.x > l && uv.x < r) && (uv.y > t && uv.y < b))));
			
			box += mix(vec4(0.0), vec4(1.0), a);
		}
	}

	vec4 blur = sum / pow(amount * 2 + 1, 2);
	vec4 mask = box / pow(amount * 2 + 1, 2);
	vec4 result = mix(orig, blur, mask);
	
	return result;
}
