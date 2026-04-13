# Images

This directory contains visual material for the diatom atlas.

## Subdirectories

- **`raw/`** – original micrographs and SEM images (only where the license allows reuse).
- **`processed/`** – cropped, contrast-enhanced versions; binary masks; outline overlays.
- **`renders/`** – generative renders produced by shaders or other models, corresponding to catalog entries.

## Naming conventions

Filenames should be descriptive and, where possible, encode:

- The shape family or genus (e.g., `centric_disc`, `naviculoid_boat`).
- The view (`valve` or `girdle`).
- A short source tag or sequential number (e.g., `coscinodiscus_valve_01`).

Example: `centric_disc_radiate_valve_01_render.png`

## License tracking

For each image, record the following either in a sidecar `.txt` file alongside the image or in the relevant catalog page:

- **Source** – paper DOI, URL, collection name, or "original render".
- **License** – e.g., CC BY 4.0, public domain, MIT (for renders in this repo).
- **Attribution** – author / institution to credit if required.
- **Catalog link** – which catalog page this image illustrates.

Only add images to `raw/` if you have confirmed the license allows reuse and redistribution.
Generative renders produced by shaders in this repo are released under the same license as the code (see `LICENSE`).
