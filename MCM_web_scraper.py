# -*- coding: utf-8 -*-
"""
@author: Dr. Jessica D. Haskins  
Email: jhaskins@alum.mit.edu 
Github: jdhask 
"""

import os  
import sys 
import numpy as np  
import pandas as pd   
import requests  
import webbrowser 
from bs4 import BeautifulSoup
from rdkit import Chem
from rdkit.Chem import  Descriptors, rdMolDescriptors, Fragments


def MCM_data_scraper(species_list, get_image: bool = False, display: bool = False,
                     filename: str = 'MCM_web_scrape', savepath: str = ''):
    """Function that takes a list of species, and rips all the info off the 
    MCM  Webpage about that species.(e.g. SMILES, INCHI, etc)...  
    
    Inputs: 
    ------- 
    
    species_list - A list of MCM Species you want info for. If you'd like info 
                   about all of the species then pass species_list= ['All']
    
    get_image - (optional) - Boolean of whether you'd like to save the image associated with that 
                species. Note: This will require saving these images to your computer.
                which can take up a considerable amount of space. Default is False. 
                
    filename - (optional) - Name of the .csv and .html files generated that 
               contain the scraped info. Do NOT include the file extensions! 
    
    savepath - (optional) Where you'd like to save the output .csv, .html and 
               MCM images. If none is provided, is saved in current directory with 
               images in a new subfolder current_path+/"MCM_images/". 
    
    display  - (optional) Boolean of whether you'd like to display the web scraped 
               results as a table in your web browser at the end. 
               
               
    Outputs: 
    --------
    
    (1) Function returns a pandas dataframe with all the saved data. 
    
    (2) A utf-8 encoded, Tab Delimited** file  saved at: savepath+filename+'.csv', 
                which contains all of the scraped data. Easily read into python by 
                pandas as a dataframe. **NOTE: This file MUST be read in and saved using 
                a tab delimiter NOT a comma delimiter because InChI strings contain commas 
                which will mess up the structure!(Use option  sep='\t' when reading/writing).
                
    (3) An HTML document saved at: savepath+filename+'.htm', which contains all the of 
                the scraped data. A nice way to display all the data scraped AND the 
                images that were scraped at the same time in a scrollable/ easily visualized way. 
                
    (4) - Optional a folder at save_path+/"MCM_images/" with .pngs of the MCM molecules 
          scraped from the MCM website. 
    """
    
    # Set savepath to the path of the script if none is given.
    if savepath == '':
        savepath = os.path.dirname(os.path.abspath(__file__))
        
    # Set name of .csv and .html files saved
    if filename == '':
        filename = 'MCM_web_scrape'
        
    if species_list[0].lower()=='all':  
        species_list=load_data_files(species=True)
    
    # Create an empty pandas dataframe with column names of all the info we're gonna scrape.
    df = pd.DataFrame(columns=['MCM_Name', 'Formula', 'Molecular_Weight',
                       'InChI', 'SMILES',  'Description', 'Image', 'NIST_url'])

    if get_image is False:
        # Don't need image column if not gonna grab.
        df = df.drop(columns='Image')
    else:  # Are grabbinb images, so make a subfolder in savepath to keep them.
        if not os.path.exists(savepath+'/MCM_Images/'):
            os.makedirs(savepath+'/MCM_Images/')
            
    # Loop through all speices you'd like to scrape data for.
    for sps in species_list:
        
        # This is the 2021 base URL for browing an MCM species on the MCM website.
        # URL to the MCM website for a species.
        url = 'http://mcm.york.ac.uk/browse.htt?species='+sps
        page = requests.get(url)
        soup = BeautifulSoup(page.content, 'html.parser')
        table = soup.find('table', {"class": "infobox"})
        tr = table.findAll(['tr'])
        
        # The InChI / SMILES infor is all contained within a "table" of the webpage...
        # Found by inspecting "soup" manually. If website changes, will need to re-inspect the soup!
        for cell in tr:
            th = cell.find_all('th')
            data_hdr = [col.text.strip('\n') for col in th][0]
            td = cell.find_all('td')
            
            if len(td) > 0:
                row = [i.text.replace('\n', '') for i in td][0]
                if data_hdr.lower() == 'molecular weight':
                    mw = np.float64(row)
                if data_hdr.lower() == 'smiles':
                    smiles = row
                if data_hdr.lower() == 'inchi':
                    inchi = row
            else:
                inchi = ''
                
            synl = list() # Get the list of synonyms of this compoudn. 
            if data_hdr.lower() == 'synonyms':
                if len(data_hdr) > 0:
                    nms = row.split(';')
                    for item in nms:
                        item = item.replace('  ', '')
                        item = item.replace('\t', '')
                        if (len(item) > 0) and (item not in synl):
                            synl.append(item)
            for s in synl: # Take list, convert to string... 
                s=s.replace("'",'')
                if len(s)==0: 
                    syn='None'
                else: 
                    if type(s)==str: 
                        syn=s 
                    else: 
                        syn=','.join(s)
                
        if len(inchi) > 0:
            if get_image is True:  # Option to also save the image of the MCM species in question.
                image_url = 'http://mcm.york.ac.uk/pics/species/'+sps+'.png'
                img_data = requests.get(image_url).content
                
                file_nm = savepath+'/MCM_Images/'+sps+'.png'
                with open(file_nm, 'wb') as handler:
                    handler.write(img_data)
                    
                img = '<img src="'+file_nm+'"/>' #Save img source for displaying using IPYTHON later... 
            
            # Link the the NIST website for this using its InChI indentifier.
            InChI2web = inchi.replace('InChI=', '')
            InChI2web = InChI2web.replace(',', '%2C')
            nist_url = 'https://webbook.nist.gov/cgi/inchi/InChI%3D'+InChI2web
            
            nist_page = requests.get(nist_url)
            nist_soup = BeautifulSoup(nist_page.content, 'html.parser')
            nist_main = nist_soup.find('main', attrs={'id': 'main'}).get_text()
            
            if 'invalid' in nist_main.lower() and 'identifier' in nist_main.lower():
                # The NIST url takes you to a "not" found page... so you can't strip it.
                nist_url = ''
            else:
                form = ''
                p1 = nist_soup.find("main")
                if p1 is not None:
                    p2 = p1.find("ul")
                    if p2 is not None:
                        parent = p2.find_all("li")
                        dat = [i.get_text().split(':') for i in parent]
                        if 'Formula' in dat[0][0].strip():
                            form = dat[0][1].strip()

            if get_image is True:
                df = df.append({'MCM_Name': sps, 'Formula': form, 'Molecular_Weight': mw,'InChI': inchi, 'SMILES': smiles, 
                                'Description': syn,  'Image': img, 'NIST_url': nist_url}, ignore_index=True)
            else:
                df = df.append({'MCM_Name': sps, 'Formula': form, 'Molecular_Weight': mw, 'InChI': inchi, 'SMILES': smiles, 
                                'Description': syn,  'NIST_url': nist_url}, ignore_index=True)
    
    # Make sure string columns are all strings... 
    only_strs= ['MCM_Name','Formula','InChI','SMILES','Description', 'NIST_url', 'Image']
    for i in df.index: 
        for col in only_strs: 
            if type(df.loc[i,col])!=str:
                if np.isnan(df.loc[i,col]): df.at[i,col]='None'
            elif df.loc[i,col] =='0': 
                  df.at[i,col]='None'
              
    # Convert dataframe to an HTML object.
    df_htm = df.to_html(escape=False)
    
    # Write html object to a file
    df.to_html(open(savepath+filename+'.html', 'w'))  
    print('HTML file saved as: ' + savepath+filename+'.html')
    
    # Option to display the saved info in your webbrowser
    if display is True:
        display_MCM_table(savepath+filename+'.htm')
        
    # Also save the data as a tab delimited file.
    # NOTE: CANNOT SAVE AS COMMA DELIMITED ( b/c InChI's contain commas!!!!)
    df.to_csv(savepath+filename+'.csv', sep='\t')
    print('TXT file saved as: ' + savepath+filename+'.csv')
    
    return df


def display_MCM_table(html_file:str):
    """Function to display the MCM_scraped HTML file in your web browser.
    If you have scraped the images as well, this wil displaythem.""" 
    
    # Open the stored HTML file on the default browser
    webbrowser.open(html_file, new=2)
    
    return 


def get_groups_of_molec(molec, groups:dict, df_in, ind:int):
    """Function to that looks for a variety of functional groups, defined in "groups" 
    within a specific molecule. Will add this data into the dataframe, df at index, ind.
    
    Inputs:
    -------
    
    molec -  An RDKit molecule object (usually generated from things like 
                                      molec= Chem.MolFromSMILES('CH4'))
    
    groups - A dictionary. Keys are "names" of functional groups, and the 
             values are the SMART () string that defines that fragment. 
             You could edit this to look for your own within the MCM, but my 
             defined functional groups can be found in the Data folder. 
             
    df_in -  Dataframe that has a column for each MCM species. The function creates 
             a column for each functional group and places the # of functional groups 
             for molec at df(ind, column). 
    
    ind -    Index of what row in df refers to this specific molec. 
    
    Outputs:
    --------
    
    df -   Same as the input dataframe, except we've added data for the row, ind, 
           with # of functional groups of everything defined in the dictionary, group. 
    
    """
    # Check that user passed appropriate inputs. 
    if not isinstance(df_in, pd.DataFrame): 
        sys.exit("ERROR in get_groups_of_molec(): df_in must be a pandas Dataframe.")
    if not isinstance(molec, Chem.rdchem.Mol): 
        sys.exit("ERROR in get_groups_of_molec(): molec must be an rdkit molecule object.")
    if ind> len(df_in): 
        sys.exit("ERROR in get_groups_of_molec(): ind passed is larger than df_in. ")
        
    df=df_in.copy() # Don't modify the original dataframe.  
    
    molec_i=Chem.rdmolops.AddHs(molec) # Make sure the molec has H's before we search for matches! 
    
    for key in groups:  # Loop over ever functional group you want to search for. 
                
        # Turn the SMARTs string for this functional group into a RDKit molec fragment. 
        frag = Chem.MolFromSmarts(groups[key])
        
        # Get a list of the indices of atom #s in molecule that match this fragment 
        inds=list(molec_i.GetSubstructMatches(frag))
        
        # Save the len of this list as the # of functional group matches you found!)
        df.at[ind,key]=np.int64(len(inds))
        
    df.at[ind,'Epoxides'] = Fragments.fr_epoxide(molec_i) # Add Number of epoxide rings 
            
    return df 


def query_rdkit_info(df_in,overwrite_with_RDKIT:bool=False ,add_functional_groups:bool=False,
                     save= True, savepath: str = '', filename:str='chem_info', verbose:bool=True):
    """Function that takes a pandas dataframe with a column named 'InChI' or 'SMILES' and 
    uses rdkit to extract its canonical SMILES string, Formula, Molecular weight, and (optionally)
    how mnay functional groups each compound has. It outputs that info as a dataframe 
    and saves it to a.csv using a tab delimiter.NOTE: Comma delimited files will NOT work
    because InChI strings contain commas.
    
    Inputs: 
    -------
        df_in - A pandas DataFrame with a column of either 'InChI', 'SMILES' or 'Canonical_SMILES' 
                that tells us what molecules we want to query info about. Optional (If you 
                have a column like "MCM_name" then you can set verbose to True for it to tell you which 
                one its doing. Must have "name" in that column title"

        overwrite_with_RDKIT- Boolean of whether you'd like to over write the input 
                formulas and molecular weights with those calculated in RDKit. 
                Sometimes MCM webscrape data is wrong, so this can correct it. 
                If verbose is true, it will print warnings when they're different! 
                If false, it will add the rdkit values as their own column and you can 
                look at the differences yourself. 
          
        add_functional_groups - Option of whether you'd like to add counts of functional groups 
                   to the output dataframe. 
         
        save     - (optional) - Boolean of wehther you'd like to save the 
                   resulting dataframe or just return it. 
                   
        filename - (optional) - Name of the .csv file generated that 
                    contain the original df and Wang et al info. 
                    Do NOT include the file extension! 
    
        savepath - (optional) Where you'd like to save the output .csv
                   If none is provided, is saved in current directory. 
                   
        verbose - (optional) Boolean. Set True to see warnings/ errors 
        
        Outputs: 
        --------  
        df - Pandas dataframe with all the original data and new columns iwth 
             data from the Wang et al., supplement added.
             
        csv -   Tab delimited csv file with df info saved at savepath+filename.csv 
    
    """
    
    # Set savepath to the path of the script if none is given.
    if savepath == '' : savepath = os.path.dirname(os.path.abspath(__file__))
    
    # Check that the user passed appropriate inputs. 
    if not isinstance(df_in, pd.DataFrame): 
        sys.exit("ERROR in query_rdkit_info(): df_in must be a pandas Dataframe.")
    if not os.path.exists(savepath): 
        sys.exit("ERROR in query_rdkit_info(): savepath does not exist.")
        
    df= df_in.copy() # Just make a copy so you're not changing stuff in the input df.
    
    col_dict=dict({}) # Create dict of all column names (independent of case)
    for col in df.columns: col_dict[col.upper()]=col  
    
    # Determine if the df has a column with molecular weight already in it or not. 
    has_mw=True  if ('MOLECULAR_WEIGHT' in col_dict.keys()) or ('MW' in col_dict.keys()) else False
    has_formula=True  if ('FORMULA' in col_dict.keys()) else False 
    
    # Figure out what column is that has the "name" or "id" of the molecule in it. 
    name_col=[col_dict[col] for col in col_dict.keys() if 'NAME' in col]
    
    # Determine what info is in this df if no desc column was passed...      
    if 'SMILES' in col_dict.keys(): 
        use= col_dict['SMILES']; get=['InChI', 'Canonical_SMILES']; case=2
    elif 'INCHI' in col_dict.keys(): 
        use= col_dict['INCHI'] ; get=['Canonical_SMILES']; case=1
    elif 'CANONICAL_SMILES' in col_dict.keys(): 
        use= col_dict['CANONICAL_SMILES']; get=['InChI']; case=3
    else: 
        sys.exit('ERROR in query_basic_info(): A column with either INCHI or SMILES strings was not found in the dataframe.')
    
    if verbose is True: print('Using {} column to generate molecule & query info'.format(use))
    
    if add_functional_groups is True: 
        groups=load_data_files(groups=True) # Load dicationary of functional group SMART strings. 
        
    # Initialize lists to hold stuff and warnings of inconsistencies! 
    formulas=[]; mws=[]; smiles=[]; inchis=[]                         
    mwarning=np.full([len(df.index),1], 1, dtype=bool)
    fwarning=np.full([len(df.index),1], 1, dtype=bool)
    
    for ind in df.index: # Loop over all compounds in the input dataframe. 
        names= ','.join(list(df.loc[ind,name_col])) # NAme of this compound. 
        
        # Use each string to make an RDKit molecule object. 
        if case ==1: molec = Chem.inchi.MolFromInchi(df.loc[ind,use], logLevel=None)
        if case >1:   molec =Chem.MolFromSmiles(df.loc[ind,use] ) #,sanitize=False)  
        
        if molec is not None:
            molec.UpdatePropertyCache(strict=True)  # for radicals!
            
            # Pull formula, molecular weight, its canonical smiles, and InChI strings. 
            form=rdMolDescriptors.CalcMolFormula(molec)
            mw=Descriptors.MolWt(molec)
            
            if has_mw is True:  # Determine dif between input and predicted MW for this compound...  
                current_mw=np.round(df.loc[ind,col_dict['MOLECULAR_WEIGHT']]*1000)/1000
                rdkit_mw=np.round(mw*1000)/1000;  dif= np.abs(current_mw-rdkit_mw)
                if dif > 0.3: # Print a warning if there's a big difference... 
                    print('WARNING: For{}, input MW is {}, but RDKit MW is {}. Abs(Difference) = {}.'.format(
                        names,current_mw, rdkit_mw, dif))
                    mwarning[ind]=False
            
            if has_formula is True: 
                current_form=str(df.loc[ind,col_dict['FORMULA']]).upper().replace(' ', '')
                if form.upper() != current_form: 
                    print('WARNING: For{}, input Formula is {}, but RDKit Formula is {}.'.format(
                        names,current_form, form.upper()))
                    fwarning[ind]=False
                    
            if add_functional_groups is True: 
                    # Add # of functional groups of this molec to dataframe! 
                    df=get_groups_of_molec(molec, groups, df, ind)
                    
            sm=Chem.MolToSmiles(molec)
            inc=Chem.inchi.MolToInchi(molec, logLevel=None)
            
        else: 
            form= 'None'; sm='None'; inc='None'; mw=0
            
        #Append all the info into lists to fill output columns with later. 
        formulas.append(form)
        mws.append(mw)
        smiles.append(sm)
        inchis.append(inc)
            
    # Only include MW if you don't have it or if all the RDkit MWs aren't the same as the input ones. 
    include_mw =False  if has_mw is True and all(mwarning) else True 
    include_form =False  if has_formula is True and all(fwarning) else True  
    
    # And decide if you need to name it something else if that column already exists... 
    mod='' if overwrite_with_RDKIT is True  else  '_rdkit' 

    # Add each column of info to the df if you need it... 
    if include_form is True:  df['Formula'+mod]=formulas 
    if include_mw is True:  df['Molecular_Weight'+mod]=mws
    if 'Canonical_SMILES' in get: df['Canonical_SMILES']=smiles
    if 'InChI' in get: df['InChI']=inchis
    
    if add_functional_groups is True:        
        # Add a column that has the number of OH groups on a compounds that might cause it to be an organic acid... 
        Organic_Acid_OHs=['Enols','Phenols','Thiols', 'Carboxylic_Acids']
        df['Organic_Acid_OHs']=df[Organic_Acid_OHs].sum(axis=1)
        
        # Add column that is the O:C ratio of each compound. 
        df['O:C']=np.round((df['O']/df['C'])*100)/100
        
        # Add column that is H:C ratio of each compound: 
        df['H:C']=np.round((df['H']/df['C'])*100)/100
        
        # Add column that is 1 if variable is an RO2 (either peroxy or peroxy acyl RO2) 
        df['Is_RO2']=[1 if df.loc[indy,'RO2s'] >0 or df.loc[indy, 'Acyl_RO2s'] >0  else 0 for indy in df.index]
        df['Is_RO']=[1 if df.loc[indy,'ROs'] >0 or df.loc[indy, 'Acyl_ROs'] >0  else 0 for indy in df.index]
        
    #Save the output dataframe. 
    df.to_csv(savepath+filename+'.csv', sep='\t')
        
    print('File saved at: ' + savepath + filename+'.csv')
    
    return df


def add_Wang_et_al_info(df_in, name_col:str, save:bool=True, savepath:str='', filename:str='mech_plus_Wang_et_al' ):
    
    """ Function to take the supplemental info from Wang et al,. 2017: 
        
       'Uncertain Henry's law constants compromise equilibrium partitioning 
        calculations of atmospheric oxidation products ' 
        
        https://acp.copernicus.org/articles/17/7529/2017/

       and add it all into dataframe containing a bunch of info about MCM species.  
       
       
       Inputs: 
       -------
        df_in     - A pandas dataframe that has a column, name_col which 
                    has the MCM ID names of each var you'd like to add info about. 
        
        name_col -  string of column name that has that MCM ID or names in it. 
                
        save     - (optional) - Boolean of wehther you'd like to save the 
                   resulting dataframe or just return it. 
                   
        filename - (optional) - Name of the .csv file generated that 
                    contain the original df and Wang et al info. 
                    Do NOT include the file extension! 
    
        savepath - (optional) Where you'd like to save the output .csv
                   If none is provided, is saved in current directory. 
        
        Outputs: 
        --------  
        df - Pandas dataframe with all the original data and new columns iwth 
             data from the Wang et al., supplement added.
             
        csv -   Tab delimited csv file with df info saved at savepath+filename.csv 
       """ 
    # Set savepath to the path of the script if none is given.
    if savepath == '' and save is True: savepath = os.path.dirname(os.path.abspath(__file__))
    
    # Check that the user passed appropriate inputs. 
    if not isinstance(df_in, pd.DataFrame): 
        sys.exit("ERROR in add_Wang_et_al_info(): df_in must be a pandas Dataframe.")
    if not os.path.exists(savepath) and save is True: 
        sys.exit("ERROR in add_Wang_et_al_info(): savepath does not exist.")
    if not name_col in list(df_in.columns): 
        sys.exit("ERROR in add_Wang_et_al_info(): name_col is not in df_in passed.")
    
    df=df_in.copy() # Don't modifiy the original dataframe. 
    
    # Load in CSV Data from Wang et al., 2017 Supplement!
    wang_df = load_data_files(Wangetal=True)
    
    # Columns from Wang et al., 2017 I want to add. Edit this as you please. 
    cols2copy = ['oxidation genration', 'average carbon oxidation state', 
                 'AROMATIC', 'Number of functional groups',
                 'COSMOtherm_logKWIOM/G', 'COSMOtherm_logKW/G']
    
    new_names = [name[0].capitalize()+name[1:]for name in cols2copy]
    new_names= [nm.replace(' ', '_') for nm in new_names] 
    
    for nm in new_names: df[nm]=np.full([len(df),1], np.nan, dtype=float)
     
    for i in list(df.index): 
        ind= wang_df.index[wang_df['MCM_ID']==df.loc[i,name_col]]
        
        if len(ind) >0: 
            for c,col in enumerate(cols2copy):  # Copy data from columns we want from Wang et al.,
                df.at[i, new_names[c]] = wang_df.loc[ind[0], col]
                
    # Header in Wang et al., are miss-spelled... fix that here.
    df['Oxidation_Generation']=df['Oxidation_genration'].copy() 
    df.drop(columns=['Oxidation_genration'], inplace=True)
    
    if save is True:  # Save the files as a csv if asked...
        df.to_csv(savepath+filename+'.csv', sep='\t')
        print('File saved at: ' + savepath + filename+'.csv')

    return df


def assign_precursors(df_in, name_col:str, save:bool=True, savepath:str='', 
                      filename:str='mech_plus_precursors'):
    """Function to take a dictionary with precursors as the keys and 
    a list of species they spawn as the values, and assign this list 
    into a column titled "Precursor" for each species in "name_Col" of the 
    pandas Dataframe.
    
        Inputs: 
       -------
        df_in    - A pandas dataframe that has a column, name_col which 
                    has the MCM ID names of each var you'd like to add info about. 
        
        name_col -  string of column name that has that MCM ID or names in it. 
        
        save     - (optional) - Boolean of wehther you'd like to save the 
                   resulting dataframe or just return it. 
                   
        filename - (optional) - Name of the .csv file generated that 
                    contain the original df and Wang et al info. 
                    Do NOT include the file extension! 
    
        savepath - (optional) Where you'd like to save the output .csv
                   If none is provided, is saved in current directory. 
        
        Outputs: 
        --------  
        df - Pandas dataframe with all the original data and info about which precursor all the 
             different species come from.
             
        csv -   Tab delimited csv file with df info saved at savepath+filename.csv 
       """ 
    
    # Set savepath to the path of the script if none is given.
    if savepath == '' and save is True: savepath = os.path.dirname(os.path.abspath(__file__))
    
    # Check that the user passed appropriate inputs. 
    if not isinstance(df_in, pd.DataFrame): 
        sys.exit("ERROR in assign_precursors(): df_in must be a pandas Dataframe.")
    if not os.path.exists(savepath) and save is True: 
        sys.exit("ERROR in assign_precursors(): savepath does not exist.")
    if not name_col in list(df_in.columns): 
        sys.exit("ERROR in assign_precursors(): name_col is not in df_in passed.")
    
    df=df_in.copy() # Dont' modify the original. 
    
    # Load dictionary that has the precursor information in it (MCM Names are keys!)
    prec_dict=load_data_files(precursors=True)
   
    df=df_in.copy() 
    df['Precursor']=['']*len(df)
    for ind, sp in enumerate(df[name_col]): # Loop over all species in the MCM... 
        prec_i=prec_dict[sp]
        df.at[ind,'Precursor']=prec_i
    if save is True: 
        df.to_csv(savepath+filename+'.csv', sep='\t')
        print('File saved at: ' + savepath + filename+'.csv')      
      
    return df 


def load_data_files(groups=False, precursors=False, species=False, Wangetal=False): 
    """Function to load data needed for these functions to work."""
    path=os.path.dirname(__file__)
    if groups is True: 
        df_in=pd.read_excel(path+'/Data/Functional_Group_SMARTs.xlsx')
        gpp= df2dict(df_in)
        return gpp
        
    if precursors is True  or species is True: 
        df_in=pd.read_excel(path+'/Data/MCM_precursors.xlsx', index_col=0)
        if precursors is True:
            precs= df2dict(df_in,split_on_comma=True)
            return precs 
        else:
            species=list(df_in['MCM_Name'])
            species.sort()
            return species
        
    if Wangetal is True: 
        df=pd.read_csv(path+'/Data/Wang_et_al_2017_Supplement.csv')
        return df
  
    
def df2dict(df_in, savepath='', filename='', split_on_comma=False):
    """Function to take a df from an excel file and convert to a dict."""
    if len(df_in.columns)<2: 
        sys.exit('Error in df2dict(): Function only works on dfs with at least 2 columns.')
                  
    dict_out=dict({})
    key_col=df_in.columns[0]; val_col=df_in.columns[1]
    for i in df_in.index:
        key=df_in.loc[i,key_col]
        if type(key) == str: 
            for bad in [' ', "'",'[',']']: key=key.replace(bad, '')
        
        value= df_in.loc[i,val_col]
        if type(value) == str: 
            for bad in [' ', "'"]: value=value.replace(bad, '')
            if split_on_comma is True: 
                for bad in ['[',']']: value=value.replace(bad, '')

                listy=value.split(',') # Turn into list
                listy.sort()
            else:
                listy=value
        else: 
            listy='None'
    
        dict_out[key]=listy 
        
    return dict_out

