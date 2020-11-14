--ABOUT THIS SCRIPT--
	--This LUA script is used to process FTIR-spectra of CO2-rich diamonds in Fityk.	
	--It is one of the scripts created to automate spectra loading, fitting, exporting obtained parameters and exporting edited spectra.
	--Scripts are tested with Fityk 1.3.1. Scripts are run from Fityk.
	--The CO2D-SPECTRA_EXPORT.lua script is used to export edited spectra. More info can be found in the README FOR SCRIPTS.txt file.

do --Script start

--OPTIONS--	(CHECK BEFORE START)
destination = string.format("/Users/meguka/CO2D-project-github/results/edited-spectra") -- Set path to the folder for data export.

--MAIN CODE SECTION--
	for i = 0, F:get_dataset_count()-1 do --For all i-numbers, from 0 to number of dataset amount.
	F:execute ("use @%d" % i) --Use dataset i.
	filename = string.format("Fitted-")..F:get_info("title") --create filename using original filename and Fitted- string
	F:execute ("print all: x, y, F(x) > '%s/%s'" % {destination, filename}) --Print x, y, model values to the output file.
	end --Cycle end
end --Script end
