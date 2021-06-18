/*  Distort
https://www.shadertoy.com/view/WdfBWN
*/

#pragma shaderfilter set def__description Deformacion
#pragma shaderfilter set def__default 0.0
#pragma shaderfilter set def__step .001
#pragma shaderfilter set def__min 0.0
#pragma shaderfilter set def__max 0.5
#pragma shaderfilter set def__slider true

#pragma shaderfilter set vel__description Velocidad
#pragma shaderfilter set vel__default 0.0
#pragma shaderfilter set vel__step .001
#pragma shaderfilter set vel__min -10.0
#pragma shaderfilter set vel__max 10.0
#pragma shaderfilter set vel__slider true

#pragma shaderfilter set scale__description GlobalScale
#pragma shaderfilter set scale__default 0.0
#pragma shaderfilter set scale__step .001
#pragma shaderfilter set scale__min 0.0
#pragma shaderfilter set scale__max 30.0
#pragma shaderfilter set scale__slider true

// #pragma shaderfilter set amp__description Amplitud
// #pragma shaderfilter set amp__default 0.0
// #pragma shaderfilter set amp__step .001
// #pragma shaderfilter set amp__min 0.0
// #pragma shaderfilter set amp__max 10.0
// #pragma shaderfilter set amp__slider true

uniform float def;
uniform float vel;
uniform float scale;
// uniform float amp;
#define amp 0.0


#define RAND_SEED 283846.698

vec2 translate(vec2 uv, vec2 t) {
    return uv - t;
}

mat2 rotate2d(float theta) {
    return mat2(cos(theta), -sin(theta),
                sin(theta), cos(theta));
}


float random2(vec2 uv) {
    return fract(
        RAND_SEED
        * (sin(dot(uv, vec2(21.12, 17.23)))
        	+ cos(dot(uv, vec2(12.2241, 22.433)))
        )
    );
}


float smoothRand(float x, vec2 blur) {
    float i = floor(x);
    return mix(random2(vec2(i)), random2(vec2(i+1.)), smoothstep(blur[0], blur[1], fract(x)));
}


float valueNoise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    float a = random2(i);
    float b = random2(i + vec2(1., 0));
    float c = random2(i + vec2(0., 1.));
    float d = random2(i + vec2(1., 1.));
	vec2 u = smoothstep(0., 1., f);
    // Bilinear
    float ab = mix(a, b, u.x);
    float cd = mix(c, d, u.x);
    return mix(ab, cd, u.y);
}

float4 render( float2 uv )
{
    uv = translate(uv, vec2(0.5));
    uv.x *= 16./9.;

    // float globalScale = 20.;
    vec2 scaleLayer = uv*scale;
    
    float noiseScale = 1.;
    vec2 noiseLayer = translate(scaleLayer*noiseScale, vec2(2.848*sin(builtin_elapsed_time * amp),vel * builtin_elapsed_time));
    float vNoise = (2. * valueNoise(noiseLayer)) - 1.;

    vec3 raintex = vec3(vNoise * def);

    uv.x /= 16./9.;
    uv = translate(uv, vec2(-0.5));

	vec2 where = uv.xy - raintex.xy;
	vec3 texchur1 = texture(image,vec2(where.x,where.y)).rgb;
	float alpha = texture(image,vec2(where.x,where.y)).a;
	
	float4 new_image = vec4(texchur1,alpha);
	return new_image;

}
