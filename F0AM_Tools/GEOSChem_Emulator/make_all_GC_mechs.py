# -*- coding: utf-8 -*-
"""
Created on Thu Jun 16 11:22:00 2022

@author: jhask
"""

import os 
import sys 
import numpy as np

from set_my_paths import add_to_path, get_path_to
add_to_path(sys.path, ['F0AM_mech_IO', 'pyMCM_utils','GEOSChem_Emulator'])
from F0AM_mech_IO import * 
from pyMCM_utils import * 
from GEOSChem_Emulator import *

remove_old=True
pth=get_path_to('desktop')+'GC_Mech_Files\\'

for version in list(os.listdir(pth)): 
    if 'database' not in version: 
        # Strip out version numbers so we can 
        ver=version.split('-')[2].split('.'); vx=np.int64(ver[0]); vy=np.int64(ver[1]); 
        
        for mech in list(os.listdir(pth+version+'\\')): 
            if vx ==13 and vy>=3: 
                # V 13.3.0 and later moved rate functions out of gckpp_Rates/ gckpp_HetRates and into these files instead:
                rate_file=pth+version+'\\'+mech+'\\'+mech+'_RateLawFuncs.F90'
                het_file=pth+version+'\\'+mech+'\\'+mech+'_RateLawFuncs.F90'
            else:
                rate_file=pth+version+'\\'+mech+'\\gckpp_Rates.F90'
                het_file=pth+version+'\\'+mech+'\\gckpp_HetRates.F90'
                
            has_eqn = os.path.exists(pth+version+'\\'+mech+'\\'+mech+'.eqn')
            has_rates = os.path.exists(rate_file)
            has_het = os.path.exists(het_file)
            
            if has_rates and has_eqn: 
                print('Making mechanism for... ', version+'\\'+mech) 
                
                # Create a F0AM folder in this mechanism if it doesn't exist. 
                if not os.path.isdir(pth+version+'\\'+mech+'\\F0AM'): os.mkdir(pth+version+'\\'+mech+'\\F0AM') 
                
                if remove_old==True: #Delete all Existing Files in ALL F0AM Folders:
                    for file in os.scandir(pth+version+'\\'+mech+'\\F0AM'):
                        os.remove(file.path)
                        
                # Get existing file names if there are any in the F0AM mech & figure out what the last version saved was so don't overwrite.
                eqf=[np.int64('.'.join(f.split('.')[:-1]).split('_eqns')[1]) for f in list(os.listdir(pth+version+'\\'+mech+'\\F0AM')) if (('.' in f) and ('_eqns' in f))]
                eqr=[np.int64('.'.join(f.split('.')[:-1]).split('_rates')[1]) for f in list(os.listdir(pth+version+'\\'+mech+'\\F0AM')) if (('.' in f) and ('_rates' in f))]
                last_eq=np.int64(-1) if len(eqf)==0 else np.nanmax(eqf)
                last_rt=np.int64(-1)  if len(eqr)==0 else np.nanmax(eqr)
                
                # Name & path of the KPP --> F0AM mechanism  & gckpp_Rates --> Rates function. 
                eqn_fnm=pth+version+'\\'+mech+'\\F0AM\\GC_'+mech.lower()+'_v'+(version.split('-')[2]).replace('.','_')+'_eqns'+str(last_eq+1)+'.m'
                rate_fnm=pth+version+'\\'+mech+'\\F0AM\\GC_'+mech.lower()+'_v'+(version.split('-')[2]).replace('.','_')+'_rates'+str(last_rt+1)+'.m'
                
                #Read KPP file, make mechanism file.  
                KPP_to_F0AM(pth+version+'\\'+mech+'\\'+mech+'.eqn', out_filename=eqn_fnm) 
             
                #Read rate file, make functions.  
                convert_gckpp_Rates_2_F0AM(rate_file, outfilename=rate_fnm) 
                print('\n')
