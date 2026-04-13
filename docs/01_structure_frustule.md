# Frustule structure

The diatom cell wall is a silica shell called a **frustule**, built from two overlapping valves and a banded girdle region.
Understanding this architecture is the basis for how shapes are grouped and modeled in this repo.

---

## Valves and girdle

- **Valves (thecae)** – two rigid plates that overlap like a petri dish:
  - **Epitheca** – slightly larger "lid".
  - **Hypotheca** – slightly smaller "base".
- **Girdle (cingulum)** – series of silica **girdle bands** (copulae) that encircle the cell and connect the valves.

During cell division, each daughter cell inherits one old valve and builds one new one, leading to progressive size reduction until a size-resetting auxospore stage.

---

## Valve view vs girdle view

Diatoms look very different depending on orientation:

- **Valve view** – looking straight at a valve face; shows the outline (disc, ellipse, boat, etc.) and arrangement of striae and pores.
- **Girdle view** – looking at the side; shows the depth of the frustule and stacked girdle bands.

Catalog entries explicitly state which view images and outlines correspond to.

---

## Surface features

Common features referenced in the catalog:

- **Areolae** – pores perforating the silica.
- **Striae** – rows of areolae; often the main visible texture in light microscopy.
- **Ribs / costae** – thicker silica bars between pores.
- **Spines & processes** – protrusions that can link cells into chains or affect hydrodynamics.

Nanometre-scale pore lattices and sub-structures give frustules unusual optical and mechanical properties and are an inspiration for some of the math and shaders.

---

## Raphe and motility (pennate special)

Many pennate diatoms have a **raphe**, a slit-like structure that runs along the valve and secretes mucilage for gliding motility.

Key points:

- Some genera have raphes on both valves (e.g., *Navicula*), some on one, some on neither.
- The raphe can be central, marginal, or traverse onto the valve mantle; canal raphes sit within a channel supported by silica bridges (fibulae).
- Raphe architecture (length, curvature, interruptions, position) is a crucial taxonomic feature and also a beautiful curve motif for generative models.

In shape terms, the raphe is often an axial curve that suggests a natural coordinate system for parameterizing the rest of the valve.

---

## Centric vs pennate architecture

The same structural vocabulary plays out differently in centric and pennate diatoms:

- **Centric diatoms**
  - Valve outline typically circular, polygonal, or cylindrical in valve view.
  - Striae and ribs are arranged radially or in concentric rings around a centre or annulus.
  - Often lack a raphe; movement is typically passive or chain-based.

- **Pennate diatoms**
  - Valve outline typically elongated and bilaterally symmetric in valve view (naviculoid boats, cymbelloid bananas, sigmoids, etc.).
  - Ornamentation organized along an apical axis, with or without a raphe system; axial and central areas are key landmarks.

---

## Why structure matters for math and art

The frustule's hierarchical structure — outline, ribs, pores, nano-lattices — is where geometry and function meet:

- Biologically, these structures relate to mechanical protection, buoyancy, filtering, and light manipulation.
- Geometrically, they provide nested symmetry operations, repeat units, and feature scales that can be captured in curves, tilings, and texture synthesis.

When building generative diatom forms in code or shaders, this doc is the checklist of which structural elements you want to honour, exaggerate, or break.

---

## Further reading

- [Diatom structure – Manaaki Whenua](https://www.landcareresearch.co.nz/tools-and-resources/identification/diatoms/diatom-structure)
- [Frustule – Wikipedia](https://en.wikipedia.org/wiki/Frustule)
