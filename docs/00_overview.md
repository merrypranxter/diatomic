# Overview

Diatoms are single-celled microalgae with silica cell walls called **frustules** that carry species-specific architectures of pores, ribs, and spines.
They account for a large fraction of global primary production, but here the focus is on their **visual structure** and **geometry** rather than ecology.

This project treats diatoms as a space where **biology**, **math**, and **image-making** collide.

---

## Goals of this repository

- Build a **visual atlas** of diatom shape families (centric and pennate).
- Collect **mathematical descriptions** of diatom outlines and patterns.
- Provide **data and code** for extracting, measuring, and generating diatom-like forms.
- Serve as a bridge between microscope imagery, generative art, and formal morphology.

---

## Big concepts

A few anchors that recur throughout the repo:

- **Frustule architecture** – valves, girdle bands, pores, raphe systems, spines.
- **Viewpoints** – valve view vs girdle view; the same cell can appear as a disc, an ellipse, or a box depending on orientation.
- **Shape families** – centric vs pennate; within each, recurring outlines (discs, polygons, rods, naviculoid boats, cymbelloid bananas, sigmoids, ribbons).
- **Pattern scales** – coarse outline, mid-scale rib/stria patterns, fine-scale nanopore lattices.

Each of these can be drawn, parameterized, and then abused in code.

---

## How to navigate

- Start with [`01_structure_frustule.md`](01_structure_frustule.md) if you want the anatomy vocabulary first.
- Jump to [`02_morphology_and_shape_families.md`](02_morphology_and_shape_families.md) if you just want to look at shapes and names.
- Go to [`03_math_and_geometry_models.md`](03_math_and_geometry_models.md) and the notebooks if you want equations and code.

The catalog in [`/catalog/`](../catalog/README.md) links back into these docs so each shape family has both a biological and mathematical context.
