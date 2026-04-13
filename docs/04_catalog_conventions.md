# Catalog conventions

The `catalog/` directory is a visual atlas organized by shape family rather than strict taxonomy.

---

## Directory layout

```
catalog/
  README.md            – index and how-to for the catalog
  centric/
    README.md          – overview of centric shape families
    disc_radiate_valve_view.md
    (more families...)
  pennate/
    README.md          – overview of pennate shape families
    naviculoid_boat_shapes.md
    (more families...)
  species/             – optional species-level profiles
    genus_species_name.md
```

---

## File naming

- Shape-family pages: `<outline_description>_<view>.md`, e.g. `disc_radiate_valve_view.md`.
- Pennate family pages: `<outline_description>_shapes.md`, e.g. `naviculoid_boat_shapes.md`.
- Species-level pages: `<genus>_<species>_profile.md`.

---

## Minimum sections for a catalog page

Each catalog page should include the following sections, in order:

1. **Title header** – shape family name and view.
2. **Family & View** – one-line metadata block (`**Family:** Centric`, `**View:** Valve view`).
3. **Visual description** – outline, symmetry, main surface features; keep it concise and image-friendly.
4. **Structural notes** – any anatomy that matters (raphe, axial/central areas, chains, spines).
5. **Example taxa** – informal list of genera that fit the shape family; not a formal key.
6. **Data and code** – references to:
   - `images/` entries with sources and licenses.
   - `data/outlines/<name>.svg` / `.csv`.
   - `data/descriptors/<name>_efd_coefficients.csv`.
   - Relevant notebooks or shaders.
7. **References** – at least one link to the literature or a key where similar forms are described.

---

## Metadata style

At the top of each catalog page, use a simple key-value block like:

```markdown
**Family:** Centric
**View:** Valve view
```

This makes it easy to parse and search without needing YAML front matter.

---

## Image attribution

When referencing images, always note:

- Source (paper DOI, Wikimedia URL, your own render, etc.).
- License (e.g., CC BY 4.0, public domain, or "original render – MIT").
- Link to the catalog entry or `images/README.md` section describing this image.
