# Week 01 — Loading DICOM Data & First Scripts

Introduction to reading a cardiac MRI **DICOM stack**, basic image processing,
and exporting a 3D volume for visualization.

## Contents

| File | Description |
|------|-------------|
| [LoadPigDicom.m](LoadPigDicom.m) | MATLAB: reads a single DICOM slice, visualizes it and its 2D FFT, then loads the full DICOM stack into a 3D volume (`I_stack`), displays a reslice, and writes the volume to VTK via `write_vtk_Volume`. |
| [MyFirstnotebook.ipynb](MyFirstnotebook.ipynb) | Python (Colab): mounts Google Drive, unzips the DICOM archive, and reads the DICOM series with **SimpleITK** (size, spacing, pixel type). |
| [MyFirstScriptInPython.ipynb](MyFirstScriptInPython.ipynb) | Python (Colab): reads the DICOM series with SimpleITK, performs simple voxel-wise processing (adds a scalar), preserves spacing metadata, and writes the result back out. |
| `images/` | Sample pig cardiac dataset: DICOM stack (`pigdicom/`), NIfTI (`.nii`), VTK (`.vtk`), STL surfaces (`.stl`), and ParaView state files (`.pvsm`). |

## Key concepts

- Reading single vs. stacked DICOM images (`dicomread`, SimpleITK `ImageSeriesReader`)
- Image geometry: **dimensions**, **voxel spacing**, and pixel type
- Frequency-domain view via the 2D FFT (`fft2`, `fftshift`)
- Building a 3D volume from 2D slices and exporting to VTK for ParaView

## Notes

- The MATLAB script calls `write_vtk_Volume` (in [../Week02](../Week02/)); make
  sure that folder is on the MATLAB path.
- After export, the script verifies the written scalar count matches
  `numel(I_stack)` so a truncated file is caught immediately.
