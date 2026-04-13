// Pennate naviculoid boat — placeholder fragment shader
// Corresponds to: catalog/pennate/naviculoid_boat_shapes.md
//
// Shape family: Pennate naviculoid, valve view
// Reference genera: Navicula, Pinnularia
//
// Features implemented:
//   [x] Boat-shaped outline (centerline + tapered width function)
//   [ ] Central raphe line (TODO)
//   [ ] Axial area (TODO)
//   [ ] Stria pattern (TODO)
//
// Run with: glslViewer, Shadertoy (paste main body), or a WebGL harness.
// Uniforms follow Shadertoy convention.

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 iResolution;
uniform float iTime;

// Returns a mask value (0=outside, 1=inside) for a naviculoid boat outline.
// p: fragment position in NDC (aspect-corrected, centred at origin).
// halfLength: half-length of the boat along x.
// maxHalfWidth: maximum half-width at the centre.
float boatShape(vec2 p, float halfLength, float maxHalfWidth) {
    // Normalize x to [-1, 1] along the long axis
    float xn = p.x / halfLength;

    // Outside the length extent → outside shape
    if (abs(xn) >= 1.0) return 0.0;

    // Width profile: cosine taper gives smooth pointed ends
    float hw = maxHalfWidth * cos(xn * 1.5707963); // cos(xn * π/2)

    // Soft edge
    return smoothstep(hw, hw - 0.015, abs(p.y));
}

void main() {
    // Normalized device coordinates, centred, aspect-corrected
    vec2 uv = (gl_FragCoord.xy / iResolution.xy) * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    float halfLength   = 0.65;
    float maxHalfWidth = 0.20;

    // --- Outline ---
    float body = boatShape(uv, halfLength, maxHalfWidth);

    // --- TODO: Raphe ---
    // Draw a thin central line along x when inside the body.
    // float raphe = body * smoothstep(0.008, 0.005, abs(uv.y));

    // --- TODO: Axial area ---
    // A slightly lighter / clear strip flanking the raphe.

    // --- TODO: Striae ---
    // Oblique lines from axial area to margins.

    float value = body;

    gl_FragColor = vec4(vec3(value), 1.0);
}
