--ABOUT THIS SCRIPT--
	--This LUA script is used to process FTIR-spectra of CO2-rich diamonds in Fityk.	
	--It is one of the scripts created to automate spectra loading, fitting, exporting obtained parameters and exporting edited spectra.
	--Scripts are tested with Fityk 1.3.1. Scripts are run from Fityk.
	--The CO2D-LOAD.lua script is used for spectra loading. More info can be found in the README FOR SCRIPTS.txt file.

do --Script start

--OPTIONS-- (CHECK BEFORE START)
	SpectraName = string.format("FN7114Profile#2-31-01-2020") --Set invariant part of spectra name (which is before number).
	SpectraFormat = string.format(".CSV") ---Set invariant part of spectra name (which is after number). Also includes file format.
	FirstSpectrum = 1--Set first spectrum number.
	LastSpectrum  = 200 --Set last spectrum number.
	SpectraFolder = string.format("/Users/meguka/CO2D-project-github/data/FN7114NewProfiles/") --Set path to the spectra folder.
	StandardName = string.format("HPHT IIa diamond spectrum normalized.dat")--Set full name of the standard spectra. Can be "HPHT IIa diamond spectra normalized.dat".
	StandardFolder = string.format("/Users/meguka/CO2D-project-github/data/HPHT-IIa-diamond/") --Set path to the folder with standard spectra.
		
	--MAIN CODE SECTION--
	F:execute ("set cwd = '%s'" % StandardFolder) -- Load path to the standard spectra folder.
	F:execute ("@0 < '%s':1:2::" % StandardName) -- Load standard spectra. :1:2:: is the import scheme. First symbol after ":" (1) shows X values position, second symbol (2) shows Y values position. 
	F:execute ("set cwd = '%s'" % SpectraFolder) -- Load path to the sample spectra folder.

	for SpectraNumber = FirstSpectrum, LastSpectrum do -- For all numbers between and including FirstSpectrum, LastSpectrum do
		F:execute ("print '-- Cycle/dataset number is %d; Trying to load %s%04d%s'" % {SpectraNumber, SpectraName, SpectraNumber, SpectraFormat }) -- Print data about cycle in the console
		F:execute ("@+ < '%s%04d%s':1:2::" % {SpectraName, SpectraNumber, SpectraFormat}) --Load spectra. %04d corresponds to numbers in 4-symbols format: for example 0001, 0002, ..., 0243, and so on.
	end --Cycle end
end	--Script end
