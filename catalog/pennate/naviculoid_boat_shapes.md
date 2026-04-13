# Pennate – naviculoid boat shapes

**Family:** Pennate
**View:** Valve view

---

## Visual description

Elongated valves with:

- Tapered, often slightly capitate (head-shaped) ends.
- A central axis with a raphe system and axial/central areas.
- Bilateral symmetry along the long axis (mirror left/right).

These are the "boat-shaped" pennates that many people picture when they think of diatoms.

---

## Structural notes

Common features:

- A straight or gently curved raphe running almost full-length along the valve.
- **Axial area** – a clear silica strip along the midline flanking the raphe.
- **Central area** – an expanded or differentiated region at the midpoint of the valve.
- Striae radiating or oblique from the axial area to the margins.

Minor variations in outline curvature, pole shape (rounded, cuneate, capitate), and raphe structure correspond to different genera and species.

For generating this shape, parameterize:

1. A straight centerline `x ∈ [-L/2, L/2]`.
2. A width function `w(x)` that peaks at the centre and tapers to near-zero at the poles.
3. Mirror across the centerline to close the outline.
4. Add a thin central line for the raphe.

---

## Example taxa (informal)

Naviculoid shapes occur in genera such as:

- *Navicula* and related biraphid pennates.
- *Pinnularia* – larger naviculoid forms with elaborate central areas.
- Other genera with similar boat-like outlines and central raphes.

---

## Images

TODO – add micrograph or SEM images under `images/raw/pennate_naviculoid_*` with source and license.

Example render: TODO – add a shader render from `code/shaders/pennate_naviculoid_boat.frag`.

---

## Data and code

- **Outline (SVG):** TODO – `data/outlines/naviculoid_boat.svg`
- **Outline (CSV):** TODO – `data/outlines/naviculoid_boat.csv`
- **EFD descriptors:** TODO – `data/descriptors/naviculoid_boat_efd.csv`
- **Shader:** [`code/shaders/pennate_naviculoid_boat.frag`](../../code/shaders/pennate_naviculoid_boat.frag)
- **Notebook:** see outline extraction and EFD notebooks in [`notebooks/`](../../notebooks/)

---

## References

- [Phycokey – pennate diatom frustule structure](https://cfb.unh.edu/phycokey/Choices/Bacillariophyceae/Pennate/pennate_page/pennate_frustule_structure.htm)
- [California Academy of Sciences diatom glossary](https://researcharchive.calacademy.org/research/diatoms/overview/glossary.html)
- Pennate morphology and naviculoid outlines in diatom identification guides.
