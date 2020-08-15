# ABOUT LUA SCRIPTS
This readme in general describes LUA scripts that can used for processing of CO2-rich diamond FTIR-spectra in Fityk. Lua scripts are tested with Fityk 1.3.1.  Scripts can be helpful to automate spectra loading, fitting, exporting obtained parameters and exporting edited spectra:

* CO2D-LOAD.lua script can load spectra files.
* CO2D-FIT.lua script can fit spectra.
* CO2D-TABLE_EXPORT.lua can export all fitted parameters for multiple functions into separate tables.
* CO2D-MATRIX_EXPORT.lua can export value of fitted parameter into a MATRIX. Useful for map creation.
* CO2D-SPECTRA_EXPORT.lua can export edited spectra.

# ABOUT PYTHON SCRIPTS
* CO2D-MAPGEN.ipynb is a Jupyter python notebook+script used for map plotting.
NumPy and Matplotlib were used in particular for the script. Jupyter workbook can be run from Anaconda: "Anaconda Navigator" application --> "Launch JupyterLab" --> Choose CO2D-MAPGEN.ipynb file --> "Run" menu in JupyterLab --> "Run all cells". More info is inside the notebook.

## LICENSE
Provided scripts are licensed under a creative Commons Attribution 4.0 International License. 

## USAGE
Scripts can be used in the following way:
1. Edit the Fityk init file (necessary for CO2D-FIT.lua to work);
2. Load spectra by hand or with CO2D-LOAD.lua;
3. Fit spectra with CO2D-FIT.lua and help by hand if necessary;
4. Export results with any of CO2D-TABLE_EXPORT.lua, CO2D-MATRIX_EXPORT, CO2D-SPECTRA_EXPORT.lua scripts.

## ABOUT THE INIT FILE FUNCTIONS
Spectra fitting in the CO2 V2, CO2 V3 and nitrogen regions requires the help of user-defined functions. Those functions are:
1. CO2GasV2, CO2GasV3. These functions approximate shapes of CO2 gas absorption in V2 and V3 regions. CO2GasV2, CO2GasV3 can be used to compensate possible interference from atmospheric CO2.
2. Acenter, Bcenter, Ccenter, Xcenter. These functions approximate shape of A, B, C, X-center absorption. Functions are normalized in a way similar to described in [μ-FTIR mapping: Distribution of impurities in different types of diamond growth]:
	* **Acenter(height)** function "height" parameter on normalized spectrum is the A-center concentration in ppm. If Acenter absorption at 1282 cm-1 is 1 cm-1 then A-center concentration is 16.5 ppm.
	* **Bcenter(height)** function "height" parameter on normalized spectrum is the B-center concentration in ppm. If Bcenter absorption at 1282 cm-1 is 1 cm-1 then B-center concentration is 79.4 ppm.
	* **Ccenter(height)** function "height" parameter on normalized spectrum is the C-center concentration in ppm. If Ccenter absorption at 1130 cm-1 is 1 cm-1 then C-center concentration is 25 ppm.
	* **Xcenter(height)** function "height" parameter on normalized spectrum is the X-center concentration in ppm. If Xcenter absorption at 1332 cm-1 is 1 cm-1 then X-center concentration is 5.5 ppm.
	* **Oband(height)** is the broad band of unknown nature. Function Oband(height) is also normalized, but in a different way. If O-band height is 1000, then O-band area is 1000 cm-2. Area was calculated in Fityk as a numerical intergral. Use $"print %_1.numarea(800, 1500, 2000)"$ if O-band if the function #1.
    

## 1. EDITING THE FITYK INIT FILE
Editing of the Init file can be done once. To do this copy text from "FUNCTIONS FOR FITYK INIT FILE.txt" and paste it to the Fityk Init file. Init file can be accessed with "Session –> Edit the Init File". Save changes and restart Fityk. Functions above can now be used for fitting.

## 2. SPECTRA LOADING
Spectra loading can be done by hand OR with CO2D-LOAD.lua script.

### LOADING SPECTRA BY HAND
Start Fityk and load standard diamond spectrum into @0 slot. Any suitable for Fityk file type can be used. Spectrum @0 should be the normalized spectrum of IIa type diamond in A=A(w) format for the CO2D-FIT.lua script to work correctly. Standard spectrum with name "HPHT IIa diamond spectra normalized.dat" is provided in data folder. After loading the standard spectrum you can load any amount of your sample spectra into Fityk.

### LOADING SPECTRA WITH SCRIPT
Script CO2D_LOAD.lua can be used to load multiple spectra semi-automatically. Before first use you should open CO2D-LOAD.lua with plain text editor and edit(check) options in --OPTIONS-- section.

Spectra filenames are expected in "SpectraName_SpectraNumber_SpectraFormat" style (underscores inside to be omitted). For example filenames can be FN7114spectra0009.CSV, FN7114spectra0010.CSV, FN7114spectra0011.CSV, FN7114spectra0012.CSV, FN7114spectra0013.CSV. String "SpectraName" (FN7114spectra in example) represent the invariant part of spectra filename before number, "SpectraFormat" (.CSV in example) represent the invariant part of spectra filename after the number, possibly with filename extension. "SpectraNumber" is the number variable that changes through user set range. In example above "SpectraNumber" changes from 0009 to 0013. "SpectraNumber" takes first value from "FirstSpectrum" (9 in example) and last value from "LastSpectrum" (13 in example).
There are also other settings. "SpectraFolder" is the path to the folder with the sample spectra. "StandardName" and "StandardFolder" options set the name and path for the standard spectra respectively. All "SpectraName", "SpectraFormat", "SpectraNumber", "FirstSpectrum, "LastSpectrum", "StandardName" and "StandardFolder" can be changed in --OPTIONS-- section of CO2D-LOAD.lua.

To run the script you need to execute it using "Fityk –> Session –> Execute script". Script is tested for CSV spectra files with X,Y (w in cm-1, A) column data style. For example first three rows of spectrum file may look like this:
8.350613e+002,5.613921e-001
8.360256e+002,5.591421e-001
8.369899e+002,5.612156e-001
...

### CODE EXAMPLE FOR SPECTRA LOADING
Options below will make Fityk to load "FN7114 map truncated version0009.CSV", ..., "FN7114 map truncated version0013.CSV" files from "FN7114 map truncated" folder. In this example folder is situated at "/Users/Admin/Dropbox/CO2 in diamond/Raw spectra/FN7114 map truncated".

SpectraName = string.format("FN7114 map truncated version")
SpectraFormat = string.format(".CSV")
FirstSpectrum = 9 
LastSpectrum  = 13
SpectraFolder = string.format("/Users/Admin/Dropbox/CO2 in diamond/Raw spectra/FN7114 map truncated")

## 3. SPECTRA FITTING
After loading spectra fitting can be done. Script CO2D-FIT.lua can fit spectra in different mutually exclusive mods. Each mode corresponds to the different spectral area among list: CO2 V2; CO2 V3; VN3H; A, B, C-centers and Platelets; Carbonates; 800 cm-1 band. Execute the CO2D-FIT.lua using "Fityk –> Session –> Execute script" and choose the desired mode.
After running this script fitting will be done, but you can also alter fitted parameters by hand and following fitting. Beware that "Start fitting" operation in Fityk requires for parameters to be consistent with initial model restrictions. Some restrictions might be used depending on spectral area. All restrictions can be edited inside CO2D-FIT.lua script. Scripts can be edited with plain text editor. 

## 4. DATA EXPORTING
Data export may be done with CO2D-TABLE_EXPORT.lua, CO2D-MATRIX_EXPORT.lua or CO2D-SPECTRA_EXPORT.lua. Before use correct options must be stated in --OPTIONS-- section of the script. Scripts can be edited with plain text editor. 

### EXPORTING WITH CO2D-MATRIX_EXPORT.lua
Before use name the correct output folder in --OPTIONS-- section. This folder must exist prior to data export. Edit the function types, the parameters to export, the desired number of values in each matrix row. Script does a search for every  type+parameter combination. If the stated parameter is found for any function stated in types then matrix will be created.
Make sure to use correct number for row to produce rectangular matrix. Only rectangular matrices are suitable for CO2D-MAPGEN.ipynb script. Output will consist of two files: Function-Matrix...csv and Function-Metadata...csv. Matrix-file is a comma-separated matrix with values of chosen parameter. Each value corresponds to one spectrum. Metadata file is a comma-separated matrix file with corresponding dataset numbers. Function-Matrix...csv can be fed into CO2D-MAPGEN.ipynb to produce map plots.

### EXPORTING WITH CO2D-TABLE_EXPORT.lua
Before use name the correct output folder in --OPTIONS-- section. This folder must exist prior to data export. Output will consist of .csv files for each each FunctionType in fitted datasets. FunctionType is the extension of template_name parameter in Fityk. FunctionType is generally equal to template_name of the function with the exception of Voigts.
Script supports all FunctionTypes including user-defined types. Linear functions, all Gaussians, all Lorentzians, ... and so on (except voigts) will be exported to separate type-related .csv files. For Voigt function special procedure exists. If Voigt function "name" contains "Voigt*" string (where is * can be every symbol) then its FunctionType will be considered a "Voigt*". This function will be exported to the separate "Voigt*"-type .csv file. Regardless of type each row in the output .csv file will correspond to one spectra. Different parameters will be in one row separated by semicolons.

### EXPORTING WITH CO2D-SPECTRA_EXPORT.lua
Before use name the correct output folder in --OPTIONS-- section. This folder must exist prior to data export. Output files will mirror loaded spectra. Output files and will contain x, y and model values (sum of all functions). Filenames will be based on the original filenames + "Fitted" string.