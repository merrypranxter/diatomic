# Descriptors

Numeric descriptors for outlines, such as elliptic Fourier descriptor (EFD) coefficients and basic morphometrics.

## File formats

- **`<name>_efd.csv`** – EFD coefficients, one row per harmonic with columns `n, a_n, b_n, c_n, d_n`.
- **`<name>_morphometrics.csv`** – basic measurements: length, width, aspect ratio, curvature statistics, symmetry measures.

## Metadata columns

Each CSV should include a header row. EFD files should also document:

- Number of harmonics computed.
- Normalization applied (translation, scale, rotation).
- Source outline file.

## Computing descriptors

Use [`code/analysis/compute_efd_descriptors.py`](../../code/analysis/compute_efd_descriptors.py) or the
[notebook](../../notebooks/02_elliptic_fourier_descriptors.ipynb) to generate descriptor files from outlines in `data/outlines/`.

## Naming

Match the corresponding outline file, e.g.:

- `centric_disc_radiate_efd.csv` → from `data/outlines/centric_disc_radiate.csv`
- `naviculoid_boat_efd.csv` → from `data/outlines/naviculoid_boat.csv`

## Current files

None yet. Run the EFD notebook or script on outlines in `data/outlines/` to populate this directory.
