"""
Compute elliptic Fourier descriptors (EFDs) for one or more diatom outlines.

Corresponds to the pipeline described in:
  notebooks/02_elliptic_fourier_descriptors.ipynb

Usage (planned):
  python compute_efd_descriptors.py <outline_file> [--harmonics N]

  <outline_file>  – path to a CSV file with columns x,y (see data/outlines/README.md)
  --harmonics N   – number of EFD harmonics to compute (default: 20)

Output:
  data/descriptors/<stem>_efd.csv  – EFD coefficients with columns n,a_n,b_n,c_n,d_n

TODO:
  - Load outline points from CSV (or SVG sampled to points).
  - Normalize for translation (centre at origin), scale (unit longest axis), and
    optionally rotation (first harmonic aligned).
  - Compute EFD coefficients using pyefd or a manual DFT implementation.
  - Write coefficients to data/descriptors/ with metadata header.

Based on methods from:
  https://pmc.ncbi.nlm.nih.gov/articles/PMC6487182/
"""
