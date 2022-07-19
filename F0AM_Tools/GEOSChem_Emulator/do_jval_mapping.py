# -*- coding: utf-8 -*-
"""
Created on Fri Feb  4 15:53:03 2022

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

def read_FJX_spec_dat(file) : 
    """Function to read in the FJX_spec.dat file from GEOS-Chem as a pandas df with 
    the wavelengths as the column names and the species_temp as the row. """ 

    # w-eff=  Centres of wavelength bins - 'effective wavelength'
      
    # SOL : Solar flux incident on top of atmosphere (cm-2.s-1)
      
    # REAL(fp)             :: QO2(WX_,3)   ! QO2: O2 cross-sections
    # REAL(fp)             :: QO3(WX_,3)   ! QO3: O3 cross-sections
    # REAL(fp)             :: Q1D(WX_,3)   ! Q1D: O3 => O(1D) quantum yield
      
    # Supplied cross sections in each wavelength bin (cm2)
    # RAYLAY : Rayleigh parameters (effective cross-section) (cm2)
    # Headernames contain _ T or P ... : Temperature for supplied cross sections

    # Open file, figure out where cross-section data begins and ends: 
    with open(file, 'r') as read_obj:
        csv_reader = reader(read_obj)
        n=0; data_end=np.inf
        for row in csv_reader:
            line= ' '.join(row)
            if 'weff' in line.replace('-', '').lower() and n < data_end: data_begin=n 
            if 'endofj' in line.replace(' ', '').lower(): data_end=n; 
            n=n+1
        file_end=n; 
        
    # List of indices of rows in the file we want to skip (headers + comments at end!) 
    to_skip=[ind for ind in range(0, file_end) if ind < data_begin or ind>=data_end]
        
    # Use pandas fixed with file to read in data. 
    out= pd.read_fwf(file, header=None, skiprows=to_skip, widths=[6,4,10,10,10,10,10,10,12]) 
    out=out.T # transpose so wavelengths are the rows (for now). 
    
    # Loop over the stuff and clean it up into a dataframe arranged appropriately 
    # since the fwf file had columns over several rows... 
    new=dict({});  new_dat=[]; varname= '' 
    col_ns= out.columns
    for i in out.columns: 
        if np.mod(np.int64(i),3)==0: 
            if i!= 0: 
                new[varname]=new_dat;  
                new_dat=[]; varname= '' 
            
            varname=str(out.iloc[0,i])+'_'+ str(out.iloc[1,i])
            new_dat=list(out.iloc[2:-1,i])
        else: 
            new_dat=new_dat+list(out.iloc[2:-1,i])
            
    # Create a dataframe from the dict we built! 
    df_out=pd.DataFrame(new) 
    
    return df_out 
        

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
    
    # Stick a j in front of the cross section used to define a "nickname"... 
    out['J-NickName']= out['FJX_CrossSec'].apply(lambda x: 'j'+str(x))

    out=out.drop(columns=[ 'Photolysis_Of', 'PHOTON','Into'])
    #out= out.sort_values('FJX_CrossSec') 
    
    return out


def get_all_photolysis_rxns(f0am_mechanism): 
    """Function to read in a F0AM compliant mechanism, and retrieve lists of the reactions and rates
    of all photolysis reactions."""
    
    f= read_F0AM_mech(f0am_mechanism,  check=True) # Read in mech and seperate out prods/rcts/yields. 
    [n_species, n_rxns, species, ro2, rxn, k, g, f, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds] =f
    
    # Get index of rxns where +hv is in it or where "J" is contained in the reaction rate... 
    photo_inds=[i for i,k_i in  enumerate(k) if 'J' in k_i or 'hv' in rxn[i]]
    
    hv_rxns =[ '+'.join(rct_cmpds[p]+['hv'])+'->'+ '+'.join(prd_cmpds[p])  for p in photo_inds]
    hv_rates=[k[p].split('=')[1].split(';')[0] for p in photo_inds]
    
    return hv_rxns, hv_rates


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
    
            
def add_or_append(df,row, col, value): 
    
    if df.loc[row,col] != '': 
        df.at[row,col]=df.loc[row,col]+ ','+ value
    else: 
        df.at[row,col]=value
        
    return df                 


def find_all_j_matches(j_default, j_gc, db, quiet:bool=True): 
    j_default['J-Name']= list([''])*len(j_default)
    j_default['Type_Match']= list([''])*len(j_default)
    j_default['Rxn_Matched']= list([''])*len(j_default)
    for cross_sect in j_gc.index:
        
        # Make a new df for each cross section to list all possible Rxns ... 
        gc_opts=pd.DataFrame({'Rxns':j_gc.loc[cross_sect,'Rxns']})
        gc_opts=split_rxns(gc_opts, 'Rxns', db)
        
        for gc in range(0,len(gc_opts)):  # Loop over all the rxns we have in the FJX file & GC mech file 
            for mc in range(0, len(j_default)): # and compare to the default in the MCM J-Values... 

                # -----Compare INCHI codes for all REACTANTS of the photolysis reactions:-------------
                rtf_1= all([rct_inchi in j_default.loc[mc,'of_INCHI'] if rct_inchi != '' else False for rct_inchi in gc_opts.loc[gc,'of_INCHI']])
                rtf_2= all([rct_inchi in gc_opts.loc[gc,'of_INCHI'] if rct_inchi != '' else False for rct_inchi in j_default.loc[mc,'of_INCHI']])
                rct_match=True  if ((rtf_1==True) and (rtf_2==True)) else False 
                
                # -----Compare INCHI codes for all PRODUCTS of the photolysis reactions:-------------
                # ptf_1 = All gc_opts Products are produced in the matched corresponding j_default Photolysis reaction: 
                ptf_1= all([prd_inchi in j_default.loc[mc,'into_INCHI']  if ((prd_inchi != '') or ('product' in gc_opts.loc[gc,'into'][o].lower())) else False  for o,prd_inchi in enumerate(gc_opts.loc[gc,'into_INCHI'])])
                
                # ptf_1 = All j_default Products are produced in the matched corresponding gc_opts Photolysis reaction: 
                ptf_2= all([prd_inchi in gc_opts.loc[gc,'into_INCHI']  if ((prd_inchi != '') or ('product' in j_default.loc[mc,'into'][o].lower())) else False for o,prd_inchi in enumerate(j_default.loc[mc,'into_INCHI'])])
                
                prd_match=True if ((ptf_1==True) and (ptf_2==True)) else False 
                # if rct_match ==True and prd_match == False and any([ptf_1,ptf_2]):
                #     prd_match=True
                #     print('Allowing exact Matches for the following:')
                #     print(j_default.loc[mc,'Reaction'], '\n', gc_opts.loc[gc, 'Photolysis_Rxn'])
                
                if all([rct in j_default.loc[mc,'photo_of'] for rct in gc_opts.loc[gc,'photo_of']])and \
                   all([prd in j_default.loc[mc,'into'] for prd in gc_opts.loc[gc,'into']]): 
                    # Exact Match if all the reactants and all the products are identical between Rxns:
                    j_default= add_or_append(j_default,mc,'J-Name',cross_sect)
                    j_default= add_or_append(j_default,mc,'Type_Match','Exact-str') 
                    j_default= add_or_append(j_default,mc,'Rxn_Matched', str(gc_opts.loc[gc,'Rxns'])) 
               
                elif rct_match == True and prd_match ==True: 
                    # Exact Match if all the  InChI Codes Match! 
                    j_default= add_or_append(j_default,mc,'J-Name',cross_sect)
                    j_default= add_or_append(j_default,mc,'Type_Match','Exact-InChI') 
                    j_default= add_or_append(j_default,mc,'Rxn_Matched', str(gc_opts.loc[gc,'Rxns'])) 
                
                elif rct_match == True and any([ptf_1,ptf_2]):
                     # Partial Match if all the Reactants match, but only some of the Prds do 
                    j_default= add_or_append(j_default,mc,'J-Name',cross_sect)
                    j_default= add_or_append(j_default,mc,'Type_Match','Reactants_&_Some_Prds') 
                    j_default= add_or_append(j_default,mc,'Rxn_Matched', str(gc_opts.loc[gc,'Rxns'])) 
                
                elif rct_match == True and not any([ptf_1,ptf_2]):
                    # RCT_Only Match if all the Reactants match, but no products do 
                    j_default= add_or_append(j_default,mc,'J-Name',cross_sect)
                    j_default= add_or_append(j_default,mc,'Type_Match','Reactants_Only') 
                    j_default= add_or_append(j_default,mc,'Rxn_Matched', str(gc_opts.loc[gc,'Rxns'])) 
                
    # If you got more than one match, then throw away the less good matches 
    unassigned=list(j_gc.index)+['NO3','MPN','PAN','HNO4','MeVK','BrNO3','MeAcr']
    for pref in ['Exact-str','Exact-InChI','Reactants_&_Some_Prds', 'Reactants_Only']: 
        for i in j_default.index: 
            # Split all the results for this J val into lists: 
            types=j_default.loc[i,'Type_Match'].split(',') 
            names=j_default.loc[i,'J-Name'].split(',')
            rxns=j_default.loc[i,'Rxn_Matched'].split(',')
                
            # Re-define values based on preferences.  
            if pref in types: 
                j = types.index(pref)
                if names[j] in unassigned:
                    j_default.at[i,'Type_Match']=types[j] 
                    j_default.at[i,'J-Name']=names[j]
                    j_default.at[i,'Rxn_Matched']=rxns[j]
                    unassigned.pop(unassigned.index(names[j]))

    # Choose only the columns we care to return
    out=j_default[['J_Value','MCM_Rxn','Rxn_Matched','J-Name', 'GEOS-Chem/New','Type_Match']]
    missing= [cross_sect for cross_sect in j_gc.index if cross_sect not in list(out['J-Name'])]
    
    
    
    return out, missing

# Get all Info about MCM items 
mcm=pd.read_excel(get_path_to('combine_MCM_RCIM')+'Combined_Mech_Data\\info_all_particles.xlsx', engine='openpyxl', index_col=0)
mcm=mcm.rename(columns={'Molecular_Weight':'MW'})
# Get info about all GEOS-Chem tracers: 
gcdb=pd.read_excel(get_path_to('Desktop')+'GC_Mech_Files\\database\\GC_database_final.xlsx', index_col=0)
gcdb['Name']=gcdb.index
# Get info about all FAST-JX specific tracers: 
fjdb=pd.read_excel(get_path_to('Desktop')+'GC_Mech_Files\\database\\fast_jx_database.xlsx', index_col=0)
fjdb['Name']=fjdb.index

# Combine them into one giant database ... 
db=pd.concat([gcdb, fjdb,mcm], join='inner', ignore_index=True,) 
db.index=db['Name']; db= db.fillna('') 

# Make a Dictionary defining what Version fof FJX Files are used as CHEM INPUTS for each GC Version: w gc version as key. 
vfjx=pd.read_excel(get_path_to('pyMCM')+'F0AM_Tools/GEOSChem_Emulator/FJX_input_by_GC-verison.xlsx', index_col=0).to_dict()['FAST-JX-INPUT']

# Get path to the file that holds all of the info about already defined F0AM J-values. 
j_dflt=pd.read_excel(get_path_to('pyMcM')+'F0AM_Tools\\GEOSChem_Emulator\\j_mapping_modd.xlsx').fillna('') 
j_dflt=split_rxns(j_dflt, 'MCM_Rxn', db) 

# Dictionary that defines which compounds to use for INCHI def for dif cross-sections
onlys= {'Aceta':'ACET', 'Acetb':'ACET',
        'ActAld':'ALD2','ActAlx':'ALD2',
        'ClNO3a':'ClNO3','ClNO3b':'ClNO3',
        'CH3OOH':'MP','GlyAld':'GLYC',
        'Glyxla':'GLYX','Glyxlb':'GLYX','Glyxlc':'GLYX','MGlyxl':'MGLY',
        'H2COa':'CH2O','H2COb':'CH2O',
        'MACRN':'MACRN','MeAcr':'MACR','MEKeto':'MEK','MeVK':'MVK',
        'PrAld':'RCHO', 'IONO':'IONO', 'I2O4':'I2O4', 
        'HPALD':'HPALD','HPALD1':'HPALD1','HPALD2':'HPALD2'}

# Loop over ALL versions of GEOS-Chem mechanisms... 
jmap=dict({}) # Dictionary to hold all output... 
pth=get_path_to('desktop')+'GC_Mech_Files\\'
for folder in np.flipud(list(os.listdir(get_path_to('desktop')+'GC_Mech_Files\\'))):
    if 'database' not in folder:                      # folder = 'geos-chem-12.9.3'
        version= folder.split('-')[2]                 # version = 12.9.3
        ver=version.split('.');                       # ver= [12,9,3],  
        for mech in list(os.listdir(pth+folder+'\\')): 
            all_fjx=dict({}) 
            
            # Get what FJX file is used as chem input for this GEOS-Chem Version: 
            j2j_file= get_path_to('Desktop')+'FAST_JX_Files\\'+vfjx[version]+'\\FJX_j2j.dat'
            
            # Read in info about what Photolysis Rxns are Defined in this FJX File:       
            fjx= read_FJX_j2j(j2j_file)
            
            # Read in F0AM mechanism and get all rxns & rates of photolysis reactions: 
            eqn_fnm=pth+folder+'\\'+mech+'\\F0AM\\GC_'+mech.lower()+'_v'+version.replace('.','_')+'_eqns0.m'
            hv_rxns, hv_rates=get_all_photolysis_rxns(eqn_fnm) 
            
            for ind in fjx.index:
                fjx_rxn= fjx.loc[ind,'Photolysis_Rxn'].replace(' ','') # Get this rxn 
                cross_sect= fjx.loc[ind,'FJX_CrossSec'].replace(' ','') # Get cross section used of this rxn 
                if cross_sect=='': cross_sect='Un-named'
                
                # Use PHOTOL(Index) to find how this rxn is written in F0AM Mech File.
                item='J.photol_'+str(fjx.loc[ind,'FJX_Index'])
                f0am_rxn=hv_rxns[hv_rates.index(item)] if item in hv_rates else ''
                
                # Determine if the compound photolyzing is the thing the cross section is defined on or if its a POINTER! 
                f0am_rct= f0am_rxn.split('->')[0].replace('+hv',''); f0am_inchi=db.loc[db.Name==f0am_rct, 'InChI'].tolist()
                fjx_rct= fjx_rxn.split('->')[0].replace('+hv',''); fjx_inchi=db.loc[db.Name==fjx_rct, 'InChI'].tolist()
                csect_rct= cross_sect if cross_sect not in onlys.keys() else onlys[cross_sect]
                csect_inchi= db.loc[db.Name==csect_rct, 'InChI'].tolist()
                f0am_same=any([True if a==b else False for a in f0am_inchi for b in csect_inchi])
                fjx_same=any([True if a==b else False for a in fjx_inchi for b in csect_inchi])
                
                # If its the first time, then make the FJX and F0AM sub-dictionaries: 
                if cross_sect not in all_fjx.keys(): all_fjx[cross_sect]={'FJX_Rxn':[], 'F0AM_Rxn':[]}
                
                # Now, add these rxns to the existing lists of rxns for this cross-section. 
                if fjx_rxn  not in all_fjx[cross_sect]['FJX_Rxn'] and fjx_same: 
                    all_fjx[cross_sect]['FJX_Rxn'] =all_fjx[cross_sect]['FJX_Rxn']+ [fjx_rxn]
                if f0am_rxn not in all_fjx[cross_sect]['F0AM_Rxn'] and f0am_rxn!=''and f0am_same: 
                    all_fjx[cross_sect]['F0AM_Rxn']=all_fjx[cross_sect]['F0AM_Rxn']+[f0am_rxn]
            
            # Get rid of all the empties 
            for cst in list(all_fjx.keys()): 
                if len(all_fjx[cst]['F0AM_Rxn'])==0 and len(all_fjx[cst]['FJX_Rxn'])==0: all_fjx.pop(cst)
                
            # And reformat this to store in a dataframe: 
            df=pd.DataFrame(index=all_fjx.keys()).fillna('' ); df['Rxns']= list([''])*len(df)
            for cst in list(all_fjx.keys()): 
                df.at[cst,'Rxns']=np.unique(all_fjx[cst]['FJX_Rxn']+all_fjx[cst]['F0AM_Rxn']).tolist()
                
            
            # Match j_dflt and GC/FJX reactons based on rxn  strings, InChis, Products, and Reactants! 
            rez, missing= find_all_j_matches(j_dflt, df, db)
            
            for item in missing.copy():  # Don't worry about 0 quantum yield/ strat rxns:
                if all([True if val==0 else False for val in fjx.loc[fjx['FJX_CrossSec']==item,'Quantum_Yield']]) or \
                'j'+item in rez.loc[rez['J_Value']=='Jzero','GEOS-Chem/New'].values[0].split(','):
                    if item in missing: missing.pop(missing.index(item))
        
            jmap[mech.lower()+'_'+version]={} 
            for indx in rez.index: 
                key=rez.loc[ind,'J-Name'].values[0]
                jval=rez.loc[ind,'J-Value'].values[0]
                
                if ',' not in key and len(key) > 0:
                    if key not in jmap[mech.lower()+'_'+version]:
                        jmap[mech.lower()+'_'+version][key]=jval 
                    else: 
                        jmap[mech.lower()+'_'+version][key]=jmap[mech.lower()+'_'+version][key]+'+'+jval
        
            




