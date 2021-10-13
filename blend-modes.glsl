/* Wave, from NetherEran
*/

#pragma shaderfilter set type__description Type +S*-/CdLdCbLb
// #pragma shaderfilter set type__description Type Add Screen Multiply Substract Divide ColorDodge LinearDodge ColorBurn LinearBurn
#pragma shaderfilter set type__step 1
#pragma shaderfilter set type__default 0
#pragma shaderfilter set type__min 0
#pragma shaderfilter set type__max 8
#pragma shaderfilter set type__slider true

#pragma shaderfilter set inf__description Influence
#pragma shaderfilter set inf__step 0.01
#pragma shaderfilter set inf__default 1.0
#pragma shaderfilter set inf__min 0.0
#pragma shaderfilter set inf__max 1.0
#pragma shaderfilter set inf__slider true

uniform float type;
uniform float inf;

float4 render(float2 uv) {
	float4 img1 = texture(image, vec2(uv.x / 2.0       , uv.y));
	float4 img2 = texture(image, vec2(uv.x / 2.0 + 0.5 , uv.y));
	vec4 blended;
	
	// Add
	if (type == 0)
		{
		blended = vec4(img1 + img2);
		}
	// Screen
	else if (type == 1)
		{
		blended = vec4(1.0 - (1.0 - img1) * (1.0 - img2));
		}
	// Multiply
	else if (type == 2)
		{
		blended = vec4(img1 * img2);
		}
	// Substract
	else if (type == 3)
		{
		blended = vec4(img2 - img1);
		}
	// Divide
	else if (type == 4)
		{
		blended = vec4(img2 / img1);
		}

	// Color Dodge
	else if (type == 5)
		{
		blended = vec4(img2 / (1.0 - img1));
		}
	// Linear Dodge
	else if (type == 6)
		{
		blended = vec4(img2 / (1.0 - img1));
		}
	// Color Burn
	else if (type == 7)
		{
		blended = vec4(1.0 - (1.0 - img2)/(img1));
		}
	// Linear Burn
	else if (type == 8)
		{
		blended = vec4(img1 + img2 - 1.0);
		}
	
	return mix(texture(image, vec2(uv.x/2.0, uv.y)), blended, inf);
}
