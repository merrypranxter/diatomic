# Outlines

Vector and sampled outlines for shapes referenced in the catalog.

## File formats

Each outline should provide one or more of:

- **`.svg`** – clean vector path tracing the valve outline. Preferred for rendering and visual inspection.
- **`.csv`** – sampled contour points, one `x,y` pair per row, ordered along the outline boundary.
- **`.json`** – same as CSV but in JSON array format, useful for direct import into notebooks.

## Coordinate conventions

Unless otherwise noted:

- Outlines are normalized so the longest axis spans `[-1, 1]`.
- The centroid is at the origin `(0, 0)`.
- For pennate forms, the long axis is along `x`; for centric forms, the outline is centred on `(0, 0)`.

Document any deviation from this convention in a comment at the top of the file.

## Naming

Match the corresponding catalog page name, e.g.:

- `centric_disc_radiate.svg` → [`catalog/centric/disc_radiate_valve_view.md`](../../catalog/centric/disc_radiate_valve_view.md)
- `naviculoid_boat.svg` → [`catalog/pennate/naviculoid_boat_shapes.md`](../../catalog/pennate/naviculoid_boat_shapes.md)

## Current files

None yet. Add SVG or CSV outlines here and reference them from the catalog pages.

TODO: add at least one outline per catalog entry as a starting point.
