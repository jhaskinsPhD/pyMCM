# -*- coding: utf-8 -*-
"""
Created on Tue Jan 18 18:04:10 2022

@author: jhask
"""

import numpy as np  
import sys  
from datetime import date  
 
sys.path.insert(0,'C:/Users/jhask/OneDrive/Documents/Research/Projects/MIT/pOrgNO3/code/MCM_RCIM_SMILES/python/pyMCM/F0AM_Tools/') 
from F0AM_mech_IO import * 
from utils import * 
 
 
def parse_kpp(kpp_filename): 
    """Read info from a KPP file into python lists.  
     
    Args:  
    -----  
    kppfilename = String with path + name of a KPP file.  
     
 
    Returns:  
    -------- 
    These outputs lists are all same length:  
        rxns - Str List of all reactions in KPP file. 
        rcts - Nested Str List of all reactants per rxn  
        rct_stoich - Nested float64 list of stoichiometry of products formed per rxn  
        rates - List of rate each rxn progresses at  
        prds - Nested List of all products per rxn   
        prd_stoich - Nested List of stoich of products formed per rxn  
        comments - List of comments (Dates + GEOS-Chem Author) at end of each rxn.  
     
    These outputs are different lengths:  
        var_info - Dictionary with tracer name, and long name info for all compounds 
        rate_functions - List of all unique functions used to call rates in KPP file.  
        het_ind - Index of item in output lists if rxn is heterogenous.  
        photo_ind - Index of item in output lists if rxn is photolysis 
         
     -------------------------------------------------------------------------------------          
     If your KPP file contained only the following reaction....   
 
         'C4HVP1 + NO = NO2 + MVKOHOO : GCARR(2.70E-12, 0.0E+00, 350.0); {2019/11/06; Bates2019; KHB}'  
          
    Output would be: 
        rxns= ['C4HVP1 + NO = NO2 + MVKOHOO'] 
        rcts=[['C4HVP1', 'NO']]; 
        rct_stoich= [[1,1]] 
        rates - ['GCARR(2.70E-12, 0.0E+00, 350.0)']  
        prds = [['NO2', 'MVKOHOO']] 
        prd_stoich -[[1,1]] 
        comments - ['2019/11/06; Bates2019; KHB'] 
         
        varinfo=dict({'C4HVP1': 'C4 hydroxy-vinyl-peroxy radicals from HPALDs' 
                      'NO': 'NO; Nitric oxide' 
                      'NO2': 'NO2; Nitrogen dioxide' 
                      'MVKOHOO':'peroxy radical from MVK + OH'}) 
        rate_functions= ['GCARR'] 
        het_ind=[] 
        photo_ind=[] 
     
    Author: Dr. Jessica D. Haskins 1.14.2022 (jhaskins@alum.mit.edu) 
    """ 
    # Define booleans that will tell us what part of the KPP file we are in.    
    past_header=False      # Boolean for whether we have passed the header or not.  
    in_defvar= False     # Switch for if currently parsing the  "#defvar" section   
    in_deffix= False     # Switch for if currently parsing the  "#deffix" section  
    in_equations= False  # Switch for if currently parsing the  "#equationsS "section  
    in_het=False         # Switch for if currently parsing the  "// Heterogeneous reactions" section  
    in_photolysis=False; # Switch for if currently parsing the  "// Photolysis reactions" section  
     
    # Make empty lists to hold output  
    tracers=[]; long_name=[]; rxn_is_het=[]; rxn_is_photo=[]; rate_functions=[]; comments=[];  
    rxns = [];  rct = []; rct_stoich = []; rates=[];  prd = []; prd_stoich = []; 
     
    num_lines = sum(1 for line in open(kpp_filename)) # Get n lines to expect.  
 
    file1 = open(kpp_filename, 'r')  # open the file. 
    count = 0  # initialize counter 
    while True:  # loop over each line of the KPP file. 
        line = file1.readline()  # Read next line from file 
        line_strip=line.strip().replace(' ', '') 
        count=count+1 
         
        # Decide if you've reached the end of a section, turn off switch for "Currently Parsing Secion X" if so.  
        past_header = True if '#defvar' in line_strip.lower() else past_header # no longer in header section   
        in_defvar = False if '#deffix' in line_strip.lower() else in_defvar # no longer in section defining vars.   
        in_deffix = False if '#equations' in line_strip.lower() else in_deffix # no longer in  section defining fix vars.   
        in_equations = False if '//heterogeneousreactions' in line_strip.lower() else in_equations  # no longer in  section defining fix vars.   
        in_het = False if '//photolysisreactions' in line_strip.lower() else in_het  # no longer in  section defining fix vars.   
         
        # Break if reached end of file 
        if count>num_lines: break  
     
        # Parsing the variable definitions...  
        if in_defvar==True or in_deffix==True:  
            # Lines look like: ' A3O2       = IGNORE; {CH3CH2CH2OO; Primary RO2 from C3H8}'  
            split_on='ignore'  # string we want to split the ^ line on... case insensitive, space insensitive. 
            if split_on in line.lower():  
                ind=line.lower().index(split_on) # Figure out where to split line. 
                tracer=str_multi_replace(line[:ind],  [' ', '='], rep_all='') 
                tracers.append(tracer)  # Keep tracer name in list.  
                 
                tracer_info=line[ind+len(split_on):] # Rest of the info about the tracer. 
                if tracer_info[0]==';': tracer_info=tracer_info[1:] # Clean it up.  
                tracer_info= str_multi_replace(tracer_info,  ['{', '}' ], rep_all='').strip() 
                long_name.append(tracer_info) 
         
        # Parsing the Chemical Equations and Rate functions:  
        if any(cond ==True for cond in [in_equations, in_photolysis, in_het]):  
            if '//'!= line[0:2]: # Don't parse commented lines.  
                # Keep track of what kind of reaction this is.  
                rxn_is_photo.append(np.int64(in_photolysis))  # 1 if is a photolysis rxn, 0 if not.   
                rxn_is_het.append(np.int64(in_het))  # 1 if is a het rxn, 0 if not.   
                     
                if ':' not in line: # ------Foudn a line where rxn is continued on line(s) below: ---------------- 
                    #  'MVKOHOO + HO2 = 0.360MCO3 + 0.360GLYC +' 
                    #'  0.335MVKHP + 0.050MGLY + 0.050CH2O :  GCARR(2.12E-13, 0.0E+00, 1300.0); {2019/11/06; Bates2019; KHB}' 
                    while line_strip.endswith('+')==True: # Read more lines til you get entire reaction, rate & comments.  
                        # Update rxn string with next line.Reapeat til doesn't end in + 
                        nline = file1.readline()  # Read next line from file 
                        count=count+1# Update line counter var.  
                        line = line+ nline.strip() # append this new line to our current line str.  
                        line_strip=line.strip().replace(' ', '') # Update line_strip!  
                    line=line.replace('\n', ' ') 
                # Now any line str (regardless of how long it was... ^) you have should look like this: -------------- 
                #'O3 + MO2 = CH2O + HO2 + O2 :   GCARR(2.90E-16, 0.0E+00, -1000.0);   {2014/02/03; Eastham2014; SDE}' 
                #                            ^split #1                            ^ split #2  
                 
                rxn_lines =line.split(':')  # Split on colon to get rxn 
                rate=rxn_lines[1].split(';')[0]  #Split on ';' to get rates  
                 
                # Clean up reactions & rates from weird chars:  
                rxn= str_multi_replace(rxn_lines[0],  ['{+M}','{', '}',' ' ], rep_all='').strip()  
                reps=dict({'E+00': '','_dp': '','E+':'e',  'd+': 'e', 'E-':'e-', 'd-': 'e-',  
                           'E0': '', 'd0': '', '*': '.*','/': './', 'e00': '',}) 
                rate=str_multi_replace(rate, reps).strip() 
                if '{' in rxn_lines[1]: # If it has a comment,then split on'{' and clean it up.  
                    reps=dict({'}': '', ';':',', '\n':''}) 
                    comment=str_multi_replace(rxn_lines[1].split('{')[1], reps) 
                else: comment= '' 
                 
                # Now save this rxn, rate, and comment to the output lists.  
                rxns.append(rxn)  
                rates.append(rate)  
                comments.append(comment)  
                 
                # Split rate to keep list of all unique functions called in this KPP file.  
                function=rate.split('(')[0] 
                if function not in rate_functions: rate_functions.append(function) 
                 
                # Split entire reaction into Reactants & Products & their stoichiometry:  
                rct_i, rct_ylds= sep_stoich_vs_tracer(rxn.split('=')[0], seps=['+']) 
                prd_i, prd_ylds= sep_stoich_vs_tracer(rxn.split('=')[1], seps=['+']) 
                 
                # Now save list of reactants, products and stoichimetry in lists:  
                rct.append(rct_i)  # Nested list of reactants per reaction.  
                rct_stoich.append(rct_ylds) # Nested list of reactants stoich per reaction.  
                prd.append(prd_i)   
                prd_stoich.append(prd_ylds)   
     
        # Update Booleans to tell us about what to expect next ...  
        in_defvar = True if '#defvar' in line_strip.lower() else in_defvar # are now in section defining vars.   
        in_deffix = True if '#deffix' in line_strip.lower() else in_deffix # are now in DEFVAR section.  
        in_equations = True if '#equations' in line_strip.lower() else in_equations  #  are now in Equations section.  
        in_het = True if '//heterogeneousreactions' in line_strip.lower() else in_het  # are now in het rxns section   
        in_photolysis = True if '//photolysisreactions' in line_strip.lower() else in_photolysis  # are now in photo rxns section   
 
    # We found the end of the KPP file and have parsed all lines. 
    file1.close()  # Close the KPP file. 
     
    # Build Var info, a dictionary connecting tracer names & long names. 
    var_info= dict(zip(tracers, long_name)) 
     
    # And build list of Index in lists where rxns are het or photolysis rxns  
    het_ind   = [i for i,hetrx in enumerate(rxn_is_het) if hetrx==1] 
    photo_ind = [i for i,hvrx in enumerate(rxn_is_photo) if hvrx==1] 
     
    # Drop any functions that don't begin with letters///  
    rate_functions= [f for f in rate_functions if f[0].isalpha()] 
     
    return [rxns, rct, rct_stoich, rates, prd, prd_stoich, comments, var_info, rate_functions, het_ind, photo_ind] 
 
    
def KPP_to_F0AM(kppfile, include_het_rxns:bool=False, out_filename:str= ''): 
    # Parse the KPP file. Get rxns and Rates we need to write a F0AM file.  
    include_het_rxns=False  
     
    KPP=parse_kpp(kppfile) 
    [RXNS0, RCT, RCT_S, RATES0, PRD, PRD_S, cmts, var_info, r_functs, het_ind, PT]= KPP 
     
    if include_het_rxns==False: # Remove het rxns from the rx list before making file:  
        not_het=[ind for ind in range(0,len(RXNS0)) if ind not in het_ind] 
        [RXNS0,  RATES0]= enforce_list_inds(not_het, [RXNS0, RATES0]) 
         
    # Add comments about each rxn back to rxn string & encase in "'" that we require for "build mech" 
    rxns=["'"+RXNS0[i]+"'; % "+cmts[i] if cmts[i] != '' else "'"+RXNS0[i]+"';" for i in range(0, len(RXNS0))] 
     
    # Make rates have "k(:,i) = " in front. As Build-Mech function expects.  
    rates=['k(:,i) = '+rr+';' for rr in RATES0] 
     
    # Build a F0AM complioant mechanism from the reaction list and rate lists  
    out= build_all_from_rxns(rxns, k_list=rates, sort_rxn_i=True, sort_rxn_list=False, verbose=True) 
    [sp_list,rxns, fs, gs, ks, rct_cmpds, prd_cmpds, rct_ylds, prd_ylds]= out                          
     
    r_functs = [f+ '()' if np.mod(i,5)!=0 or i==0 else '%                    '+f+ '()'for i,f in enumerate(r_functs) ] 
    rate_info='%    rate_functions={' +','.join(r_functs)+'};' 
    # Make Title Containing deailts + list of functions this rxn file requires to run.  
    mech_title=''.join([' GEOS-Chem Mechanism.','\n', 
                        '% Generated on '+str(date.today())+' from KPP file: ',  
                        '%    '+kppfile, '\n', 
                        '% List of GEOS-Chem Functions for Reaction Rates Required in this Mechanism:', 
                        rate_info]) 
     
    # Write this mechanism to a F0AM file:  
    write_mech_to_file(out_filename, sp_list, [''],rxns, ks,gs,fs,mech_title=mech_title) 
 
    
def redo_function_header(line): 
 
    if 'RESULT' in line:  
       # Turn FORTRAN:  
            #   'FUNCTION ARRPLUS_ade( a0, d0, e0 ) RESULT( k )'  
       # Into MATLAB:  
        #   'function [k] = ARRPLUS_ade(a0, d0, e0 ) 
        l=line.split('FUNCTION')[1].strip() 
        l=l.split('RESULT') 
         
        out= str_multi_replace(l[1].strip(), ['(', ')'], rep_all='').strip() 
        funct_title_args=l[0].strip() # 'ARRPLUS_ade( a0, d0, e0 )'  
         
        matlab= 'function ['+out+'] = '+funct_title_args 
         
    else:  
        # Turn FORTRAN:  
        #   REAL(kind=dp) FUNCTION FALL ( A0,B0,C0,A1,B1,C1,CF) 
        # Into MATLAB:  
        #   'function [FALL] = FALL(( A0,B0,C0,A1,B1,C1,CF) ) 
         
        l=line.split('FUNCTION')[1].strip() 
        nm=l.split('(')[0].strip() 
         
        matlab= 'function ['+nm+'] = '+l 
 
    return matlab  
 
    
def insert_after_indent(line, insert):  
    not_spaces=[i for i,ll in enumerate(line) if ll !=' '] 
    if line[not_spaces[0]] != insert:  
        line= line[0:not_spaces[0]]+ insert + line[not_spaces[0]:] 
    return line 
 
    
def is_comment(line):  
    not_spaces=[i for i,ll in enumerate(line) if ll !=' '] 
    if len(not_spaces) > 0:  
        tf=False if line[not_spaces[0]]!='%' else True 
    else:  
        tf=False 
     
    return tf 
 
    
def convert_gckpp_Rates_2_F0AM(gckpp_rates_file, outfilename=''):  
    """Function to convert at GEOS-Chem gckpp_Rates.F90 file to a MATLAB 
        compliant set of functions for rate expressions.  
         
        Author: Dr. Jessica D. Haskins (jhaskins@alum.mit.edu) GitHub: @jdhask 
         
        1/14/2022 JDH Created.  
        """ 
         
    num_lines = sum(1 for line in open(gckpp_rates_file)) # Count # of lines in file.  
     
    inF = open(gckpp_rates_file, 'r')  # Open the Input file to Read  
    if outfilename =='': outfilename= gckpp_rates_file.split('.')[0];  
    if '.' in outfilename: outfilename=outfilename.split('.')[0] 
    outF = open(outfilename+'.m', "w"); # Open the Output file to Write  
     
    count = 0; pass_go=False  # Initialize counter 
    while True:  # Loop over each line of the KPP rate file. 
     
            line = inF.readline()  # Read next line from file 
            line=line.replace('\n', '') #Remove new line characters.  
             
            if 'Begin Rate Law Functions' in line: pass_go=True # Boolean of whether to start writing file or not.   
             
            if pass_go is True:  
                if len(line) > 0 :  
                    if '::' in line and 'PARAMETER' in line: # keep parameter definitions.  
                        line= insert_after_indent(line, line.split('::')[1].strip() +'&&baddie&&') 
                        line=line.split('&&baddie&&')[0] 
                    # Comment out all var definitions. Don't need them in MATLAB.  
                    if '::' in line and is_comment(line) is False: line= insert_after_indent(line, '%') 
                     
                    # Replace "END FUNCTION" with 'end' so it won't think the "end"line is a line with a function to fix...  
                    if 'END FUNCTION' in line and is_comment(line) is False: line= 'end'  
                     
                    # Make sure we comment out "intrinsic variables.. b/c I have no idea what that means & neither does MATLAB 
                    if 'INTRINSIC' in line and is_comment(line) is False: line= insert_after_indent(line, '%') 
                     
                    # Move things around at function declarations to make MATLAB happy. 
                    if 'FUNCTION' in line and is_comment(line) is False : line= redo_function_header(line) 
                     
                    # Only after fixing functions can we make sure REAL declaraations are commented out.  
                    if 'REAL' in line and is_comment(line) is False: line = '%'+line 
                     
                    # If its a one line "if" statement then need to add an "end" for MATLAB.  
                    if 'IF' in line and 'THEN' not in line and 'END IF' not in line :  
                        line =line.split(')')[0]+');'+line.split(')')[1]+'; end ' 
                     
                    # Otherwise, FORTRAN --> MATLAB is a series of operator substitutions...  
                    fortran_2_matlab= dict({ '!':'%',   
                                             '**':'.^',  
                                             '*' :'.*',  
                                             '/':'./', 
                                             'EXP':'exp',  
                                             'temp':'TEMP',  
                                             'MAX' :'max', 
                                             'LOG10':'log1',  
                                             '&':'...',  
                                             'IF':'if',  
                                             'DBLE':'double',   
                                             'e+':'e',  
                                             'E-':'e-', 
                                             'E+':'e',  
                                             'SQRT':'sqrt',  
                                             'ENDIF':'end',  
                                             'ENDDO':'end',  
                                             '.eq.':'==',  
                                             '.not.':'~',  
                                             '.lt.':'<', 
                                             '.gt.':'>',  
                                             '.ne.':'~=',  
                                             '.ge.':'>=',  
                                             '.le.':'<=',  
                                             '.and.':'&&',  
                                             '.or': '||' }) 
                     
                    line= str_multi_replace(line,fortran_2_matlab) 
                     
                    # Remove things like double precision and 'Then' statements - unnecessary.  
                    line = str_multi_replace(line,['_dp', 'THEN'], rep_all='') 
                     
                    # Fix anything my substitutitons messed up. 
                    line= str_multi_replace(line,dict({'../':'./', '..*': '.*'})) 
                     
                    # Make sure all the lines are suppressing their content in MATLAB by adding a ';' where appropriate.  
                    if 'end' not in line and 'function' not in line and is_comment(line) is False and line[-3:]!= '...':  
                        if '%' not in line:  
                            line=line+';' 
                        else:  
                            cmt_i=line.index('%') 
                            line=line[0:cmt_i]+';'+line[cmt_i:] 
                 
                outF.write(line+ '\n') # Write our modified line to the output file:  
             
            count=count+1 # Update counter var.  
             
            # Break if reached end of file or end of the functions for rate constants.  
            if count>num_lines or 'End INLINED Rate Law Functions' in line: break  
         
    inF.close() # Close the input file  
    outF.close() # Close the output file  
    print('MATLAB compliant version of gckpp_Rates.F90 saved at: '+outfilename+'.m' ) 
     
    return  
 
