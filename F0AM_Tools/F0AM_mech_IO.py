# -*- coding: utf-8 -*-
"""
Created on Thu Oct  7 09:16:41 2021

@author: jhask
"""
import numpy as np 
import csv
import os 
import re 
import pandas as pd 
import sys 

sys.path.insert(0, 'C://Users//jhask//OneDrive//Documents//Python//private//') 
from list_utils import *
from custom_functions import *

sys.path.insert(0,'C:/Users/jhask/OneDrive/Documents/Research/Projects/MIT/pOrgNO3/code/MCM_RCIM_SMILES/python/pyMCM/')
from MCM_web_scraper import *
    
sys.path.insert(0,'C://Users//jhask//OneDrive//Documents//Research//Projects//MIT//pOrgNO3//code//plot_mechanism//')
from plot_mech import cascade_mech


def sort_rxn_indv(rct_cmpds,prd_cmpds,rct_ylds,prd_ylds):

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

                
def read_F0AM_mech(file,  tag='', map_dict=dict({}), check=True, read_only=True,
                   sort_rxn_i=False, sort_rxn_list=False, return_comments=False):
    """Function to read in a F0AM mechanism .m file...and return things like 
    the "Species List", the "RO2" list, the reactions, the rates (k), the gstr and the f 
    that are on each line... allows you to later parse these as lists  in python 
    with the same indices to do things like find their chem families, look for dupes, etc.
    
    Inputs
    ------
        file = path to .m file holding reactions for a F0AM mechanism. 
        
        tag (optional) = A MATLAB comment to add on to the Rnames line that says what
                   mechanism this reaction is from. Useful if combining mechanisms later. 
                   
        map_dict (optional) - dictionary to map names in mech to dif ones. 
        
        read_only (optional) - boolean of whether to read in stuff only or if 
            you want the option to correct things in the mech found using a write function. 
            
        sort_rxn_i (optional) - boolean of whether you want to sort items in the rxn. 
                (e.g. OH + APINENE -->   becomes APINENE + OH --> )
        
        sort_rxn_list (optional) - boolean of whether you want to sort all reactions 
                       by reactant (e.g. all APINENE + XXX --> will appear together in 
                        alphabetical order. This makes it easy to see all fates of a reactant in the mech. 
        
    Outputs
    -------
    
    n_species - integer number of unique species in the mechanism. 
    n_rxns - integer number of reactions in the mechanism.
    species- list of all species in the mechanism (EXCEPT "RO2", don't declare this in F0AM!!!). 
    ro2- list of all species that are "RO2" in the mechanism. EXCEPT "RO2" ^^
    
    rxn- list of all reactions in the mechanism. This is the "Rnames" line in MATLAB. 
    k - list of all rates of reactions in the mehcanism. This is k(i,:)= line in MATALB. 
    g - list of all reactants in each reaction. This is Gstr{i,:}= line in MATALB. 
    f - list of stoichiometry each reaction changes in mech. This is fOH(i)=fOH(i)+1  line in MATALB. 
    rct_cmpds- nested list of all reactants in a reaction_i in the reaction list. 
    rct_ylds- nested list of the yields/stoichiometry of rct_cmpds for reaction_i
    prd_cmpds- nested list of all products in a reaction_i in the reaction list. 
    prd_ylds- nested list of the yields/stoichiometry of prd_cmpds for reaction_i
    
    rxn, k, g, f, rct_cmpds, rct_yields, prd_cmpds, prd_ylds, should all be the same size. 
                If n_rxns declared in header is correct, then they should be size (n_rxns x 1). 
                If n_species declared in header is correct,  then "species" should be size (N-species x 1). 
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
        cors, info= check_mech_n_map(species, ro2, rxn, k, g, f, n_species=n_species, 
                               n_rxns=n_rxns, mech_name=file, map_dict=map_dict, 
                               sort_rxn_i=sort_rxn_i, sort_rxn_list=sort_rxn_list, verbose=True)
        
        # Unpack all the new stuff. 
        [species,ro2,rxn,k,g,f, n_species, n_rxns,rct_cmpds, prd_cmpds, rct_ylds, prd_ylds] = info
        
    else: 
        cors=False
        rct_cmpds=[]; prd_cmpds=[]; rct_ylds=[]; prd_ylds=[];
        
    mech_title=' '.join(comments); #Steal comments from orign.
    if cors is True and read_only is False: # Corrections have been made... ask if they want to overwrite the file with them? 
        ow='-1'; 
        while ow not in ['0','1','2']:
            ow= input('Write file with all corrections?  0 = No, 1= To a new file, 2= Overwrite original ') 
        if ow=='1' or ow =='2':  
            if ow=='1': overwrite=False; 
            if ow=='2': overwrite=True; 
        
            # And write it to the file...                
            file= file.replace('.m', '') # remove .m extension
            write_mech_to_file(file, species,ro2,rxn,k,g,f, 
                        mech_title=mech_title, overwrite= overwrite)
            
    if return_comments==False: 
        # Return lists of everything we got out of the mechanism.
        return [n_species, n_rxns, species, ro2, rxn, k, g, f, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds]
    else:
        return [n_species, n_rxns, species, ro2, rxn, k, g, f, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds, mech_title,
                    insert_cmt, insert_ind]


def check_fline(rnames_line, fline_in, f_should_have, f_replaced, f_removed,
                verbose= True, map_dict=dict({})):
    """Function to take a reaction line and a fstr line and make sure that the 
    amount made in the fstr line is what is actually made in the rxn line!!! 
    Will OVERWRITE the fs-line if differences are found.
    

        
    Inputs: 
    -------
        rnames_line- String from a rxn list that has an indv reaction on it: 
                    rnames_line= "Rnames{i}='14Z+ C= 12V + 3.45G'; % Comment v important " 
                    
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
    """ 
    if len(fline_in) >0: 
        fs_cmts= fline_in.split('%') # Look for any comments after line 
    else: 
        fs_cmts=['','']
        
    comments=' % '+' '.join(fs_cmts[1:]) if len(fs_cmts) >1 else '' # Store it if you got one. 
    
    # Get a list of the fstrs you have in fline_in for this rx
    fs_have=[f.replace(' ', '')+';' for f in  fs_cmts[0].split(';') if f.replace(' ', '')+';' != ';']

    
    # MAP FS YOU HAVE TO THEIR MAPPED VALS TO MAPPED FS SHOULD HAVE. 
    for fi, fstr in enumerate(fs_have) :
        for old in map_dict.keys():
            if 'f'+old+'(i)' in fstr: 
                fs_have[fi]=fstr.replace('f'+old+'(i)', 'f'+str(map_dict[old])+'(i)')
            
    # Flag any f-strings that are dif from what you should have (and ones that 
    # werent replaced or removed because they were dupes or combined).... 
    missing_f=[indd for indd, fstr in enumerate(fs_have) if (fstr not in f_should_have) and \
               (fstr not in f_replaced) and (fstr not in f_removed)]
    if len(missing_f) >0: 
        if verbose is True: 
            print ('Bad F-string found in rxn: ', "'"+rnames_line+"'", "\n    ", fs_cmts[0] )   
            [print('     This string:', "'"+fs_have[baddie]+"'", 'should be in:', "'",f_should_have, f_replaced, f_removed,"' \n \n") for baddie in missing_f]
            
            if len(missing_f) >0: input()
    
    # Never keep RO2 in the Fline... will depete RO2 and thats bad. 
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
    
    # Don't pop an error just because they're sorted in a dif way
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
    
    # Now craft the F-List based on what you should have.... 
    gline_out= ' '. join(should_have)+ comments
    
    return gline_out


def combo_dupes(rcts, rct_yld, prds, prd_yld):
        
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
    
    
def build_all_from_rxns(rxn_list, f_list=[], g_list=[], k_list=[], map_dict= dict({}), 
                        sort_rxn_i=True, sort_rxn_list=False, verbose=True):
    
    rct_ylds_all=[]; rct_cmpds_all=[]
    prd_ylds_all=[]; prd_cmpds_all=[]
    fs_all=[]; gs_all=[]; sp_list=[]; rx_all=[]
    
    for indx, rxn_i in enumerate(rxn_list): 
        line=rxn_i.split("'") # Reactions in Rnames lines have aporstrophes around them. 
        comments=line[2] if len(line)>1 else ''  # Anything that comes after is a comment. 
        
        if len(line)>1:# Make sure we actually have some data in this line. 
            rx_only="'"+line[1].replace(' ', '')+"'" # Put apostrpophes back. Need to id beg/ends! 
            
            # Catch everything in between +s, =s or apostropphes. 
            inbetween= r'(?<=[\+\=\']).*?(?=[\+\=\'])'
            
            # All reactants, prods with yields still attached. 
            mtch=[h.group() for h in re.finditer(inbetween,  rx_only) if h.group() != '']
            
            #Seperate the yields from the compounds in this rxn/ 
            num_only=r"[0-9+.+0-9*]+[a-zA-z]"; yld=list(); cmpd=[]
            for m in mtch: 
                if ~np.char.isnumeric(m[0]) and (m[0]!='.'):
                    yld.append(1) # Beghins with letter, is a compound, keep # then. 
                    cmpd.append(m) # Whole match is a compound no yield. 
                else: 
                    yld_i=np.float64(re.match(num_only, m).group()[:-1])
                    sig_fig=len(re.match(num_only, m).group()[:-1])
                    if np.mod(yld_i, 1)==0: 
                        yld_i= np.int64(yld_i)
                    elif sig_fig != len(str(yld_i)) : 
                        yld_i=toDecimal(yld_i,np.int(sig_fig-2))
                    yld.append(yld_i)# Keep yield 
                    cmpd.append(m[sig_fig:]) # Yield comes first. take it out of mtch str. 
            
            # Decide if thing we split into cmpd & yld into was rct or prd... 
            equals=[rxn_i.replace(' ', '') for rxn_i in  line[1].split('=')]
            rcts=list(equals[0].split('+')) if len(equals[0])>2  else [equals[0]]
            prods=list(equals[1].split('+')) if len(equals[1])>2  else [equals[1]]
             
            rcts=[r.replace(' ', '') for r in rcts if r != '']; 
            prods=[p.replace(' ', '') for p in prods if p != '']; 
            
            # We know rcts come first, so split the matched compounds into rcts, prds  based on len of rct list.
            rct_cmpds=cmpd[0:len(rcts)]; rct_ylds=yld[0:len(rcts)];  
            prd_cmpds=cmpd[len(rcts):]; prd_ylds=yld[len(rcts):]; 
            
            # Do a quick check that we seperated things correctly: 
            is_this= [str(yld[i])+cmpd[i]  if str(yld[i]) !='1' else cmpd[i] for i in range(0, len(mtch))]
            
            valid= [is_this[ii]!=rx for ii, rx in enumerate(rcts+prods)]
            if any(valid) and verbose is True : print ('Errors in seperating yield from compounds!') 
            
            # Map the compound name if asked. (Will propogate into f and g since done here). 
            if len(list(map_dict.keys())) > 0:
                for cmpd_i in rct_cmpds: 
                    if cmpd_i in list(map_dict.keys()): 
                        d, rct_cmpds_= find_in_list(cmpd_i, rct_cmpds, replace_with=str(map_dict[cmpd_i]))
                for cmpd_i in prd_cmpds: 
                    if cmpd_i in list(map_dict.keys()): 
                        d, prd_cmpds= find_in_list(cmpd_i, prd_cmpds, replace_with=str(map_dict[cmpd_i]))
            
            if sort_rxn_i is True: 
                rct_cmpds,prd_cmpds,rct_ylds,prd_ylds=  sort_rxn_indv(rct_cmpds,prd_cmpds,rct_ylds,prd_ylds)
        
            # Combine any products that are listed twice in both the f line and the prds lines (not rcts!) 
            outs=combo_dupes(rct_cmpds, rct_ylds, prd_cmpds, prd_ylds)
            [rct_cmpds, rct_ylds,prd_cmpds, prd_ylds, f_shoulds, f_replaced, f_removed]= outs
            
            fin=f_list[indx] if len(f_list) > 0 else  ''
            new_fline=check_fline(rxn_i, fin, f_shoulds, f_replaced, f_removed,
                        verbose=verbose, map_dict=map_dict)
            
            gin=g_list[indx] if len(g_list) > 0 else  ''
            new_gline= check_gline(rxn_i, gin, rct_cmpds, verbose=verbose,
                                  map_dict=map_dict)
            
            rct_ylds_m1s=[str(yll) if yll!= 1 else '' for yll in rct_ylds]
            prd_ylds_m1s=[str(yll) if yll!= 1 else '' for yll in prd_ylds]
            
            rct_half= '+'.join([rct_ylds_m1s[ind] + rct_cmpds[ind] for ind in range(0, len(rct_cmpds))])
            prd_half= '+'.join([prd_ylds_m1s[ind] + prd_cmpds[ind] for ind in range(0, len(prd_cmpds))])
            new_rx="Rnames{i}='"+rct_half+'='+prd_half+"'"+comments
            
            # Save the species in this line to the bigger list if they're not in it already. 
            [sp_list.append(sp) for sp in rct_cmpds+ prd_cmpds if sp not in sp_list and sp not in['RO2', 'hv']]
            sp_list.sort()
            
            # Now save everything to a list! 
            rct_cmpds_all.append(rct_cmpds);  prd_cmpds_all.append(prd_cmpds)
            rct_ylds_all.append(rct_ylds); prd_ylds_all.append(prd_ylds)
            fs_all.append(new_fline); gs_all.append(new_gline)
            rx_all.append(new_rx)
            
    if sort_rxn_list is True: 
        sort_ind=np.argsort(rx_all)
        if len(k_list) >0: 
            sortedd= enforce_list_inds(sort_ind,[rx_all, fs_all, gs_all, k_list, rct_cmpds_all, prd_cmpds_all, rct_ylds_all, prd_ylds_all])
            [rx_all, fs_all, gs_all, ks_all, rct_cmpds_all, prd_cmpds_all, rct_ylds_all, prd_ylds_all] = sortedd
   
    else: 
        ks_all=k_list 
        
    return [sp_list,rx_all, fs_all, gs_all, ks_all, rct_cmpds_all, prd_cmpds_all, rct_ylds_all, prd_ylds_all]
    
    
def check_mech_n_map(species_list,ro2_list,rxn_list,k_list,g_list,f_list, n_species=-1, n_rxns=-1, 
                     map_dict=dict({}), fix_errors=True, sort_rxn_i=False, sort_rxn_list=False,
                     verbose=True, mech_name=''): 
    
    cor=False # Flag for if corrections are reccommended  or not. 
    if verbose is True: print(' Checking ... ', mech_name)
    check_lens(rxn_list,k_list,g_list,f_list, 'ERROR : Found in Check: rxn, k, f, g, not same len. ' )
    
    # Check that the Species List, F-list and G-list are consistent with the reaction list by "building" 
    # what they should be from the reaction list. Fix_errors=True will use the "built" lists... 
    out=build_all_from_rxns(rxn_list, f_list, g_list, k_list, map_dict= map_dict, 
                        sort_rxn_i=sort_rxn_i, sort_rxn_list=sort_rxn_list)
    
    [sps_declared,rxn_list, f_list, g_list, k_list, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds]= out
    check_lens(rxn_list,k_list,g_list,f_list, 'ERROR : Found in Check: rxn, k, f, g, not same len after "build_from_rxns"')
        
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
        
    # Can't declare RO2 in species or RO2 list or F0AM will crash. 
    for v in ['RO2', 'hv']:
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
        
    if any(x !=len(rxn) for x in [ len(k), len(g), len(f)] ): 
        print (error)
        print('Len (rxns)= ', len(rxn))
        print('Len (k)= ', len(k))
        print('Len (g)= ', len(g))
        print('Len (f)= ', len(f))
        return 


def list2_MATLAB_cell_str(listy, preface_list:str='list = ', comment=True, return_len=False ):
    """ Function to take a list and convert it into a single string 
    that formats whatever is in the list as a MATLAB cell array, seperated by 
    semicolons, and that has a line break roughly where it should be to
    display properly in MATLAB. """
    
    cmt='%' if comment is True else '' # whether this list should be commented out or not.

    last_len=0; 
    full_list= cmt+preface_list
    n_lines=0
    for val in listy: # Make the full list a string. 
        com="'; "
        if val==listy[-1]: com="' }; \n" ; n_lines=n_lines+1
        full_list=full_list+ "'"+val+com
        if len(full_list) > last_len+75 and val!=listy[-1]: 
            full_list=full_list+' ... \n'+cmt; last_len=len(full_list)
            n_lines=n_lines+1
    if return_len is False:
        return full_list
    else:
        return full_list, n_lines
    
    
def write_mech_to_file(filename, species_list,ro2_list,rxn_list,k_list,g_list,f_list, 
                       mech_title='', overwrite= False, insert_cmt=[], insert_ind=[]): 
    """ Function to take species lists, ro2 lists, rxn list, k list, g list and f list and 
    write them to a F0AM compliant .m file that can be used in MATALB. 
    
    Inputs: 
    -------
        filename - name of the file the mechanism will be written to (DOES NOT INCLUDE '.m' Extension!)  
        
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
        
    """
    ext=''
    if '.' in filename: 
        nm=filename.split('.')
        filename=nm[0] 
        ext= '.'+nm[1]
    if (overwrite is False) or (len(ext)==0):  ext='.m' 
    
    n=1; filename0=filename;
    while os.path.isfile(filename+'.m'):
        if overwrite is True:  
            os.remove(filename+'.m') # Delete file if it currenly exists. 
        else: 
            if '_'+str(n-1) in filename:  filename=filename0; 
            filename=filename+'_'+str(n)
        n=n+1; 
        if os.path.isfile(filename+'.m') is False: break 
        
    # Open the output file and write headers line by line. 
    outF = open(filename+'.m', "w"); write_file= True; ln_num=0;  rct_ct=0
     
    check_lens(rxn_list,k_list,g_list,f_list, 'ERROR : Input to write to file does not match lens. ' )
    
    # Break up comments on %, add line break char for all comments...
    cmts=mech_title.split('%'); big_title=''; title_lines=len(cmts)
    for l in cmts[0:]: 
        big_title=big_title+'%'+l+'\n'

    # Turn species list & RO2 list into a MATLAB formatted  cell array as a single string!
    sps_lines= list2_MATLAB_cell_str(species_list, preface_list='SpeciesToAdd = {', comment=False)
    ro2_lines= list2_MATLAB_cell_str(ro2_list, preface_list='RO2ToAdd = {', comment=False)

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
    
    print('Mechanism written to file: ' , filename+'.m')
    return 


def make_mapping_dict(csv_file):
    """Function to read in CSV with RCIM --> MCM & vice versa  and put them in a 
    nice dict. There are "3" cases of how we match...  
    
    - For 1:1 mataches, the RCIM variable is converted to its MCM counterpart. 
    
    - For RCIM vars where there is NO MCM match, the RCIM name is used. 
    
    - CSV File contains "+" where an RCIM or MCM compound is a group of the other. 
         Mapping takes each individual compound and converts it to the grouped one. Except for 
         IEPOXc+IEPOXt (RCIM) =IEPOXB (MCM), which you have to do by hand 
         this  means we map MCM vars to their grouped buddy in the RCIM since
         the MCM is generally more explicit.
         """
    
    mapp=pd.read_csv(csv_file)
    RCIM_dict=dict({}) # dict to hold RCIM vars --> MCM vars 
    MCM_dict=dict({}) # dict to hold MCM vars --> RCIM vars 
    duped=[]; 
    for i,row in mapp.iterrows(): 
        
        # Decide if we're in a grouping or not. denoted with '+' 
        if '+' in row['MCM_Name']: # Map All these MCM vars to one RCIM var. 
            mcm_group=row['MCM_Name'].split('+')
            mcm_group=[v.replace(' ', '') for v in mcm_group if len(v.replace(' ', '')) >0]
            for cmpd in mcm_group: MCM_dict[cmpd]=row['RCIM_Name']
        elif '+' in row['RCIM_Name']:
            #print('This functionality is not currently included. '+\
            #     'Please map: {} (RCIM) to {} (MCM) yourself.'.format(row['RCIM_Name'], row['MCM_Name']))
            dum=9
        elif row['MCM_Name'] != 'None':     # 1:1 case... Map RCIM --> MCM var.  
            RCIM_dict[row['RCIM_Name']]=row['MCM_Name'].replace(' ', '') 

    # Remove anything that isn't actually mapping a var to a new name. 
    [RCIM_dict.pop(item) for item in list(RCIM_dict.keys()) if RCIM_dict[item]== item]
        
    return RCIM_dict, MCM_dict

def get_split_add(lists, to_add=None, parse_chars:bool=False): 
    """Function to take two comma delimited strings, and combine them without dupes.
    Also can remove "[" or "'" left from lists --> str conversions(?) using parse_char."""
    
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


def gen_prec_mech_files(all_MCM_file, name2use='MCM_Name', savepath='',
                        filename='precursors', remake_cascade=True,
                        map_dict=dict({}), mod=''):
    """Script to look at the "All_Rxns" file and generate a mechanism for 
    each individual precursor species. Also saves an xlsx of Species 
    & their individual precrusors... """  
    
    # Set savepath to the path of the script if none is given.
    if savepath == '': savepath = os.path.dirname(os.path.abspath(__file__))
    
    # Read in the f0am mechanism that is "all MCM rxns" ... NEED ALL!!! 
    one=read_F0AM_mech(all_MCM_file, check=True, read_only=True,
                        sort_rxn_i=True, sort_rxn_list=False, map_dict=map_dict)
    [n_species, n_rxns, species, ro2, rxn, k, g, f, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds]= one
    
    # Flatten reactants/prods into a single list, with dupes removed. 
    #List of species of everything that appears in a rxn as a reactant or product 
    all_mcm_rcts= flatten_nested_list(rct_cmpds, drop_dupes=True)
    all_mcm_prds= flatten_nested_list(prd_cmpds, drop_dupes=True)
    
    # Get a list of precursor compounds in the MCM. Are not formed. Only beginning pts. 
    all_precursors=[];
    for sp in species: 
        if sp in all_mcm_rcts and sp not in all_mcm_prds: 
            all_precursors.append(sp)
            
    # Get all MCM Rcts and Prds in correct format for "Cascae_mech" to work... 
    r=convert_nested_list_2arr(rct_cmpds)
    p=convert_nested_list_2arr(prd_cmpds)
            
    # List of species in the inorg only file to ignore propgating in the mech... 
    ignore= ['N2O5', 'H2O2', 'NO', 'H2', 'NA', 'HONO', 'OH', 'SO2', 'O', 'HNO3', 'H2O', 'CO2', 'O2',
            'SO3', 'O1D', 'HO2', 'HO2NO2', 'CO', 'SA', 'O3', 'HSO3', 'NO2', 'NO3', 'RO2','hv']  
    
    if remake_cascade is True: 
        sp_dict=dict({}); all_sp=[]
        for prec in all_precursors:   
            if prec not in ignore: 
                # Get a list of species spawned from this precursor. 
                mech= cascade_mech(prec, r,p, ignore=ignore)
                
                involved=[]; # Get indices of reactions where these species are lost in our lists! 
                for sp in mech: 
                    [involved.append(i) for i, rx in enumerate(rct_cmpds) if sp in rx and i not in involved]
                
                mech_out=enforce_list_inds(involved, [rxn, k, g, f, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds])
                
                [n_rxn, n_k, n_g, n_f, n_rct_cmpds, n_prd_cmpds, n_rct_ylds, n_prd_ylds]= mech_out
                
                n_frcts= flatten_nested_list(n_rct_cmpds, drop_dupes=True)
                n_fprds= flatten_nested_list(n_prd_cmpds, drop_dupes=True)
                
                new_sp= []; new_ro2=[]; # Build a new species list & RO2 list up 
                [new_sp.append(sp) for sp in species if (sp in n_frcts) or (sp in n_fprds) and sp not in new_sp and sp not in ['RO2', 'hv']]
                [new_ro2.append(sp) for sp in list(ro2) if (sp in new_sp) and (sp not in new_ro2)]
                
                # Write everything to a text file... 
                filename1=savepath+'cascade_'+str(prec)+mod+'.m'
                write_mech_to_file(filename1, new_sp,new_ro2,n_rxn,n_k,n_g,n_f, mech_title='MCMv331- '+ str(prec)+'- minus inorgs')
                
                # Save all of the species in this mechanism to a dictionary! 
                sp_dict[prec+mod]=species 
                
                # Keep list of all species in all the dif cascaded mechanisms... 
                [all_sp.append(sp) for sp in new_sp if sp not in all_sp and sp not in ['hv', 'RO2']]
    else: 
        all_sp=species # Load the "sp_dict" file that we saved... 
        sp_dict=dict2df(savepath='C:/Users/jhask/OneDrive/Documents/MATLAB/F0AM/Chem/MCM_facisimiles/v331prec_mechs/', 
                        filename='precursors', reverse=True)

    # Sort that species list alphabetically
    [all_sp.remove(sp) for sp in ignore if sp in all_sp]
    all_sp.sort()
    
    # Convert the Species dictionary into a nicer format (switch keys/values!)
    df_out=pd.DataFrame()
    
    df_out[name2use]=all_sp # Set "name to use" column = to all species in any cascade. 
    df_out['Precursor']=['']*len(df_out)

    for ind, sp in enumerate(df_out[name2use]): # Loop over all species
        for prec in sp_dict.keys(): # And each of the precursors. 
            if sp in sp_dict[prec]:
                cs= get_split_add([df_out.loc[ind,'Precursor']], to_add=[prec])
                df_out.at[ind,'Precursor']=cs
                
    df_out.to_excel(savepath+filename+'.xlsx',engine="openpyxl")
    print('Saved to: '+savepath+filename+'.xlsx') 
        
    return df_out


def build_full_RCIM_precursors(map_file:str, savepath:str, mcm_prec_only:str, rcim_prec_only:str):
    """Function to take completeley seperate RCIM / MCM precursors, and generate 
    a dictionary that uses the name-mapping  info to add precursors from the MCM to the RCIM 
    and to the MCM from the RCIM where applicable. Essientially gives you a 
    precursor dict that considers where things came from in the combined mechanism!""" 
    
    # Map RCIM names to MCM names where it might matter .... 
    RCIM_map, MCM_map= make_mapping_dict(map_file)    

    # Get Reverse of the MCM Map. Has RCIM vars as keys, MCM vars converted to them as values. 
    rev_mcm=reverse_dict(MCM_map) 
    rev_rcm=reverse_dict(RCIM_map)  # & same for RCIM.
    
    # Get the dictionaries that have precursor info for ONLY MCM or ONLY RCIM mechanism... 
    mc_prec_dict= dict2df(full_file=mcm_prec_only, reverse=True)
    rc_prec_dict= dict2df(full_file=rcim_prec_only, reverse=True)
    
    RCIM_precs_full=dict({}); MCM_precs_full=mc_prec_dict.copy(); # Dicts to hold our output. 

    for rcim_grp in rev_mcm.keys(): # Loop over all RCIM groupings of various MCM compounds. 
        rc_prec=rc_prec_dict[rcim_grp] # Get the RCIM precursors of this grouping.
        
        get_all=[] # Get a list of all the precursors of any MCM compound that's in
        for mcm_cmpd in rev_mcm[rcim_grp]: # this RCIM grouping, with no dupes.
            [get_all.append(m) for m in mc_prec_dict[mcm_cmpd] if m not in get_all]
            
            # Keep a list of the individual precs + RCIM prec for the MCM combo dict. 
            cmbd=drop_dupes(mc_prec_dict[mcm_cmpd]+rc_prec); cmbd.sort()
            MCM_precs_full[mcm_cmpd]=cmbd
            
        # Combine the MCM precursors for ALL compounds in the group and the RCIM precursor
        all_together=get_all+rc_prec 
        all_together.sort()
        
        RCIM_precs_full[rcim_grp]=all_together  # And assign to oiutput dict. 
        
    for mcm_cmpd in rev_rcm.keys(): # Loop over all RCIM vars that were converted to MCMs... using their MCM name
        rc_name=rev_rcm[mcm_cmpd][0] # Get RCIM name of this MCM... 
        
        # Get a list of the MCM and RCIM precursors of this compound 
        alls=drop_dupes(mc_prec_dict[mcm_cmpd]+ rc_prec_dict[rc_name])
        alls.sort() 
        
        # Save to output mapping dict. RCIM/MCM names as Key, w/ Precs of its MCM & RCIM components 
        RCIM_precs_full[rc_name]=alls
        MCM_precs_full[mcm_cmpd]= alls 
    
    for var in rc_prec_dict.keys():  # Take care of vars with same names, but more than 1 precursor! 
        # Don't have info about this RCIM var & Not in MCM, so just use RCIM precursors. 
        if var not in list(RCIM_precs_full.keys()) and var not in mc_prec_dict.keys():
            RCIM_precs_full[var]=rc_prec_dict[var] 
            
        elif var in mc_prec_dict.keys():  # Compound with same name in RCIM, MCM and has precursors from both. 
            alls=drop_dupes(mc_prec_dict[var]+ rc_prec_dict[var]); alls.sort()
            if var not in list(RCIM_precs_full.keys()): RCIM_precs_full[var]=alls
            MCM_precs_full[var]=alls # Overwrite the MCM only vals with the combo
                
        if var in ['IEPOXc', 'IEPOXt']: # And overwrite that for IEPOXt/c using IEPOXB data. 
            iep= drop_dupes(mc_prec_dict['IEPOXB']+ rc_prec_dict[var]); iep.sort()
            RCIM_precs_full[var]=iep
    
    # And do for IEPOX B too...         
    iep_all= drop_dupes(mc_prec_dict['IEPOXB']+ rc_prec_dict['IEPOXc']+ rc_prec_dict['IEPOXt']); iep_all.sort()
    MCM_precs_full['IEPOXB']= iep_all
    
    # Now use both full dictionaries to create a combo dict. Here it doesn't matter 
    # if you ask for the precursors by their MCM or RCIM names.. it will give you the same info! 
    combo= RCIM_precs_full | MCM_precs_full
        
    # Convert all to dataframes and save as xlsx docs. 
    RCIM_dfo= dict2df(dat_in=RCIM_precs_full, savepath=savepath+'/RCIM/', filename=rcim_prec_only+'plus_MCM')
    MCM_dfo= dict2df(dat_in=MCM_precs_full, savepath=savepath+'/MCM/', filename=mcm_prec_only+'plus_RCIM')
    combo_dfo= dict2df(dat_in=combo, savepath=savepath+'/python/python_io/', filename='RCIM_MCM_precursors')

    return RCIM_precs_full, MCM_precs_full, combo
    
    
    
    

#def lookforbad_fs(file):
    # fix_gc_info= read_F0AM_mech(file)
    # [fix_gc_n_sp, fix_gc_n_rx, fix_gc_species,fix_gc_ro2, fix_gc_rxn, fix_gc_k, fix_gc_g, fix_gc_f] = fix_gc_info
    
    # new_fs_all=[]
    # for ind, f in enumerate(fix_gc_f): 
        
    #     fs=f.split(';')
        
    #     this_line=[]
    #     for ff in fs: 
    #         f_new=ff
    #         if '=' in ff: 
    #             ff=ff.replace(' ', '')
    #             f_of= ff.split('=')[0]
    #             yld= ff.split('=')[1]
    #             rctt= f_of.split('f')[1]
    #             rctt=rctt.replace('(i)', '')
                
    #             if f_of+'='+f_of not in ff: 
    #                 op='+'
    #                 if rctt in fix_gc_g[ind]: op= '-' 
    #                 f_new=f_of+'='+f_of+op+yld
    
    #         this_line.append(f_new)
    #     new_f_line_i=';'. join(this_line) 
        
    #     new_fs_all.append(new_f_line_i)
                
    
    # write_mech_to_file(file, 
    #                    fix_gc_species,fix_gc_ro2, fix_gc_rxn, fix_gc_k, fix_gc_g, new_fs_all) 
    
    #return


# %%%%%%%%%%%%%%% EXAMPLES~ 
# file='C:/Users/jhask/OneDrive/Documents/MATLAB/F0AM/Chem/RCIM_only/RCIM_minus_inorg.m'
# n_species, n_rxns, species, ro2, rxn, k, g, f=read_F0AM_mech(file)


# speices_list= copypaste_to_MATLAB(species)
# ro2_list= copypaste_to_MATLAB(ro2)


# %%%%%%%%%%   but dont want to delete  %%%%%%%%%%%%%%%%%%%%%
def map_names_in_mech(map_dict, sp=list(),ro2=list(),
                         rxns=list(),  gs=list(), fs= list()): 
    """Function to take a dictionary(map_dict) and map the keys which exist in the 
    species ro2 rrxn g and f list in to their values....""" 
    
    # Update the species list with the old names mapped to their new Names 
    new_sp =[it if it not in list(map_dict.keys()) else map_dict[it] for it in sp ] 
    
    # Update the RO2 list with the old names mapped to their new Names 
    new_ro2 =[it if it not in list(map_dict.keys()) else map_dict[it] for it in ro2 ] 
    
    # Update the new Reaction list with the old names mapped to their new names: 
    new_rxns= list() 
    for z,item in enumerate(rxns): # loop oever each reaction. 
        this_molec=item
        for old_name in map_dict.keys():
            if old_name in this_molec: 
                    regex= r"[\+\=\'][0-9]*[.][0-9]*"+old_name+"[\+\=\']"
                    while True: 
                        mtch=[x.group() for x in re.finditer(regex, this_molec)]
                        if len(mtch) > 0: 
                            for mtch_i in mtch: 
                                mtch_new= mtch_i.replace(old_name, map_dict[old_name])
                                this_molec=this_molec.replace(mtch_i, mtch_new)
                            mtch=[x.group() for x in re.finditer(regex, this_molec)]
                        if len(mtch) ==0 : break
                    
                    regex= r"[\+\=\']"+old_name+"[\+\=\']"
                    while True: 
                        mtch=[x.group() for x in re.finditer(regex, this_molec)]
                        if len(mtch) > 0: 
                            for mtch_i in mtch: 
                                mtch_new= mtch_i.replace(old_name, map_dict[old_name])
                                this_molec=this_molec.replace(mtch_i, mtch_new)
                            mtch=[x.group() for x in re.finditer(regex, this_molec)]
                        if len(mtch) ==0 : break

        new_rxns.append(this_molec)
               
    # Update the old f list with the old names mapped to their new names: 
    new_fs= list()             
    for item in fs:        
        for old_name in map_dict.keys():
            if "f"+old_name+"(" in item: 
                item= item.replace("f"+old_name+"(", "f"+map_dict[old_name]+"(")
        new_fs.append(item)
        
    # Update the old GStr list with the old names mapped to their new names: 
    new_gs= list()             
    for item in gs:             
        for old_name in map_dict.keys():
            if "'"+old_name+"'" in item: 
                item= item.replace("'"+old_name+"'", "'"+map_dict[old_name]+"'")
        new_gs.append(item)
    
    sp_out= list()
    ro2_out=list() # Drop any dupes from mapping... 
    [sp_out.append(sp) for sp in new_sp if sp not in sp_out]
    [ro2_out.append(ro2) for ro2 in new_ro2 if ro2 not in ro2_out]
    
    sp_out.sort()
    ro2_out.sort()
    
    kdum=['']*len( new_rxns)
    check_lens( new_rxns,kdum,new_gs,new_fs, 'ERROR : In Map Names: rxn f g not same len. ' )
    
    return [sp_out, ro2_out, new_rxns, new_gs, new_fs]

