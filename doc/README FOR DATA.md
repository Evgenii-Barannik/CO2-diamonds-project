# General notes
This file describes datasets in the CO2D-project. Each folder inside the **data** folder contains one dataset. Most datasets are centred around FTIR-spectra, but there is also dataset with photos. Files .map are omnic IR maps and can be opened with Omnic software. All FTIR datasets in the **data** folder were collected with Nicolet iN10 microscope.

## About maps
Each small red square on the omnic-generated photo corresponds to one FTIR-spectrum. See "about-maps.jpg" in **results/edited-photo**for more info. Picture uses FN7112 diamond truncated map photo as an example to show mapping order. Generally order is from left to right and from bottom to top: lower left corner--> lower right corner --> second row left --> second row right, and so on.

## About spectra
Spectra from maps were exported to .csv files. Each row of .csv file contains w and A values (wavenumber in cm-1, Absorption).

# FN7114 diamond FTIR-datasets
FN7114 is a nitrogen-containing CO2-rich diamond with obvious zoning.

## FN7114 map truncated
Folder "FN7114 map truncated" contains "FN7114 map truncated version.map" file, spectra exported from truncated map, omnic-generated photos, omnic-generated maps with screenshots. Omnic options (seen on screenshots): transmission mode, 64 scans per spectrum, spectral range of 675-4000 cm-1 (seen in .csv files), resolution of 2 cm-1, aperture width of 150x150 µm2, step size of 100 µm, background collection every 30 min. Original map size - 18x18 spectra.
 Spectra were normalized with omnic in attempt to create omnic maps prior to fitting with Fityk. Omnic normalization seems to set maximum A(w) on the spectrum to 1 regardless of the wavenumber where maximum occurs. Normalization seems not consistent since maximum is "jumping" from CO2 V3-bands to nitrogen and diamond bands. This normalization is not sufficient for further calculations but probably should not interfere with Fityk+Lua script workflow. Omnic-generated maps seem to be inaccurate. This is probably due to "jumping" behavior and omnic mapping procedure with only A(w) values (but not band areas) used for mapping.
Spectra on the borders of the full map show strong polymer signal which is probably from polymer support used to hold diamonds. Due to bad quality of border spectra original .map file was truncated in omnic. Dimensions of truncated map are 15x18: 15 spectra in row, 18 in column, 270 in total. Spectra numbers in each row from the bottom are: [1-15, 16-30, 31-45, 46-60, 61-75, 76-90, 91-105, 106-120, 121-135, 136-150, 151-165, 166-180, 181-195, 196-210, 211-225, 226-240, 241-255, 256-270].
Possible inclusion absorption is seen on spectra listed below: 
[120,
134, 135,
148, 149, 150,
163, 164, 165,
179].
The origin of the signal and if corresponds to the inclusion is not understood well. There is also organics signal near, but it can possibly arise from oil contamination on the surface. For more info see "Possible Inclusion on FN7114 map photo cut.jpeg".
Spectra [0][14] in row/column coordinate system (spectrum 15) and [17][14] have low signal/noise ratio. Points can be masked when plotting with MatPlotLib (see notebooks in python-jupyter-code folder).

## FN7114 map full (not truncated)
Folder "FN7114 map full (not truncated)" contains "FN7114 map.map" file (324 spectra, 18x18 map) — full version of the map in the "FN7114 map truncated" folder. There are also .csv and .spa spectra exported from the full FN7114 map, omnic-generated photo, omnic screenshot with settings. 

## FN7114 line across CO2 30 microns
Folder contains data for the long profile through FN7114 diamond. There are .map file, interferogram, profile photo with screenshots, exported .csv and .spa spectra (56). Step size is 30 µm (seen in spa spectra logs inside), aperture appears to be 30x30 µm2.

## FN7114NewProfiles
Folder contains data for three parallel profiles through the central part of FN7114 diamond. Profiles are shorter compared to "FN7114 line across CO2 30 microns" profile. There are three .map files, three interferograms, profile photos, options screenshots, three .csv spectra sets:

* FN7114Profile#1-31-01-2020 (21 spectra);
* FN7114Profile#2-31-01-2020 (21 spectra);
* FN7114Profile#3-31-01-2020 (14 spectra, profile was not completed).

Last 4 symbols in spectra names are spectrum numbers. For example for FN7114Profile#1-31-01-20200001.csv spectrum number is 0001. Omnic options (seen on screenshots): step size of 50 µm, aperture of 50x50 µm2, 256 scans per spectra, 600-4000 cm-1 spectral range, background collection was repeated every 10 minutes ~ every 3-4 spectra.

# FN7112 diamond FTIR-datasets
FN7112 is a low-nitrogen CO2-rich diamond.

## FN7112 map
Folder "FN7112 map" contains three .map files:

* FN7112 map truncated version.map (truncated map with 16x22=352 spectra);
* FN7112map.map (full map with 24x24 spectra);
* FN7112map_Ifg.map (interferogram).

There are also .csv spectra exported from the truncated map, omnic-generated photos and omnic-generated maps, screenshots with maps, screenshot with settings, text file with the copy of settings. Omnic option (seen in the settings file and on screenshots): 64 scans per spectrum, spectral resolution of 2 cm-1, step of 100 µm, aperture width of 150x150 µm2, 4000 to 600 cm-1 spectral region, background collection every 30 min, original map size - 24x24 spectra.
Full FN7112 was truncated for the same reasons as FN7114 was. Dimensions of the truncated map are 16x22: 16 spectra in rows, 22 in column, 352 in total. Spectra numbers in each row from the bottom are: [1-16, 17-32, 33-48, 49-64, 65-80, 81-96, 97-112, 113-128, 129-144, 145-160, 161-176, 177-192, 193-208, 209-224, 225-240, 241-256, 257-272, 273-288, 289-304, 305-320, 321-336, 337-352].
Omnic-generated maps for CO2 V3 (2370 cm-1) and CO2 V2 (659 cm-1) are acceptable for this sample. Probably because 2415 cm-1 band is not strong in the sample and CO2 band width is nearly constant. Peak on 668 cm-1 is from CO2 gas, bands on 2922 cm-1 are probably from oil contamination on the surface. 

## FN7112 vertical profile at 18750 through CO2 max 30 microns
Folder contains data for profile through FN7112 diamond. There are .map file, interferogram, exported spectra, profile photo, omnic screenshot, omnic-generated "maps" with Y-w coordinates (profile is 1-dimensional). Step size appears to be 30 µm, aperture appears to be 30x30 µm2.

## FN7112 map 50 mkm
Folder contains data for the small map of FN7112 diamond CO2-rich zone. There are .map file, interferogram, exported spectra and omnic-generated maps for 2370 (V3b), 668 (CO2 gas), 659 (V2a) cm-1 bands. Map dimensions are 9x13, 117 spectra in total. Step size is 50 µm (seen on photo), aperture appears to be 50x50 µm2.

# Other data

## diamond-photo
Folder contains photos of FN7114 and FN7112 diamonds. Diamonds can be easily distinguished by appearance. Photos in the root are copies created to show diamond appearances.

## HPHT-IIa-diamond
Folder contains data for the HPHT IIa diamond. This diamond was used as a control sample for this study. Maps and spectra were collected with Nicolet iN10. Files inside:

* IIa_map_HPHT#2.map (map of a diamond);
* IIa_map_HPHT#2_Ifg.map (interferogram);
* IIa_map_HPHT#2_spectra0001.csv to IIa_map_HPHT#2_spectra0009.csv (spectra from map);
* HPHT_IIa_diamond.spa (spa spectrum);
* HPHT IIa diamond spectrum normalized.dat. It is NORMALIZED diamond spectra, which is used as a standard in this work.

## background-spectra
Folder contains FTIR-spectra of CO2 and H2O background in A = A(w) format. Spectra were collected with Nicolet iN10. "Single beam LowCO2 A(w)" and "Single beam HighCO2 A(w)" are single beam spectra with low and high measured CO2 content in air. "Pure CO2 + H2O background (w)", was created by subtraction of two single beam spectra. It was used to create fitting functions for gaseous CO2 absorption: CO2GasV3 and CO2GasV2.

# from-elsewhere folder
Folder from-elsewhere contains data from other various sources:

* "12CO2-v3-Hitran-k(w)-1atm-296K.txt" and "13CO2+12CO2-CDSD296-k(w)-1atm-296K.txt" are HITRAN/CDSD-generated CO2 spectra (look inside file for more info);
* "A study of unusual diamonds - CO2 v3 - Fig 416" file was created by digitization of absorption spectra from [A study of unusual diamonds from the George Creek K1 Kimberlite dyke, Colorado" thesis] with Engauge Digitizer;
* "Defects spectra.csv" file contains diamond center FTIR-spectra. Curves from this table were used to create Fityk fitting functions for A, B, C, and X-centers.