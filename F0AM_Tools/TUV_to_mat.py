# -*- coding: utf-8 -*-
"""
Created on Wed Jun 16 18:06:05 2021

@author: jhask
"""
import csv 
import pandas as pd
import numpy as np 
import re
import scipy.io as sio 
import os 

# Map MCM names to TUV labels 
j_vals_dict= dict({
'O3 -> O2 + O(1D)':'J1',
'O3 -> O2 + O(3P)':'J2',
'H2O2 -> 2 OH':'J3',
'NO2 -> NO + O(3P)':'J4',
'NO3 -> NO + O2':'J5',
'NO3 -> NO2 + O(3P)':'J6',
'HNO2 -> OH + NO':'J7',
'HNO3 -> OH + NO2':'J8',
'CH2O -> H + HCO':'J11',
'CH2O -> H2 + CO':'J12',
'CH3CHO -> CH3 + HCO':'J13',
'C2H5CHO -> C2H5 + HCO':'J14',
'CH2=C(CH3)CHO -> Products':'J18',
'CH3COCH3 -> CH3CO + CH3':'J21',
'CH3COCH2CH3 -> CH3CO + CH2CH3':'J22',
'CH3COCH=CH2 -> Products':'J23',
'CHOCHO -> H2 + 2CO':'J31',
'CHOCHO -> CH2O + CO':'J32',
'CHOCHO -> HCO + HCO':'J33',
'CH3COCHO -> CH3CO + HCO':'J34',
'CH3COCOCH3 -> Products':'J35',
'CH3OOH -> CH3O + OH':'J41',
'CH3ONO2 -> CH3O + NO2':'J51',
'C2H5ONO2 -> C2H5O + NO2':'J52',
'n-C3H7ONO2 -> C3H7O + NO2':'J53',
'CH3CHONO2CH3 -> CH3CHOCH3 + NO2':'J54',
'C(CH3)3(ONO2) -> C(CH3)3(O.) + NO2':'J55',
'CH3COCH2(ONO2) -> CH3COCH2(O.) + NO2':'J56',
'CH2(OH)COCH3 -> CH3CO + CH2(OH)':'Jn10',
'CH2=CHCHO -> Products':'Jn11',
'CH3CO(OONO2) -> CH3CO(OO) + NO2':'Jn14',
'CH3CO(OONO2) -> CH3CO(O) + NO3':'Jn15',
'CH3(OONO2) -> CH3(OO) + NO2':'Jn16',
'CH3(OONO2) -> CH3(OO) + NO2':'Jn17',
'N2O5 -> NO3 + NO2':'Jn19',
'N2O5 -> NO3 + NO + O(3P)':'Jn20',
'HNO4 -> HO2 + NO2':'Jn21'})


#TUV output file. 
file= 'C:/Users/jhask/OneDrive/Documents/MATLAB/F0AM/Setups/SOAS_RCIM/foam_6_29_out.txt'

with open(file, "r",errors="ignore") as f: # read line by line.
    reader = csv.reader(f, delimiter="\t")
    
    # Initialize vars we fill in reading the file. 
    ln_num = 0; map_cols=dict({})
    in_species_list=False; 

    pass_go=False
    for row in reader:
        line = " ".join(row)  # read line by line. 


        hdrs= [key  for key in list(j_vals_dict.keys()) if key in line]
        
        if len(hdrs) > 0 : 
            headers= re.search(r"[\d]*[\=\w]", line)
            print(line, hdrs, j_vals_dict[ hdrs[:][0]]) 
            if headers: map_cols[headers.group()]=j_vals_dict[ hdrs[:][0]]

        if (pass_go is True) and ('------' not in line ): 
            # Append the j-values to the dataframe at this point in time. 
            splt= [float(item) for item in line.split(" ") if item !=''] 
            df.loc[len(df)]=np.array(splt)
            
        if 'time, hrs.  sza, deg.' in line: 
            pass_go=True 
            df=pd.DataFrame(columns= ['time', 'sza']+ list(map_cols.values()))
            

to_mat={name: col.values for name, col in df.items()}

filename= os.path.join('C:/Users/jhask/OneDrive/Documents/MATLAB/F0AM/Setups/SOAS_RCIM/'+'F0AM_tuv.mat')
sio.savemat(filename, to_mat)
    
        
print(filename)
        
