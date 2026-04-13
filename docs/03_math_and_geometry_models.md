# Math and geometry models

This document sketches the mathematical tools used to describe and generate diatom forms.
More worked examples live in the [notebooks](../notebooks/).

---

## Outlines as curves

Valve outlines can be treated as closed planar curves:

- Simple shapes (circles, ellipses) model centric discs and elongated rods.
- More complex curves model naviculoid, cymbelloid, and sigmoid outlines:
  - A centerline curve plus a width function mirrored across a midline is a natural way to represent many pennate forms.

For a centric disc the outline can be written in polar coordinates as:

```
r(θ) = R + ε(θ)
```

where `R` is the mean radius and `ε(θ)` is a small periodic modulation capturing deviations from a perfect circle.

For a pennate form, a common approach is:

```
x(t) = centerline_x(t)
y(t) = centerline_y(t) ± width(t)
```

where `t` is arc-length parameter along the long axis and `width(t)` is a smooth, even function that tapers to near-zero at the poles.

---

## Symmetry

Key symmetry types relevant to diatom outlines:

- **Radial / rotational** – centric discs and stars; n-fold rotational symmetry, n = 2, 3, 4, 6, or continuous.
- **Bilateral** – pennate forms with a single mirror axis (the apical axis); some also have transapical symmetry.
- **Dorsiventral asymmetry** – cymbelloid and gomphonemoid forms that are curved or asymmetric across the transapical axis.
- **Translational / chain** – ribbon-forming or chain-forming taxa in girdle view.

These symmetries guide both outline parameterizations and pattern tilings in shaders.

---

## Elliptic Fourier descriptors (EFDs)

Elliptic Fourier descriptors (EFDs) are used in the literature to encode diatom valve outlines and compare shapes quantitatively.

The idea:

1. Sample a closed outline as a sequence of `(x, y)` points parameterized by arc length `t ∈ [0, 1]`.
2. Compute separate Fourier series for `x(t)` and `y(t)`.
3. Collect the harmonic coefficients `(aₙ, bₙ, cₙ, dₙ)` as the descriptor vector.
4. Reconstruct the outline with the first `N` harmonics to smooth/simplify the shape.

In this repo, EFDs serve to:

- Compress outlines from `data/outlines/` into a small set of coefficients stored in `data/descriptors/`.
- Reconstruct outlines at different harmonic counts in notebooks.
- Map multiple shapes into a low-dimensional "shape space" for comparison.

See [`notebooks/02_elliptic_fourier_descriptors.ipynb`](../notebooks/02_elliptic_fourier_descriptors.ipynb) for a worked example.

---

## Hierarchy and pattern

Frustules have nested structure: outline → ribs → pores → nanopores.
Several reviews discuss links between morphology, mechanics, and optics.

In this repo, this hierarchy is treated as:

- A design pattern for multi-layer shaders and textures.
- A prompt for toy models of light scattering or mechanical stiffness, not full physical simulations.

Concretely, a shader might:

1. Use the outline curve to define the silica boundary.
2. Add a radial or axial stria pattern at the mid scale.
3. Add a pore lattice (e.g., hexagonal tiling) at the fine scale.
4. Optionally modulate brightness to suggest photonic crystal effects.

Details live in the shader comments and in relevant catalog pages.

---

## Further reading

- [Elliptic Fourier analysis – PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC6487182/)
- [Mathematical models of diatoms – McGill Bioengineering Hyperbook](https://bioengineering.hyperbook.mcgill.ca/mathematical-models-of-diatoms-understanding-their-complex-shape-reproduction-and-chain-formation/)
- [Diatom shape modeling review – Kassel](https://www.mathematik.uni-kassel.de/~seiler/Papers/PDF/DiatomReview.pdf)
