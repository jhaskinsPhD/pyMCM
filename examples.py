# -*- coding: utf-8 -*-
"""
Examples by Dr. Jessica D Haskins 
jhaskins@alum.mit.edu Github: jdhask

"""
import pandas as pd 
import numpy as np 
from MCM_web_scraper import *
from add_a_precursor import add_a_precursor 

# Folder where I want to save things... 
pth = 'C:/Users/Jhask/OneDrive/Desktop/fldr/'

# A short list of species we want info about... 
species_list=['APINENE', 'C5H8',  'C59O', 'MPAN', 'A2PAN']

print('\n','----------Example #1 Log:----------', '\n')
# Scrape info about the species in species_list from the MCM website & NIST.
ex_df1= MCM_data_scraper(species_list, filename='example_scrape',
                            get_image=True, display=False, savepath=pth)
#     Extension: Try species_list=['All'] or species_list='All' to get info on all MCM species

print('\n','----------Example #2 Log:----------', '\n')
# Pass the scraped dataframe to rdkit and get more info about the molecule from the SMILES strings  
ex_df2=query_rdkit_info(ex_df1,  add_functional_groups=True, overwrite_with_RDKIT=True,
                          verbose=True, save=False)

print('\n','----------Example #3 Log:----------', '\n')
# Add partitioning coefficient data from Wang et al., 2017 Supplement and save to a new file.
#     Wang et al., 2017: 'Uncertain Henry's law constants compromise equilibrium partitioning 
#                        calculations of atmospheric oxidation products ' 
#     https://acp.copernicus.org/articles/17/7529/2017/
ex_df3 = add_Wang_et_al_info(ex_df2,'MCM_Name', save=False)


print('\n','----------Example #4 Log:----------', '\n')
# Use precursors file generated above to assign them in our df. 
ex_df4= assign_precursors(ex_df3, 'MCM_Name',  savepath=pth, 
                        filename='example_scrape_plus') 

print('\n','----------Example #5 Log:----------', '\n')
# Let's consider "PAN" a precursor, so we can ID all compounds formed in MCM from PAN! 
precfile='C:/Users/jhask/OneDrive/Documents/Python/pyMCM/IO_data/MCM_Precursors.xlsx'
mechfile='C:/Users/jhask/OneDrive/Documents/MATLAB/F0AM/Chem/MCMv331/MCMv331_AllRxns.m'

new_precs, formed_from= add_a_precursor('PAN', precfile, mechfile) # Update your local precursor file to include PAN. 

ex_df5= assign_precursors(ex_df3, 'MCM_Name',  savepath=pth,  # And now re-assign the precursors using the updated file. 
                        filename='example_scrape_plus_w_PAN') 

# Now, compare ex_df4.loc['A2PAN','Precursor'] and ex_df5.loc['A2PAN','Precursor']
# You should see 'PAN' in ex_df5, but not ex_df4 for all species in the list  "formed_from"
print('Added PAN as a precursor for: ')
[print('    ', item) for item in ex_df5['MCM_Name'].tolist() if 'PAN' in ex_df5.loc[ex_df5['MCM_Name']==item, 'Precursors'].tolist()[0]]
