# -*- coding: utf-8 -*-
"""
Created on Tue Jul 19 13:36:09 2022

@author: Dr. Jessica D. Haskins  
Email: jhaskins@alum.mit.edu 
Github: @jhaskinsPhd
"""
import numpy as np 
import pandas as pd 
from pyMCM_utils import get_split_add
from F0AM_mech_IO import read_F0AM_mech 

# # Example Usage (For adding PAN as a precursor!):
# precfile='C:/Users/jhask/OneDrive/Documents/Python/pyMCM/IO_data/MCM_Precursors.xlsx'
# mechfile='C:/Users/jhask/OneDrive/Documents/MATLAB/F0AM/Chem/MCMv331/MCMv331_AllRxns.m'
# new_precs= add_a_precursor('PAN', precfile, mechfile)


def add_a_precursor(precursor, precfile, mechfile): 
    
    """Function to add info about what species are formed from a specific precursor to the 
    MCM_Precursors File, which is used to define that column in the resulting .xlsx of all data on MCMs.
    
    Inputs: 
    ------
        precursor (str) - MCM Name of compound you want to "Add" as a precursor. 
        
        precfile (str) - Absolute path to the existing precursor file 
                         (Originally at 'pyMCM/IO_data/MCM_precursors.xlsx')
                         
        mechfile (str) - Absolute path to a F0AM compliant mechanism file that contains reactions for the MCM. 
                         
    Outputs: 
    ------- 
         Function will updates the contents of precfile to include precursor where appropriate! 
         
         prec_df - the UPdated contents of the precfile as a pandas dataframe.
         
         created_from - a list of compounds formed from the passed precursor. 
         
    NOTE: Function is used to update the precursor file then re-run the assign_precursors 
          function on an existing MCM_web scrape dataframe as in Example #4 
              
          ex_df4= assign_precursors(ex_df1, 'MCM_Name',  savepath=pth, 
                                        filename='example_scrape_plus') 
          
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jhaskinsPhD
    
    Change Log: 
    ----------
        7/19/2022    JDH Created 
    """ 
    # Read in the existing Precursor file: 
    prec_df=pd.read_excel(precfile, engine='openpyxl',index_col=0).fillna('')
     
    # Read all MCM reactions in the Mechanism from a F0AM File... Note: CHECK MUST BE TRUE TO SPLIT FILES! 
    mech1= read_F0AM_mech(mechfile,check=True, sort_rxn_i=False, sort_rxn_list=False)
    [n_sp,_n_rx,sps,ro2_list, rxn_list, k_list, g_list, f_list,rct_list, prd_list, r_ylds, p_ylds]=mech1
    
    # Transform stuff from MCM rxns into the type of list that cascade_mech() likes... 
    rct=nD_list2_nparray(rct_list)
    prd=nD_list2_nparray(prd_list)
    
    created_from= cascade_mech(precursor, rct, prd, reverse=False) # Get all species formed from it. 
    
    # Remove anything formed that's not in the MCM species list ... (e.g. O1D, etc)
    for item in created_from.copy(): 
        if item in created_from and item not in prec_df['MCM_Name'].to_list(): created_from.remove(item) 
    if precursor in created_from: created_from.remove(precursor)
    created_from.sort() # Sort list of compounds formed from target, alphabetically 
    
    for sp in created_from: # Loop over all species created from the new precursor .. 
        if sp in prec_df['MCM_Name'].tolist() : # Make sure we have some other prec data on this sp already!
            # Get all precursors it forms from in original data file: 
            old_prec_ls=prec_df.loc[prec_df['MCM_Name']== sp, 'Precursor'].tolist() 
            # Add whatever the new precursor is to that list in alphabetical order. 
            new_prec_ls= get_split_add(old_prec_ls, to_add=[precursor])
            # Assign that to the precursor dataframe. 
            prec_df.at[prec_df['MCM_Name']== sp,'Precursor']=new_prec_ls
                 
    prec_df.to_excel(precfile)
    print ('Precursor datafile updated:' , precfile)
    
    
    return prec_df,created_from


def nD_list2_nparray(lst):
    """Convert a ND list of variable len to an NP array)."""
    # Calculate length of maximal list
    n = len(max(lst, key=len))
    
    # Make the lists equal in length
    lst_2 = [x + [None] * (n - len(x)) for x in lst]

    # Convert it to a NumPy array
    lst_arr = np.array(lst_2)

    return lst_arr


def cascade_mech(target: str , rct, prd, ignore: list = [], reverse:bool =False):
    """Find ALL speces that come from target, excluding those in ignore.
    
    This function searches the reactants created in kpp_parse for the
    target species name. When it finds a reaction that consumes the target
    species,it gets a list of the products formed from it. It adds those
    products to the list of species involved in the mechanism if those
    products are not already in that list and also not in the list of species
    to ignore in the mechanism. It then re-loops through the reactions to
    check for reactions that consume these products. In this way, we are
    searching for a cascade of products from target. Returns a list
    of products that are ultimately formed from target.
    
    Args
    ----
        target - string containing a tracer name you want to cascade from.
                'ISOP' to see entire isoprene oxidation mechanism.
                
        rct  and prd - arrays returned from kpp_prase containing list of
                    products and reactants in each reaction in the mech.
        
        ignore - list of tracer names not to include in the cascade.
                E.g. you may want to look at Isoprenee oxidation but not
                want to catch ALL reactiosn that involve NO2 or OH just because
                sometimes those are products of isoprene oxidation  steps..
                So, you can add such speces to the ignore list.
                
    Returns
    -------
        mech  - lsit of all species that come from rxns with target excluding
                those in ignore.
                
    """
    # Set up return vars to hold output.
    all_mech = [target] # Initially, mech just consists of target.
    growing = True  # initialize while loop with a true value.
    ct=1
    if reverse is False:
        cascade=rct.copy()
        opposite=prd.copy()
    else: 
        cascade=prd.copy()
        opposite=rct.copy()
        
    while growing is True:  # Only search while mechanism list is growing.
        len0 = len(all_mech)  # Keep initial len of mech to see if it grows.
        mech=[]
        for i in range(0, cascade.shape[0]):  # Loop over all
            for j in range(0, cascade.shape[1]):
                if cascade[i, j] in all_mech:  # If exact string match.
                    
                    # Add all products that are not Nones to list if not dupes
                    for h in opposite[i, :]: mech.append(h) if (type(h) is str) \
                        and (h not in all_mech) and (h != 'hv') and h not in ignore else None
    
                    # Remove anything we added that we want to ignore
                    #mech = [k for k in mech if k not in ignore]

        all_mech=all_mech+mech

        if len(all_mech) == len0 : growing=False  # Nothing added; Stop looking.
        ct=ct+1
        
        all_mech0, inds  =np.unique(np.array(all_mech), return_index=True)
        
        # Get unique nodes in order they appeard in the cascade. 
        all_mech=np.array(all_mech)[np.sort(inds)].tolist()
        
    return all_mech




