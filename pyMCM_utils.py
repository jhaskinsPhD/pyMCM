# -*- coding: utf-8 -*-
"""
List Tools I use a lot... 

@author: jhask
"""
import os 
import sys 
import numpy as np 
import pandas as pd 
from collections import defaultdict

def check_filename(filename:str='', default_name:str= '', ext:str='', 
                   savepath:str='', overwrite: bool=False,return_full:bool=False ): 
    """ Function to check user input "filename" and "savepath" are valid. If 
    none are passed, generates, a file at current working directory named "default_name" 
    with extensions ext. If Overwrite is True, then it will delete old files with this name 
    other wise it will append a version number on the new file. return full set True returns 
    the path and filename plus extension while set to False returns the savepath 
    and name seperately. 
    
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    ----------
    1/18/2022    JDH Created 
    
    """ 
    if '.' not in ext: ext= '.'+ext 
    
    # Set the filename to default if none passed by the user. 
    if filename == '': filename = default_name+ext;  
     
    # Split the name into path / filename: 
    input_pth, filename= os.path.split(filename)
    cwd=  os.path.dirname(os.path.abspath(__file__))+'/'
    
    # Remove file extension. Just want str with name in it. 
    filename=filename.split('.')[0] if '.' in filename else filename
    
    # Specify savepath and make sure that it exists. 
    if savepath == '': savepath= cwd  if len(input_pth)==0 else input_pth+'/' 
    if not os.path.exists(savepath): savepath=cwd
    
    fullname=savepath+filename+ext
    
    n=1;
    while os.path.isfile(fullname):
        if overwrite is True:  # Delete file if it currenly exists. 
            os.remove(fullname) 
        else:                  # Otherwise append a version # to the file. 
            if '_'+str(n-1) in filename: 
                filename=filename.split('_')[0] # Remove old version #s from filename. 
            filename=filename+'_'+str(n) # Add new version # to filename 
            fullname=savepath+filename+ext
        n=n+1; 
        # You now havea valid file path, name, extension combo that is new. 
        if os.path.isfile(fullname) is False: break 
    
    file= filename+ext
    
    print(fullname)
    if return_full is True: 
        return fullname
    else:
        return [savepath, file]


def str_multi_replace(string, baddies, rep_all:str=''): 
    """ Replace multiple items in a string. 
    Inputs: 
        string = str you want to replace items in. 
        baddies- list of chars to replace with rep_all or 
                 dict where keys are items to replace and values are replacements. 
        rep_all= str to replace items in list baddies with. Not relevant if baddies is dict. 
        
     Author: Dr. Jessica D. Haskins 1.14.2022 (jhaskins@alum.mit.edu)
    """
    if type(baddies)==type(list()):  # If baddies is a list: 
        for item in baddies: 
            string=string.replace(item, rep_all)
    else:  # If baddies is a dict! 
        for key in list(baddies.keys()):
            string=string.replace(key, baddies[key])
        
    return string 


def enforce_list_inds(inds,list_ofs):
    """Return itenms in a list from a list of their indices.
    Mostly used when taking indices from unq2List(rxn_list) and 
    applying them in K,GStr, F lists.""" 
    
    out=[];# Empty list to hold things for output. 
    
    # Loop over all items turn into arrays so we can index them and append to out
    for item in list(list_ofs): 
        this_list=[]; 
        this_list= [item[i] for i in list(inds) if item[i] not in this_list]
        out.append(this_list)

    return out


def flatten_nested_list(list_in, drop_dupes=False): 
    """Function to take a nested list and flatten into a 1d list.""" 
    if len(list_in) > 0: 
        is_nested=True if type(list_in[0]) ==type(['v','d']) else False 
        if is_nested is True: 
            list_out=[]; 
            if drop_dupes is True: 
                [list_out.append(r) for list_i in list_in for r in list_i if r not in list_out]
            else: 
                [list_out.append(r) for list_i in list_in for r in list_i]
        else: 
            list_out=list_in 
    else: 
        list_out=[]
            
    return list_out


def convert_nested_list_2arr(nested_list_in): 
    """Function to turn a nested list into an np.array of the same size. 
    Nested lists shorter than the max will have None as their vals..."""
    
    # Create array full of None that is the same len as the nested_list_in, 
    #but as wide as the longest nested list. 
    n_cols=max([len(item) for item in nested_list_in])
    out=np.full([len(nested_list_in), n_cols], None)
    
    for ind,item in enumerate(nested_list_in): 
        for v,val in enumerate(item): 
            out[ind,v]=val
            
    return out 


def drop_dupes(listy): 
    """Function to return a list with no dupes""" 
    dupes=list_dupes(listy, thresh=0) # List of where eveything is. 
    
    list_out=[]
    for unq in dupes.keys(): 
        first= dupes[unq][0]
        list_out.append(listy[first])
    
    return list_out


def list_dupes(seq, thresh=1): 
    """Finds the location of ALL DUPLICATES in a list in a single pass.
    returns a dictionary with keys= all duplicate values and values = index in seq."""
    out=dict({}); tally = defaultdict(list)
    
    # Nothing is a list. 
    if all([ type(item)!= type(list()) for item in seq]) : 
        [tally[item].append(i) for i,item in enumerate(seq)]
    else: 
        # If the values in seq are a list, then join them together with a comma 
        # because dict keys can't be lists they must be strings.
        for i,item in enumerate(seq):
            skip=False
            if type(item)==type(list()) and len(item) > 1: 
                item=','.join([str(it) for it in item])
            elif type(item)==type(list()) and len(item)==1: item=item[0] 
            elif type(item)==type(list()) and len(item)<1: skip=True 
            if skip is False: tally[item].append(i)
    
    out= {key:locs for key,locs in tally.items() if len(locs)>thresh}

    return  out


def find_in_list(val2find, inlist, replace_with='', drop_all=False, drop_first=False,
                 match_i=None, match_if_contains=False, partial_match=False): 
    """ Function to find a value within a list, and return all indcies of that match 
    Options include returning a list with all matches to val2find dropped,
    or a list with just the first occurance dropped, or a list with that value replaced with 
    replace_with. 
    
    If you're looking for a match within a list (e.g. if val2find is a list!),
    then use match_i to set the index of where the val2find should be located in the inlist.
    
    Match if contains will return a match to any item in inlist which contains a partial match to val2find... 
    """
    outlist=inlist; indx=[];  # Set the output to the input list. Pop values later if found. 

    # Returns dictionary of all items in inlist where keys are the items and values are the index! 
    inds2all= list_dupes(inlist, thresh=0) 
    
    # If you're trying to find a list within a list!... 
    # then join the target list in the same way list_dupes(in_list).. with commas.
    if type(val2find)==type(list()): 
        if len(val2find) >1: # only do it if you list has more than one item in it. 
                val2find=','.join([str(it) for it in val2find])
        else: #Otherwise find the one value that's in that list! 
            if len(val2find)==1: val2find=val2find[0] 
    
    # If the user wants an exact match and the key of it is in the inds2all. then get its index. 
    if val2find in inds2all.keys() and match_if_contains is False: 
            indx=inds2all[val2find] # List of indices of match to this val
    elif partial_match is True: 
         indx=[inds2all[ky] for ky in list(inds2all.keys()) if val2find in ky] # See if any of the keys contain your val. 
         if len(indx) > 0:  indx=flatten_nested_list(indx)
        
    if match_if_contains is True: 
        indx=[inds2all[key] for key in inds2all if val2find in key.split(',')]
        if len(indx) >0:  indx=flatten_nested_list(indx, drop_dupes=True)
    
    # Replace val2find with replace_with... 
    if replace_with != '' and  (len(indx)>0):
        for ind in indx: outlist[ind]=replace_with 
    
    # Remove ALL occurances of the match from the input list. 
    if drop_all is True and  (len(indx)>0):
        indx.sort(reverse=True) # Sort in decending order (biggest first!!!) 
        if (match_i is None):
            [outlist.pop(i) for i in indx ]
        else: 
            [outlist.pop(i[match_i]) for i in indx]
        
    # Remove only the first occurance of the match from the input list. 
    # or the match at match_i from the input list... 
    if (drop_first is True) and (len(indx)>0):
        indx.sort(); # Either drop first or put match_i in as the "first" to drop... 
        if match_i is not None: indx.pop(match_i); indx.insert(match_i)
        outlist.pop(indx[0])
                
    if ((drop_all is True) or (drop_first is True)) and (len(outlist) == len(inlist)): 
        sys.exit("ERROR in find_in_list(): Couldn't find val2find in inlist.")
        
    return indx, outlist


def drop_indxs_from_lists(lists, indxs): 
    """Function to take a list of indexes, and drop them from a list of lists."""
    if len(indxs) > 0: 
        lists_out=[];
        for list_i in lists: 
            list_o=[list_i[i] for i in range(0, len(list_i)) if i not in indxs]
        
            lists_out.append(list_o)
    else: 
        lists_out= lists 
        
    return list(lists_out) 


def get_split_add(lists, to_add=None, parse_chars:bool=False): 
    """Function to take two comma delimited strings, and combine them without dupes.
    Also can remove "[" or "'" left from lists --> str conversions(?) using parse_char.
    
    Author: Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    1/18/2022: JDH Created """
    
    combo=[]
    for listy in lists: 
        split=listy.split(',')
        combo=combo+split
            
    if parse_chars is True: 
        ok=[]
        for st in combo: 
                for bad in ['[',']',"'", ' '] : st=st.replace(bad, '')
                ok.append(st)
    else: 
        ok=combo
                    
    alls=[]; # Get list without dupes of everything in one and two. 
    [alls.append(value) for value in ok if value not in alls]
        
    if to_add is not None: 
        [alls.append(item) for item in to_add]
        
    alls.sort()
    
    as_str=','.join(alls) # Join it back with commas. 
    if as_str[0]==',': as_str=as_str[1:]
    
    return as_str


def move_lists(items, from_lists, to_lists) :
    """Function to move an item from one list to another."""
    
    if type(from_lists[0]) == type(['']):
        for i,val in enumerate(items): 
            if val in from_lists[i]: from_lists[i].remove(val)
            if val not in to_lists[i]: to_lists[i].append(val)
    else: 
        for val in items: 
            if val in from_lists: from_lists.remove(val)
            if val not in to_lists: to_lists.append(val)
        
    return [from_lists, to_lists]


def mod_list_as_str(str_list, add=None, remove=None, prefix='', suffix='', ignore=[]): 
    """Function to take a delimited strings, and add or remove anything in the 
    list add or the list remove... Can also add prefixes or suffixes to items in str list.
    Ignore is a list of items in the list not to add a prefix or suffix to. 
    """
    if type(ignore)==str: ignore=[ignore]
    split=str_list.split(',')
        
    ok=[]
    for st in split: 
        for bad in ['[',']',"'", ' '] : st=st.replace(bad, '')
        ok.append(st)

    if add is not None: [ok.append(item) for item in add]
        
    if remove is not None: [ok.remove(item) for item in remove]
        
    if prefix !='': ok= [prefix+item if item not in ignore else item for item in ok ]
    if suffix !='': ok= [item+suffix if item not in ignore else item for item in ok ]
    
    as_str=','.join(ok) # Join it back with commas. 
    if as_str[0]==',': as_str=as_str[1:]
    
    return as_str

    
def dict2df(dat_in=dict({}), full_file='', savepath='', filename='', reverse:bool=False, 
            split_on_comma=False, parse_chars=False):
    """Function to take a dictionary and save it as a df in an xlsx file. 
    Easy way to save lists of varying lens in a easy to read excel. OR do vice-versa!"""
    
    # Set savepath to the path of the script if none is given & no abs path is given
    if full_file=='':
        if savepath == '': savepath = os.path.dirname(os.path.abspath(__file__))
        full_file=savepath+filename
    if reverse ==False:  # Turn dict into a df with 2 cols: Key and Value.
        df=pd.DataFrame(); df['Key']=[' ']*len(dat_in); df['Value']= [' ']*len(dat_in)
        ind=0
        for key in dat_in: 
            listy=dat_in[key]
            listy.sort()
            df.at[ind,'Key']= key
            df.at[ind,'Value']=listy
            ind=ind+1
            
        df.to_excel(full_file+'.xlsx', engine="openpyxl",)
        print("Data Saved at: {}".format(full_file+'.xlsx'))                                            
        
        return df 
    else:  # Turn df into a Dict! 
        df_in=pd.read_excel(full_file+'.xlsx', engine="openpyxl", index_col= 0)
        
        if len(df_in.columns)<2: 
            sys.exit('Error in dict2df(): Function only works on dfs with at least 2 columns.')
        
        dict_out=dict({}); key_col=df_in.columns[0]; val_col=df_in.columns[1]
        for i in df_in.index:
            #Get "key" and "value", and strip spaces... 
            key=str(df_in.loc[i,key_col]); key=key.replace(' ', '')
            value= df_in.loc[i,val_col];  
            if type(value) ==str: value=value.replace(' ', '')
            
            # Remove weird characters if asked... 
            if parse_chars is True: 
                for bad in ["'",'[',']']:   
                    if type(value) ==str: value=value.replace(bad, '')
                    key=key.replace(bad, '')
            
            # Split value string on commas if asked... 
            if split_on_comma is True and type(value)==str: 
                listy=value.split(',') # Turn into list
                listy.sort()
            else:
                listy=value
        
            dict_out[key]=listy 
            
        return dict_out
  
    
def reverse_dict(dict_in): 
    """Function to reverse a dictionary, values:keys, takes care of dupes in values.""" 
    keys=list(dict_in.keys())
    values=list(dict_in.values())
    
    # Get dictionary that has a unique value in the dict as keys and 
    # their indices in the original dict as the values! 
    dupe_vals=list_dupes(values, thresh=0)
    
    dict_out=dict({})
    for k in list(dupe_vals.keys()): # Loop over unique values in orig dict... 
        get_all=[]; # Get a list of all the keys that have this value. 
        for ind in dupe_vals[k]: get_all.append(keys[ind]) 
            
        # And assign the value as a list of the keys that had the value! 
        dict_out[k]= get_all 

    return dict_out
