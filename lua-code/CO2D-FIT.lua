--ABOUT THIS SCRIPT--
	--This LUA script is used to process FTIR-spectra of CO2-rich diamonds in Fityk.	
	--It is one of the scripts created to automate spectra loading, fitting, exporting obtained parameters and exporting edited spectra.
	--Scripts are tested with Fityk 1.3.1. Scripts are run from Fityk.
	--The CO2D-FIT script is used for spectra fitting. More info can be found in the README FOR SCRIPTS.txt file.

do --Script start

--OPTIONS-- (CHECK BEFORE START)
	F:execute ("set fitting_method = mpfit") -- Set the fitting method.

--MAIN CODE SECTION--
	repeat mode = F:input ("Type one symbol to choose fitting mode:\n  2 (for CO2 V2);\n  3 (for CO2 V3);\n  h (for VN3H);\n  c (for Carbonates);\n  n (for A, B, C-centers and Platelets);\n  s (for 800 cm-1 band).") -- Script mode selection
	until  mode == "2" or mode == "3" or mode == "h" or mode == "c" or mode == "n" or mode == "s" -- Repeat until correct script mode is selected

	if mode == "n" then Cskip=F:input ("Skip C-centers? [y/n]") --Choose to C-centers in calculation
	else end

	if mode == "n" then Xskip=F:input ("Skip X-centers? [y/n]") --Choose to X-centers in calculation
	else end

	if mode == "3" then Dskip=F:input ("Skip V3b band COPY? Copy is useful for V3b FWHM calculation. [y/n]") --Choose to X-centers in calculation
	else end

	baselinemode=F:input ("Subtract and remove baseline? [y/n]") --Choose if baseline should be removed

	for j = 0, F:get_dataset_count()-1 do --For all j up to dataset amount
	F:execute ("use @%d" % j) --Choose spectra j
		if j == 0 then -- on the 0th cycle work with standard spectra 
		F:execute ("$StandartAbs2105 = {avg(y if x > 2100 and x < 2110)}") -- Get standard spectra absorption on w = 2105 cm-1
		F:execute ("$StandartAbs2020 = {avg(y if x > 2015 and x < 2025)}") -- Get standard spectra absorption on w = 2020 cm-1
		goto skipspectra --Skip all fitting for the standard spectra
		else end
 
--SAMPLE SPECTRA LINEAR TRANSFORMATION AND SUBTRACTION--
		for h = 1, 100 do --Begin the main cycle
			F:execute ("Y = y + $StandartAbs2105 - {avg(y if x > 2100 and x < 2110)}" % j) --Vertical shift
			F:execute ("Y = y*$StandartAbs2020/{avg(y if x > 2015 and x < 2025)}" % j) --Vertical stretch
			if math.abs(F:calculate_expr("$StandartAbs2105 - {avg(y if x > 2100 and x < 2110)}")) < 1E-6 --Check for convergence
			then print("######Spectrum %04d converged to standard in %d steps######" % {j, h}) break --If converged then print info into Fityk console and break
			else end 
		end
		F:execute ("@%d = @%d - @0" % {j, j}) --Subtraction of the standard spectrum. {j, j} is used to set the value of j in two places.

--CO2 V3 mode
		if mode == "3" then --Mode check
			F:execute ("A = x > 2250 and x < 2580") --Setting a wavenumber range.
			F:execute ("A = a and not (x > 2285 and x < 2500)") --Cut the wavenumber range.
			F:execute ("$spec%04d_inter = ~-2" % j) --Create the variable for the linear baseline function.
			F:execute ("$spec%04d_slope = ~0.001" % j) --Create the variable for the linear baseline function.
			F:execute ("guess %%Spec%04d_CO2_linear = Linear(a0=$spec%04d_inter, a1=$spec%04d_slope)" % {j, j, j}) --Guess the linear function.
			F:execute ("fit @%d" % j) --Fit
			F:execute ("$spec%04d_inter ={$spec%04d_inter}" % {j, j}) --Block the linear function parameters.
			F:execute ("$spec%04d_slope ={$spec%04d_slope}" % {j, j}) --Block the linear function parameters.

			if baselinemode == "y" then
						F:execute ("Y = y - %%Spec%04d_CO2_linear(x)" % j) --Subtract baseline
						F:execute ("delete %%Spec%04d_CO2_linear" % j) --delete baseline
			else end			

			F:execute ("A = x > 2250 and x < 2580") --Setting a wavenumber range.

			F:execute ("$spec%04d_h1 = ~10 [0:] " % j) --Variable for the height of Voigt1. Only physical restrictions > 0.
			F:execute ("$spec%04d_h2 = ~3 [0:] " % j) --Variable for the height of Voigt2. Only physical restrictions > 0.
			F:execute ("$spec%04d_c1 = ~2372  " % j) --Variable for the line center of V1 and V2. No restrictions.
			F:execute ("$spec%04d_s1 = 0" % j) --Variable for the shape. S = 0 means pure Gauss mode.
			F:execute ("$spec%04d_s2 = 0" % j) --Variable for the shape. S = 0 means pure Gauss mode.
			F:execute ("$spec%04d_w1 = ~4 [2:]" % j) --Variable for the line width of Voigt2. Only physical restrictions > 0.
			F:execute ("$spec%04d_w2 = ~10 [2:]" % j) --Variable for the line width of Voigt2. Only physical restrictions > 0.
			F:execute ("guess %%Spec%04d_Voigt1 = Voigt (height=$spec%04d_h1, center=$spec%04d_c1, shape=$spec%04d_s1, gwidth=$spec%04d_w1)" % {j, j, j, j, j}) --Guess Voigt1 function
			F:execute ("guess %%Spec%04d_Voigt2 = Voigt (height=$spec%04d_h2, center=$spec%04d_c1, shape=$spec%04d_s2, gwidth=$spec%04d_w2)" %{j, j, j, j, j}) --Guess Voigt2 function
			F:execute ("fit @%d" % j) --Fit

			F:execute ("$spec%04d_s3 = 0" % j) --Variable for the shape. S = 0 means pure Gauss mode.
			F:execute ("$spec%04d_h3 = ~3 [0:] " % j) --Variable for the height. Only physical restrictions > 0.
			F:execute ("$spec%04d_w3 = ~30 [2:40]" % j) --Variable for the line width. RESTRICTIONS FOR BETTER FIT
			F:execute ("$spec%04d_c3 = ~2415 [2410:2430]" % j) --Variable for the line center. RESTRICTIONS FOR BETTER FIT
			F:execute ("guess %%Spec%04d_Voigt3 = Voigt (height=$spec%04d_h3, center=$spec%04d_c3, shape=$spec%04d_s3, gwidth=$spec%04d_w3)" % {j, j, j, j, j}) --Guess Voigt3 function
			
			F:execute ("$spec%04d_c4 = ~2300 [2290:2310]" % j) --Variable for the line center. RESTRICTIONS FOR BETTER FIT
			F:execute ("$spec%04d_h4 = ~2 [0:] " % j) ---Variable for the height. Only physical restrictions > 0.
			F:execute ("$spec%04d_s4 = 0" % j) --Variable for the shape. S = 0 means pure Gauss mode.
			F:execute ("$spec%04d_w4 = ~2 [0:10]" % j) --Variable for the line width. RESTRICTIONS FOR BETTER FIT
			F:execute ("guess %%Spec%04d_Voigt4 = Voigt (center=$spec%04d_c4, height=$spec%04d_h4, shape=$spec%04d_s4, gwidth=$spec%04d_w4)" % {j, j, j, j, j}) --Guess Voigt4 function
			F:execute ("guess %%Spec%04d_CO2GasV3 = CO2GasV3" % {j}) --Guess CO2gas in V3 area
			F:execute ("fit @%d" % j) --Fit

--Sum V3b peak creation. That is the copy of v3 and v2 bands created For easy export. It has FWHM calculated from V1 and V2 and correct center but its AREA = o so it does not affect fit.
			if Dskip ==  "n" then -- If COPY is not skiped

				HalfmaxValue = (F:calculate_expr("(y[index($spec%04d_c1)])/2" % j)) --calculate half maximum of model
				HalfmaxPosition = (F:calculate_expr("F.findx(2300, 2370, %s)" % HalfmaxValue)) --calculate postion of left half maximum
				FWHM = (F:calculate_expr("2*($spec%04d_c1-%s)" % {j, HalfmaxPosition})) --calculate FWHM of V1+V2
				F:execute ("$spec%04d_wD = %s*0.8" % {j,FWHM}) -- VoigtD ("double peak") gwidth
				F:execute ("$spec%04d_cD = $spec%04d_c1" % {j, j}) -- double peak maximum
				F:execute("$spec%04d_sD = 0" % {j}) -- double peak shape
				F:execute("$spec%04d_hD = 0" % {j}) -- double peak height
				F:execute ("guess %%Spec%04d_VoigtD = Voigt (center=$spec%04d_cD, shape=$spec%04d_sD, gwidth=$spec%04d_wD, height=$spec%04d_hD)" % {j, j, j, j, j}) --Guess VoigtD function
            else end
		else end
--CO2 V2 mode
		if mode == "2" then --Mode check
			F:execute ("A = x > 630 and x < 690") --Setting a wavenumber range.
			F:execute ("A = a and not (x > 640 and x < 680)") --Cut the wavenumber range.
			F:execute ("$spec%04d_inter = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("$spec%04d_slope = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("guess %%Spec%04d_CO2_linear = Linear(a0=$spec%04d_inter, a1=$spec%04d_slope)" % {j, j, j}) --Guess the linear function.
			F:execute ("fit @%d" % j) --Fit

			if baselinemode == "y" then
						F:execute ("Y = y - %%Spec%04d_CO2_linear(x)" % j) --Subtract baseline
						F:execute ("delete %%Spec%04d_CO2_linear" % j) --delete baseline
			else end			
			F:execute ("A = x > 635 and x < 685") --Setting a wavenumber range.

			F:execute ("$spec%04d_h5 = ~1 [0:] " % j)
			F:execute ("$spec%04d_h6 = ~0.5 [0:] " % j)
			F:execute ("$spec%04d_s5 = 0" % j)
			F:execute ("$spec%04d_s6 = 0" % j)
			F:execute ("$spec%04d_w5 = ~1 [1:]" % j) 
			F:execute ("$spec%04d_w6 = ~1 [1:3]" % j)
			F:execute ("$spec%04d_c5 = ~660 []" % j)
			F:execute ("$spec%04d_c6 = ~650 [645:652]" % j)

			F:execute ("guess %%Spec%04d_Voigt5 = Voigt (height=$spec%04d_h5, shape=$spec%04d_s5, gwidth=$spec%04d_w5,  center=$spec%04d_c5)" % {j, j, j, j, j})
			F:execute ("guess %%Spec%04d_Voigt6 = Voigt (height=$spec%04d_h6, shape=$spec%04d_s6, gwidth=$spec%04d_w6, center=$spec%04d_c6)" % {j, j, j, j, j})
			F:execute ("guess %%Spec%04d_CO2GasV2 = CO2GasV2" % {j}) --Guess CO2gas in V2 area
			F:execute ("fit @%d" % j) --Fit
		else end

--VN3H mode (3107 cm-1)
		if mode == "h" then --Mode check
			F:execute ("A = x > 3080 and x < 3132") --Setting a wavenumber range.
			F:execute ("A = a and not (x > 3096 and x < 3116)") --Cut the wavenumber range.
			F:execute ("$spec%04d_inter = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("$spec%04d_slope = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("guess %%Spec%04d_CO2_linear = Linear(a0=$spec%04d_inter, a1=$spec%04d_slope)" % {j, j, j}) --Guess the linear function.
			F:execute ("fit @%d" % j) --Fit
			F:execute ("$spec%04d_inter ={$spec%04d_inter}" % {j, j}) --Block the linear function parameters.
			F:execute ("$spec%04d_slope ={$spec%04d_slope}" % {j, j}) --Block the linear function parameters.

			if baselinemode == "y" then
						F:execute ("Y = y - %%Spec%04d_CO2_linear(x)" % j) --Subtract baseline
						F:execute ("delete %%Spec%04d_CO2_linear" % j) --delete baseline
			else end			
			F:execute ("A = x > 3080 and x < 3132") --Setting a wavenumber range.
			F:execute ("$spec%04d_sH = 1 " % j) -- Variable for the shape.
			F:execute ("guess %%Spec%04d_VoigtH =Voigt (shape=$spec%04d_sH)" % {j, j})

			F:execute ("fit")

		else end

--Nitrogen and Platelets mode
		if mode == "n" then --Mode check
			F:execute ("A = x > 830 and x < 1430") --Setting a wavenumber range.
			F:execute ("A = a and not (x > 910 and x < 1410)") --Cut the wavenumber range.
			F:execute ("$spec%04d_inter = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("$spec%04d_slope = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("guess %%Spec%04d_CO2_linear = Linear(a0=$spec%04d_inter, a1=$spec%04d_slope)" % {j, j, j}) --Guess the linear function.
			F:execute ("fit @%d" % j) --Fit
			F:execute ("$spec%04d_inter ={$spec%04d_inter}" % {j, j}) --Block the linear function parameters.
			F:execute ("$spec%04d_slope ={$spec%04d_slope}" % {j, j}) --Block the linear function parameters.

			if baselinemode == "y" then --if baseline mod is activated then:
						F:execute ("Y = y - %%Spec%04d_CO2_linear(x)" % j) --Subtract baseline
						F:execute ("delete %%Spec%04d_CO2_linear" % j) --delete baseline
			else end

			-- xnmax = F:calculate_expr("argmax(y if x > 900 and x < 1400)" % j) -- Arg of x maximum in nitrogen zone
			-- if xnmax  < 1150 then -- Check for if silicate-like band is seen.
			-- print ("Arg of x maximum in nitrogen zone - %s is < 1150 cm-1. Using fit with high-freq border." % xnmax)
			F:execute ("A = x > 1260 and x < 1400") --Setting a wavenumber range.
			-- else
			-- print ("Arg of x maximum in nitrogen zone is %s." % xnmax)
			-- F:execute ("A = x > 900 and x < 1400") --Setting a wavenumber range.
			-- end
			
			F:execute ("$spec%04d_hO = ~1 [0:]" % j) -- Create the variable for the B-center height

			F:execute ("$spec%04d_hB = ~1 [0:]" % j) -- Create the variable for the B-center height

			F:execute ("$spec%04d_hA = ~1 [0:]" % j) -- Create the variable for the A-center height

			F:execute ("guess %%Spec%04d_A = Acenter (height=$spec%04d_hA)" % {j, j}) --Create A-center function
			F:execute ("guess %%Spec%04d_B = Bcenter (height=$spec%04d_hB)" % {j, j}) --Create B-center function
			F:execute ("guess %%Spec%04d_O = Oband (height=$spec%04d_hO)" % {j, j}) --Create A-band function

			if Cskip == "n" then  --If C-centers fit is requested then
				F:execute ("$spec%04d_hC = ~1 [0:]" % j) -- 
				F:execute ("guess %%Spec%04d_C = Ccenter (height=$spec%04d_hC)" % {j, j}) --C band is enabled only if Cmode = n
			else end
			if Xskip == "n" then  --If C-centers fit is requested then
				F:execute ("$spec%04d_hX = ~1 [0:]" % j) -- 
				F:execute ("guess %%Spec%04d_X = Xcenter (height=$spec%04d_hX)" % {j, j}) --X band is enabled only if Xmode = n
			else end

			F:execute ("fit @%d" % j) --Fit
			if F:calculate_expr("$spec%04d_hB" % j) < 2 --Logic function for Platelets. Platelets height is nonzero only if B-center absorption is > 2 cm-1.
			then F:execute ("$spec%04d_hP = 0" % j) else --
			F:execute ("$spec%04d_hP = ~1 [0:]" % j)
			end

			F:execute ("$spec%04d_sP = 0" % j)
			F:execute ("$spec%04d_cP = ~1365 [1350:1400]" % j)
			F:execute ("guess %%Spec%04d_VoigtP =Voigt (shape=$spec%04d_sP,center=$spec%04d_cP, height=$spec%04d_hP )" % {j, j, j, j}) -- Create platelets voigt function
			F:execute ("fit @%d" % j) --Fit
		else end

--Carbonates mode
		if mode == "c" then --Mode check
			F:execute ("A = x > 860 and x < 880") --Setting a wavenumber range.
			F:execute ("A = a and not (x > 865 and x < 875)") --Cut the wavenumber range.
			F:execute ("$spec%04d_inter = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("$spec%04d_slope = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("guess %%Spec%04d_CO2_linear = Linear(a0=$spec%04d_inter, a1=$spec%04d_slope)" % {j, j, j}) --Guess the linear function.
			F:execute ("fit @%d" % j) --Fit
			F:execute ("$spec%04d_inter ={$spec%04d_inter}" % {j, j}) --Block the linear function parameters.
			F:execute ("$spec%04d_slope ={$spec%04d_slope}" % {j, j}) --Block the linear function parameters.
			F:execute ("A = x > 860 and x < 880") --Setting a wavenumber range.

			if baselinemode == "y" then
						F:execute ("Y = y - %%Spec%04d_CO2_linear(x)" % j) --Subtract baseline
						F:execute ("delete %%Spec%04d_CO2_linear" % j) --delete baseline
			else end			

			F:execute ("$spec%04d_sK = 0" % j) -- 
			F:execute ("$spec%04d_wK = ~ 2 [1:3]" % j) -- RESTRICTIONS FOR BETTER FIT
			F:execute ("$spec%04d_cK = ~ 868 [860:880]" % j) -- RESTRICTIONS FOR BETTER FIT
			F:execute ("$spec%04d_hK = ~1 [0:]" % j) -- Only physical restrictions > 0.
			F:execute ("guess %%Spec%04d_VoigtK = Voigt (shape=$spec%04d_sK, gwidth=$spec%04d_wK, center=$spec%04d_cK, height=$spec%04d_hK)" % {j, j, j, j, j})
			F:execute ("fit @%d" % j) --Fit
		else end

--Silicates? 800 cm-1 band mode. 
		if mode == "s" then --Mode check
			F:execute ("A = x > 770 and x < 860") --Setting a wavenumber range.
			F:execute ("A = a and not (x > 780 and x < 840)") --Cut the wavenumber range.
			F:execute ("$spec%04d_inter = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("$spec%04d_slope = ~0" % j) --Create the variable for the linear baseline function.
			F:execute ("guess %%Spec%04d_CO2_linear = Linear(a0=$spec%04d_inter, a1=$spec%04d_slope)" % {j, j, j}) --Guess the linear function.
			F:execute ("fit @%d" % j) --Fit
			F:execute ("$spec%04d_inter ={$spec%04d_inter}" % {j, j}) --Block the linear function parameters.
			F:execute ("$spec%04d_slope ={$spec%04d_slope}" % {j, j}) --Block the linear function parameters.

			if baselinemode == "y" then
				F:execute ("Y = y - %%Spec%04d_CO2_linear(x)" % j) --Subtract baseline
				F:execute ("delete %%Spec%04d_CO2_linear" % j) --delete baseline
			else end			

			F:execute ("$spec%04d_sS = 0" % j) -- 
			F:execute ("$spec%04d_wS = ~15 [0:]" % j)
			F:execute ("A = x > 770 and x < 860") --Setting a wavenumber range.
			F:execute ("guess %%Spec%04d_VoigtS =Voigt (shape=$spec%04d_sS, gwidth=$spec%04d_wS)" % {j, j, j})
			F:execute ("fit @%d" % j) --Fit
		else end
			::skipspectra:: -- flag to skip iteration of cycle
	end --Cycle end
end --Script end