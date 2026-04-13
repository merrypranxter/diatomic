# Centric disc – radiate (valve view)

**Family:** Centric
**View:** Valve view

---

## Visual description

Near-circular valves with:

- A central region (often an areolated centre or annulus).
- Striae or ribs radiating outward in a roughly radial pattern.
- Pores arranged along striae, sometimes forming a fine lattice.

This is the archetypal "sunburst disc" diatom look.

---

## Structural notes

Typical features to look for:

- Clear separation between central area and peripheral region.
- Radial striae that may be uniseriate or multiseriate.
- Marginal spines or processes in some taxa that promote chain formation.

The outline in valve view is close to a circle, sometimes slightly polygonal at high resolution. Generating this shape in a shader: use polar coordinates and a near-constant `r(θ)` with a small modulation for any departures from circularity.

---

## Example taxa (informal)

Not a formal ID, but visually similar forms occur in genera such as:

- *Coscinodiscus* and related disc-like centrics.
- *Actinoptychus* – a centric with alternating raised and depressed sectors.
- Other centric planktonic forms with radiate valve ornamentation.

---

## Images

TODO – add micrograph or SEM images under `images/raw/centric_disc_*` with source and license.

Example render: TODO – add a shader render from `code/shaders/centric_disc_radiate.frag`.

---

## Data and code

- **Outline (SVG):** TODO – `data/outlines/centric_disc_radiate.svg`
- **Outline (CSV):** TODO – `data/outlines/centric_disc_radiate.csv`
- **EFD descriptors:** TODO – `data/descriptors/centric_disc_radiate_efd.csv`
- **Shader:** [`code/shaders/centric_disc_radiate.frag`](../../code/shaders/centric_disc_radiate.frag)
- **Notebook:** see outline extraction and EFD notebooks in [`notebooks/`](../../notebooks/)

---

## References

- [UCL Micropalaeontology – centric diatoms](https://www.ucl.ac.uk/GeolSci/micropal/diatom.html)
- Centric disc morphology and examples in teaching keys and image guides.
