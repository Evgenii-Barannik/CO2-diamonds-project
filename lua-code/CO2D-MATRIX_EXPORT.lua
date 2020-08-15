--ABOUT THIS SCRIPT--
	--This LUA script is used to process FTIR-spectra of CO2-rich diamonds in Fityk.	
	--It is one of the scripts created to automate spectra loading, fitting, exporting obtained parameters and exporting edited spectra.
	--Scripts are tested with Fityk 1.3.1. Scripts are run from Fityk.
	--The CO2D-MATRIX_EXPORT.lua script is used to export fitted parameters into a MATRICES. Useful for map creation. More info can be found in the README FOR SCRIPTS.txt file.

do --Script start
print("----------MATRIX EXPORT LOG----------")

--OPTIONS-- (CHECK BEFORE START)
	types = {"Acenter", "Bcenter", "Oband", "Voigt1", "Voigt2", "Voigt3", "Voigt4", "Voigt5", "Voigt6", "VoigtP", "VoigtD", "VoigtH", "VoigtS", "VoigtK"} -- LIST FOR FunctionType's for export. --Script does search for every type and option combination.
	parameters = {"height", "Area", "center", "FWHM", "shape"} -- LIST FOR parameter's for export. For example "Area", "center", "FWHM" can be used for Voigt, or "height" for Acenter, Bcenter, Ccenter, Oband.

	NumberOfPointsinRow = 16 -- Number of points in each row of a matrix
	MatrixFolder = string.format("/Users/meguka/Dropbox/CO2D-project-github/results/matrix") --Set path to the folder for Matrix export
	MetadataFolder = string.format("/Users/meguka/Dropbox/CO2D-project-github/results/matrix-metadata") -- Set path to the folder for Metadata export

--CYCLES START
	for j, Funtype in  ipairs(types) do --For all function types do:
		FunctionType = types[j]	 --Choose current function
	print("----------%s EXPORT LOG----------" % Funtype)	
	for i, Parameter in ipairs(parameters) do --For all parameter types do:
		ParameterForExport = parameters[i] --Choose current option

	FirstCall = true -- Variable to mark the first call and file creation. FirstCall exist for every types[j],  parameters[i] combination
	RowCounter = 0 -- Variable to count the points inside current row

	for n,f in F:all_functions() do --For all n-numbers, f-functions in function list do
--LUA FUNCTIONS--	
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

			function SearchForFunctionInsideArray(name) --Create lua function to search for function with "name" string inside title in array. All dataset models are inspected. 
				for i = 0, F:get_dataset_count()-1 do -- For all datasets
				F:execute ("use @%d" % i) -- Activate dataset
					if (string.match (F:get_info("F"), name)) == string.format(name) then -- if dataset model contains function with string "name"
					 	return i -- then return dataset number and end i-cycle (works like break)
					else end -- else end
				end	
				return nil
			end 

			function SearchForFunctionType( typetocheck) --Check if FunctionType is present in any function from any dataset
					for n,f in F:all_functions() do --For all n-numbers, f-functions in function list do
						if f:get_template_name() == typetocheck --Template is equal FunctionType (non Voigts)
						or f:get_template_name() == string.format("Voigt") and string.match(typetocheck, f:get_template_name()) ==  f:get_template_name() --Template is a substing inde FunctionType (Voigts)
						then return true end
					end	
			return false 
			end

--MAIN CODE SECTION--
		
		check, b = pcall(function() f:get_param_value("%s" % ParameterForExport) end)
		if check  == true  --check if current ParameterForExport exists for current f. If not - goto skipcycle.
		then 
				if FunctionTypeCheck() == FunctionType then --check if f type is the current type-cycle type. If not - goto skipcycle.
				-- print ("3 - %s, %s - function %s and parameter %s" % {check, b, n, ParameterForExport})  
				else 
				-- print ("2 - %s, %s - function %s and parameter %s.--- %s - %s  " % {check, b, n, ParameterForExport, FunctionTypeCheck(), FunctionType})
				 goto skipcycle end
		else 
		-- print ("1 - %s, %s - function %s and parameter %s" % {check, b, n, ParameterForExport}) 
		goto skipcycle end 

--FIRST CALL - FILE CREATION--	
			if FirstCall == true then -- Check if the cycle is first			
				filename= string.format((string.sub(F:get_info("title",1), 1,20))) -- Get filename
				F:execute ("set cwd = '%s'" % MatrixFolder) -- Load path
				OutputData = io.open("%s-MATRIX-%s-%s.csv" % {FunctionType, ParameterForExport, filename}, "w" ) -- Create file for Matrix data output. w- write mode, a - append mode
				F:execute ("set cwd = '%s'" % MetadataFolder) -- Load path
				OutputMeta = io.open("%s-METADATA-%s-%s.csv" % {FunctionType, ParameterForExport, filename}, "w" ) -- Create file for Matrix METAdata output. w- write mode, a - append mode

				OutputMeta:write(string.format("---This METADATA file contains corresponding dataset numbers (numbers of datasets from which function parameters used to create MATRIX file were taken)---\n")) --Write header into METADATA file
				OutputMeta:write(string.format("---Parameter %s for %s FunctionType in MATRIX with %s points in a row---\n" % {ParameterForExport, FunctionType, NumberOfPointsinRow})) --write about settings
				OutputMeta:write(os.date("---Created at %c---")) --write date and time
				OutputMeta:write(string.format("\n")) --Write new line (\n) 
				FirstCall = false -- Disable first call
			else end

-- --MAIN DATA PRINTING--	
			if FunctionTypeCheck() == FunctionType then -- If "FunctionType" checks
				OutputData:write((f:get_param_value("%s" % ParameterForExport))) --get parameter for export, write parameter and "; " into DATA file 
				OutputMeta:write(SearchForFunctionInsideArray(f.name)) --write dataset number for f.name into METADATA file 

				RowCounter = RowCounter+1 -- Row counter + 1
				if RowCounter ~= NumberOfPointsinRow then -- If row counter has reached the NumberOfPointsinRow then 
				OutputData:write(string.format(", ")) -- here because we don't need to print comma on the last point of row
				OutputMeta:write(string.format(", "))
				else -- else:
					OutputData:write(string.format("\n")) -- Write new line (\n) 
					OutputMeta:write(string.format("\n")) -- Write new line (\n) 
					RowCounter = 0 --reset row counter to 0
				end -- end 
			else end -- end if functiontype is not correct
		::skipcycle:: --Skip this cycle

	end --end for n,f-cycle
			if FirstCall == false then --If file was created then close it.
				OutputData:close() -- Close the output file	
				OutputMeta:close() -- Close the output file
				print ('Parameter and type combination was found. FILE WAS CREATED. [%s, %s] ' % {parameters[i], types[j]})
			else end

			if FirstCall == true then --If file was created then close it.
				print ('Parameter and type combination NOT found. File was not created. [%s, %s]' % {parameters[i], types[j]})
			else end
	end -- end function cycle
	end -- end parameters cycle
		::skipspectra:: -- flag to whole cycle	
end --Script end