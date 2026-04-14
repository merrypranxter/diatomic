# DIATOMIC

A visual and mathematical atlas of diatoms — tiny silica architectures with outrageous symmetry, pattern, and micro-geometry.

Diatoms are unicellular microalgae whose cell wall is a glassy silica shell called a **frustule**, built from two overlapping valves (epitheca and hypotheca) and a set of girdle bands that link them together.

## 🚀 Quick Start

```bash
# Clone and explore
git clone https://github.com/merrypranxter/diatomic.git
cd diatomic

# View interactive gallery
python3 -m http.server 8000
# Open http://localhost:8000

# Generate outline gallery with Python
python code/analysis/generate_diatom_outlines.py
```

## 📦 What's Included

### Interactive Viewers
- **`index.html`** - Live WebGL gallery with 7 diatom types
- Real-time shader rendering
- Zoom, rotation, animation controls
- Detailed morphological descriptions

### Code Libraries
- **`code/shaders/diatom_library.glsl`** - Complete GLSL shader library
  - 7 parametric diatom generators
  - Utility functions (SDFs, rotations, hash)
  - Pattern generators (striae, pores, rosettes)
- **`diatom_library.js`** - JavaScript/WebGL bridge
- **`code/analysis/generate_diatom_outlines.py`** - Python outline generator
  - 9 parametric diatom classes
  - Gallery generation
  - JSON export for web

### Available Diatom Types

**Centric (Radially Symmetric):**
1. Disc Radiate (Cyclotella-style) - circular with radial striae
2. Polygonal Triangle (Triceratium-style) - triangular with hex pores
3. Stellate (Chaetoceros-style) - star-shaped with radiating arms

**Pennate (Bilaterally Symmetric):**
1. Naviculoid Boat (Navicula-style) - elongated ellipse with raphe
2. Sigmoid Curve (Gyrosigma-style) - S-curved with tilted striae
3. Cymbelloid Banana (Cymbella-style) - asymmetric crescent shape
4. Ribbon Colony - chain-forming cells with girdle connections

## 💻 Code Examples

### GLSL Shader Usage

```glsl
#include "diatom_library.glsl"

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    float t = iTime;
    
    // Generate a centric disc diatom
    vec3 col = centric_disc_radiate(uv, t);
    
    fragColor = vec4(col, 1.0);
}
```

### Python Outline Generation

```python
from generate_diatom_outlines import PennateNaviculoid, CentricDisc
import matplotlib.pyplot as plt

# Create a naviculoid diatom
diatom = PennateNaviculoid(length=2.5, width=0.8, end_taper=0.4)
x, y = diatom.get_outline()

# Plot it
plt.plot(x, y, 'b-', linewidth=2)
plt.fill(x, y, alpha=0.2)
plt.axis('equal')
plt.show()

# Export to JSON for web use
export_outline_to_json(diatom, 'my_diatom.json')
```

### JavaScript Integration

```javascript
// Load the diatom library
const shader = DiatomLibrary.centric_disc_radiate;

// Use in WebGL fragment shader
const fragmentSource = `
  ${DiatomLibrary.utilityFunctions}
  ${DiatomLibrary.patternGenerators}
  ${shader}
  
  void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.y;
    vec3 col = centric_disc_radiate(uv, u_time);
    gl_FragColor = vec4(col, 1.0);
  }
`;
```

## 📐 Morphological Features

Each diatom shader implements authentic structures:

- **Frustule outline** - Species-specific shapes (disc, boat, S-curve, triangle)
- **Striae** - Fine ribs/grooves (radial or transverse)
- **Pores** - Nanoscale perforations (hexagonal or random fields)
- **Raphe** - Longitudinal slit in pennate forms
- **Nodules** - Central and polar thickenings
- **Girdle bands** - Connecting structures in colony forms
- **Rosettes** - Central ornament patterns
- **Processes** - Extended arms in stellate forms

## 📚 Documentation

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
