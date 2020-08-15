#ABOUT THIS FILE
#This file contains some settings for CO2D-MAPGEN.ipynb script.
ax.set_aspect('equal') #Make pixels to have equal dimensions
# ax.set_xlabel('X coordinate') #set axis labels
# ax.set_ylabel('Y coordinate')
ax.set_xticklabels([]) #remove tick labels
ax.set_yticklabels([])
ax.get_xaxis().set_ticks([]) #remove ticks
ax.get_yaxis().set_ticks([])

if "-Area" in name:
    clb.ax.set_title('Integrated \n band area, cm$^{-2}$', size = 12) #add title above colorbar. size - font size
if "-FWHM" in name:
    clb.ax.set_title('FWHM,\n cm$^{-1}$', size = 12) #add title above colorbar. size - font size
if "-center" in name:    
    clb.ax.set_title('Center,\n cm$^{-1}$', size = 12) #add title above colorbar. size - font size
if "-height" in name:
    clb.ax.set_title('Peak height,\n cm-1', size = 12) #add title above colorbar. size - font size

if "VoigtK-MATRIX" in name: #If "VoigtK" is in name then set axis title.
    ax.set_title('Carbonates', size = 14) # Indentation matters for if construсtion.
if "VoigtH-MATRIX" in name: 
    ax.set_title('3107 cm$^{-1}$', size = 14)
if "VoigtD-MATRIX" in name: 
    ax.set_title('CO$_2$ ν3b', size = 14)
if "Voigt-1+2-MATRIX-Area" in name: 
    ax.set_title('CO$_2$ ν3b', size = 14)
if "Voigt3-MATRIX" in name: 
    ax.set_title('ν3a', size = 14)
if "Voigt4-MATRIX" in name: 
    ax.set_title('$^{13}$CO$_2$ ν3b', size = 14)    
if "Voigt5-MATRIX" in name: 
    ax.set_title('CO$_2$ ν2a', size = 14)
if "Voigt6-MATRIX" in name: 
    ax.set_title('CO$_2$ ν2b', size = 14)
if "VoigtS-MATRIX" in name: 
    ax.set_title('800 cm$^{-1}$', size = 14)
if "VoigtP-MATRIX" in name: 
    ax.set_title('Platelets', size = 14)
if "Voigt1-MATRIX-center" in name: #If "VoigtK" is in name then set axis title.
    ax.set_title('CO$_2$ ν3b', size = 14) # Indentation matters for if construсtion.
    
if "Acenter-MATRIX" in name: 
    ax.set_title('A-center', size = 14)
    if "-height" in name:
        clb.ax.set_title('N concentration,\n atomic ppm', size = 12) #add title above colorbar. size - font size
if "Bcenter-MATRIX" in name: 
    ax.set_title('B-center', size = 14)
    if "-height" in name:
        clb.ax.set_title('N concentration,\n atomic ppm', size = 12) #add title above colorbar. size - font size

if "Oband-MATRIX" in name: 
    ax.set_title('O-band', size = 14)
    if "-height" in name:
        clb.ax.set_title('Integrated \n band area, cm$^{-2}$', size = 14) #add title above colorbar. size - font sizeif "Oband" in name:
        
if contour == True:
    if "VoigtK-MATRIX-Area-FN7114" in name: #If "VoigtK" is in name then set axis title.
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[0.1, 0.2, 0.3], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %.1f ')
    elif "Acenter" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[25, 75, 125, 175], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
    elif "Bcenter" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[5, 20, 40, 50], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
    elif "VoigtH-MATRIX-Area-FN7114" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[1.9, 4, 6], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
    elif "Voigt6-MATRIX-Area-FN7112" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[1, 2, 3, 4], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
    elif "Voigt-1+2-MATRIX-Area-FN7112" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[50, 100, 150, 200], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
    elif "Voigt-1+2-MATRIX-Area-FN7114" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1.5), levels=[500, 600, 700], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f', inline_spacing=5)
    elif "Voigt4-MATRIX-center-FN7114" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[2300, 2302, 2304, 2306], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
    elif "Voigt4-MATRIX-Area-FN7114" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[3, 5, 7], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
        
    elif "VoigtP-MATRIX-Area-FN7114" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[5, 10, 20], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
    elif "Voigt1-MATRIX-center-FN7114" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[2371, 2372, 2373, 2374, 2375], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
    elif "VoigtK-MATRIX-Area-FN7112" in name: #If "VoigtK" is in name then set axis title.
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[0.1, 0.2, 0.3], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %.1f ')
    elif "VoigtD-MATRIX-FWHM-FN7114" in name: #If "VoigtK" is in name then set axis title.
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[25, 30, 35, 40, 45], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f ')
    elif "Voigt3-MATRIX-Area-FN7114" in name:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[10, 50, 100, 150, 175], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')        
    elif "B % map" in plotname:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[25, 30, 50], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
        ax.set_title('N aggregation: B/(A+B)', size = 14)
        clb.ax.set_title('%', size = 12)
        
    elif "FN7112 map truncated Pressure" in plotname:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[4], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %.1f')
        clb.ax.set_title('GPa', size = 12)
        ax.set_title('Caclulated pressure', size = 14)
        
    elif "FN7114 map truncated Pressure" in plotname:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[3.8, 4, 4.2, 4.4, 4.6, 4.8], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %.1f')
        clb.ax.set_title('GPa', size = 12)
        ax.set_title('Caclulated pressure', size = 14)
        
    elif "Voigt1-MATRIX-center-FN7112 map truncated.csv" in plotname:
        CS = ax.contour(gaussian_filter(datatoplot, 1), levels=[2370, 2371], colors='w')
        plt.clabel(CS, colors='w', inline=True, fontsize=10, fmt=' %1.0f')
        
    else:
        pass
        CS = ax.contour(gaussian_filter(datatoplot, 1.5), 4, colors='white')
        plt.clabel(CS, colors='white',inline=True, fontsize=10, fmt=' %1.0f ')
    
    