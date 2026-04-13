// Centric radiate disc — placeholder fragment shader
// Corresponds to: catalog/centric/disc_radiate_valve_view.md
//
// Shape family: Centric disc, valve view
// Reference genera: Coscinodiscus, Actinoptychus
//
// Features implemented:
//   [x] Circular outline (disc silhouette)
//   [ ] Radial striae (TODO)
//   [ ] Pore lattice (TODO)
//   [ ] Central annulus or hyaline centre (TODO)
//
// Run with: glslViewer, Shadertoy (paste main body), or a WebGL harness.
// Uniforms follow Shadertoy convention.

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 iResolution;
uniform float iTime;

void main() {
    // Normalized device coordinates, centred, aspect-corrected
    vec2 uv = (gl_FragCoord.xy / iResolution.xy) * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    float r = length(uv);
    float angle = atan(uv.y, uv.x);

    // --- Outline ---
    // Smooth disc edge
    float disc = smoothstep(0.82, 0.80, r);

    // --- TODO: Radial striae ---
    // float striae = ...; // modulate with angle and r

    // --- TODO: Pore lattice ---
    // float pores = ...; // fine-scale hex or square lattice

    // Composite (only outline for now)
    float value = disc;

    gl_FragColor = vec4(vec3(value), 1.0);
}
