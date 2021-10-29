# -*- coding: utf-8 -*-
"""
Examples by Dr. Jessica D Haskins 
jhaskins@alum.mit.edu Github: jdhask

"""
import pandas as pd 
import numpy as np 
from MCM_web_scraper import *

# Folder where I want to save things... 
pth = 'C:/Users/Jhask/OneDrive/Desktop/fldr/'

# A short list of species we want info about... 
species_list=['APINENE', 'C5H8',  'C59O', 'MPAN']

# Scrape info about all the species in our mechanism from the MCM website & NIST.
MCM_df0= MCM_data_scraper(species_list, filename='example_scrape',
                            get_image=True, display=False, savepath=pth)

# Pass the scraped dataframe to rdkit and get more info about the molecule from the SMIELS strings  
MCM_df1=query_rdkit_info(MCM_df0,  add_functional_groups=True,overwrite_with_RDKIT=True,
                          verbose=True, save=False)

# Add partitioning coefficient data from Wang et al., 2017 Supplement and save to a new file.
MCM_df2 = add_Wang_et_al_info(MCM_df1,'MCM_Name', save=False)
 
# Use precursors file generated above to assign them in our df. 
MCM_df3= assign_precursors(MCM_df2, 'MCM_Name',  savepath=pth, 
                        filename='example_scrape_plus') 
