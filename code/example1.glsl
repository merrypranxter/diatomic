#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float hash(vec2 p){
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

mat2 rot(float a){
    float s = sin(a), c = cos(a);
    return mat2(c,-s,s,c);
}

float sdCircle(vec2 p, float r){
    return length(p) - r;
}

float ring(float d, float w){
    return 1.0 - smoothstep(0.0, w, abs(d));
}

float radialStriae(vec2 p, float freq, float sharpness){
    float a = atan(p.y, p.x);
    float v = abs(sin(a * freq));
    return pow(v, sharpness);
}

float concentricBands(vec2 p, float freq, float sharpness){
    float r = length(p);
    float v = abs(sin(r * freq));
    return pow(v, sharpness);
}

float poreField(vec2 p, float scale, float size){
    vec2 gp = p * scale;
    vec2 id = floor(gp);
    vec2 f = fract(gp) - 0.5;

    float rnd = hash(id);
    f *= rot(rnd * 6.2831);

    float d = length(f);
    return 1.0 - smoothstep(size, size + 0.03, d);
}

void main(){
    vec2 uv = (gl_FragCoord.xy - 0.5 * u_resolution.xy) / u_resolution.y;

    // subtle drift / specimen motion
    uv *= rot(0.15 * sin(u_time * 0.4));
    uv += 0.02 * vec2(sin(u_time * 0.31), cos(u_time * 0.27));

    // main body
    float body = 1.0 - smoothstep(0.0, 0.01, sdCircle(uv, 0.42));

    // edge shell
    float edge = ring(sdCircle(uv, 0.42), 0.008);

    // radial silica architecture
    float striae = radialStriae(uv, 48.0, 7.0);
    striae *= smoothstep(0.03, 0.35, length(uv));

    // nested bands
    float bands = concentricBands(uv, 95.0, 12.0);

    // pores: denser toward middle ring
    float pores = poreField(uv, 38.0, 0.14);
    pores *= smoothstep(0.08, 0.38, length(uv));

    // central rosette
    float rosette = radialStriae(uv * rot(0.2), 12.0, 10.0);
    rosette *= 1.0 - smoothstep(0.0, 0.12, length(uv));

    float ornament = 0.0;
    ornament += 0.35 * striae;
    ornament += 0.25 * bands;
    ornament += 0.7 * pores;
    ornament += 0.5 * rosette;

    ornament *= body;

    // silica material feel
    float r = length(uv);
    float fresnelish = pow(1.0 - clamp(dot(normalize(vec2(r + 0.0001, 1.0)), vec2(0.0, 1.0)), 0.0, 1.0), 2.0);
    float glow = exp(-18.0 * abs(sdCircle(uv, 0.42)));

    vec3 base = vec3(0.03, 0.08, 0.12);
    vec3 silica = vec3(0.72, 0.92, 0.97);
    vec3 iridescent = vec3(0.35 + 0.35*sin(u_time + r*18.0),
                           0.45 + 0.35*sin(u_time + r*18.0 + 2.0),
                           0.55 + 0.35*sin(u_time + r*18.0 + 4.0));

    vec3 col = base;
    col += body * 0.12 * silica;
    col += ornament * mix(silica, iridescent, 0.25);
    col += edge * 0.8 * silica;
    col += glow * 0.25 * iridescent;

    // vignette / microscope darkness
    col *= 1.0 - 0.25 * length(uv);

    gl_FragColor = vec4(col, 1.0);
}
