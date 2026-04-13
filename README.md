# DIATOMIC

A visual and mathematical atlas of diatoms — tiny silica architectures with outrageous symmetry, pattern, and micro-geometry.

Diatoms are unicellular microalgae whose cell wall is a glassy silica shell called a **frustule**, built from two overlapping valves (epitheca and hypotheca) and a set of girdle bands that link them together.

This repo focuses on:

- **Visual structure** – frustules, valves, girdle bands, pores, spines.
- **Morphology & shape families** – centric vs pennate, discs, boats, ribbons, sigmoids.
- **Math & generative models** – parametric outlines, symmetry, elliptic Fourier descriptors, toy photonic/mechanical ideas.
- **A catalog of forms** – curated examples with outlines, references, and code hooks.

---

## Structure

- `docs/` – concepts: frustule structure, shape families, math models, catalog conventions, references.
- `catalog/` – visual atlas grouped into centric and pennate shape families.
- `images/` – real micrographs / SEMs (where allowed) and generative renders.
- `data/` – outlines, descriptors, and measurements tied to catalog entries.
- `notebooks/` – Jupyter notebooks for outline extraction, Fourier descriptors, and toy models.
- `code/` – analysis utilities and shaders that generate diatom-like forms.

---

## Getting started

1. Read [`docs/00_overview.md`](docs/00_overview.md) and [`docs/01_structure_frustule.md`](docs/01_structure_frustule.md) for anatomy and terminology.
2. Browse [`catalog/`](catalog/README.md) to see shape families and example images.
3. Open [`notebooks/`](notebooks/) if you want to play with outlines and descriptors.
4. Dive into [`code/shaders/`](code/shaders/README.md) if you want to generate diatom-inspired visuals in GLSL.

---

## What is a diatom?

Diatoms are unicellular microalgae with silica cell walls called **frustules**.
The frustule is built from two overlapping halves (valves) that fit together like a petri dish, with the joint reinforced by silica girdle bands.

In **valve view** you see the face of a valve (disc, ellipse, boat, etc.); in **girdle view** you see the side, where the two valves and their girdle bands read as a box or cylinder.

At the gross level, diatoms fall into two big shape families:

- **Centric diatoms** – radially symmetric, often circular or polygonal in valve view.
- **Pennate diatoms** – bilaterally symmetric, often elongated or boat-shaped in valve view.

Within those two families is a wild zoo of outlines, pore lattices, ribs, spines, and slits that can all be treated as geometry.

---

## References & further reading

- [Diatom structure – Manaaki Whenua](https://www.landcareresearch.co.nz/tools-and-resources/identification/diatoms/diatom-structure)
- [Diatom – Wikipedia](https://en.wikipedia.org/wiki/Diatom)
- [Frustule – Wikipedia](https://en.wikipedia.org/wiki/Frustule)

See [`docs/05_references_and_resources.md`](docs/05_references_and_resources.md) for a more complete bibliography.

---

## Status

Early days. Expect stubs, TODOs, and shifting structure while the atlas and math pieces grow.

---

## License

- **Code** – MIT (proposed, tbd).
- **Docs** – CC BY-SA (proposed, tbd).
- **Images** – per-image licenses documented in `images/` and catalog pages.

This repository is not a formal taxonomic authority — it is an art-science playground.
