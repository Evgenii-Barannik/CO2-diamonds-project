# About
This file describes data processing workflow used for IR spectra of FN7114 and FN7112 diamonds. Spectra were processed with Fityk and custom Lua scripts. Spectra were loaded with CO2D-LOAD.lua script, fitted with CO2-FIT.lua, data was exported with CO2D-MATRIX-EXPORT.lua and CO2D-TABLE-EXPORT.lua. Matrices were exported into two folders: **matrix** and **matrix-not-used-for-plotting**. Matrices from **matrix** folder were plotted with CO2D-MAPGEN.ipynb notebook/script using JupyterLab run from Anaconda environment. In Fityk mpfit was used as a fitting method. "HPHT IIa diamond spectrum normalized.dat" was used as a standard spectrum.

# FN7114 map truncated
Spectra from truncated map were used. Spectra are treated as A = A(w). There is no CO2 V2 calculation because the lower wavenumber limit for this map is only 675 cm-1. Baseline was subtracted and removed for every calculation mode to make peak examination easier. Spectra [0][14] and [17][14] have high noise/signal ratio. They can be masked when plotting with Matplotlib. Spectra 1-270 were loaded and fitted in the listed modes:

## VN3H fitting
Loaded and fitted VoigtH by script. Spectrum #15 value is probably erroneous due to high noise. No hand edits were done, exported as it is. Exported into table and matrices.

## Carbonates fitting
Loaded and fitted VoigtK by script. Spectrum #15 value is probably erroneous due to high noise. No edits were done, exported as it is. Exported into table and matrices. Carbonates area on spectrum #207 is large relative to the background. 

## A-center, B-center, Platelets, O-band fitting
Loaded and fitted by script. Oband was used in the fit. Due to inclusion influence fit was done for 1260-1400 cm-1 range. Line 

    F:execute ("A = x > 1260 and x < 1400")

was used for this in Lua code.
C-centers and X-centers were skipped. Spectrum #15 value is probably erroneous due to high noise. Edits were done. Platelets VoigtP functions did not converged when present on spectra [149, 150, 174, 181, 198, 200, 201, 202, 203, 212, 227, 228, 235, 241, 257, 258]. After parameter change and fit they did converge. There may be influence from other band (organics?). Most influence is seen on the map border, for example on spectrum #266. Data exported into 4 tables (A-center, B-center, O-band, Platelets) and lots of matrices.
	
## CO2 V3 fitting
Loaded and fitted by script. V3b band copy (VoigtD) was included into fit. Spectrum #15 value is probably erroneous due to high noise. Edits were done. Voigt4 functions did not converge on spectra [1, 15, 32, 60]. After parameter change and fit spectra [1, 32, 60] did converge.
Most Voigt1 converged as a sharp component of v3b, and most Voigt2 converged as broad component of v3b. Only some Voigt1 and Voigt2 bands interchanged roles on spectra [31, 77, 116, 117, 128, 129, 141, 143, 146, 152]. This was fixed by parameter change and fitting. Allows plotting of broad and sharp V3b components separately.
Exported into 6 tables and a lots of matrices.
VoigtD was used for easy data export. VoigtD Area is 0 cm-2 so it does not influence fit, but VoigtD FWHM is calculated from experimental v3b band shape. True area of v3b is sum of Voigt1 and Voigt2 areas, true FWHM of v3b is FWHM of VoigtD. Center is the same for VoigtD, Voigt1, Voigt2.
To plot V3b (Voigt1 + Voigt2) area map following manipulations were done: 

* "Voigt1-MATRIX-Area-FN7114 map truncated.csv" and "Voigt2-MATRIX-Area-FN7114 map truncated.csv" were imported into Origin.
* Matrices were summed. The sum was exported from Origin as .csv matrix to produce "Voigt-1+2-MATRIX-Area-FN7114 map truncated (from Origin).csv".
* Matrix was opened with text editor, every comma "," was replaced with comma and space ", ".
* Map was plotted from this matrix. It is the map of V3b Area.

## 800 cm-1 band fitting
Loaded and fitted VoigtS by script. Spectrum #15 value is probably erroneous due to high noise. Spectrum #15 peak was helped to converge, spectrum #1 peak was set to 0 height as its height did converged to negative value. No other edits made. Exported into matrices and table.
	
# FN7112 map truncated
Spectra from truncated map were used. Baseline was subtracted and removed for every calculation mode to make peak examination easier. Spectra are treated as A = A(w). A, B, C-centres, platelets were not fitted because nitrogen centers were not detected. Spectra 1-352 were loaded and fitted in the listed modes:

## VN3H fitting
Loaded and fitted VoigtH by script. No hand edits were done, exported as it is. Exported into table and matrices.

## Carbonate fitting
Loaded and fitted VoigtK by script. No hand edits were done, exported as it is into table and matrices.

## 800 cm-1 band fitting
Loaded and fitted VoigtS by script. No hand edits were done, exported as it is into table and matrices.

## CO2 V3 fitting
V3b band copy (VoigtD) was NOT included into fit - area of V3b Voigts was too small to do fitting procedure.
Point 210, 211 did not converge well. No hand edits were done, exported as it is into tables and matrices. Voigt4 was not studied in details because of lower CO2 absorption for this sample. Voigt3 (V3a) area is low compared to Voigt1+Voigt2 (V3b).
To plot V3b (Voigt1 + Voigt2) area map similliar manipulations were done: 
* "Voigt1-MATRIX-Area-FN7112 map truncated.csv" and "Voigt2-MATRIX-Area-FN7112 map truncated.csv" were imported into Origin.
* Matrices were summed. The sum was exported from Origin as .csv matrix to produce "Voigt-1+2-MATRIX-Area-FN7112 map truncated (from Origin).csv".
* Matrix was opened and editor, every comma "," was replaced with comma and space ", ".
* Map was created from this matrix. It is the map of V3b Area.

## CO2 V2 fitting
No hand edits were done, exported as it is into tables and matrices.

# FN7114NewProfiles 
FN7114Profile#2 spectra were loaded and fitted in CO2 V3, CO2 V2 modes. VoigtD was not skipped. Linear baseline was NOT removed! No hand edits were made. Exported into tables. Spectra 0003 for both V2 and V3 regions were exported as .dat files into **edited-spectra** folder. Export was done with Data --> Export points menu in Fityk. X, Y, all component functions, model sum, residuals were exported. Exported spectra were plotted with CO2D-SPLOT.ipynb.

# FN7112 vertical profile at 18750 through CO2 max 30 microns 
Spectra were loaded and fitted in CO2 V3, CO2 V2 modes. VoigtD was not skipped. Linear baseline was NOT removed! No hand edits were made. Exported into tables. Spectra 0034 for both V2 and V3 regions were exported as .dat files into **edited-spectra** folder. Export was done with Data --> Export points menu in Fityk. X, Y, all component functions, model sum, residuals were exported. Exported spectra were plotted with CO2D-SPLOT.ipynb.

# FN7114 line across CO2 30 microns
Baseline was subtracted and removed for every calculation mode to make peak examination easier. Spectra are treated as A = A(w). All 56 spectra were fitted in the listed modes:

## VN3H fitting
Loaded and fitted by script. No edits were done, exported into tables.

## Carbonates fitting
Loaded and fitted by script. Results were NOT exported because there were no carbonates detected.

## A-center, B-center, Platelets, O-band fitting
Loaded and fitted by script. Oband was used in the fit. Line 
    
    F:execute ("A = x > 1260 and x < 1400")

was also used for this fit in Lua code for consistency. C-centers and X-centers were skipped. Edits were done. VoigtP functions heights on spectra [36, 37, 38, 39, 40, 41, 42, 43] were set to 0. Exported into tables.

## CO2 V2 fitting
Loaded and fitted by script. Edits were done. V2b bands did not converge in spectra [40, 43, 44, 54, 55, 56]. All spectra did converge after hand edit and fit. Exported into tables.

## CO2 V3 fitting
Loaded and fitted by script. V3b band copy (VoigtD) was included into fit. No edits were done. Exported into tables.

# HPHT-IIa-diamond
"HPHT IIa diamond spectrum normalized.dat" was created from 
IIa_map_HPHT#2_spectra0001.CSV. Used Fityk code:

	y=y/(y[index(2020)]/12.8)

# Origin project 

# Plotted spectra folder
* A study of unusual diamonds sheet data is imported from "A study of unusual diamonds - CO2 v3 - Fig 416.csv". File .csv was created by digitization of absorption spectra from [A study of unusual diamonds from the George Creek K1 Kimberlite dyke, Colorado" thesis].
* Background CO2+H2O sheet data is imported from "Pure CO2 + H2O background A(w).dat".

# FN7114 and FN7112 matrices addition folder
Folder is for Voigt1+Voigt2 matrices addition. Data for both FN7114 and FN7112 diamonds is here.

# Plots from FN7112 data folder
Folder with plots and data from "FN7112 map truncated" and "FN7112 vertical profile at 18750 through CO2 max 30 microns" tables. Tables with V1-V6 function parameters were imported for both map and profile. V3b and V2a+V2b area correlations were ploted for both map and profile.
Linear correlation parameters computed with CO2D-LPLOT.ipynb for "FN7114 line across CO2 30 microns linear fit comparison.png" and "FN7112 map+profile linear fit.png" were verified with Origin. FN7114 linear fit is exactly like computed with Origin. For FN7112 linear fit can be calculated from [map, profile, map+profile] datasets. Linear fit from map dataset is exactly like computed with Origin. Linear fit for combined map+profile dataset was used for the figure.

# Edited-photo
FN7114-with-approximate-mapping-zone-rotated.png was created by aligning of FN7114 diamond photo and "FN7114 map photo uncut.JPG". Alignment was done using diamond outline and two visible defects near diamond center. Small rotation was included. Procedure was analogues for FN7112 picture.