# ABOUT
This file describes the data processing workflow for IR-spectra of CO2-rich diamonds FN7114 and FN7112.

Spectra were processed with Fityk and custom lua scripts.
If not stated otherwise spectra were loaded with CO2D-LOAD.lua script, fitted with CO2-FIT.lua.If, data was exported with CO2D-MATRIX-EXPORT.lua and CO2D-TABLE-EXPORT.lua. Mpfit was used as a fitting method. "HPHT IIa diamond spectrum normalized.dat" was used as a standard spectrum.
Maps were plotted with CO2D-MAPGEN.py script using MatPlotlib. Script was run from Anaconda environment. 

Scheme for copy-paste (ignore if left):
Loaded and fitted by script. Spectrum # value is probably erroneous due to high noise. Edits were done, exported into table and matrix.

# FN7114 map truncated
======================
Spectra from truncated map were used. Spectra are treated as normalized A = A(w). Results are in "FN7114 map truncated results backup". There is no CO2 V2 calculation because the lower wavelength boundary for this mpa is only 675 cm-1. Spectrum #15 has high noise/signal ratio. Baseline was subtracted and removed for every calculation mode to make peak examination easier. It was pinned out when plotting with Matplotlib. Spectra 1-270 were loaded and fitted in different modes:

## VN3H fitting
Loaded and fitted VoigtH by script. Spectrum #15 value is probably erroneous due to high noise. No hand edits were done, exported as it is. Exported into table and matrix.

## Carbonates fitting
Loaded and fitted VoigtK by script. Spectrum #15 value is probably erroneous due to high noise. No edits were done, exported as it is. Exported into table and matrix.

## A-center, B-center, Platelets, O-band fitting
Loaded and fitted by script. Spectrum #15 value is probably erroneous due to high noise. Oband was used in the fit. C-centers and X-centers were skipped. Edits were done. Some platelets VoigtP functions did not converged when present (spectra # 195, 207, 210, 214, 215, 216, 217, 222, 225, 226, 227, 229, 230, 231, 241, 242, 243, 244, 245, 256, 257, 258, 259, 260, 265). After parameter change and fit they did converge. Data exported into 4 tables and 5 matrices (A-center, B-center, O-band, Platelets Area, Platelets center).
	
## CO2 V3 fitting
Loaded and fitted by script. Spectrum #15 value is probably erroneous due to high noise. V3b band COPY was inluded into fit. Edits were done. Some Voigt4 functions did not converge (1, 32, 60). After parameter change and fit they did converge. Most Voigt1 converged as sharp component of v3b, and most Voigt2 converged as broad component of v3b. Only some Voigt1 and Voigt2 bands interchanged roles, this was fixed by parameter change and fitting for consistency (allows plotting of broad and sharp V3b components separately).
Exported into 6 tables and a lot of matrices.
VoigtD is used for easy data export.
VoigtD Area is 0 so it does not influence fit, but VoigtD FWHM is helpful and calculated with Voigt1, Voigt2 band data. True area of v3b is sum of Voigt1 and Voigt2 areas, true FWHM of v3b is FWHM of VoigtD. Center is the same for VoigtD, Voigt1, Voigt2.
To plot V3b (Voigt1 + Voigt2) area map following manipulations were done: 
* "Voigt1-MATRIX-Area-FN7114 map truncated.csv" and "Voigt2-MATRIX-Area-FN7114 map truncated.csv" were imported into Origin.
* Matrices were summed to produce "Voigt-1+2-MATRIX-Area-FN7114 map truncated (from Origin).csv".
* Matrix was opened and editor, every coma "," was replaced with coma and space ", ".
* Map was created from this matrix. It is the map of V3b Area.
	
# FN7112 map truncated
======================
Spectra from truncated map were used. Baseline was subtracted and removed for every calculation mode to make peak examination easier. Spectra are treated as normalized A = A(w). A, B, C-centres, platelets were not fitted because they were not detected.
Spectra 1-352 were loaded and fitted in different modes:

## VN3H fitting
Loaded and fitted VoigtH by script. No hand edits were done, exported as it is. Exported into table and matrix.

## Carbonate fitting
Loaded and fitted VoigtK by script. No hand edits were done, exported as it is into table and matrix.

## 800 band fitting
Loaded and fitted VoigtS by script. No hand edits were done, exported as it is into table and matrix.

## CO2 V3 fitting
V3b band COPY was NOT inluded into fit - area of V3b Voigts was to small to do fitting procedure. No hand edits were done, exported as it is into tables and matrices. Voigt4 was not studied in details because of lower CO2 absorption for this sample. Voigt3 area is low compared to Voigt2 and Voigt2.
To plot V3b (Voigt1 + Voigt2) area map simmiliar manipulations were done: 
* "Voigt1-MATRIX-Area-FN7112 map truncated.csv" and "Voigt2-MATRIX-Area-FN7112 map truncated.csv" were imported into Origin.
* Matrices were summed to produce "Voigt-1+2-MATRIX-Area-FN7112 map truncated (from Origin).csv".
* Matrix was opened and editor, every coma "," was replaced with coma and space ", ".
* Map was created from this matrix. It is the map of V3b Area.

## CO2 V2 fitting
No hand edits were done, exported as it is into tables and matrices.
