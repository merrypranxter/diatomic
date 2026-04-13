"""
Extract the main diatom outline from an image.

Corresponds to the pipeline described in:
  notebooks/01_outline_extraction_from_image.ipynb

Usage (planned):
  python extract_outline_from_image.py <input_image> <output_dir>

Output:
  <output_dir>/<stem>.svg   – vector outline of the largest detected contour
  <output_dir>/<stem>.csv   – sampled boundary points (x, y), normalized

TODO:
  - Load a grayscale or RGB image.
  - Preprocess: denoise (e.g., Gaussian blur), enhance contrast (CLAHE).
  - Threshold / segment the diatom cell (Otsu or adaptive threshold).
  - Extract the largest closed contour (cv2.findContours or skimage).
  - Normalize the contour to the coordinate convention in data/outlines/README.md.
  - Save outline as SVG and/or CSV under data/outlines/.
"""
