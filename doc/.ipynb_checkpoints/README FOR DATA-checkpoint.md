# ABOUT
This file describes the data in CO2-rich diamonds project. In general data is FTIR-spectra, but there are also images and other files. Data was collected for FN7114 and FN7112 diamonds. Files .Map can be read with omnic software.
All FTIR-spectral data (except from-elsewhere folder) were collected with Nicolet iN10 microscope with liquid nitrogen-cooled MCT detector. Not all data is used for the paper.

## FN7114 map truncated
======================
Folder "FN7114 map truncated" contains "FN7114 map truncated version.MAP" file, spectra exported from truncated map, omnic-generated photos, omnic-generated maps with screenshots. 
 
Spectra were normalized in omnic to create maps (prior to fitting with Fityk). Omnic normalization seems to set maximum A(w) on spectrum to 1 regardless of the wavenumber where maximum occurs. Normalization seems not consistent since maximum is "jumping" from CO2 V3-band (w) to nitrogen band (w) and diamond bands (w). Normalization is not sufficient for further calculations but probably should not interfere with lua script normalization.

Omnic-generated maps seem to be inaccurate due to this jumping and omnic mapping procedure — only A(w) is used for mapping.

Spectra on the borders of the full map showed strong polymer signal which is probably from polymer support used hold diamonds. Due to bad quality of border spectra orignal file .MAP was truncated. Dimension of truncated map are 15*18 spectra: 15 spectra in row, 18 in column, 270 in total. Spectra numbers in each row are: 
{1-15, 16-30, 31-45, 46-60, 61-75, 76-90, 91-105, 106-120, 121-135, 136-150, 151-165, 166-180, 181-195, 196-210, 211-225, 226-240, 241-255, 256-270}.

Possible inclusion absorption seems to show up on spectra listed below: 
120
134, 135
148, 149, 150
163, 164, 165
179 
See "Possible Inclusion on FN7114 map photo cut.jpeg". The nature of signal and if corresponds to the inclusion is not understood. There is also strong organics signal near, but it can possibly arise from oil contaminatieon.

Spectrum #15 has high noise/signal ratio. It can pinned out when plotting with MatPlotLib.

## FN7114 map full (not truncated)
======================
Folder "FN7114 map full (not truncated)" contains full "FN7114 map.MAP" file, .CSV and .SPA spectra exported from the full FN7114 map (324 spectra, 18*18 map), omnic-generated photo, omnic screenshot with settings. It is full version of the truncated FN7114 map. 

## FN7112 map
======================
Folder "FN7112 map" contains three .MAP files:
* FN7112 map truncated version.MAP (truncated map with 16*22=352 spectra);
* FN7112map.MAP (full map with 24*24 spectra);
* FN7112map_Ifg.MAP (interferogram).
There are also .csv spectra exported from truncated map, omnic-generated photos and omnic-generated maps, screenshots with maps, screenshot with settings, text file with the copy of settings. Full map was truncated for the same reasons as for FN7114. Dimensions of the truncated map are 16*22: 16 spectra in rows, 18 in column, 352 in total. Spectra numbers in each row are:
{1-16, 17-32, 33-48, 49-64, 65-80, 81-96, 97-112, 113-128, 129-144, 145-160, 161-176, 177-192, 193-208, 209-224, 225-240, 241-256, 257-272, 273-288, 289-304, 305-320, 321-336, 337-352}.

Omnic-generated maps on CO2 V3 (2370 cm-1) and CO2 V2 (659 cm-1) wavenumbers are acceptable for this sample. Probably because neither IR-visible nitrogen centers nor intense 2415 band are seen in sample. 668 cm-1 band is from CO2 gas, 2922 cm-1 is probably from oil on the surface. 

## from-elsewhere folder
======================
Folder from-elsewhere contains data from various sources.
* "12CO2-v3-Hitran-k(w)-1atm-296K.txt" and "13CO2+12CO2-CDSD296-k(w)-1atm-296K.txt" are HITRAN/CDSD-generated CO2 spectra (look inside files for more info).
* "A study of unusual diamonds. " files are digitalised with Engauge Digitizer absorption spectra from [A study of unusual diamonds from the George Creek K1 Kimberlite dyke, Colorado" thesis].
* "Defects spectra from Shiryaev.csv" is file with diamond defect spectra. Curves from here are used to create Fityk init functions of A,B,C,X-centers.
* "RamanIR / IR in situ - H2CO3 from Hongbo Wang.OPJ" files were sent to me by Hongbo Wang <whb2477@jlu.edu.cn>. It is data from [Stable solid and aqueous H2CO3 from CO2 and H2O at high pressure and high temperature] paper.

## diamond-photo folder
======================
Folder contains photos for FN7114 and FN7112 diamonds. Two photos in the root are copies creater to show diamond appearence. Photo and folder names seem arbitrary, but diamonds can be easily distinguished by appearence.

## HPHT-IIa-diamond
======================
Folder contains data for HPHT IIa-diamond. Normalized spectrum of this diamond was used as a control sample for this study. Maps and spectra were also collected on the same FTIR-microscope.
* IIa_map_HPHT#2.map (map of a diamond);
* IIa_map_HPHT#2_Ifg.map (interferogram);
* IIa_map_HPHT#2_spectra0001.csv to IIa_map_HPHT#2_spectra0009.csv (spectra from map).
* HPHT_IIa_diamond.SPA (spa spectrum);
* HPHT IIa diamond spectrum normalized.dat. It is the NORMALIZED diamond spectra, which is used as a reference in this work.
