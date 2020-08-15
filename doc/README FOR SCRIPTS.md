# About
This readme describes scripts for working with CO2-rich diamond FTIR data. 

# Lua code
Lua scrips were created to automate spectra loading, fitting, exporting obtained parameters and edited spectra with Fityk software. Lua programming language was chosen for deep Fityk integration. Lua scripts were tested with Fityk 1.3.1.

* CO2D-LOAD.lua script can load spectra files into Fityk;
* CO2D-FIT.lua script can fit diamond spectra in the Fityk;
* CO2D-TABLE_EXPORT.lua can export fitted parameters for multiple functions from Fityk into separate .csv tables;
* CO2D-MATRIX_EXPORT.lua can export fitted parameters from Fityk into matrices. Useful for map creation;
* CO2D-SPECTRA_EXPORT.lua can export multiple edited spectra from Fityk.

# Python Jupyter code
Folder contains Jupyter notebooks aka Interactive Python notebooks (.ipynb). Jupyter notebook can be run from Anaconda: "Anaconda Navigator" application --> "Launch JupyterLab" --> Choose CO2D-MAPGEN.ipynb file --> "Run" menu in JupyterLab --> "Run all cells". Scripts were tested with 3.7.6 Python version. More info is inside the notebooks.

* CO2D-MAPGEN.ipynb is a Jupyter notebook with Python script used for map plotting. Script takes matrices as input and creates images. NumPy and Matplotlib were used in particular for this script. 
* CO2D-SPLOT.ipynb is a Jupyter notebook with Python script used for spectra plotting. For example FN7114Profile#2-31-01-20200003-V2-Fitted.png was plotted with it.
* CO2D-LPLOT.ipynb is a Jupyter notebook with Python script used for linear and scatter plotting. For example 'FN7114 line across CO2 30 microns linear fit comparison.png' was plotted with it. 

## How to use
Scripts can be used in the following way:

1. Edit the Fityk init file (necessary for CO2D-FIT.lua to work);
2. Load spectra by hand or with CO2D-LOAD.lua;
3. Fit spectra with CO2D-FIT.lua and edit manually if necessary;
4. Export results with any of CO2D-TABLE_EXPORT.lua, CO2D-MATRIX_EXPORT, CO2D-SPECTRA_EXPORT.lua scripts.
5. Create maps and plots with .ipynb scripts.

## About the init functions
Spectra fitting with Fityk requires the use of user-defined functions:

1. CO2GasV2, CO2GasV3. These functions approximate shapes of CO2 gas absorption in V2 and V3 regions. CO2GasV2, CO2GasV3 can be used to compensate possible interference from atmospheric CO2.
2. Acenter, Bcenter, Ccenter, Xcenter. These functions approximate shapes of A, B, C, X-center absorption. Functions are normalized in a way similar to described in [μ-FTIR mapping: Distribution of impurities in different types of diamond growth].
	* **Acenter(height)** function "height" parameter on normalized spectrum is the concentration of nitrogen in A-center state in atomic ppm. If Acenter absorption at 1282 cm-1 is 1 cm-1 then atomic nitrogen concentration in A-center is 16.5 ppm.
	* **Bcenter(height)** function "height" parameter on normalized spectrum is the concentration of nitrogen in B-center state in atomic ppm. If Bcenter absorption at 1282 cm-1 is 1 cm-1 then atomic nitrogen concentration in B-center is 79.4 ppm.
	* **Ccenter(height)** function "height" parameter on normalized spectrum is the concentration of nitrogen in C-center state in atomic ppm. If Ccenter absorption at 1130 cm-1 is 1 cm-1 then atomic nitrogen concentration in C-center is 25 ppm.
	* **Xcenter(height)** function "height" parameter on normalized spectrum is the concentration of nitrogen in X-center state in atomic ppm. If Xcenter absorption at 1332 cm-1 is 1 cm-1 then atomic nitrogen concentration in X-center is 5.5 ppm.
	* **O-band** is the broad band of unknown nature. Function **Oband(height)** is also normalized, but in a different way. If O-band height is 1000, then O-band area is 1000 cm-2. Band area was calculated in Fityk as a numerical integral.
    
## 1. Editing the Fityk init file
Init file editing can be done once. To do this copy text from "FUNCTIONS FOR FITYK INIT FILE.txt" and paste it to the Fityk Init file. Init file can be opened in Fityk with "Session –> Edit the Init File". Save changes and restart Fityk. Functions above can now be used for fitting.

## 2. Loading spectra
Spectra loading can be done by hand OR with CO2D-LOAD.lua script.

### Loading spectra by hand
Start Fityk and load standard diamond spectrum into @0 slot. Any suitable for Fityk file type can be used. Spectrum @0 should be the normalized spectrum of IIa type diamond in A=A(w) format for the CO2D-FIT.lua script to work correctly. Standard spectrum with name "HPHT IIa diamond spectra normalized.dat" is provided in **data/HPHT-IIa-diamond** folder. Afterwards you can load any amount of sample spectra into Fityk.

### Loading spectra with script
Script CO2D_LOAD.lua can be used to load multiple spectra semi-automatically. Before first use open CO2D-LOAD.lua with text editor and edit (check) options/settings in the --OPTIONS-- section. Script was tested for .csv files with X,Y (w in cm-1, A) data style. For example first three rows of spectra files may look similar like this:

    5.997780e+002,2.836216e-001
    6.007423e+002,4.123333e-001
    6.017065e+002,2.998884e-001

Spectra filenames are expected in "SpectraName_SpectraNumber_SpectraFormat" style. For example filenames can be FN7114spectra0009.CSV, FN7114spectra0010.CSV, FN7114spectra0011.CSV, FN7114spectra0012.CSV, FN7114spectra0013.CSV. String "SpectraName" (FN7114spectra in example) represents the invariant part of spectra filename before number, "SpectraFormat" (.CSV in example) represents the invariant part of spectra filename after the number, possibly with the file extension. "SpectraNumber" is the number variable that changes through user set range. In example above "SpectraNumber" changes from 0009 to 0013. "SpectraNumber" takes first value from "FirstSpectrum" (9 in example) and last value from "LastSpectrum" (13 in example).
There are also other settings. "SpectraFolder" is the path to the sample spectra folder. "StandardName" and "StandardFolder" options set the name and path for the standard spectra respectively. Settings can be changed in --OPTIONS-- section of CO2D-LOAD.lua.

To run the script you need to execute it using "Fityk –> Session –> Execute script". 

### Code example for spectra loading
Options below will make Fityk to load "FN7114 map truncated version0009.CSV", ..., "FN7114 map truncated version0013.CSV" files from "FN7114 map truncated" folder. In this example folder is situated at "/Users/Admin/Dropbox/CO2D-project-github/data/FN7114 map truncated version/".

    SpectraName = string.format("FN7114 map truncated version")
    SpectraFormat = string.format(".CSV")
    FirstSpectrum = 9 
    LastSpectrum  = 13
    SpectraFolder = string.format("/Users/Admin/Dropbox/CO2D-project-github/data/FN7114 map truncated/")


## 3. Spectra fitting
After loading fitting can be started. Script CO2D-FIT.lua can fit spectra in different mutually exclusive modes. Each mode corresponds to the different spectral area: CO2 V2; CO2 V3; VN3H; A, B, C-centers and Platelets; Carbonates; 800 cm-1 band. Execute the CO2D-FIT.lua using "Fityk –> Session –> Execute script" and choose the desired mode.
After fitting will be done you can alter fitted parameters by hand. Beware that "Start fitting" operation in Fityk requires for parameters to be consistent with the initial model restrictions. Some restrictions might be used depending on mode/spectral area. All restrictions can be edited inside CO2D-FIT.lua script.

## 4. Data export
Data export may be done with CO2D-TABLE_EXPORT.lua, CO2D-MATRIX_EXPORT.lua or CO2D-SPECTRA_EXPORT.lua. Correct options must be stated in --OPTIONS-- section of the script. Scripts can be edited with plain text editor. 

### Export with CO2D-MATRIX_EXPORT.lua
Name the correct output folder in --OPTIONS-- section. This folder must exist prior to data export. If needed edit the function types, the parameters to export, the desired number of values in each matrix row. Script does a search for every type+parameter combination. If the stated parameter is found for any stated function then matrix will be created. Make sure to use correct number of values in a row to produce rectangular matrix. Only rectangular matrices are suitable for CO2D-MAPGEN.ipynb script. Output will consist of two files: Function-Matrix...csv and Function-Metadata...csv. Matrix-file is a comma-separated matrix with the values of chosen parameter. Each value corresponds to one spectrum. Metadata file is a comma-separated matrix file with the corresponding spectra numbers. Function-Matrix...csv files can be loaded with CO2D-MAPGEN.ipynb to produce map plots.

### Export with CO2D-TABLE_EXPORT.lua
Name the correct output folder in --OPTIONS-- section. This folder must exist prior to data export. Output will consist of .csv files for each FunctionType in fitted datasets. FunctionType is generally equal to template_name of the function. Voigts are exception.
Script supports all template_name including user-defined. All Linear functions, all Gaussians, all Lorentzians, ... and so on (except Voigts) will be exported to separate type-related .csv files. Each row in the output .csv file will correspond to one spectra. Function parameters will be separated by semicolons.
    FunctionType is the extension of template_name parameter in Fityk. For Voigt functions special procedure exists. If Voigt function name contains "Voigt*" string (where is * can be every symbol) then its FunctionType will be considered a "Voigt*". Data for this function will be exported into separate .csv file. 

### Export with CO2D-SPECTRA_EXPORT.lua
Name the correct output folder in --OPTIONS-- section. This folder must exist prior to data export. Output will mirror loaded into Fityk spectra. Output files will contain x, y and model values (sum of all model functions). Filenames will be based on the original filenames with the addition of "Fitted" string.