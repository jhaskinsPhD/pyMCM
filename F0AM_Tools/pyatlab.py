from scipy.io import loadmat
import pandas as pd 
import numpy as np 
import sys


def join_list_for_MATLAB(join_str:str, ls:list,
                         min_len:int =75, 
                         add_semicolon:bool =False, 
                         comment:bool=False, 
                         preface:str =''): 
    """Function to take a list and join it together with a delimiter as str.join(ls) does 
    except, you actually insert a MATLAB style line break where the lines start to get 
    long. Doesn't append delimiter to beginning or end.
    
    Inputs: 
        join_str = string delimiter you want to use to join the list: ',', '+'  ... 
        ls   = list of items you want to join with join_str. 
        min_len = int that is the minimum line lenth they must be before inserting a line break. 
        add_semicolon = boolean of wehther to add a semi colon at then end or not. 
        comment = boolean of whether the entire list should be commented our or not. 
        
    Outputs- Single string that has all items in list joined with delimiters and 
            MATLAB style line breaks where lines are long. 
            
    Example Usage:
        ls=['a'*np.random.randint(5,65) for i in range(0,100)] # random list. 
        join_str=' + ' # Delimiter you want to join this list. 
        out = join_list_for_MATLAB(join_str, ls)
        print(out)       

    Author: Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask 
    
    1.14.2022   JDH created.                                      
    """
    ad=';' if add_semicolon is True  else '' 
    
    ln_ls=[]; lines=[]
    for i, item in enumerate(ls): 
        if type(item) != str: item=str(item) # Join only takes string lists. 
        if len(item) > 0: # Don't join things that are blanks. 
            ln_ls.append(item)
            ln= join_str.join(ln_ls) 
            if len(ln) > min_len: 
                if comment is True and i != 0: ln='% '+ln
                lines.append(ln) # Keep all these joined strings. They will be on 1 line. 
                ln_ls=[]; # reset list holding items to put on a single line.  
    
    if len(lines)==0: # Stuff wasn't long enough! So write one line with it on it. 
        out=preface+join_str.join(ls)+ad
    else:
        # Join each line together with the MATLAB line break and new line character 
        to_join= join_str+'...\n    ' 
        out=to_join.join(lines)+ad
    
    return out 


def find_nested_np_depth(var,mx_dim2ck):
    '''Function to find the actual number of nested np.object arrays which 
    occur when you loadmat a MATLAB structure into python using scipy. Needed in 
    loadmat_struc_to_df(). py
    '''
    # Start with some high # of indexes (mx_dim2ck) and try indexing the 
    # variable(var) with   them until you don't get an index error. Option to 
    # indexes back that will give you the ultimate arr in the nest. 
    
    while True:   
        try: 
            dim2ck= tuple([[0] for v in range(0, mx_dim2ck)])
            dummy= var[dim2ck]
            break
        except IndexError:
            mx_dim2ck=mx_dim2ck-1 # remove a dimension to check. 
            
        if mx_dim2ck<0: 
            print('Bad Break')
            break
    
    return mx_dim2ck 
    

def loadmat_struc_to_df(path2mech, var_names= list()): 
    """Scipy laods MATLAB structures as nested np arrays. Unravel them into a 
    # dataframe. Varnames is optional input of list of vars in a struc that 
    # contains more than just 1D variables. 
    
    Author: Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask 
    
    1.14.2022   JDH created.
    """
    
    mech = loadmat(path2mech) # Load variables from path. 
    
    varz= [v for v in mech.keys() if not v.startswith('_' )] # Get var names from struc. 
    
    df=pd.DataFrame()  # Create dataframe to hold data. 
    
    for var_i in varz: # Loop over all vars 
        sz= np.shape(mech[var_i]) # Check # of columns in variable! 
        for n2loop in range(0,sz[1]): # Loop over its columns if its a 2D variable. 
            mx_dim= find_nested_np_depth(mech[var_i],9) # Find # of nested dimensions. 
            indxs=[0 for dim in range(0, mx_dim-1)] # Create apppropriate # of 0s as index. 

            if n2loop!= 0: indxs[0]=n2loop # Access the appropriate column! 
            
            # Return a 1D  numpy array that has all the data in it. 
            arr= np.array([mech[var_i][tuple([i]+indxs)] for i in range(0, len(mech[var_i]))]).flatten()
        
            var_nm=var_i
            if sz[1] >1:
                if len(var_names)>0: # Use user assigned names. 
                    var_nm=var_names[n2loop]
                else: 
                    var_nm= var_i+'_'+str(n2loop+1)
                    
            df[var_nm]=arr # Assign that array into the dataframe. 
            
    return df 
