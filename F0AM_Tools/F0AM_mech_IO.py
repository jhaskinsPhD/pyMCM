# -*- coding: utf-8 -*-
"""
Created on Thu Oct  7 09:16:41 2021

@author: jhask
"""
import numpy as np 
import csv
import re 

import sys 
import set_my_paths as init # Add these folders to my sys path so I can use their functions! 
init.add_to_path(sys.path, ['pyatlab', 'pyMCM_utils'])  
from pyMCM_utils import * 
from pyatlab import *  # Tools for making things MATLAB compliant.

                
def read_F0AM_mech(file,  tag='', map_dict=dict({}), check=True, 
                   sort_rxn_i=False, sort_rxn_list=False, return_comments=False):
    """Function to read in a F0AM mechanism .m file...and return things like 
    the "Species List", the "RO2" list, the reactions, the rates (k), the gstr and the f 
    that are on each line... allows you to later parse these as lists  in python 
    with the same indices to do things like find their chem families, look for dupes, etc.
    
    Inputs
    ------
        file = path to .m file holding reactions for a F0AM mechanism. 
                   
        check (optional) - boolean of whether to check the file for errors that might 
                    make F0AM throw errors... 
            
        sort_rxn_i (optional) - Boolean of whether you want to sort items in the rxn. 
                (e.g. OH + APINENE -->   becomes APINENE + OH --> )
        
        sort_rxn_list (optional) - boolean of whether you want to sort all reactions 
                       by reactant (e.g. all APINENE + XXX --> will appear together in 
                       alphabetical order. This makes it easy to see all fates of a reactant in the mech. 
        
        tag (optional) = A MATLAB comment to add on to the Rnames line that says what
                   mechanism this reaction is from. Useful if combining mechanisms- as tag 
                   set to 'Some Mech Name" can tell you where this rxn came from. 
                   
        map_dict (optional) - dictionary to map names in mech to dif ones. Useful if 
             you are using an MCM based mech with another that has dif var names (like GEOS-Chem)...
        
    Outputs
    -------
    
    n_species - integer number of unique species in the mechanism. 
    n_rxns - integer number of reactions in the mechanism.
    species- list of all species in the mechanism (EXCEPT "RO2", don't declare this in F0AM!!!). 
    ro2- list of all species that are "RO2" in the mechanism. EXCEPT "RO2" ^^
    
    rxn- list of all reactions in the mechanism. This is the "Rnames" line in F0AM. 
    k - list of all rates of reactions in the mehcanism. This is k(i,:)= line in F0AM. 
    g - list of all reactants in each reaction. This is Gstr{i,:}= line in F0AM. 
    f - list of stoichiometry each reaction changes in mech. This is fOH(i)=fOH(i)+1  line in F0AM. 
    rct_cmpds- nested list of all reactants in a reaction_i in the reaction list. 
    rct_ylds- nested list of the yields/stoichiometry of rct_cmpds for reaction_i
    prd_cmpds- nested list of all products in a reaction_i in the reaction list. 
    prd_ylds- nested list of the yields/stoichiometry of prd_cmpds for reaction_i
    
    rxn, k, g, f, rct_cmpds, rct_yields, prd_cmpds, prd_ylds, should all be the same size. 
                If n_rxns declared in header is correct, then they should be size (n_rxns x 1). 
                If n_species declared in header is correct,  then "species" should be size (N-species x 1). 
    
                
    Custom Functions Referenced: 
        
        check_mech_n_map() 
        
    Author: Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    1/18/2022:  JDH Created
    """
    
    with open(file, "r",errors="ignore") as f: # read line by line.
        reader = csv.reader(f, delimiter=' ')
        
        # Initialize vars we fill in reading the file. 
        n_species=np.inf; n_rxns=np.inf;  # Hold # of species and # of rxns 
        ln_num = 0; knext=-99; gnext=-99; fnext=-99; in_species_list=False;  in_ro2_list=False
        species=[]; ro2=[];  rxn=[]; k=[]; g=[]; f=[]; comments=[];
        insert_cmt=[]; insert_ind=[]; pass_go=False  
        for row in reader:
            line0= " ".join(row)  # read in the .m file line by line, keep original line! 
            line=line0 # and keep a copy to mod later.
            
            comment_line=False 
            if len(line)>0:  # Decide if it's a commented out line or not. (MATLAB Comments = "%") 
                if line[0]=='%': comment_line=True 
            
            # Decide if its a comment at the top of the file or not. 
            if comment_line is True and 'species' not in line and 'reaction' not in line and '#' not in line and pass_go is False: 
                comments.append(line)
            
            # Sometimes top level comments have # of species and # of rxns... 
            if comment_line is True and '#' in line and pass_go is False: 
                col_name, sep, after = line.rpartition("=")
                if 'species' in line: n_species=int(after.strip())  # Save # of species..
                if 'reaction' in line: n_rxns=int(after.strip())  # Save # of reactions.
                
            if comment_line is False: # Don't parse commented out lines for mech data.  
                annotations=''
                if '%' in line: # Line has a comment at the end of it... 
                    line_listy=line.split('%') # Split into data and the annotation.
                    line=line_listy[0];  annotations=line_listy[1]
                    
                if 'SpeciesToAdd' in line: in_species_list = True ; pass_go=True# If we're in species list   
                if 'RO2ToAdd' in line: in_ro2_list = True # If we're in RO2 list 
                
                # --------- Populate list of Species/ RO2s in mechanism.-------------
                # List of things to remove from these lines... 
                remove=['SpeciesToAdd', 'RO2ToAdd', '{', '=', '}', '...', "'"] 
                if (in_species_list is True) or (in_ro2_list is True):
                    for item in remove: # Remove things we don't want.
                        if item in line: line =line.replace(item, '').strip()
                        
                    # Split line along semicolon which divides lists in Matlab, remove spaces. 
                    list_line = line.split(";")  
                    value= [item.strip() for item in list_line  if len(item.replace(' ', ''))>0]
                    
                    if (in_species_list is True) : # Append unique vals into the species list. 
                        species=species+ [v for v in value if v not in species]
                    
                    if (in_ro2_list is True) : # Append unique vals into the RO2 list. 
                        ro2=ro2+ [v for v in value if v not in ro2]
                
                # --------- Populate list of rxns, ks, rcts, and yields in mechanism.-----------
                if (in_species_list is False)  and (in_ro2_list is False):                    
                    line=line.replace(' ', '') # remove any spaces from the line. 
                    
                    # Check if this line is just some kind of extra, unexpected 
                    # line which isn't a comment but doesn't contain mech info. 
                    if  len(line)>0 and \
                        'i=i+1;' not in line and \
                        'Rnames{i}=' not in line and \
                        'k(:,i)=' not in line and \
                        'Gstr{i,1}=' not in line and \
                        '(i)=f' not in line and \
                        any(['(i)=f' not in strr for strr in line]) \
                        and pass_go is True:
                        insert_cmt.append(line0); insert_ind.append(len(f))
                    else:     
                        # Append the whole line to our lists of Rnames, K, or Gstr. 
                        add=' % ' if annotations !='' or tag != '' else ''
                        add= add+ annotations+' # '+tag  if tag!='' else add+annotations
                        if 'Rnames' in line: rxn.append(line +add); knext=ln_num+1;
                        if knext==ln_num :  k.append(line+add); gnext=ln_num+1
                        if gnext==ln_num:  g.append(line+add);  fnext=ln_num+1; 
                        if fnext==ln_num: f.append(line+add); 

                # Set exit flags For species, list, ro2 lists only after you 
                # added the lines to the correct list. 
                if (in_species_list is True)  and ('};' in line0): in_species_list = False 
                if (in_ro2_list is True)  and ('};' in line0):  in_ro2_list = False 
            
            elif comment_line is True and pass_go is True:  # Found a comment in the middle of the file... 
                insert_cmt.append(line0); insert_ind.append(len(f))
            
            ln_num=ln_num+1 # Update the line number. 
            
    for c in range(0, len(rxn)): 
        # Some photolysis rxns don't have +hv in them which makes it hard to plot later... fix here. 
        if ('J' in k[c]) and ('+hv' not in rxn[c]): 
            [rnames, rcts, prds] = rxn[c].split("=") 
            rcts=rcts+'+hv' # add '+hv' !  
            rxn[c]= rnames+'='+ rcts+'='+prds 
    
    if check is True: 
        # Preform some checks!, and map names to the appropriate ones in map dict if provided. 
        cors, info= check_mech(species, ro2, rxn, k, g, f, n_species=n_species, 
                               n_rxns=n_rxns, mech_name=file, map_dict=map_dict, 
                               sort_rxn_i=sort_rxn_i, sort_rxn_list=sort_rxn_list, verbose=True)
        # Unpack all the new stuff. 
        [species,ro2,rxn,k,g,f, n_species, n_rxns,rct_cmpds, prd_cmpds, rct_ylds, prd_ylds] = info
    else: 
        rct_cmpds=[]; prd_cmpds=[]; rct_ylds=[]; prd_ylds=[];
        
    mech_title=' '.join(comments); #Steal comments from orign.
            
    if return_comments==False: 
        # Return lists of everything we got out of the mechanism.
        return [n_species, n_rxns, species, ro2, rxn, k, g, f, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds]
    else:
        return [n_species, n_rxns, species, ro2, rxn, k, g, f, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds, mech_title,
                    insert_cmt, insert_ind]


def write_mech_to_file(filename, species_list,ro2_list,rxn_list,k_list,g_list,f_list, 
                       mech_title='', overwrite= False, insert_cmt=[], insert_ind=[]): 
    """ Function to take species lists, ro2 lists, rxn list, k list, g list and f list and 
    write them to a F0AM compliant .m file that can be used in MATALB. 
    
    Inputs: 
    -------
        filename - path+ name of the file the mechanism will be written to.
        
        species_list - list of all species in the mechanism
        ro2_list- list of all species that are "RO2" in the mechanism. EXCEPT "RO2" ^^
        
        rxn_list- list of all reactions in the mechanism. This is the "Rnames" line in MATLAB. 
        k_list - list of all rates of reactions in the mehcanism. This is k(i,:)= line in MATALB. 
        g_list - list of all reactants in each reaction. This is Gstr{i,:}= line in MATALB. 
        f_list - list of stoichiometry each reaction changes in mech. This is fOH(i)=fOH(i)+1  line in MATALB. 
        
        mech_title (optional)  - comment at top of F0AM mechanism stating what 
                    kind of mech this is... e.g. "% MCMv331 ISOPRENE +INORG rxns" 
        
        overwrite (optional) -  Boolean of whether to overwrite an existing 
                                file or apend a "_1" to it... 
    
        NOTE: rxn_list, k_list, g_list, f_list should all be the same size. 
            ro2_list must be subset of species_list. 
    
    Outputs: 
    --------
        filename.m  - mechanism written to a .m file for use in F0AM. 
    
    Custom Functions Referenced: 
    ---------------------------
        check_lens()
        check_filename()
        
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    ----------
    1/18/2022    JDH Created 
    """
    # Check the path + filename exists / has correct extension. 
    outfile= check_filename(filename, overwrite=overwrite, ext= '.m', return_full=True)
        
    # Open the output file and write headers line by line. 
    outF = open(outfile, "w"); write_file= True; ln_num=0;  rct_ct=0
     
    check_lens(rxn_list,k_list,g_list,f_list, 'ERROR : Input to write to file does not match lens. ' )
    
    # Break up comments on %, add line break char for all comments...
    cmts=mech_title.split('%'); big_title=''; title_lines=len(cmts)
    for l in cmts[0:]: 
        big_title=big_title+'%'+l+'\n'
    
    species_list=["'"+sp+"'" for sp in species_list ]
    ro2_list=["'"+sp+"'" for sp in ro2_list ]
    # Turn species list & RO2 list into a MATLAB formatted  cell array as a single string!
    sps_lines= 'SpeciesToAdd = {'+ join_list_for_MATLAB(';', species_list, comment=False, add_semicolon=False)+ '};\n' 
    ro2_lines= 'RO2ToAdd = {'+ join_list_for_MATLAB(';', ro2_list,  comment=False, add_semicolon=False)+ '};' 

    if ro2_lines =="RO2ToAdd = {''};":  ro2_lines='RO2ToAdd = {};';  
    while write_file== True: 
        blank= '' ;   line=blank ; 
    
        if ln_num ==0:line= big_title
        if ln_num ==1:  line= '% # of species ='+ str(len(species_list))
        if ln_num ==2:  line= '% # of reactions ='+ str(len(rxn_list))
        if ln_num ==3:  line= blank
        if ln_num ==4:  line= sps_lines
        if ln_num ==5:  line= ro2_lines; 
        if ln_num ==6: line= blank 
        if ln_num == 7: line= 'AddSpecies' 
        if ln_num == 8: line= blank
        
        if (ln_num >8) and (rct_ct<= len(rxn_list)): 
            line=[]
            if rct_ct in insert_ind: # If you have a comment to insert here... 
                insertion=[insert_cmt[i]+'\n' for i,ind in enumerate(insert_ind) if ind==rct_ct]
                for idv,lnn in enumerate(insertion):
                    if 'if' in lnn: lnn='\n'+lnn
                    if 'end' in lnn: lnn= lnn+'\n'
                    if idv==0 and lnn[0]=='%' : lnn= '\n'+lnn 
                    if idv==len(insertion)-1 and lnn[0]=='%' : lnn= lnn+'\n' 
                    line.append(lnn) #append the insertion to the line. 
            
            if rct_ct< len(rxn_list): # Append all the info for this rxn. 
                line.append('i=i+1;\n')
                line.append(rxn_list[rct_ct]+'\n')
                line.append(k_list[rct_ct]+'\n')
                line.append(g_list[rct_ct]+'\n')
                line.append(f_list[rct_ct]+'\n') if rct_ct+1  not in insert_ind else line.append(f_list[rct_ct])
            
            line=''.join(line) # make it a big long char. 
            rct_ct=rct_ct+1
                
        outF.write(line)
        outF.write("\n")
        
        if rct_ct > len(rxn_list):
            break
            write_file=False 
    
        ln_num=ln_num+1
    
    outF.close() # Close the output file. 
    
    print('Mechanism written to file: ' , outfile)
    return 



# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# The rest of the functions are utility functions for the main two above! 
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    
def toDecimal(x, n_decimals):  # x is a float.
    """Function to take a number or list of numbers and force it to have 
    a certain # of sig figs. 
    
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    ----------
    1/18/2022    JDH Created 
    """ 
    import decimal 
    
    # Decide if you got a list or a single number.... 
    if type(x) == type(['']) or type(x)==type(np.arange(0,2)): 
        x2=[np.float64(value) if type(value)!=type(np.float64(1)) else x for value in x] 
    else: 
        x2=[np.float64(x)] if type(x)!=type(np.float64(1)) else [x] 
    
    d=[]
    for value in x2:
       if not np.isnan(value): 
           val='1.'+''.join(['0']*n_decimals)
           d_i= decimal.Decimal(str(value)).quantize(decimal.Decimal(val))
       else: 
           d_i=value
       d.append(d_i)
        
    if len(d)==1: d=d[0] 
    
    return d


def sort_rxn_indv(rct_cmpds,prd_cmpds,rct_ylds,prd_ylds):
    """
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    ----------
    1/18/2022    JDH Created 
    """

    # Get indices that would sort reactants and products: 
    rcts_indx= list(np.argsort(rct_cmpds));  prds_indx= list(np.argsort(prd_cmpds))
    
    # Make a list of items in a reaction you wan to appear at the "end" of the half of the rct/prd 
    move2end=dict({'MGLYOX':1, 'GLYOX':2, 'CH3CO2':3, 'CH3CO3':4,'CH3O2':5, 
                   'HCHO':6, 'NO2':7,'O3':8,' NO':9,  'NO3':10, 'Cl':11, 
                   'Br':12,'RO2':13,  'CO':14, 'OH':15, 'HO2':16, 'O':17, 
                   'CO2':18, 'H2':19, 'O2':20,'hv':21})
    
    for do in [0,1]:
        if do==0: cmpds= rct_cmpds; sort_indx_list= rcts_indx;
        if do==1: cmpds= prd_cmpds; sort_indx_list= prds_indx;
        
        # List of indexes to remove from sort_indx_list and move2end 
        to_pop0=[cmpds.index(m) for m in cmpds if m in list(move2end.keys())]
        if len(to_pop0) >0: 
            # Heirarchy of "where" to move those... 
            heirarchy = [move2end[m] for m in cmpds if m in list(move2end.keys())]
            order=np.argsort(heirarchy) 
        
            # Pop and append in specific order determined by heirarch in move2end dict.... 
            to_pop=[to_pop0[val] for val in order] 
            for v in to_pop:
                sort_indx_list.pop(sort_indx_list.index(v))
                sort_indx_list.append(v)
                
        if do==0: rcts_sort_i=sort_indx_list
        if do==1: prds_sort_i=sort_indx_list
        
    [rct_cmpds_o, rct_ylds_o]=enforce_list_inds(rcts_sort_i,[rct_cmpds, rct_ylds])
    [prd_cmpds_o, prd_ylds_o]=enforce_list_inds(prds_sort_i,[prd_cmpds, prd_ylds])
    
    return rct_cmpds_o,prd_cmpds_o,rct_ylds_o,prd_ylds_o


def check_fline(rnames_line, fline_in, f_should_have, f_replaced, f_removed,
                verbose= True, map_dict=dict({})):
    """Function to take a reaction line and a fstr line and make sure that the 
    amount made in the fstr line is what is actually made in the rxn line. 
    
    Inputs: 
    -------
        rnames_line- String from a rxn list that has an indv reaction on it: 
                    rnames_line= "Rnames{i}='14Z+ C= 12V + 3.45G'; % Comment stuff here  " 
                    
        fline_in   - String from a f_list that has fractional stoichiometry for rxn on it. (Can be empty)... 
                     fline_in= 'fZ(i)=fZ(i)-14; fC(i)=fC(i)-1; fV(i)=fV(i)+12; fG(i)=fG(i)+3.45; % V impt comment'
                     
        f_shoulds  -  A list of fs you "should" have based on the rxn. 
        
        f_replaced  -  A list of fs that that should be there but were replaced with a combo yield
        
        f_removed   -  A list of fs that should be there but were removed b/c no net prod.
                      
        verbose (opt)   -  Boolean of whether to print errors if found or not. 
        
        map_dict(opt)   - A dictionary used to map compoudns from one name to another. 
        
    Outputs: 
    -------- 
       fline_out -    A  string corresponding to fline in where the  fractions used in the fline 
                  have been verified against the product & reactant stoichiometry in the rnames line. 
                  If sort_indx is passed, it will also be sorted so that things appear in the fline 
                  as they would in the sorted reaction.(Obv with rcts before prods still)... 
                 'fC(i)=fC(i)-1; fZ(i)=fZ(i)-14;  fG(i)=fG(i)+3.45; fV(i)=fV(i)+12;
                 
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    ----------
    1/18/2022    JDH Created 
    """ 
    if len(fline_in) >0: 
        fs_cmts= fline_in.split('%') # Look for any comments after line 
    else: 
        fs_cmts=['','']
        
    comments=' % '+' '.join(fs_cmts[1:]) if len(fs_cmts) >1 else '' # Store it if you got one. 
    
    # Get a list of the fstrs you have in fline_in for this rx
    fs_have=[f.replace(' ', '')+';' for f in  fs_cmts[0].split(';') if f.replace(' ', '')+';' != ';']

    # Map f variables to a different name if map_dict is passed.
    for fi, fstr in enumerate(fs_have) :
        for old in map_dict.keys():
            if 'f'+old+'(i)' in fstr: 
                fs_have[fi]=fstr.replace('f'+old+'(i)', 'f'+str(map_dict[old])+'(i)')
   
    # Flag any f-strings that are dif from what you should have (and ones that 
    # werent replaced or removed because they were dupes or combined).... 
    missing_f=[indd for indd, fstr in enumerate(fs_have) if (fstr not in f_should_have) and \
               (fstr not in f_replaced) and (fstr not in f_removed) and \
                   'fRO2(i)' not in fstr and 'fH2O(i)' not in fstr]
    

    if len(missing_f) >0: 
        # Don't flag things for having different # of decimal places between rxn str and fline. 
        sh_brk= []
        for ct, sh in enumerate(f_should_have):
            for op in ['+', '-']: 
                if op in sh: 
                    num= np.float64(sh.split(op)[1].split(';')[0])
                    fi=sh.split('=')[0] # Get just the fDETLMUNO3(i) operator. 
                    sh_brk.append([fi, op, num])
        ind2pop=[];        
        for ct, baddie in enumerate(missing_f): 
            for op in ['+', '-']:  # Get # only ... # fDETLMUNO3(i)=fDETLMUNO3(i)-0.45; becomes  --> '0.45' 
                if op in fs_have[baddie]: 
                    num= np.float64(fs_have[baddie].split(op)[1].split(';')[0])
                    fi=fs_have[baddie].split('=')[0] # Get just the fDETLMUNO3(i) operator. 
                    ind, ls= find_in_list([fi, op, num], sh_brk)
                    if len(ind) > 0: # We found a match. things are just dif decimals! 
                        ind2pop.append(ct)
         
        [missing_f]=drop_indxs_from_lists([missing_f], ind2pop)
    
    if len(missing_f) >0: 
        if verbose is True: 
            print ('Bad F-string found in rxn: ', "'"+rnames_line+"'", "\n    ", fs_cmts[0] , '\n')   
            [print('     This string:', "'"+fs_have[baddie]+"'", 'should be in:', "'",f_should_have, f_replaced, f_removed,"' \n \n") for baddie in missing_f]
            
            if len(missing_f) >0: input()
    
    # Never keep RO2 in the fline... will deplete RO2 and thats bad / will break F0AM! 
    [f_should_have.remove(ln) for ln in f_should_have if 'fRO2(i)' in ln]
    
    # Now craft the F-List based on what you should have.... 
    fline_out= ' '. join(f_should_have)+ comments
    
    return fline_out


def check_gline(rnames_line, gline_in, rct_cmpds, sort_rcts=[], verbose= True, map_dict=dict({})):
    """Function to take a reaction line and a Gstr line and make sure that the 
    reactants in the Gstr line is what are  actually are the rcts in the rxn line!!! 
    Will OVERWRITE the Gs-line if differences are found.
    
    Inputs: 
    -------
        rnames_line- String from a rxn list that has an indv reaction on it: 
                    rnames_line= "Rnames{i}='14Z+ C= 12V + 3.45G'; % Comment v important " 
                    
        gline_in   - String from a f_list that has fractional stoichiometry for rxn on it.  Can be empty.
                     gline_in= 'Gstr{i,1} ='Z';  Gstr{i,2} ='C';  % V impt comment'
                     
        rct_cmpds  -  A list of reactants in the rnames_line. = ['Z','C']
        
        sort_rcts  -  A list of indices that sort rct_cmpds. 
                      
        verbose    -  Boolean of whether to print errors if found or not. 
        
    Outputs: 
    -------- 
       gline_out -    A  string corresponding to gline in where the reactants used in the gline 
                  have been verified against the reactants in the rnames line. 
                  If sort_indx is passed, it will also be sorted so that things appear in the gline 
                  as they would in the sorted reaction.(Obv with rcts before prods still)... 
                 ' Gstr{i,1} ='C'; Gstr{i,2} ='Z';   % V impt comment' 
                 
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    ----------
    1/18/2022    JDH Created 
    """
    if len(gline_in )>0: 
        gs_cmts= gline_in.split('%') # Look for any comments after line 
    else: 
        gs_cmts=['', '']; 
    comments=' % '+' '.join(gs_cmts[1:]) if len(gs_cmts) >1 else '' # Store it if you got one. 

    # Get a list of the gstrs you have in gline_in for this rx
    gs_have=[g.replace(' ', '')+';' for g in  gs_cmts[0].split(';') if g.replace(' ', '')+';' != ';']
    
    # Map gs you have to what they'd be using map dict so comparison to mapped shoulds isn't wonky. 
    for gi, gstr in enumerate(gs_have) :
        for old in map_dict.keys():
            if "'"+old+"';" in gstr: 
                gs_have[gi]=gstr.replace("'"+old+"'", "'"+str(map_dict[old])+"'")
                
    # Build a list of what you *should* have for all the Gstrs on this line. 
    should_have= ["Gstr{i,"+str(ii+1)+"}='"+cmpd_i+"';" for ii, cmpd_i in enumerate(rct_cmpds) if cmpd_i != 'hv']
    
    # Don't pop an error just because the items in G are sorted in a dif way
    for n, rct_i in enumerate(rct_cmpds): 
        for indxx, gstr in enumerate(gs_have): 
            if rct_i in gstr: 
                current_ind= [h.group() for h in re.finditer(r"(?<=Gstr{i,).*?(?=}\=\'"+rct_i+"\';)", gstr) if h.group() !='']
                if len(current_ind) >0: 
                    indd=current_ind[0]
                    gs_have[indxx]=gstr.replace("{i,"+str(indd)+"}","{i,"+str(n+1)+"}")  
                    
    # Check whether you have all the Gstrs you should have.... Is True if Invalid found 
    invalid=[indd for indd, gstr in enumerate(gs_have) if gstr not in should_have]
    
    if len(invalid) >0 and verbose is True: 
        print ('Bad G-string found in rxn: ', "'"+rnames_line+"'", "\n", 'Original: ',gs_cmts[0], "\n" )   
        [print('     This string:', "'"+gs_have[baddie]+"'", 'should be in', "'",should_have,"' \n \n") for baddie in invalid]
    
    # Now Craft the G-List based on what you should have.... 
    gline_out= ' '. join(should_have)+ comments
    
    return gline_out


def combo_dupes(rcts, rct_yld, prds, prd_yld):
    """
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    ----------
    1/18/2022    JDH Created 
    """
    fs=[]; f_should_have=[]; f_removed=[]; f_replaced=[];# Build list of fs for each and every reactant & product  
    [fs.append('f'+cmpd_i+'(i)=f'+cmpd_i+'(i)-'+str(rct_yld[j])+';') for j,cmpd_i in enumerate(rcts)]
    [fs.append('f'+cmpd_i+'(i)=f'+cmpd_i+'(i)+'+str(prd_yld[j])+';') for j,cmpd_i in enumerate(prds)]
    
    rct_dupes= list_dupes(rcts) # Get duplicates in rcts or prds. 
    prd_dupes= list_dupes(prds)
        
    rct_2_drop=[];
    cmb_rct_yld=rct_yld.copy();
    for rct_i in rct_dupes.keys():
        tote_r_yld=np.sum([rct_yld[ind] for ind in rct_dupes[rct_i] ]) # Add yield of duplicates 
        if np.mod(tote_r_yld,1)==0:
            tote_r_yld=np.int64(tote_r_yld)
        else:
            tote_r_yld=toDecimal(tote_r_yld,2) 
        [rct_2_drop.append(y) for x,y in enumerate(rct_dupes[rct_i]) if x>0] # index of all duplicates that aren't 1st occurance
        [f_replaced.append(fs[y]) for y in rct_dupes[rct_i]]
        cmb_rct_yld[rct_dupes[rct_i][0]]=tote_r_yld; # Update first occurance to the total yield.
        
    prd_2_drop=[]; 
    for prd_i in prd_dupes.keys():
        tote_p_yld=np.sum([prd_yld[ind] for ind in prd_dupes[prd_i] ]) # Add yield of duplicates 
        if np.mod(tote_p_yld,1)==0:
            tote_p_yld=np.int64(tote_p_yld)
        else:
            tote_p_yld=toDecimal(tote_p_yld,2) 
        [prd_2_drop.append(y) for x,y in enumerate(prd_dupes[prd_i]) if x>0] # index of all duplicates that aren't 1st occurance
        [f_replaced.append(fs[np.int64(y)+np.int64(len(rcts))]) for y in prd_dupes[prd_i]]
        prd_yld[prd_dupes[prd_i][0]]=tote_p_yld; # Update first occurance to the total yield.
                       
    # Indicies to drop are for rct+prd, so need to add len(rct) to prd) before dropping those for any duplicates! 
    f2drop=rct_2_drop+[np.int64(ind)+np.int64(len(rct_2_drop)) for ind in prd_2_drop]
    
    # Drop indices from rcts, ylds, and "ideal" fstrs. 
    fs= drop_indxs_from_lists([fs], f2drop)  
    
    [C_rcts, C_rct_yld]= drop_indxs_from_lists([rcts, cmb_rct_yld], rct_2_drop)
    [prds, prd_yld]= drop_indxs_from_lists([prds, prd_yld], prd_2_drop) 
    
    # If compounds are in reactants and products, combine into ONLY ONE f_str.
    # Otherwise write an F-str that is should be based on its yield stripped from rxn. 
    for cmpd_i in list(C_rcts+prds):
        f_of='f'+cmpd_i+'(i)'
        
        if cmpd_i in C_rcts: 
            yld_r=C_rct_yld[C_rcts.index(cmpd_i)]
            f_str=f_of+'='+f_of+'-'+str(yld_r)+';'
            
        if cmpd_i in prds: 
            yld_p=prd_yld[prds.index(cmpd_i)]
            f_str=f_of+'='+f_of+'+'+str(yld_p)+';'
            
        if cmpd_i in C_rcts and cmpd_i in prds: 
            if yld_p== yld_r: # conc does not change from rx. 
                f_removed.append(f_of+'='+f_of+'-'+str(yld_r)+';')
                f_removed.append(f_of+'='+f_of+'+'+str(yld_p)+';')
                f_str=''
            else:
                if yld_r > yld_p: # Net lose stuff to this rx 
                    yld_c=yld_r- yld_p; op = '-'
                    f_removed.append(f_of+'='+f_of+'+'+str(yld_p)+';')
                    f_replaced.append(f_of+'='+f_of+'-'+str(yld_r)+';')
                if yld_p > yld_r: # Net make stuff from this rx 
                    yld_c=yld_p- yld_r; op = '+'
                    f_removed.append(f_of+'='+f_of+'-'+str(yld_r)+';')
                    f_replaced.append(f_of+'='+f_of+'+'+str(yld_p)+';')
                    
                if np.mod(yld_c,1)==0: 
                    yld_c=np.int64(yld_c)
                else:
                    yld_cs=[toDecimal(yld_c,n) for n in range(1,4)]
                    [f_removed.append(f_of+'='+f_of+op+str(i)+';') for i in yld_cs]
                    yld_c=yld_cs[2]
                f_str=f_of+'='+f_of+op+str(yld_c)+';'
            
        # List of f_strs that are ONLY the ones you actually need.
        if f_str!= '': f_should_have.append(f_str)
    
    # Never keep RO2 in the Fline... will depete RO2 and thats bad. 
    [f_should_have.remove(ln) for ln in f_should_have if ('fRO2(i)' in ln) or ('fhv(i)' in ln)]
    
    loss= [i for i, fstr in enumerate(f_should_have) if '-' in fstr]
    plus= [i for i in range(0, len(f_should_have)) if i not in loss] 
    
    f_shoulds=[];
    for v in loss+plus: # Force losses to be before pluses! 
        f_shoulds.append(f_should_have[v]);                       
            
    return rcts, rct_yld,prds, prd_yld, f_shoulds, f_replaced, f_removed
  
  
def sep_stoich_vs_tracer(rxn_str:str, seps:list=['+','=', '->', '-->', '<->'] ):
    """Seperate all stoichiometry from compounds in a string into 2 lists.
    
    Inputs: 
        rxn_str='TOLU + OH = TRO2 + 1.920CH2O + 0.260GLYX + 0.215MGLY + OH' 
        seps= ['+', '=']
    Outputs: 
        cmpds= ['TOLU', 'OH', 'TRO2', 'CH2O', 'GLYX', 'MGLY', 'OH']
        stoich= [1, 1, 1, 1.920, 0.260, 0.215, 1]
        
    Notes: Don't have to pass a whole rxn. Can pass just rcts or prds. 
           Function won't work properly if chem compounds can begin with numbers. 
           
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    ----------
    1/18/2022    JDH Created 
    """
    ls=[]; cmpds=[]; stoich=[] 
    for sep in seps:  # Split input string at the input seperators: 
        ls=ls+rxn_str.replace(' ' , '').split(sep)   # ls =['TOLU','OH','TRO2','1.920CH2O','0.260GLYX','0.215MGLY','OH'] 
    
    for grp in ls: # Loop over all groupings in the list split at seps
        if len(grp) > 0:
            if grp[0].isalpha(): # If str begins with a letter, then its a tracer name (e.g. 'TOLU'). 
                cmpds.append(grp); stoich.append(1) # Save the compound, save the stoichiometry. 
            
            else: # Otherwise, loop over the chars in the grp til you find a letter. 
                yld=grp[0]; ind=1; found_yld=False #Set yileld= to first char (not-a letter!)
                
                while found_yld==False:  #loop til you find a letter. 
                    if grp[ind].isnumeric() or grp[ind]=='.': # Found a letter or decimal place. 
                        yld=yld+grp[ind];  # Add to str containing all stoichiometry. 
                    elif grp[ind].isalpha() or  ind==len(grp)-1: # Found beginning of compound name. 
                        cmpds.append(grp[ind:]) # Store it 
                        stoich.append(np.float64(yld)) # and the #s making up the yield as a #
                        found_yld=True
                        break
                    ind=ind+1
                    
    if 'hv' in cmpds: cmpds.pop(cmpds.index('hv'))
    return cmpds, stoich


def build_all_from_rxns(rxn_list:list, k_list:list, f_list:list=[], g_list:list=[], 
                        sort_rxn_i=True, sort_rxn_list=False, verbose=True,map_dict= dict({})):
    """Function to bulid a F0AM Compliant mechanism from a list of reactions & rates . 
    
    Inputs: 
    -------        
        rxn_list- list of all reactions to write to the F0AM mechanism.
        
        k_list - list of all rates of reactions in the mechanism. 
                
        f_list (optional) - list of stoichiometry for rxn. This is fOH=fOH(i) +1; line in F0AM.  
                If provided, input f_list is compared to what it should be based on input rxn_list.  
        
        g_list (optional)  - list of all reactants in each reaction. This is Gstr{i,:}= line in F0AM.. 
                If provided, input g_list is compared to what it should be based on input rxn_list.

        sort_rxn_i (optional) - Boolean of whether you want to sort items in the rxn. 
                (e.g. OH + APINENE -->   becomes APINENE + OH --> )
        
        sort_rxn_list (optional) - Boolean of whether you want to sort all reactions 
                       by reactant (e.g. all APINENE + XXX --> will appear together in 
                       alphabetical order. This makes it easy to see all fates of a reactant in the mech. 
                   
        map_dict (optional) - Dictionary to map names in mech to dif ones. Useful if 
             you are using an MCM based mech with another that has dif var names (like GEOS-Chem)...
    
        verbose (optional) - Boolean of whether to print errors when found... 
        
    Outputs: 
    --------
        sp_list - list of all species in any rxn in mechanism
        
        rxns_all- list of strings formatted to be the the "Rnames" line in F0AM. 
        ks_all -  list of strings formatted to be the  k(i,:)= line in F0AM. 
        gs_all -  list of strings formatted to be the Gstr{i,:}= line in F0AM. 
        fs_all -  list of strings formatted to be the fOH(i)=fOH(i)+1  line in F0AM.
        rct_cmpds- nested list of all reactants in a reaction_i in the reaction list. 
        rct_stoich- nested list of the yields/stoichiometry of rct_cmpds for reaction_i
        prd_cmpds- nested list of all products in a reaction_i in the reaction list. 
        prd_stoich- nested list of the yields/stoichiometry of prd_cmpds for reaction_i
    
        rxn_list, ks_all, gs_all, fs_all, should all be size (n_rxns x 1). 
        rct_cmpds, rct_yields, prd_cmpds, prd_ylds, should all be size (n_rxns x 1:n_cmpds). 
    
    Custom Functions: 
    -----------------
        to_Decimal() 
        sep_stoich_vs_tracer() 
        combo_dupes()
        sort_rxn_indv() 
        check_flin()
        check_gline()
        enforce_list_inds()  ->  (in list_utils_f0am.py) 
        str_multi_replace()  ->  (in list_utils_f0am.py) 
        find_in_list()       ->  (in list_utils_f0am.py) 
        
    
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    -----------
        1/18/2022 JDH Created 
        
        """ 
    # Set up empty lists to hold outputs. 
    sp_list=[]; rct_stoich=[]; rcts=[]; prd_stoich=[]; prds=[]
    rx_all=[];  fs_all=[]; gs_all=[]; ks_all=[]; 
    
    for indx, rxn_i in enumerate(rxn_list): 
        
        line=rxn_i.split("'") # Reactions in Rnames lines have apostrophes around them. 
        comments=line[2] if len(line)>1 else ''  # Anything that comes after the ' is a comment! 
        rx=line[1]
        
        if len(rx)>1:# Make sure we actually have some data in this line. No spaces. 
            rx_only=rx.replace(' ', '')
            
            # Split reaction into reactant & product halves 
            rct_half=rx_only.split('=')[0]; 
            prd_half=rx_only.split('=')[1]
            
            # Pass to function to seperate rct and prd halfs into stoich & compounds. 
            rct_cmpds, rct_ylds= sep_stoich_vs_tracer(rct_half, seps=['+']) # '+' is delimitor that seperates them. 
            prd_cmpds, prd_ylds= sep_stoich_vs_tracer(prd_half, seps=['+'])
                
            # Map the compound name if asked. (Will propogate into f and g lists sincemapping is  done here). 
            if len(list(map_dict.keys())) > 0:
                for cmpd_i in rct_cmpds: 
                    if cmpd_i in list(map_dict.keys()): 
                        d, rct_cmpds_= find_in_list(cmpd_i, rct_cmpds, replace_with=str(map_dict[cmpd_i]))
                for cmpd_i in prd_cmpds: 
                    if cmpd_i in list(map_dict.keys()): 
                        d, prd_cmpds= find_in_list(cmpd_i, prd_cmpds, replace_with=str(map_dict[cmpd_i]))
            
            # Sort the reaction to have move things like "+OH, '+hv" to the ned of the rxn. 
            if sort_rxn_i is True: 
                rct_cmpds,prd_cmpds,rct_ylds,prd_ylds=  sort_rxn_indv(rct_cmpds,prd_cmpds,rct_ylds,prd_ylds)
        
            # Combine any products that are listed twice .... (not rcts!) 
            outs=combo_dupes(rct_cmpds, rct_ylds, prd_cmpds, prd_ylds)
            [rct_cmpds, rct_ylds,prd_cmpds, prd_ylds, f_shoulds, f_replaced, f_removed]= outs
            
            # Make reaction rate lists into correct format: 
            kline=  k_list[indx] 
            kline=str_multi_replace(kline, dict({'^':'.^', '*':'.*', '/':'./', '..*':'.*', '../':'./', '..^':'.^'}))
            if 'k(:,i)=' not in kline.replace(' ', ''):
                new_kline='k(:,i)='+kline + ';'
            else: 
                new_kline= kline
            
            # If f-list is provided, compare it against what it "should" be. 
            fin=f_list[indx] if len(f_list) > 0 else  ''
            new_fline=check_fline(rxn_i, fin, f_shoulds, f_replaced, f_removed,
                        verbose=verbose, map_dict=map_dict)
            
            # If g-list is provided, compare it against what it "should" be. 
            gin=g_list[indx] if len(g_list) > 0 else  ''
            new_gline= check_gline(rxn_i, gin, rct_cmpds, verbose=verbose,
                                  map_dict=map_dict)
            
            # Convert rct/ prd stoichiometry to strings. Keep 3 decimal spaces. 
            rct_ylds_strs=[str(yll) if yll!= 1 else '' for yll in rct_ylds]
            prd_ylds_strs=[str(yll) if yll!= 1 else '' for yll in prd_ylds]
            
            # Put stoichiometry and compounds back together into a rxn  
            rct_half= '+'.join([rct_ylds_strs[ind] + rct_cmpds[ind] for ind in range(0, len(rct_cmpds))])
            prd_half= '+'.join([prd_ylds_strs[ind] + prd_cmpds[ind] for ind in range(0, len(prd_cmpds))])
            new_rx="Rnames{i}='"+rct_half+'='+prd_half+"'"+comments
            
            # Save the species in this line to the bigger list if they're not in it already. 
            [sp_list.append(sp) for sp in rct_cmpds+ prd_cmpds if sp not in sp_list and sp not in['RO2', 'hv']]
            sp_list.sort()
            
            # Now save everything to output lists: 
            rcts.append(rct_cmpds);         prds.append(prd_cmpds)
            rct_stoich.append(rct_ylds);    prd_stoich.append(prd_ylds)
            rx_all.append(new_rx);          fs_all.append(new_fline); 
            gs_all.append(new_gline);       ks_all.append(new_kline)
            
    if sort_rxn_list is True: # Sort reactions alphabetically if asked so all APINENE + X rxns appear together. 
        sort_ind=np.argsort(rx_all) 
        sout= enforce_list_inds(sort_ind,[rx_all, fs_all, gs_all, k_list, rcts, prds, rct_stoich, prd_stoich])
        [rx_all, fs_all, gs_all, ks_all, rcts, prds, rct_stoich, prd_stoich] = sout
        
    return [sp_list, rx_all, fs_all, gs_all, ks_all, rcts, prds, rct_stoich, prd_stoich]
    
    
def check_mech(species_list,ro2_list,rxn_list,k_list,g_list,f_list, n_species=-1, n_rxns=-1, 
               fix_errors=True, sort_rxn_i=False, sort_rxn_list=False,
               verbose=True, mech_name='', map_dict=dict({}),): 
    """Function to parse lists about a F0AM mechanism and check that they are formatted correctly 
    
    Author: Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    1/18/2022: JDH Created """
    
    if verbose is True: print(' Checking ... ', mech_name)
    check_lens(rxn_list,k_list,g_list,f_list, 'ERROR : Found in Check: rxn, k, f, g, not same len. ' )
    cor=False # Boolean of whether output should be corrected... 
    
    # Check that the species List, f-list and g-list are consistent with the reaction list by "building" 
    # what they should be from the reaction list. Fix_errors=True will use the "built" lists... 
    out=build_all_from_rxns(rxn_list,k_list=k_list, f_list= f_list, g_list=g_list, map_dict= map_dict, 
                        sort_rxn_i=sort_rxn_i, sort_rxn_list=sort_rxn_list)
    [sps_declared,rxn_list, f_list, g_list, k_list, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds]= out
        
    # Look for species that are in mech but not declared (and remove any changed from mapping!)
    missing= list(set(sps_declared) - set(species_list)) # list of sp not declared. 
    [missing.pop(missing.index(n)) for n in list(missing) if n in list(map_dict.values())+['hv', 'RO2'] and n in missing] 
    
    extra= list(set(species_list) - set(sps_declared)) # list of sp declared & not used. 
    [extra.pop(extra.index(n)) for n in list(extra) if n in list(map_dict.keys())+['hv', 'RO2'] and n in extra] 
    
    if len(missing) > 0:  
        if verbose is True: print('Species_list is missing the following:', missing); cor=True;
        species_list=species_list+missing; n_species=len(species_list)
        
    if len(extra) > 0:  
        if verbose is True: print('Species_list has the following extras:', extra); cor=True; 
        for this in extra:  species_list.remove(this) 
        n_species=len(species_list);
        
    for v in ['RO2', 'hv']: # Can't declare RO2 in species or RO2 list or F0AM will crash. 
        if v in species_list: 
            species_list.remove(v); cor=True
            if verbose is True and v=='RO2': print('CRITICAL: Found "RO2" in species_list. Removing or F0AM will crash!'); 
            if verbose is True and v=='hv': print('Found "hv" in species_list. Removing .')
        if v in ro2_list: 
            ro2_list= ro2_list.remove(v); cor=True
            if verbose is True and v=='RO2': print('CRITICAL: Found "RO2" in ro2_list. Removing or F0AM will crash!');
            if verbose is True and v=='hv': print('Found "hv" in ro2_list. Removing .')
            
    if n_rxns != -1 and n_rxns!= len(rxn_list): 
        if verbose is True:    print('Header stating # of reactions', n_rxns,' is incorrect. n_rxns is:', len(rxn_list) );
        n_rxns= len(rxn_list);  cor=True;
        
    if n_species != -1 and n_species!= len(species_list): 
        if verbose is True:  print('Header stating # of species', n_species,' is incorrect. n_species is:', len(species_list) );
        n_species= len(species_list);  cor=True;
        
    if n_species ==-1: n_species=len(species_list) 
    if n_rxns ==-1: n_rxns =len(rxn_list)
        
    species_list=[map_dict[sp] if sp in map_dict.keys() else sp for sp in species_list]
    
    return cor, [species_list,ro2_list,rxn_list,k_list,g_list,f_list, n_species, n_rxns,
                 rct_cmpds, prd_cmpds, rct_ylds, prd_ylds]


def check_lens(rxn, k, g, f, error ):
    """ Function to check the lengths of the rxn, k g, and f lists. Should always be same len. 
    
    Author: 
    -------
        Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask
    
    Change Log: 
    ----------
    1/18/2022    JDH Created 
    """ 
    if any(x !=len(rxn) for x in [ len(k), len(g), len(f)] ): 
        print (error)
        print('Len (rxns)= ',len(rxn))
        print('Len (k)= ',   len(k))
        print('Len (g)= ',   len(g))
        print('Len (f)= ',   len(f))
        return 

