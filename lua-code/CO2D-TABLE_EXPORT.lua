--ABOUT THIS SCRIPT--
	--This LUA script is used to process FTIR-spectra of CO2-rich diamonds in Fityk.	
	--It is one of the scripts created to automate spectra loading, fitting, exporting obtained parameters and exporting edited spectra.
	--Scripts are tested with Fityk 1.3.1. Scripts are run from Fityk.
	--The CO2D-TABLE_EXPORT.lua script is used to export all parameters for multiple finctions into separate csv files. More info can be found in the README FOR SCRIPTS.txt file.

do --Script start

--OPTIONS-- (CHECK BEFORE START)
	F:execute ("set cwd = '/Users/meguka/CO2D-project-github/results/tables/'") -- Set path to the folder for data export

--MAIN CODE SECTION--
	arrayCounter = 0 --Create variable to count the functions inside array
	array = {} -- Create array to contain detected function types. It is used to create output file and print table header only once for every function type.
	for n,f in F:all_functions() do --For all n-numbers, f-functions in function list do	

--LUA FUNCTIONS--	
	function ArrayCheckifNovel (tab, val) --Create lua function = function (two parameters) to check if value is novel (NOT present) inside array.
	    for index, value in ipairs(tab) do
	        if value == val then return false -- If is present then return false
	        end
	    end return true  -- If novel then return true
	end

	function PrintParameter( parameter ) --Create lua function = function (parameter) to write parameter value inside output file.
		return Outputfile:write(f:get_param_value("%s" % parameter)..string.format(", ")) --text to write with lua function
	end

		function SearchForFunctionInsideArray(name) --Create lua function to search for function with "name" string inside title in array. All dataset models are inspected. 
			for i = 0, F:get_dataset_count()-1 do -- For all datasets
			F:execute ("use @%d" % i) -- Activate dataset
				if (string.match (F:get_info("F"), name)) == string.format(name) then -- if dataset model contains function with string "name"
				 	return i -- then return dataset number and end i-cycle (works like break)
				else end -- else end
			end	
			return nil
		end 

	function FunctionTypeCheck() --Create lua function to output FunctionType for f. Works inside "for n,f in F:all_functions() do " cycle. FunctionType is the extension of file_template parameter in Fityk.
		if f:get_template_name() == string.format("Voigt") then
			if string.match (f.name, 'Voigt.') ~= nil then
			 	FType = string.match (f.name, 'Voigt.')
				else FType = string.format("Voigt")
			end
		else FType = f:get_template_name()
		end	
	return FType	
	end

--EXPORT--
		FunctionType = FunctionTypeCheck() --Take FunctionType
		Nametemplate=(string.format("%s-from-" % {FunctionType})..(string.sub(F:get_info("filename",1), 1,20))) -- Create template with function type, first 20 symbols of filename. Will be part of the file name.	
		if f:get_template_name() == "Voigt" then mode = 1 else mode = 0 end -- If Voigt do special Voigt export mode
				
--HEADER EXPORT--			
		if ArrayCheckifNovel(array, FunctionType) then -- If FunctionType is novel for array
			table.insert (array, FunctionType) --Then insert FunctionType in array
			arrayCounter = arrayCounter +1 -- Increase arrayCounter
			Outputfile = io.open("%s.csv" % Nametemplate, "w" ) -- Create a file to output results. Name is based on Nametemplate. w- write mode, a - append mode

			if mode == 1 then -- if mode is Voigt do special heading export
				Outputfile:write("Spectra_filename, Number_in_fun_name, Function_full_name, FunctionType, Area, Center, FWHM, shape, GaussianFWHM, LorentzianFWHM,  gwidth, height,  ") --Write table header
			else -- if mode is not Voigt do general heading export
				Outputfile:write("Spectra_filename, Number_in_fun_name, Function_full_name, FunctionType, ") --Write table header
				for i = 0, 9 do -- print parameters 1-9 names for heading if they exist 
				if f:get_param(i) ~= string.format("") then Outputfile:write(f:get_param(i)..string.format(", ")) else end
				end				
			end	

			Outputfile:write(os.date("--- Created at %c ---\n")) --Write current time inside table header and print new line (\n)
			print ("%s added to array as function #%s. File '%s.csv' is generated." % {FunctionType, arrayCounter, Nametemplate} ) --Print info to Fityk console.
			Outputfile:close() --Close the output file
		else end
--PARAMETERS EXPORT--
		Outputfile = io.open("%s.csv" % Nametemplate, "a" ) -- Open output file, now in append mode.
		if (string.match (f.name, "%d+")) == nil --check if there is a number inside function name.
		then  Number_in_fun_name = string.format("None") -- if no — use None
		else Number_in_fun_name = (string.match (f.name, "%d+")) end -- if yes — try to take first number inside a function name and use it as Number_in_fun_name.
		Spectra_filename = F:get_info("filename", SearchForFunctionInsideArray(f.name)) -- Spectra_filename is the title of file with corresponds to dataset with model containing function "f.name"
		Outputfile:write(string.format("%s, %s, %s, %s, " % {Spectra_filename, Number_in_fun_name, f.name, FunctionType})) --Write data into output

		if mode == 1 then -- if mode is Voigt do special parameter export
			PrintParameter("Area") --Write data into output using PrintParameter lua function.
			PrintParameter("center")
			PrintParameter("FWHM")
			PrintParameter("shape")
			PrintParameter("GaussianFWHM")
			PrintParameter("LorentzianFWHM")
			PrintParameter("gwidth")
			PrintParameter("height")
		else -- if mode is not Voigt do general parameter export
			for i = 0, 9 do -- print parameters 1-9 values if they exist 
			if f:get_param(i) ~= string.format("") then Outputfile:write(f:get_param_value(f:get_param(i))..string.format(", ")) else end
			end
		end		
			Outputfile:write(string.format("\n")) --Write new line
			Outputfile:close() -- Close the output file	
	end-- Cycle end	
end --Script end