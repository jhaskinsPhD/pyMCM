# -*- coding: utf-8 -*-
"""
Created on Tue Jan 18 18:06:39 2022

@author: jhask
"""
import os
from GEOSChem_Emulator import * 

# EXAMPLE: --------------------------------------------------------------
# Get path to the Emulator folder/ 
pth=  os.path.dirname(os.path.abspath(__file__))+'/'

# Read KPP file, make mechanism file.  
kppfile=pth+'input/fullchem.eqn' 
KPP_to_F0AM(kppfile, out_filename=pth+'output/GEOSChem_F0AM_mech.m') 
 
# Read rate file, make functions.  
rate_file=pth+'input/gckpp_Rates.F90' 
convert_gckpp_Rates_2_F0AM(rate_file, outfilename=pth+'output/gckpp_Rates.m') 
