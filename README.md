![FN7112-diamond-inclusion](https://github.com/Evgenii-Barannik/CO2-diamonds-project/blob/master/results/edited-photo/FN7112-inclusions-preview.jpg)

# CO2D-project
This project contains data for the CO2-rich diamond research undertaken in 2019-2020. Project is hosted on GitHub: https://github.com/Evgenii-Barannik/CO2-diamonds-project. Text documents in the project are formatted in Markdown (.md) and can be opened with plain-text editor.  

1. **data** folder contains raw data: FTIR-spectra, photos, omnic maps (.map). Folders inside correspond to the different datasets. For more info, see the "README FOR DATA.txt" in the **doc** folder. 
2. **doc** folder contains most written documents: readme for data, readme for code, workflow for data processing, licence. There are also Fityk init functions, origin project.
3. **from-elsewhere** folder contains data from other sources.
4. **lua-code** folder contains Lua scripts used with Fityk. For more info, see the "README FOR SCRIPTS.txt" in the **doc** folder.
5. **python-jupyter-code** folder contains Jupyter (.ipynb) notebooks with Python scripts used to plot maps and other figures. For more info, see the "README FOR SCRIPTS.txt" in the **doc** folder.
6. **results** folder contains processed data and plots. Most files in the folder were created by Lua and Python scripts. For more info, see the "WORKFLOW FOR DATA PROCESSING.txt" in the **doc** folder.
   
    * **edited-spectra** folder contains exported from Fityk .dat spectra;
    * **spectra-plots** folder contains plots;
    * **matrix** folder contains matrices created with the CO2D-MATRIX_EXPORT.lua script. Each matrix is a 2D array with the values of one parameter (examples: carbonates peak area, CO2 v3b center position) for each spectrum of the map;
    * **matrix-metadata** folder contains metadata files for the matrices. Metadata files were also created with the CO2D-MATRIX_EXPORT.lua script;
	* **matrix-not-used-for-plotting** folder also contains matrices created with the CO2D-MATRIX_EXPORT.lua script. Matrices from this folder are not used by the CO2D-MAPGEN.ipynb for map plotting;
    * **maps** folder contains maps created by the CO2D-MAPGEN.ipynb using matrices from the matrix folder;
    * **tables** folder contains tables with exported function parameters. Tables were created with the CO2D-TABLE_EXPORT.lua script.
    * **edited-photo** folder contains rescaled or edited photos.
