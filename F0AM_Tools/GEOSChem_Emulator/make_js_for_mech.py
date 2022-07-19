# -*- coding: utf-8 -*-
"""
Created on Wed Jul  6 17:07:40 2022

@author: jhask
"""
import numpy as np 
import pandas as pd 
from csv import reader
import sys 
import os 

from set_my_paths import add_to_path, get_path_to
add_to_path(sys.path, ['F0AM_mech_IO'])
from F0AM_mech_IO import sep_stoich_vs_tracer, read_F0AM_mech

def read_FJX_j2j(file): 
    out= pd.read_fwf(file, skip_rows=[1,2], widths=[5,10,10,34,6,8]) 
    out= out.drop(index=len(out)-1); # Drop nan column. 
    names=list(out.columns);  # Get weird column names. 
    
    out=out.rename(columns={names[0]:'FJX_Index',  #This is the internal index used by Fast-JX, & the number you need when indexing PHOTOL!   
                            names[1]:'Photolysis_Of', # T he GEOS-Chem species that will undergo photolysis.
                            names[2]:'PHOTON', # This just makes clear that the reaction is photolysis.
                            names[3]:'Into', # Products of this specific photolysis reaction ...
                            names[4]:'Quantum_Yield', # This is the quantum yield of the reaction. Specifically, it is a flat multiplier applied to the first-order rate returned by Fast-JX for this reaction specifically.
                            names[5]:'FJX_CrossSec'}) # his is the cross-section (from FJX_spec.dat) which will be used to calculate the first-order reaction rate.
        
    # Join stuff together so its a photolysis reaction that makes sense... 
    out['Photolysis_Rxn']= [str(out.loc[ind, 'Photolysis_Of'])+ '+hv -> '+'+'.join( [prd.replace('...','') for prd in str(out.loc[ind, 'Into']).split(' ') if len(prd) >0]) for ind in range(0, len(out))]
    
    # Clean up cross section used column: 
    out['FJX_CrossSec']=out['FJX_CrossSec'].apply(lambda x: x.replace(' ', '').replace('/', '').replace('(', '').replace(')', '').replace('-', ''))

    out=out.drop(columns=[ 'Photolysis_Of', 'PHOTON','Into'])
    
    return out

def assign_from_dbase(cmpd_list, dbase): 
    """Return a list.string of InChI(s) from a database for a list/string of (a) compound(s). """  
    if type(cmpd_list)==str: cmpd_list=[cmpd_list]
    
    ls=list();
    for item in cmpd_list:
        if item in dbase.index:
            match= dbase['InChI'].loc[item]
             # Sometimes get 2 matches. Combine them removing common InChI strings. 
            if type(match)!= str and len(match) > 1: 
                these=[]
                for matches in list(dbase['InChI'].loc[item]):
                    if matches not in these:
                        if ';' not in matches: these.append(matches) 
                        else: 
                            [these.append(mtch) for mtch in matches.split(';') if mtch not in these ]
                these=';'.join(these) if len(these)>1 else these[0]
                ls.append(these)
            else: 
                ls.append(match)
        else:
            ls.append('')
    
    return ls 

def split_rxns(df, column_name, dbase):
    df['photo_of']=list([''])*len(df); 
    df['of_INCHI']=list([''])*len(df); 
    df['into']=list([''])*len(df); 
    df['into_INCHI']=list([''])*len(df); 
    
    for indy,rx in enumerate(df[column_name]): 
        rxx= rx.replace(' ', '').split('->')
            
        of_cmpds, of_stoich=sep_stoich_vs_tracer(rxx[0], seps='+')
        if len(rxx) > 1: 
            into_cmpds, into_stoich= sep_stoich_vs_tracer(rxx[1], seps='+')  
        else: 
            into_cmpds=['']
            
        # Remove any "PRODUCTS" tags...
        [into_cmpds.pop(into_cmpds.index(item))  for item in into_cmpds.copy() if'product' in item.lower() and item in into_cmpds]
           
        df.at[indy, 'photo_of']=of_cmpds
        df.at[indy, 'into']=into_cmpds
        df.at[indy, 'of_INCHI']=assign_from_dbase(of_cmpds, dbase)
        df.at[indy, 'into_INCHI']=assign_from_dbase(into_cmpds, dbase)

    return df

def define_j_values(version,j2j_file, cs, col2use='Emulator_Value'): 
    
    # Read in info about what Photolysis Rxns are Defined in this FJX File:       
    fjx= read_FJX_j2j(j2j_file);     
    fjx['J-Name']= list([''])*len(fjx)  # Create an empty list-like column to hold J-values... 
    
    # Assign J-Values in mechanism based on the Cross-Section used in FAST-JX: 
    for ind in fjx.index: # All data is defined in the dataframe CS for this matching.
        csect_need=fjx.loc[ind,'FJX_CrossSec'] # Cross-Section we need a J-Value for... 
        
        # Get Index in dataframe, cs, where that's defined: 
        has=cs.index[cs['FJX_Cross_Section']==csect_need]
        
        if len(np.unique(cs.loc[has,col2use]))==1: # If we have a match 
            fjx.at[ind,'J-Name']=np.unique(cs.loc[has,col2use])[0]# Then use that in the df. 

    return fjx 
    

# Get FJX-Cross Section --> MCM J-Value Mapping done in do_jval_mapping.py
cs=pd.read_excel(get_path_to('Desktop')+'GC_Mech_Files\\database\\fjx_cross_sect_to_jvalues.xlsx').fillna('') 

# Make a Dictionary defining what version fof FJX files are used as CHEM_INPUTS for each GC cersion w/ gc version as key 
vfjx=pd.read_excel(get_path_to('pyMCM')+'F0AM_Tools/GEOSChem_Emulator/FJX_input_by_GC-verison.xlsx', index_col=0).to_dict()['FAST-JX-INPUT']


# Loop over ALL versions of GEOS-Chem mechanisms... 
pth=get_path_to('desktop')+'GC_Mech_Files\\'
for folder in list(os.listdir(get_path_to('desktop')+'GC_Mech_Files\\')):
    if 'database' not in folder:                      # folder = 'geos-chem-12.9.3'
        version= folder.split('-')[2]                 # version = 12.9.3
        ver=version.split('.');                       # ver= [12,9,3],  
        for mech in list(os.listdir(pth+folder+'\\')): 
            
            if version in vfjx.keys(): # Get what FJX file is used as chem input for this GEOS-Chem Version: 
                j2j_file= get_path_to('Desktop')+'FAST_JX_Files\\'+vfjx[version]+'\\FJX_j2j.dat'
            else: 
                print('Version ',version,' not found in dictionary defniing its corresopnding FJX chem input file...') 
                sys.exit()
                
            # Assign J-Values in mechanism based on the Cross Section used in FAST-JX: 
            js=define_j_values(version,j2j_file, cs, col2use='Emulator_Value')
             
            # Name of the corresponding F0AM mechanism file generated in the Emulator: 
            eqn_fnm=pth+folder+'\\'+mech+'\\F0AM\\GC_'+mech.lower()+'_v'+version.replace('.','_')+'_eqns0.m'
            
            # Read in F0AM mechanism and get info on species are used in this version of GEOS-Chem's mechanism 
            f= read_F0AM_mech(eqn_fnm,  check=True)
            [n_species, n_rxns, species, ro2, rxn, k, g, f, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds] =f

            
            
