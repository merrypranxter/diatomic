# Shaders

GLSL fragment shaders that generate diatom-inspired forms procedurally.

## Catalog mapping

| Shader | Catalog entry |
|---|---|
| `centric_disc_radiate.frag` | [`catalog/centric/disc_radiate_valve_view.md`](../../catalog/centric/disc_radiate_valve_view.md) |
| `pennate_naviculoid_boat.frag` | [`catalog/pennate/naviculoid_boat_shapes.md`](../../catalog/pennate/naviculoid_boat_shapes.md) |

## How to run

These shaders follow the [Shadertoy](https://www.shadertoy.com/) convention with uniforms
`iResolution` (vec2) and `iTime` (float).

To run locally, you can use:

- [glslViewer](https://github.com/patriciogonzalezvivo/glslViewer)
- [Shadertoy](https://www.shadertoy.com/) – paste the `main()` body and adjust uniform names.
- A simple WebGL harness (planned: `code/viewer/webgl_diatom_viewer.html`).

## Design goals for each shader

Each shader should aim to capture at least:

1. **Outline** – the characteristic silhouette of the shape family.
2. **Striae / ribs** – mid-scale radial or axial pattern.
3. **Pores** – fine-scale repeating texture (can be procedural noise or a lattice).

Comments in each shader explain which features are implemented and what is left as TODO.
