# Week 02 — Least-Squares Fitting & VTK Volume Export

Fitting a line to noisy measurements with **ordinary least squares (OLS)** in
MATLAB, plus a reusable function for writing 3D volumes to the VTK format.

## Contents

| File | Description |
|------|-------------|
| [OLS_Matlab.m](OLS_Matlab.m) | MATLAB: generates a noisy linear signal `y = b1*x + b0 + noise`, then estimates the slope and intercept two ways — the normal equations `inv(A'*A)*(A'*y)` and MATLAB's backslash solver `A\y`. |
| [write_vtk_Volume.m](write_vtk_Volume.m) | MATLAB function `write_vtk_Volume(array, Spacing, filename)` that writes a 3D scalar array as an ASCII VTK `STRUCTURED_POINTS` volume. Uses a vectorized write so exports are fast and complete. |
| `pigdicomstack_flippedZ (1).vtk` | Example VTK volume (192×256×51) exported from the Week 01 DICOM stack, loadable in ParaView. |

## Key concepts

- Formulating linear regression as `A x = y` and solving via the **normal equations**
- Comparing the normal-equations solution with the numerically preferable
  backslash (`\`) least-squares solver
- The VTK `STRUCTURED_POINTS` format: dimensions, origin, spacing, and
  scalar point data
- Vectorized file writing in MATLAB (avoids slow per-voxel loops that can
  produce truncated files)

## Using `write_vtk_Volume`

```matlab
% array: 3D scalar volume (nx x ny x nz)
% Spacing: [dx dy dz] voxel spacing
write_vtk_Volume(I_stack, [1.5 1.5 4.5], 'volume.vtk');
```

VTK ordering (x fastest, then y, then z) matches MATLAB's column-major layout,
so the whole array is written in a single call. Verify an export with:

```bash
awk 'found{n+=NF} /LOOKUP_TABLE/{found=1} END{print n}' volume.vtk
# must equal nx*ny*nz
```
