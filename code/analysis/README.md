# Analysis utilities

Python tools for working with diatom outlines:

- **`extract_outline_from_image.py`** – extract the main diatom contour from a micrograph image and save it as SVG/CSV.
- **`compute_efd_descriptors.py`** – load an outline file, compute elliptic Fourier descriptors, and write them to `data/descriptors/`.

## Dependencies

These scripts are intended to use standard scientific Python packages:

- `opencv-python` or `scikit-image` for image processing.
- `numpy`, `scipy` for numerical operations.
- `matplotlib` for quick visual checks.
- `pyefd` or equivalent for EFD computation.

Install with:

```bash
pip install numpy scipy matplotlib scikit-image opencv-python pyefd
```

## Usage (planned)

```bash
# Extract an outline from an image:
python extract_outline_from_image.py input.png output_dir/

# Compute EFDs from an outline CSV:
python compute_efd_descriptors.py data/outlines/naviculoid_boat.csv --harmonics 20
```

See the [notebooks](../../notebooks/) for step-by-step interactive versions of these pipelines.
