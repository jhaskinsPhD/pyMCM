% GEOS-Chem Mechanism.

% Generated on 2022-02-04 from KPP file: 
%    C:\Users\jhask\OneDrive\Documents\Research\Projects\MIT\pOrgNO3\code\MCM_RCIM_SMILES\python\pyMCM\F0AM_Tools\GEOSChem_Emulator/input/fullchem.eqn

% List of GEOS-Chem Functions for Reaction Rates Required in this Mechanism:
%    rate_functions={GCARR_ac(),GCJPLPR_aba(),GC_HO2HO2_acac(),GC_OHCO_a(),GC_RO2NO_B1_ac(),
%                    GC_RO2NO_A1_ac(),GCARR_abc(),GC_TBRANCH_1_acac(),GC_OHHNO3_acacac(),GCJPLPR_abab(),
%                    GCJPLPR_abcabc(),GCJPLEQ_acabab(),GC_RO2NO_B2_aca(),GC_RO2NO_A2_aca(),GC_TBRANCH_2_acabc(),
%                    GC_RO2HO2_aca(),GC_GLYCOH_A_a(),GC_GLYCOH_B_a(),GC_GLYXNO3_ac(),GC_HACOH_A_ac(),
%                    GC_HACOH_B_ac(),GC_DMSOH_acac(),GCARR_ab(),GCJPLPR_aa(),GC_ISO1(),
%                    GC_ISO2(),ARRPLUS_abde(),TUNPLUS_abcde(),ARRPLUS_ade(),GC_NIT(),
%                    GC_ALK(),GC_EPO_a(),GC_PAN_acac(),HET(),PHOTOL()};

% # of species =249
% # of reactions =752

SpeciesToAdd = {'A3O2';'ACET';'ACTA';'ALD2';'ALK4';'ATO2';'ATOOH';'B3O2';'BENZ';'BRO2';'Br';'Br2';...
    'BrCl';'BrNO2';'BrNO3';'BrO';'C2H6';'C3H8';'C4HVP1';'C4HVP2';'CCl4';'CFC11';'CFC113';...
    'CFC114';'CFC115';'CFC12';'CH2Br2';'CH2Cl2';'CH2I2';'CH2IBr';'CH2ICl';'CH2O';...
    'CH2OO';'CH3Br';'CH3CCl3';'CH3CHOO';'CH3Cl';'CH3I';'CH4';'CHBr3';'CHCl3';'CO';...
    'CO2';'Cl';'Cl2';'Cl2O2';'ClNO2';'ClNO3';'ClO';'ClOO';'DMS';'EOH';'ETHLN';'ETNO3';...
    'ETO2';'ETP';'GLYC';'GLYX';'H';'H1211';'H1301';'H2';'H2402';'H2O';'H2O2';'HAC';...
    'HBr';'HC5A';'HCFC123';'HCFC141b';'HCFC142b';'HCFC22';'HCOOH';'HCl';'HI';'HMHP';...
    'HMML';'HNO2';'HNO3';'HNO4';'HO2';'HOBr';'HOCl';'HOI';'HONIT';'HPALD1';'HPALD1OO';...
    'HPALD2';'HPALD2OO';'HPALD3';'HPALD4';'HPETHNL';'I';'I2';'I2O2';'I2O3';'I2O4';...
    'IBr';'ICHE';'ICHOO';'ICN';'ICNOO';'ICPDH';'ICl';'IDC';'IDCHP';'IDHDP';'IDHNBOO';...
    'IDHNDOO1';'IDHNDOO2';'IDHPE';'IDN';'IDNOO';'IEPOXA';'IEPOXAOO';'IEPOXB';'IEPOXBOO';...
    'IEPOXD';'IHN1';'IHN2';'IHN3';'IHN4';'IHOO1';'IHOO4';'IHPNBOO';'IHPNDOO';'IHPOO1';...
    'IHPOO2';'IHPOO3';'INA';'INDIOL';'INO';'INO2B';'INO2D';'INPB';'INPD';'IO';'IONITA';...
    'IONO';'IONO2';'IPRNO3';'ISOP';'ISOPNOO1';'ISOPNOO2';'ITCN';'ITHN';'KO2';'LBRO2H';...
    'LBRO2N';'LIMO';'LIMO2';'LISOPNO3';'LISOPOH';'LNRO2H';'LNRO2N';'LTRO2H';'LTRO2N';...
    'LVOC';'LXRO2H';'LXRO2N';'MACR';'MACR1OO';'MACR1OOH';'MACRNO2';'MAP';'MCO3';'MCRDH';...
    'MCRENOL';'MCRHN';'MCRHNB';'MCRHP';'MCROHOO';'MEK';'MENO3';'MGLY';'MO2';'MOH';...
    'MONITA';'MONITS';'MONITU';'MP';'MPAN';'MPN';'MSA';'MTPA';'MTPO';'MVK';'MVKDH';...
    'MVKHC';'MVKHCB';'MVKHP';'MVKN';'MVKOHOO';'MVKPC';'N';'N2';'N2O';'N2O5';'NAP';...
    'NIT';'NITs';'NO';'NO2';'NO3';'NPRNO3';'NRO2';'O';'O1D';'O2';'O3';'OCS';'OClO';...
    'OH';'OIO';'OLND';'OLNN';'OTHRO2';'PAN';'PIO2';'PIP';'PO2';'PP';'PPN';'PRN1';...
    'PROPNN';'PRPE';'PRPN';'PYAC';'R4N1';'R4N2';'R4O2';'R4P';'RA3P';'RB3P';'RCHO';...
    'RCO3';'RCOOH';'RIPA';'RIPB';'RIPC';'RIPD';'ROH';'RP';'SO2';'SO4';'TOLU';'TRO2';...
    'XRO2';'XYLE'};

RO2ToAdd = {};

AddSpecies

i=i+1;
Rnames{i}='NO+O3=NO2+O2';
k(:,i) = GCARR_ac(3.00e-12, -1500.0);
Gstr{i,1}='NO'; Gstr{i,2}='O3'; % 
fNO(i)=fNO(i)-1; fO3(i)=fO3(i)-1; fNO2(i)=fNO2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='O3+OH=HO2+O2';
k(:,i) = GCARR_ac(1.70e-12, -940.0);
Gstr{i,1}='O3'; Gstr{i,2}='OH'; % 
fO3(i)=fO3(i)-1; fOH(i)=fOH(i)-1; fHO2(i)=fHO2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='O3+HO2=2O2+OH';
k(:,i) = GCARR_ac(1.00e-14, -490.0);
Gstr{i,1}='O3'; Gstr{i,2}='HO2'; % 
fO3(i)=fO3(i)-1; fHO2(i)=fHO2(i)-1; fO2(i)=fO2(i)+2; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='NO2+O3=NO3+O2';
k(:,i) = GCARR_ac(1.20e-13, -2450.0);
Gstr{i,1}='NO2'; Gstr{i,2}='O3'; % 
fNO2(i)=fNO2(i)-1; fO3(i)=fO3(i)-1; fNO3(i)=fNO3(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+O3=CH2O+HO2+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.90e-16, -1000.0);
Gstr{i,1}='MO2'; Gstr{i,2}='O3'; % 
fMO2(i)=fMO2(i)-1; fO3(i)=fO3(i)-1; fCH2O(i)=fCH2O(i)+1; fHO2(i)=fHO2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='OH+OH=H2O+O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.80e-12;
Gstr{i,1}='OH'; Gstr{i,2}='OH'; % 
fOH(i)=fOH(i)-2; fH2O(i)=fH2O(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='OH+OH=H2O2';
k(:,i) = GCJPLPR_aba(6.90e-31, 1.0, 2.6e-11, 0.6);
Gstr{i,1}='OH'; Gstr{i,2}='OH'; % 
fOH(i)=fOH(i)-2; fH2O2(i)=fH2O2(i)+1; % 

i=i+1;
Rnames{i}='OH+HO2=H2O+O2';
k(:,i) = GCARR_ac(4.80e-11, 250.0);
Gstr{i,1}='OH'; Gstr{i,2}='HO2'; % 
fOH(i)=fOH(i)-1; fHO2(i)=fHO2(i)-1; fH2O(i)=fH2O(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='H2O2+OH=H2O+HO2';
k(:,i) = 1.80e-12;
Gstr{i,1}='H2O2'; Gstr{i,2}='OH'; % 
fH2O2(i)=fH2O2(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='NO+HO2=NO2+OH'; % 2013/02/12, JPL 10-6, BHH,JMAO,EAM
k(:,i) = GCARR_ac(3.30e-12, 270.0);
Gstr{i,1}='NO'; Gstr{i,2}='HO2'; % 
fNO(i)=fNO(i)-1; fHO2(i)=fHO2(i)-1; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='HO2+HO2=H2O2+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GC_HO2HO2_acac(3.00e-13, 460.0, 2.1e-33, 920.0);
Gstr{i,1}='HO2'; Gstr{i,2}='HO2'; % 
fHO2(i)=fHO2(i)-2; fH2O2(i)=fH2O2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='CO+OH=HO2+CO2'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GC_OHCO_a(1.50e-13);
Gstr{i,1}='CO'; Gstr{i,2}='OH'; % 
fCO(i)=fCO(i)-1; fOH(i)=fOH(i)-1; fHO2(i)=fHO2(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='CH4+OH=H2O+MO2';
k(:,i) = GCARR_ac(2.45e-12, -1775.0);
Gstr{i,1}='CH4'; Gstr{i,2}='OH'; % 
fCH4(i)=fCH4(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fMO2(i)=fMO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+NO=CH2O+NO2+HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GC_RO2NO_B1_ac(2.80e-12, 300.0);
Gstr{i,1}='MO2'; Gstr{i,2}='NO'; % 
fMO2(i)=fMO2(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+NO=MENO3'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GC_RO2NO_A1_ac(2.80e-12, 300.0);
Gstr{i,1}='MO2'; Gstr{i,2}='NO'; % 
fMO2(i)=fMO2(i)-1; fNO(i)=fNO(i)-1; fMENO3(i)=fMENO3(i)+1; % 

i=i+1;
Rnames{i}='MO2+HO2=MP+O2';
k(:,i) = GCARR_abc(4.10e-13, 0.0, 750.0);
Gstr{i,1}='MO2'; Gstr{i,2}='HO2'; % 
fMO2(i)=fMO2(i)-1; fHO2(i)=fHO2(i)-1; fMP(i)=fMP(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+MO2=CH2O+MOH+O2';
k(:,i) = GC_TBRANCH_1_acac(9.50e-14, 390.0, 2.62d1, -1130.0);
Gstr{i,1}='MO2'; Gstr{i,2}='MO2'; % 
fMO2(i)=fMO2(i)-2; fCH2O(i)=fCH2O(i)+1; fMOH(i)=fMOH(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+MO2=2.0CH2O+2.0HO2';
k(:,i) = GC_TBRANCH_1_acac(9.50e-14, 390.0, 4.0e-2, 1130.0);
Gstr{i,1}='MO2'; Gstr{i,2}='MO2'; % 
fMO2(i)=fMO2(i)-2; fCH2O(i)=fCH2O(i)+2.0; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='MP+OH=H2O+MO2';
k(:,i) = GCARR_ac(2.66e-12, 200.0);
Gstr{i,1}='MP'; Gstr{i,2}='OH'; % 
fMP(i)=fMP(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fMO2(i)=fMO2(i)+1; % 

i=i+1;
Rnames{i}='MP+OH=CH2O+H2O+OH';
k(:,i) = GCARR_ac(1.14e-12, 200.0);
Gstr{i,1}='MP'; Gstr{i,2}='OH'; % 
fMP(i)=fMP(i)-1; fCH2O(i)=fCH2O(i)+1; fH2O(i)=fH2O(i)+1; % 

i=i+1;
Rnames{i}='ATOOH+OH=ATO2+H2O'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(2.66e-12, 200.0);
Gstr{i,1}='ATOOH'; Gstr{i,2}='OH'; % 
fATOOH(i)=fATOOH(i)-1; fOH(i)=fOH(i)-1; fATO2(i)=fATO2(i)+1; fH2O(i)=fH2O(i)+1; % 

i=i+1;
Rnames{i}='ATOOH+OH=H2O+MGLY+OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(1.14e-12, 200.0);
Gstr{i,1}='ATOOH'; Gstr{i,2}='OH'; % 
fATOOH(i)=fATOOH(i)-1; fH2O(i)=fH2O(i)+1; fMGLY(i)=fMGLY(i)+1; % 

i=i+1;
Rnames{i}='CH2O+OH=H2O+CO+HO2';
k(:,i) = GCARR_ac(5.50e-12, 125.0);
Gstr{i,1}='CH2O'; Gstr{i,2}='OH'; % 
fCH2O(i)=fCH2O(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='NO2+OH=HNO3';
k(:,i) = GCJPLPR_aba(1.80e-30, 3.0, 2.8e-11, 0.6);
Gstr{i,1}='NO2'; Gstr{i,2}='OH'; % 
fNO2(i)=fNO2(i)-1; fOH(i)=fOH(i)-1; fHNO3(i)=fHNO3(i)+1; % 

i=i+1;
Rnames{i}='HNO3+OH=H2O+NO3';
k(:,i) = GC_OHHNO3_acacac(2.41e-14, 460.0, 2.69e-17, 2199.0, 6.51e-34, 1335.0);
Gstr{i,1}='HNO3'; Gstr{i,2}='OH'; % 
fHNO3(i)=fHNO3(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='NO+OH=HNO2';
k(:,i) = GCJPLPR_abab(7.00e-31, 2.6, 3.60e-11, 0.1, 0.6);
Gstr{i,1}='NO'; Gstr{i,2}='OH'; % 
fNO(i)=fNO(i)-1; fOH(i)=fOH(i)-1; fHNO2(i)=fHNO2(i)+1; % 

i=i+1;
Rnames{i}='HNO2+OH=H2O+NO2';
k(:,i) = GCARR_ac(1.80e-11, -390.0);
Gstr{i,1}='HNO2'; Gstr{i,2}='OH'; % 
fHNO2(i)=fHNO2(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='NO2+HO2=HNO4'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCJPLPR_abab(1.90e-31, 3.4, 4.0e-12, 0.3, 0.6);
Gstr{i,1}='NO2'; Gstr{i,2}='HO2'; % 
fNO2(i)=fNO2(i)-1; fHO2(i)=fHO2(i)-1; fHNO4(i)=fHNO4(i)+1; % 

i=i+1;
Rnames{i}='HNO4=NO2+HO2'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCJPLPR_abcabc(9.05e-05, 3.4, -10900.0, 1.90d15, 0.3, -10900.0, 0.6);
Gstr{i,1}='HNO4'; % 
fHNO4(i)=fHNO4(i)-1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='HNO4+OH=H2O+NO2+O2';
k(:,i) = GCARR_ac(1.30e-12, 380.0);
Gstr{i,1}='HNO4'; Gstr{i,2}='OH'; % 
fHNO4(i)=fHNO4(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fNO2(i)=fNO2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='NO3+HO2=NO2+OH+O2';
k(:,i) = 3.50e-12;
Gstr{i,1}='NO3'; Gstr{i,2}='HO2'; % 
fNO3(i)=fNO3(i)-1; fHO2(i)=fHO2(i)-1; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='NO+NO3=2.0NO2';
k(:,i) = GCARR_ac(1.50e-11, 170.0);
Gstr{i,1}='NO'; Gstr{i,2}='NO3'; % 
fNO(i)=fNO(i)-1; fNO3(i)=fNO3(i)-1; fNO2(i)=fNO2(i)+2.0; % 

i=i+1;
Rnames{i}='NO3+OH=NO2+HO2';
k(:,i) = 2.20e-11;
Gstr{i,1}='NO3'; Gstr{i,2}='OH'; % 
fNO3(i)=fNO3(i)-1; fOH(i)=fOH(i)-1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='NO2+NO3=N2O5'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCJPLPR_abab(2.40e-30, 3.0, 1.6e-12, -0.1, 0.6);
Gstr{i,1}='NO2'; Gstr{i,2}='NO3'; % 
fNO2(i)=fNO2(i)-1; fNO3(i)=fNO3(i)-1; fN2O5(i)=fN2O5(i)+1; % 

i=i+1;
Rnames{i}='N2O5=NO2+NO3'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCJPLPR_abcabc(4.14e-04, 3.0, -10840.0, 2.76d14, -0.1, -10840.0, 0.6);
Gstr{i,1}='N2O5'; % 
fN2O5(i)=fN2O5(i)-1; fNO2(i)=fNO2(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='HCOOH+OH=H2O+HO2+CO2'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = 4.00e-13;
Gstr{i,1}='HCOOH'; Gstr{i,2}='OH'; % 
fHCOOH(i)=fHCOOH(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fHO2(i)=fHO2(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='MOH+OH=CH2O+HO2';
k(:,i) = GCARR_ac(2.90e-12, -345.0);
Gstr{i,1}='MOH'; Gstr{i,2}='OH'; % 
fMOH(i)=fMOH(i)-1; fOH(i)=fOH(i)-1; fCH2O(i)=fCH2O(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='NO2+NO3=NO+NO2+O2';
k(:,i) = GCARR_ac(4.50e-14, -1260.0);
Gstr{i,1}='NO2'; Gstr{i,2}='NO3'; % 
fNO3(i)=fNO3(i)-1; fNO(i)=fNO(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='CH2O+NO3=HNO3+CO+HO2';
k(:,i) = 5.80e-16;
Gstr{i,1}='CH2O'; Gstr{i,2}='NO3'; % 
fCH2O(i)=fCH2O(i)-1; fNO3(i)=fNO3(i)-1; fHNO3(i)=fHNO3(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ALD2+OH=0.05CH2O+H2O+0.95MCO3+0.05CO+0.05HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(4.63e-12, 350.0);
Gstr{i,1}='ALD2'; Gstr{i,2}='OH'; % 
fALD2(i)=fALD2(i)-1; fOH(i)=fOH(i)-1; fCH2O(i)=fCH2O(i)+0.05; fH2O(i)=fH2O(i)+1; fMCO3(i)=fMCO3(i)+0.95; fCO(i)=fCO(i)+0.05; fHO2(i)=fHO2(i)+0.05; % 

i=i+1;
Rnames{i}='ALD2+NO3=HNO3+MCO3';
k(:,i) = GCARR_ac(1.40e-12, -1900.0);
Gstr{i,1}='ALD2'; Gstr{i,2}='NO3'; % 
fALD2(i)=fALD2(i)-1; fNO3(i)=fNO3(i)-1; fHNO3(i)=fHNO3(i)+1; fMCO3(i)=fMCO3(i)+1; % 

i=i+1;
Rnames{i}='MCO3+NO2=PAN'; % JPL Eval 17
k(:,i) = GCJPLPR_abab(9.70e-29, 5.6, 9.3e-12, 1.5, 0.6);
Gstr{i,1}='MCO3'; Gstr{i,2}='NO2'; % 
fMCO3(i)=fMCO3(i)-1; fNO2(i)=fNO2(i)-1; fPAN(i)=fPAN(i)+1; % 

i=i+1;
Rnames{i}='PAN=MCO3+NO2';
k(:,i) = GCJPLEQ_acabab(9.30e-29, 14000.0, 9.7e-29, 5.6, 9.3e-12, 1.5, 0.6);
Gstr{i,1}='PAN'; % 
fPAN(i)=fPAN(i)-1; fMCO3(i)=fMCO3(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+NO=MO2+NO2+CO2';
k(:,i) = GCARR_ac(8.10e-12, 270.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='NO'; % 
fMCO3(i)=fMCO3(i)-1; fNO(i)=fNO(i)-1; fMO2(i)=fMO2(i)+1; fNO2(i)=fNO2(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='C2H6+OH=ETO2+H2O'; % 2013/02/12, JPL 10-6, BHH,JMAO,EAM
k(:,i) = GCARR_ac(7.66e-12, -1020.0);
Gstr{i,1}='C2H6'; Gstr{i,2}='OH'; % 
fC2H6(i)=fC2H6(i)-1; fOH(i)=fOH(i)-1; fETO2(i)=fETO2(i)+1; fH2O(i)=fH2O(i)+1; % 

i=i+1;
Rnames{i}='ETO2+NO=ALD2+NO2+HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GC_RO2NO_B2_aca(2.60e-12, 365.0, 2.0);
Gstr{i,1}='ETO2'; Gstr{i,2}='NO'; % 
fETO2(i)=fETO2(i)-1; fNO(i)=fNO(i)-1; fALD2(i)=fALD2(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ETO2+NO=ETNO3'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GC_RO2NO_A2_aca(2.60e-12, 365.0, 2.0);
Gstr{i,1}='ETO2'; Gstr{i,2}='NO'; % 
fETO2(i)=fETO2(i)-1; fNO(i)=fNO(i)-1; fETNO3(i)=fETNO3(i)+1; % 

i=i+1;
Rnames{i}='NO+OTHRO2=ALD2+NO2+HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GCARR_ac(2.60e-12, 365.0);
Gstr{i,1}='NO'; Gstr{i,2}='OTHRO2'; % 
fNO(i)=fNO(i)-1; fOTHRO2(i)=fOTHRO2(i)-1; fALD2(i)=fALD2(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='C3H8+OH=B3O2';
k(:,i) = GC_TBRANCH_2_acabc(7.60e-12, -585.0, 5.87, 0.64, -816.0);
Gstr{i,1}='C3H8'; Gstr{i,2}='OH'; % 
fC3H8(i)=fC3H8(i)-1; fOH(i)=fOH(i)-1; fB3O2(i)=fB3O2(i)+1; % 

i=i+1;
Rnames{i}='C3H8+OH=A3O2';
k(:,i) = GC_TBRANCH_2_acabc(7.60e-12, -585.0, 1.7e-1, -0.64, 816.0);
Gstr{i,1}='C3H8'; Gstr{i,2}='OH'; % 
fC3H8(i)=fC3H8(i)-1; fOH(i)=fOH(i)-1; fA3O2(i)=fA3O2(i)+1; % 

i=i+1;
Rnames{i}='A3O2+NO=RCHO+NO2+HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GC_RO2NO_B2_aca(2.90e-12, 350.0, 3.0);
Gstr{i,1}='A3O2'; Gstr{i,2}='NO'; % 
fA3O2(i)=fA3O2(i)-1; fNO(i)=fNO(i)-1; fRCHO(i)=fRCHO(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='A3O2+NO=NPRNO3'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GC_RO2NO_A2_aca(2.90e-12, 350.0, 3.0);
Gstr{i,1}='A3O2'; Gstr{i,2}='NO'; % 
fA3O2(i)=fA3O2(i)-1; fNO(i)=fNO(i)-1; fNPRNO3(i)=fNPRNO3(i)+1; % 

i=i+1;
Rnames{i}='NO+PO2=ALD2+CH2O+NO2+HO2';
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='NO'; Gstr{i,2}='PO2'; % 
fNO(i)=fNO(i)-1; fPO2(i)=fPO2(i)-1; fALD2(i)=fALD2(i)+1; fCH2O(i)=fCH2O(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ALK4+OH=R4O2';
k(:,i) = GCARR_ac(9.10e-12, -405.0);
Gstr{i,1}='ALK4'; Gstr{i,2}='OH'; % 
fALK4(i)=fALK4(i)-1; fOH(i)=fOH(i)-1; fR4O2(i)=fR4O2(i)+1; % 

i=i+1;
Rnames{i}='NO+R4O2=0.05A3O2+0.32ACET+0.32ALD2+0.18B3O2+0.19MEK+0.19MO2+0.32OTHRO2+0.14RCHO+NO2+0.27HO2'; % 2017/02/23, ALK4 lumping fix, BHH
k(:,i) = GC_RO2NO_B2_aca(2.70e-12, 350.0, 4.5);
Gstr{i,1}='NO'; Gstr{i,2}='R4O2'; % 
fNO(i)=fNO(i)-1; fR4O2(i)=fR4O2(i)-1; fA3O2(i)=fA3O2(i)+0.05; fACET(i)=fACET(i)+0.32; fALD2(i)=fALD2(i)+0.32; fB3O2(i)=fB3O2(i)+0.18; fMEK(i)=fMEK(i)+0.19; fMO2(i)=fMO2(i)+0.19; fOTHRO2(i)=fOTHRO2(i)+0.32; fRCHO(i)=fRCHO(i)+0.14; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+0.27; % 

i=i+1;
Rnames{i}='NO+R4O2=R4N2';
k(:,i) = GC_RO2NO_A2_aca(2.70e-12, 350.0, 4.5);
Gstr{i,1}='NO'; Gstr{i,2}='R4O2'; % 
fNO(i)=fNO(i)-1; fR4O2(i)=fR4O2(i)-1; fR4N2(i)=fR4N2(i)+1; % 

i=i+1;
Rnames{i}='NO+R4N1=0.86ALD2+0.57CH2O+0.57RCHO+2.0NO2'; % 2017/07/27, Fix C creation, SAS,BHH,MJE
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='NO'; Gstr{i,2}='R4N1'; % 
fNO(i)=fNO(i)-1; fR4N1(i)=fR4N1(i)-1; fALD2(i)=fALD2(i)+0.86; fCH2O(i)=fCH2O(i)+0.57; fRCHO(i)=fRCHO(i)+0.57; fNO2(i)=fNO2(i)+2.0; % 

i=i+1;
Rnames{i}='ATO2+NO=CH2O+MCO3+NO2'; % 2017/07/27, Fix C creation, SAS,BHH,MJE
k(:,i) = GCARR_ac(2.80e-12, 300.0);
Gstr{i,1}='ATO2'; Gstr{i,2}='NO'; % 
fATO2(i)=fATO2(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+1; fMCO3(i)=fMCO3(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='KO2+NO=0.93ALD2+0.93MCO3+0.07R4N2+0.93NO2';
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='KO2'; Gstr{i,2}='NO'; % 
fKO2(i)=fKO2(i)-1; fNO(i)=fNO(i)-1; fALD2(i)=fALD2(i)+0.93; fMCO3(i)=fMCO3(i)+0.93; fR4N2(i)=fR4N2(i)+0.07; fNO2(i)=fNO2(i)+0.93; % 

i=i+1;
Rnames{i}='B3O2+NO=ACET+NO2+HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GC_RO2NO_B2_aca(2.70e-12, 360.0, 3.0);
Gstr{i,1}='B3O2'; Gstr{i,2}='NO'; % 
fB3O2(i)=fB3O2(i)-1; fNO(i)=fNO(i)-1; fACET(i)=fACET(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='B3O2+NO=IPRNO3'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GC_RO2NO_A2_aca(2.70e-12, 360.0, 3.0);
Gstr{i,1}='B3O2'; Gstr{i,2}='NO'; % 
fB3O2(i)=fB3O2(i)-1; fNO(i)=fNO(i)-1; fIPRNO3(i)=fIPRNO3(i)+1; % 

i=i+1;
Rnames{i}='NO+PRN1=ALD2+CH2O+2.0NO2';
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='NO'; Gstr{i,2}='PRN1'; % 
fNO(i)=fNO(i)-1; fPRN1(i)=fPRN1(i)-1; fALD2(i)=fALD2(i)+1; fCH2O(i)=fCH2O(i)+1; fNO2(i)=fNO2(i)+2.0; % 

i=i+1;
Rnames{i}='ALK4+NO3=HNO3+R4O2';
k(:,i) = GCARR_ac(2.80e-12, -3280.0);
Gstr{i,1}='ALK4'; Gstr{i,2}='NO3'; % 
fALK4(i)=fALK4(i)-1; fNO3(i)=fNO3(i)-1; fHNO3(i)=fHNO3(i)+1; fR4O2(i)=fR4O2(i)+1; % 

i=i+1;
Rnames{i}='R4N2+OH=H2O+R4N1';
k(:,i) = 1.60e-12;
Gstr{i,1}='R4N2'; Gstr{i,2}='OH'; % 
fR4N2(i)=fR4N2(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fR4N1(i)=fR4N1(i)+1; % 

i=i+1;
Rnames{i}='ACTA+OH=H2O+MO2+CO2'; % 2013/02/12, JPL 10-6, BHH,JMAO,EAM
k(:,i) = GCARR_ac(3.15e-14, 920.0);
Gstr{i,1}='ACTA'; Gstr{i,2}='OH'; % 
fACTA(i)=fACTA(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fMO2(i)=fMO2(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='RCHO+OH=H2O+RCO3';
k(:,i) = GCARR_ac(6.00e-12, 410.0);
Gstr{i,1}='RCHO'; Gstr{i,2}='OH'; % 
fRCHO(i)=fRCHO(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fRCO3(i)=fRCO3(i)+1; % 

i=i+1;
Rnames{i}='RCO3+NO2=PPN'; % JPL Eval 17
k(:,i) = GCJPLPR_abab(9.00e-28, 8.9, 7.7e-12, 0.2, 0.6);
Gstr{i,1}='RCO3'; Gstr{i,2}='NO2'; % 
fRCO3(i)=fRCO3(i)-1; fNO2(i)=fNO2(i)-1; fPPN(i)=fPPN(i)+1; % 

i=i+1;
Rnames{i}='PPN=RCO3+NO2';
k(:,i) = GCJPLEQ_acabab(9.00e-29, 14000.0, 9.00e-28, 8.9, 7.7e-12, 0.2, 0.6);
Gstr{i,1}='PPN'; % 
fPPN(i)=fPPN(i)-1; fRCO3(i)=fRCO3(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='NO+RCO3=0.07A3O2+0.27B3O2+0.5OTHRO2+NO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GCARR_ac(6.70e-12, 340.0);
Gstr{i,1}='NO'; Gstr{i,2}='RCO3'; % 
fNO(i)=fNO(i)-1; fRCO3(i)=fRCO3(i)-1; fA3O2(i)=fA3O2(i)+0.07; fB3O2(i)=fB3O2(i)+0.27; fOTHRO2(i)=fOTHRO2(i)+0.5; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='RCHO+NO3=HNO3+RCO3';
k(:,i) = 6.50e-15;
Gstr{i,1}='RCHO'; Gstr{i,2}='NO3'; % 
fRCHO(i)=fRCHO(i)-1; fNO3(i)=fNO3(i)-1; fHNO3(i)=fHNO3(i)+1; fRCO3(i)=fRCO3(i)+1; % 

i=i+1;
Rnames{i}='ACET+OH=ATO2+H2O'; % JPL Eval 17, p1-62-D31, EVF
k(:,i) = 1.33e-13 + 3.82e-11.*exp(-2000.0./TEMP);
Gstr{i,1}='ACET'; Gstr{i,2}='OH'; % 
fACET(i)=fACET(i)-1; fOH(i)=fOH(i)-1; fATO2(i)=fATO2(i)+1; fH2O(i)=fH2O(i)+1; % 

i=i+1;
Rnames{i}='A3O2+MO2=0.75CH2O+0.25MOH+0.75RCHO+0.25ROH+HO2';
k(:,i) = 5.92e-13;
Gstr{i,1}='A3O2'; Gstr{i,2}='MO2'; % 
fA3O2(i)=fA3O2(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+0.75; fMOH(i)=fMOH(i)+0.25; fRCHO(i)=fRCHO(i)+0.75; fROH(i)=fROH(i)+0.25; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+PO2=0.5ALD2+1.25CH2O+0.16HAC+0.25MOH+0.09RCHO+0.25ROH+HO2';
k(:,i) = 5.92e-13;
Gstr{i,1}='MO2'; Gstr{i,2}='PO2'; % 
fMO2(i)=fMO2(i)-1; fPO2(i)=fPO2(i)-1; fALD2(i)=fALD2(i)+0.5; fCH2O(i)=fCH2O(i)+1.25; fHAC(i)=fHAC(i)+0.16; fMOH(i)=fMOH(i)+0.25; fRCHO(i)=fRCHO(i)+0.09; fROH(i)=fROH(i)+0.25; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='R4O2+HO2=R4P';
k(:,i) = GCARR_ac(7.40e-13, 700.0);
Gstr{i,1}='R4O2'; Gstr{i,2}='HO2'; % 
fR4O2(i)=fR4O2(i)-1; fHO2(i)=fHO2(i)-1; fR4P(i)=fR4P(i)+1; % 

i=i+1;
Rnames{i}='R4N1+HO2=R4N2';
k(:,i) = GCARR_ac(7.40e-13, 700.0);
Gstr{i,1}='R4N1'; Gstr{i,2}='HO2'; % 
fR4N1(i)=fR4N1(i)-1; fHO2(i)=fHO2(i)-1; fR4N2(i)=fR4N2(i)+1; % 

i=i+1;
Rnames{i}='ATO2+HO2=0.85ATOOH+0.15CH2O+0.15MCO3+0.15OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(8.60e-13, 700.0);
Gstr{i,1}='ATO2'; Gstr{i,2}='HO2'; % 
fATO2(i)=fATO2(i)-1; fHO2(i)=fHO2(i)-1; fATOOH(i)=fATOOH(i)+0.85; fCH2O(i)=fCH2O(i)+0.15; fMCO3(i)=fMCO3(i)+0.15; fOH(i)=fOH(i)+0.15; % 

i=i+1;
Rnames{i}='KO2+HO2=0.15ALD2+0.85ATOOH+0.15MCO3+0.15OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GC_RO2HO2_aca(2.91e-13, 1300.0, 4.0);
Gstr{i,1}='KO2'; Gstr{i,2}='HO2'; % 
fKO2(i)=fKO2(i)-1; fHO2(i)=fHO2(i)-1; fALD2(i)=fALD2(i)+0.15; fATOOH(i)=fATOOH(i)+0.85; fMCO3(i)=fMCO3(i)+0.15; fOH(i)=fOH(i)+0.15; % 

i=i+1;
Rnames{i}='B3O2+HO2=RB3P'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GC_RO2HO2_aca(2.91e-13, 1300.0, 3.0);
Gstr{i,1}='B3O2'; Gstr{i,2}='HO2'; % 
fB3O2(i)=fB3O2(i)-1; fHO2(i)=fHO2(i)-1; fRB3P(i)=fRB3P(i)+1; % 

i=i+1;
Rnames{i}='PRN1+HO2=PRPN'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GC_RO2HO2_aca(2.91e-13, 1300.0, 3.0);
Gstr{i,1}='PRN1'; Gstr{i,2}='HO2'; % 
fPRN1(i)=fPRN1(i)-1; fHO2(i)=fHO2(i)-1; fPRPN(i)=fPRPN(i)+1; % 

i=i+1;
Rnames{i}='MEK+OH=H2O+KO2';
k(:,i) = GCARR_ac(1.30e-12, -25.0);
Gstr{i,1}='MEK'; Gstr{i,2}='OH'; % 
fMEK(i)=fMEK(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fKO2(i)=fKO2(i)+1; % 

i=i+1;
Rnames{i}='ETO2+MO2=0.75ALD2+0.75CH2O+0.25EOH+0.25MOH+HO2';
k(:,i) = 3.00e-13;
Gstr{i,1}='ETO2'; Gstr{i,2}='MO2'; % 
fETO2(i)=fETO2(i)-1; fMO2(i)=fMO2(i)-1; fALD2(i)=fALD2(i)+0.75; fCH2O(i)=fCH2O(i)+0.75; fEOH(i)=fEOH(i)+0.25; fMOH(i)=fMOH(i)+0.25; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+OTHRO2=0.75ALD2+0.75CH2O+0.25EOH+0.25MOH+HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = 3.00e-13;
Gstr{i,1}='MO2'; Gstr{i,2}='OTHRO2'; % 
fMO2(i)=fMO2(i)-1; fOTHRO2(i)=fOTHRO2(i)-1; fALD2(i)=fALD2(i)+0.75; fCH2O(i)=fCH2O(i)+0.75; fEOH(i)=fEOH(i)+0.25; fMOH(i)=fMOH(i)+0.25; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MEK+NO3=HNO3+KO2';
k(:,i) = 8.00e-16;
Gstr{i,1}='MEK'; Gstr{i,2}='NO3'; % 
fMEK(i)=fMEK(i)-1; fNO3(i)=fNO3(i)-1; fHNO3(i)=fHNO3(i)+1; fKO2(i)=fKO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+R4O2=0.03A3O2+0.16ACET+0.16ALD2+0.09B3O2+0.75CH2O+0.64HO2+0.35MEK+0.09MO2+0.25MOH+0.16OTHRO2+0.07RCHO+0.25ROH';
k(:,i) = 8.37e-14;
Gstr{i,1}='MO2'; Gstr{i,2}='R4O2'; % 
fMO2(i)=fMO2(i)-0.910; fR4O2(i)=fR4O2(i)-1; fMO2(i)=fMO2(i)-0.910; fA3O2(i)=fA3O2(i)+0.03; fACET(i)=fACET(i)+0.16; fALD2(i)=fALD2(i)+0.16; fB3O2(i)=fB3O2(i)+0.09; fCH2O(i)=fCH2O(i)+0.75; fHO2(i)=fHO2(i)+0.64; fMEK(i)=fMEK(i)+0.35; fMOH(i)=fMOH(i)+0.25; fOTHRO2(i)=fOTHRO2(i)+0.16; fRCHO(i)=fRCHO(i)+0.07; fROH(i)=fROH(i)+0.25; % 

i=i+1;
Rnames{i}='MO2+R4N1=0.38ALD2+0.95CH2O+0.25MOH+0.15R4O2+0.54RCHO+0.25ROH+NO2+0.5HO2';
k(:,i) = 8.37e-14;
Gstr{i,1}='MO2'; Gstr{i,2}='R4N1'; % 
fMO2(i)=fMO2(i)-1; fR4N1(i)=fR4N1(i)-1; fALD2(i)=fALD2(i)+0.38; fCH2O(i)=fCH2O(i)+0.95; fMOH(i)=fMOH(i)+0.25; fR4O2(i)=fR4O2(i)+0.15; fRCHO(i)=fRCHO(i)+0.54; fROH(i)=fROH(i)+0.25; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='ATO2+MO2=0.50CH2O+0.2HAC+0.3MCO3+0.5MGLY+0.5MOH+0.3HO2';
k(:,i) = GCARR_ac(7.50e-13, 500.0);
Gstr{i,1}='ATO2'; Gstr{i,2}='MO2'; % 
fATO2(i)=fATO2(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+0.50; fHAC(i)=fHAC(i)+0.2; fMCO3(i)=fMCO3(i)+0.3; fMGLY(i)=fMGLY(i)+0.5; fMOH(i)=fMOH(i)+0.5; fHO2(i)=fHO2(i)+0.3; % 

i=i+1;
Rnames{i}='KO2+MO2=0.5ALD2+0.75CH2O+0.5MCO3+0.25MEK+0.25MOH+0.25ROH+0.5HO2';
k(:,i) = 8.37e-14;
Gstr{i,1}='KO2'; Gstr{i,2}='MO2'; % 
fKO2(i)=fKO2(i)-1; fMO2(i)=fMO2(i)-1; fALD2(i)=fALD2(i)+0.5; fCH2O(i)=fCH2O(i)+0.75; fMCO3(i)=fMCO3(i)+0.5; fMEK(i)=fMEK(i)+0.25; fMOH(i)=fMOH(i)+0.25; fROH(i)=fROH(i)+0.25; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='B3O2+MO2=0.75ACET+0.75CH2O+HO2+0.25MOH+0.25ROH';
k(:,i) = 8.37e-14;
Gstr{i,1}='B3O2'; Gstr{i,2}='MO2'; % 
fB3O2(i)=fB3O2(i)-1; fMO2(i)=fMO2(i)-1; fACET(i)=fACET(i)+0.75; fCH2O(i)=fCH2O(i)+0.75; fHO2(i)=fHO2(i)+1; fMOH(i)=fMOH(i)+0.25; fROH(i)=fROH(i)+0.25; % 

i=i+1;
Rnames{i}='MO2+PRN1=0.5ALD2+1.25CH2O+0.25MOH+0.25RCHO+0.25ROH+NO2+0.5HO2';
k(:,i) = 8.37e-14;
Gstr{i,1}='MO2'; Gstr{i,2}='PRN1'; % 
fMO2(i)=fMO2(i)-1; fPRN1(i)=fPRN1(i)-1; fALD2(i)=fALD2(i)+0.5; fCH2O(i)=fCH2O(i)+1.25; fMOH(i)=fMOH(i)+0.25; fRCHO(i)=fRCHO(i)+0.25; fROH(i)=fROH(i)+0.25; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='EOH+OH=ALD2+HO2'; % 2013/02/12, JPL 10-6, BHH,JMAO,EAM
k(:,i) = 3.35e-12;
Gstr{i,1}='EOH'; Gstr{i,2}='OH'; % 
fEOH(i)=fEOH(i)-1; fOH(i)=fOH(i)-1; fALD2(i)=fALD2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ROH+OH=RCHO+HO2';
k(:,i) = GCARR_ac(4.60e-12, 70.0);
Gstr{i,1}='ROH'; Gstr{i,2}='OH'; % 
fROH(i)=fROH(i)-1; fOH(i)=fOH(i)-1; fRCHO(i)=fRCHO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ETO2+ETO2=2.0ALD2+2.0HO2';
k(:,i) = 4.10e-14;
Gstr{i,1}='ETO2'; Gstr{i,2}='ETO2'; % 
fETO2(i)=fETO2(i)-2; fALD2(i)=fALD2(i)+2.0; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='OTHRO2+OTHRO2=2.0ALD2+2.0HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = 4.10e-14;
Gstr{i,1}='OTHRO2'; Gstr{i,2}='OTHRO2'; % 
fOTHRO2(i)=fOTHRO2(i)-2; fALD2(i)=fALD2(i)+2.0; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='ETO2+ETO2=ALD2+EOH';
k(:,i) = 2.70e-14;
Gstr{i,1}='ETO2'; Gstr{i,2}='ETO2'; % 
fETO2(i)=fETO2(i)-2; fALD2(i)=fALD2(i)+1; fEOH(i)=fEOH(i)+1; % 

i=i+1;
Rnames{i}='OTHRO2+OTHRO2=ALD2+EOH'; % 2019/05/10, Fisher2018, JAF
k(:,i) = 2.70e-14;
Gstr{i,1}='OTHRO2'; Gstr{i,2}='OTHRO2'; % 
fOTHRO2(i)=fOTHRO2(i)-2; fALD2(i)=fALD2(i)+1; fEOH(i)=fEOH(i)+1; % 

i=i+1;
Rnames{i}='ETO2+HO2=ETP';
k(:,i) = GCARR_ac(7.40e-13, 700.0);
Gstr{i,1}='ETO2'; Gstr{i,2}='HO2'; % 
fETO2(i)=fETO2(i)-1; fHO2(i)=fHO2(i)-1; fETP(i)=fETP(i)+1; % 

i=i+1;
Rnames{i}='OTHRO2+HO2=ETP'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GCARR_ac(7.40e-13, 700.0);
Gstr{i,1}='OTHRO2'; Gstr{i,2}='HO2'; % 
fOTHRO2(i)=fOTHRO2(i)-1; fHO2(i)=fHO2(i)-1; fETP(i)=fETP(i)+1; % 

i=i+1;
Rnames{i}='A3O2+HO2=RA3P'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GC_RO2HO2_aca(2.91e-13, 1300.0, 3.0);
Gstr{i,1}='A3O2'; Gstr{i,2}='HO2'; % 
fA3O2(i)=fA3O2(i)-1; fHO2(i)=fHO2(i)-1; fRA3P(i)=fRA3P(i)+1; % 

i=i+1;
Rnames{i}='PO2+HO2=PP'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GC_RO2HO2_aca(2.91e-13, 1300.0, 3.0);
Gstr{i,1}='PO2'; Gstr{i,2}='HO2'; % 
fPO2(i)=fPO2(i)-1; fHO2(i)=fHO2(i)-1; fPP(i)=fPP(i)+1; % 

i=i+1;
Rnames{i}='RCO3+HO2=0.03A3O2+0.12B3O2+0.22OTHRO2+0.15RCOOH+0.41RP+0.15O3+0.44OH'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GCARR_ac(4.30e-13, 1040.0);
Gstr{i,1}='RCO3'; Gstr{i,2}='HO2'; % 
fRCO3(i)=fRCO3(i)-1; fHO2(i)=fHO2(i)-1; fA3O2(i)=fA3O2(i)+0.03; fB3O2(i)=fB3O2(i)+0.12; fOTHRO2(i)=fOTHRO2(i)+0.22; fRCOOH(i)=fRCOOH(i)+0.15; fRP(i)=fRP(i)+0.41; fO3(i)=fO3(i)+0.15; fOH(i)=fOH(i)+0.44; % 

i=i+1;
Rnames{i}='PRPE+OH=PO2'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCJPLPR_abab(4.60e-27, 4.0, 2.6e-11, 1.3, 0.5);
Gstr{i,1}='PRPE'; Gstr{i,2}='OH'; % 
fPRPE(i)=fPRPE(i)-1; fOH(i)=fOH(i)-1; fPO2(i)=fPO2(i)+1; % 

i=i+1;
Rnames{i}='PRPE+O3=0.5ALD2+0.5CH2O+0.12CH2OO+0.12CH3CHOO+0.1CH4+0.28MO2+0.56CO+0.36OH+0.28HO2'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = GCARR_ac(5.50e-15, -1880.0);
Gstr{i,1}='PRPE'; Gstr{i,2}='O3'; % 
fPRPE(i)=fPRPE(i)-1; fO3(i)=fO3(i)-1; fALD2(i)=fALD2(i)+0.5; fCH2O(i)=fCH2O(i)+0.5; fCH2OO(i)=fCH2OO(i)+0.12; fCH3CHOO(i)=fCH3CHOO(i)+0.12; fCH4(i)=fCH4(i)+0.1; fMO2(i)=fMO2(i)+0.28; fCO(i)=fCO(i)+0.56; fOH(i)=fOH(i)+0.36; fHO2(i)=fHO2(i)+0.28; % 

i=i+1;
Rnames{i}='GLYC+OH=0.732CH2O+0.134GLYX+0.134HCOOH+0.505CO+0.227OH+0.773HO2+0.361CO2'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GC_GLYCOH_A_a(8.00e-12);
Gstr{i,1}='GLYC'; Gstr{i,2}='OH'; % 
fGLYC(i)=fGLYC(i)-1; fOH(i)=fOH(i)-0.773; fOH(i)=fOH(i)-0.773; fCH2O(i)=fCH2O(i)+0.732; fGLYX(i)=fGLYX(i)+0.134; fHCOOH(i)=fHCOOH(i)+0.134; fCO(i)=fCO(i)+0.505; fHO2(i)=fHO2(i)+0.773; fCO2(i)=fCO2(i)+0.361; % 

i=i+1;
Rnames{i}='GLYC+OH=HCOOH+CO+OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GC_GLYCOH_B_a(8.00e-12);
Gstr{i,1}='GLYC'; Gstr{i,2}='OH'; % 
fGLYC(i)=fGLYC(i)-1; fHCOOH(i)=fHCOOH(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='PRPE+NO3=PRN1';
k(:,i) = GCARR_ac(4.59e-13, -1156.0);
Gstr{i,1}='PRPE'; Gstr{i,2}='NO3'; % 
fPRPE(i)=fPRPE(i)-1; fNO3(i)=fNO3(i)-1; fPRN1(i)=fPRN1(i)+1; % 

i=i+1;
Rnames{i}='GLYX+OH=2.0CO+HO2'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(3.10e-12, 340.0);
Gstr{i,1}='GLYX'; Gstr{i,2}='OH'; % 
fGLYX(i)=fGLYX(i)-1; fOH(i)=fOH(i)-1; fCO(i)=fCO(i)+2.0; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MGLY+OH=MCO3+CO';
k(:,i) = 1.50e-11;
Gstr{i,1}='MGLY'; Gstr{i,2}='OH'; % 
fMGLY(i)=fMGLY(i)-1; fOH(i)=fOH(i)-1; fMCO3(i)=fMCO3(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='GLYX+NO3=HNO3+2.0CO+HO2';
k(:,i) = GC_GLYXNO3_ac(1.40e-12, -1860.0);
Gstr{i,1}='GLYX'; Gstr{i,2}='NO3'; % 
fGLYX(i)=fGLYX(i)-1; fNO3(i)=fNO3(i)-1; fHNO3(i)=fHNO3(i)+1; fCO(i)=fCO(i)+2.0; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MGLY+NO3=HNO3+MCO3+CO'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(3.36e-12, -1860.0);
Gstr{i,1}='MGLY'; Gstr{i,2}='NO3'; % 
fMGLY(i)=fMGLY(i)-1; fNO3(i)=fNO3(i)-1; fHNO3(i)=fHNO3(i)+1; fMCO3(i)=fMCO3(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='HAC+OH=MGLY+HO2'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GC_HACOH_A_ac(2.15e-12, 305.0);
Gstr{i,1}='HAC'; Gstr{i,2}='OH'; % 
fHAC(i)=fHAC(i)-1; fOH(i)=fOH(i)-1; fMGLY(i)=fMGLY(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='HAC+OH=0.5ACTA+0.5HCOOH+0.5MO2+0.5CO+OH+0.5CO2'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GC_HACOH_B_ac(2.15e-12, 305.0);
Gstr{i,1}='HAC'; Gstr{i,2}='OH'; % 
fHAC(i)=fHAC(i)-1; fACTA(i)=fACTA(i)+0.5; fHCOOH(i)=fHCOOH(i)+0.5; fMO2(i)=fMO2(i)+0.5; fCO(i)=fCO(i)+0.5; fCO2(i)=fCO2(i)+0.5; % 

i=i+1;
Rnames{i}='A3O2+MCO3=MO2+RCHO+HO2';
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='A3O2'; Gstr{i,2}='MCO3'; % 
fA3O2(i)=fA3O2(i)-1; fMCO3(i)=fMCO3(i)-1; fMO2(i)=fMO2(i)+1; fRCHO(i)=fRCHO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+PO2=ALD2+CH2O+MO2+HO2';
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='PO2'; % 
fMCO3(i)=fMCO3(i)-1; fPO2(i)=fPO2(i)-1; fALD2(i)=fALD2(i)+1; fCH2O(i)=fCH2O(i)+1; fMO2(i)=fMO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='A3O2+MCO3=ACTA+RCHO';
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='A3O2'; Gstr{i,2}='MCO3'; % 
fA3O2(i)=fA3O2(i)-1; fMCO3(i)=fMCO3(i)-1; fACTA(i)=fACTA(i)+1; fRCHO(i)=fRCHO(i)+1; % 

i=i+1;
Rnames{i}='MCO3+PO2=ACTA+0.65HAC+0.35RCHO';
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='PO2'; % 
fMCO3(i)=fMCO3(i)-1; fPO2(i)=fPO2(i)-1; fACTA(i)=fACTA(i)+1; fHAC(i)=fHAC(i)+0.65; fRCHO(i)=fRCHO(i)+0.35; % 

i=i+1;
Rnames{i}='MO2+RCO3=0.07A3O2+0.27B3O2+CH2O+0.5OTHRO2+HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='MO2'; Gstr{i,2}='RCO3'; % 
fMO2(i)=fMO2(i)-1; fRCO3(i)=fRCO3(i)-1; fA3O2(i)=fA3O2(i)+0.07; fB3O2(i)=fB3O2(i)+0.27; fCH2O(i)=fCH2O(i)+1; fOTHRO2(i)=fOTHRO2(i)+0.5; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+RCO3=CH2O+RCOOH';
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='MO2'; Gstr{i,2}='RCO3'; % 
fMO2(i)=fMO2(i)-1; fRCO3(i)=fRCO3(i)-1; fCH2O(i)=fCH2O(i)+1; fRCOOH(i)=fRCOOH(i)+1; % 

i=i+1;
Rnames{i}='PRPN+OH=0.209PRN1+0.791PROPNN+0.791OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(8.78e-12, 200.0);
Gstr{i,1}='PRPN'; Gstr{i,2}='OH'; % 
fPRPN(i)=fPRPN(i)-1; fOH(i)=fOH(i)-0.209; fOH(i)=fOH(i)-0.209; fPRN1(i)=fPRN1(i)+0.209; fPROPNN(i)=fPROPNN(i)+0.791; % 

i=i+1;
Rnames{i}='ETP+OH=0.64ALD2+0.36OTHRO2+0.64OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(5.18e-12, 200.0);
Gstr{i,1}='ETP'; Gstr{i,2}='OH'; % 
fETP(i)=fETP(i)-1; fOH(i)=fOH(i)-0.360; fOH(i)=fOH(i)-0.360; fALD2(i)=fALD2(i)+0.64; fOTHRO2(i)=fOTHRO2(i)+0.36; % 

i=i+1;
Rnames{i}='RA3P+OH=0.36A3O2+0.64RCHO+0.64OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(5.18e-12, 200.0);
Gstr{i,1}='RA3P'; Gstr{i,2}='OH'; % 
fRA3P(i)=fRA3P(i)-1; fOH(i)=fOH(i)-0.360; fOH(i)=fOH(i)-0.360; fA3O2(i)=fA3O2(i)+0.36; fRCHO(i)=fRCHO(i)+0.64; % 

i=i+1;
Rnames{i}='RB3P+OH=0.791ACET+0.209B3O2+0.791OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(8.78e-12, 200.0);
Gstr{i,1}='RB3P'; Gstr{i,2}='OH'; % 
fRB3P(i)=fRB3P(i)-1; fOH(i)=fOH(i)-0.209; fOH(i)=fOH(i)-0.209; fACET(i)=fACET(i)+0.791; fB3O2(i)=fB3O2(i)+0.209; % 

i=i+1;
Rnames{i}='R4P+OH=0.209R4O2+0.791RCHO+0.791OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(8.78e-12, 200.0);
Gstr{i,1}='R4P'; Gstr{i,2}='OH'; % 
fR4P(i)=fR4P(i)-1; fOH(i)=fOH(i)-0.209; fOH(i)=fOH(i)-0.209; fR4O2(i)=fR4O2(i)+0.209; fRCHO(i)=fRCHO(i)+0.791; % 

i=i+1;
Rnames{i}='RP+OH=RCO3'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(6.13e-13, 200.0);
Gstr{i,1}='RP'; Gstr{i,2}='OH'; % 
fRP(i)=fRP(i)-1; fOH(i)=fOH(i)-1; fRCO3(i)=fRCO3(i)+1; % 

i=i+1;
Rnames{i}='PP+OH=0.791HAC+0.209PO2+0.791OH'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(8.78e-12, 200.0);
Gstr{i,1}='PP'; Gstr{i,2}='OH'; % 
fPP(i)=fPP(i)-1; fOH(i)=fOH(i)-0.209; fOH(i)=fOH(i)-0.209; fHAC(i)=fHAC(i)+0.791; fPO2(i)=fPO2(i)+0.209; % 

i=i+1;
Rnames{i}='LVOC+OH=OH'; % 2017/06/14, Marais2016, EAM
k(:,i) = GCARR_ac(4.82e-11, -400.0);
Gstr{i,1}='LVOC'; Gstr{i,2}='OH'; % 
fLVOC(i)=fLVOC(i)-1; % 

i=i+1;
Rnames{i}='MAP+OH=MCO3'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(6.13e-13, 200.0);
Gstr{i,1}='MAP'; Gstr{i,2}='OH'; % 
fMAP(i)=fMAP(i)-1; fOH(i)=fOH(i)-1; fMCO3(i)=fMCO3(i)+1; % 

i=i+1;
Rnames{i}='C2H6+NO3=ETO2+HNO3'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = 1.40e-18;
Gstr{i,1}='C2H6'; Gstr{i,2}='NO3'; % 
fC2H6(i)=fC2H6(i)-1; fNO3(i)=fNO3(i)-1; fETO2(i)=fETO2(i)+1; fHNO3(i)=fHNO3(i)+1; % 

i=i+1;
Rnames{i}='MCO3+MCO3=2.0MO2';
k(:,i) = GCARR_ac(2.50e-12, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='MCO3'; % 
fMCO3(i)=fMCO3(i)-2; fMO2(i)=fMO2(i)+2.0; % 

i=i+1;
Rnames{i}='MCO3+MO2=CH2O+MO2+HO2';
k(:,i) = GCARR_ac(1.80e-12, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='MO2'; % 
fMCO3(i)=fMCO3(i)-1; fCH2O(i)=fCH2O(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+MO2=ACTA+CH2O';
k(:,i) = GCARR_ac(2.00e-13, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='MO2'; % 
fMCO3(i)=fMCO3(i)-1; fMO2(i)=fMO2(i)-1; fACTA(i)=fACTA(i)+1; fCH2O(i)=fCH2O(i)+1; % 

i=i+1;
Rnames{i}='MCO3+R4O2=0.05A3O2+0.32ACET+0.32ALD2+0.18B3O2+0.19MEK+MO2+0.32OTHRO2+0.13RCHO+0.27HO2'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='R4O2'; % 
fMCO3(i)=fMCO3(i)-1; fR4O2(i)=fR4O2(i)-1; fA3O2(i)=fA3O2(i)+0.05; fACET(i)=fACET(i)+0.32; fALD2(i)=fALD2(i)+0.32; fB3O2(i)=fB3O2(i)+0.18; fMEK(i)=fMEK(i)+0.19; fMO2(i)=fMO2(i)+1; fOTHRO2(i)=fOTHRO2(i)+0.32; fRCHO(i)=fRCHO(i)+0.13; fHO2(i)=fHO2(i)+0.27; % 

i=i+1;
Rnames{i}='ATO2+MCO3=CH2O+MCO3+MO2'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='ATO2'; Gstr{i,2}='MCO3'; % 
fATO2(i)=fATO2(i)-1; fCH2O(i)=fCH2O(i)+1; fMO2(i)=fMO2(i)+1; % 

i=i+1;
Rnames{i}='KO2+MCO3=ALD2+MCO3+MO2';
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='KO2'; Gstr{i,2}='MCO3'; % 
fKO2(i)=fKO2(i)-1; fALD2(i)=fALD2(i)+1; fMO2(i)=fMO2(i)+1; % 

i=i+1;
Rnames{i}='B3O2+MCO3=ACET+MO2+HO2';
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='B3O2'; Gstr{i,2}='MCO3'; % 
fB3O2(i)=fB3O2(i)-1; fMCO3(i)=fMCO3(i)-1; fACET(i)=fACET(i)+1; fMO2(i)=fMO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+R4N1=0.75ALD2+0.39CH2O+MO2+0.3R4O2+0.57RCHO+NO2';
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='R4N1'; % 
fMCO3(i)=fMCO3(i)-1; fR4N1(i)=fR4N1(i)-1; fALD2(i)=fALD2(i)+0.75; fCH2O(i)=fCH2O(i)+0.39; fMO2(i)=fMO2(i)+1; fR4O2(i)=fR4O2(i)+0.3; fRCHO(i)=fRCHO(i)+0.57; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+PRN1=ALD2+CH2O+MO2+NO2';
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='PRN1'; % 
fMCO3(i)=fMCO3(i)-1; fPRN1(i)=fPRN1(i)-1; fALD2(i)=fALD2(i)+1; fCH2O(i)=fCH2O(i)+1; fMO2(i)=fMO2(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+R4O2=ACTA+MEK';
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='R4O2'; % 
fMCO3(i)=fMCO3(i)-1; fR4O2(i)=fR4O2(i)-1; fACTA(i)=fACTA(i)+1; fMEK(i)=fMEK(i)+1; % 

i=i+1;
Rnames{i}='ATO2+MCO3=ACTA+MGLY'; % 2017/07/27, Fix C creation, SAS,BHH,MJE
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='ATO2'; Gstr{i,2}='MCO3'; % 
fATO2(i)=fATO2(i)-1; fMCO3(i)=fMCO3(i)-1; fACTA(i)=fACTA(i)+1; fMGLY(i)=fMGLY(i)+1; % 

i=i+1;
Rnames{i}='KO2+MCO3=ACTA+MEK';
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='KO2'; Gstr{i,2}='MCO3'; % 
fKO2(i)=fKO2(i)-1; fMCO3(i)=fMCO3(i)-1; fACTA(i)=fACTA(i)+1; fMEK(i)=fMEK(i)+1; % 

i=i+1;
Rnames{i}='MCO3+R4N1=ACTA+RCHO+NO2';
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='R4N1'; % 
fMCO3(i)=fMCO3(i)-1; fR4N1(i)=fR4N1(i)-1; fACTA(i)=fACTA(i)+1; fRCHO(i)=fRCHO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+PRN1=ACTA+RCHO+NO2';
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='PRN1'; % 
fMCO3(i)=fMCO3(i)-1; fPRN1(i)=fPRN1(i)-1; fACTA(i)=fACTA(i)+1; fRCHO(i)=fRCHO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='B3O2+MCO3=ACET+ACTA';
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='B3O2'; Gstr{i,2}='MCO3'; % 
fB3O2(i)=fB3O2(i)-1; fMCO3(i)=fMCO3(i)-1; fACET(i)=fACET(i)+1; fACTA(i)=fACTA(i)+1; % 

i=i+1;
Rnames{i}='ETO2+MCO3=ALD2+MO2+HO2';
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='ETO2'; Gstr{i,2}='MCO3'; % 
fETO2(i)=fETO2(i)-1; fMCO3(i)=fMCO3(i)-1; fALD2(i)=fALD2(i)+1; fMO2(i)=fMO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+OTHRO2=ALD2+MO2+HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GCARR_ac(1.68e-12, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='OTHRO2'; % 
fMCO3(i)=fMCO3(i)-1; fOTHRO2(i)=fOTHRO2(i)-1; fALD2(i)=fALD2(i)+1; fMO2(i)=fMO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ETO2+MCO3=ACTA+ALD2';
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='ETO2'; Gstr{i,2}='MCO3'; % 
fETO2(i)=fETO2(i)-1; fMCO3(i)=fMCO3(i)-1; fACTA(i)=fACTA(i)+1; fALD2(i)=fALD2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+OTHRO2=ACTA+ALD2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GCARR_ac(1.87e-13, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='OTHRO2'; % 
fMCO3(i)=fMCO3(i)-1; fOTHRO2(i)=fOTHRO2(i)-1; fACTA(i)=fACTA(i)+1; fALD2(i)=fALD2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+RCO3=0.07A3O2+0.27B3O2+MO2+0.5OTHRO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = GCARR_ac(2.50e-12, 500.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='RCO3'; % 
fMCO3(i)=fMCO3(i)-1; fRCO3(i)=fRCO3(i)-1; fA3O2(i)=fA3O2(i)+0.07; fB3O2(i)=fB3O2(i)+0.27; fMO2(i)=fMO2(i)+1; fOTHRO2(i)=fOTHRO2(i)+0.5; % 

i=i+1;
Rnames{i}='NO3+NO3=2.0NO2+O2';
k(:,i) = GCARR_ac(8.50e-13, -2450.0);
Gstr{i,1}='NO3'; Gstr{i,2}='NO3'; % 
fNO3(i)=fNO3(i)-2; fNO2(i)=fNO2(i)+2.0; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+NO2=MPN'; % 2012/02/12, Browne2011, ECB
k(:,i) = GCJPLPR_abab(1.00e-30, 4.8, 7.2e-12, 2.1, 0.6);
Gstr{i,1}='MO2'; Gstr{i,2}='NO2'; % 
fMO2(i)=fMO2(i)-1; fNO2(i)=fNO2(i)-1; fMPN(i)=fMPN(i)+1; % 

i=i+1;
Rnames{i}='MPN=MO2+NO2'; % 2012/02/12, Browne2011, ECB
k(:,i) = GCJPLPR_abcabc(1.05e-02, 4.8, -11234.0, 7.58d16, 2.1, -11234.0, 0.6);
Gstr{i,1}='MPN'; % 
fMPN(i)=fMPN(i)-1; fMO2(i)=fMO2(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='DMS+OH=CH2O+MO2+SO2';
k(:,i) = GCARR_ac(1.20e-11, -280.0);
Gstr{i,1}='DMS'; Gstr{i,2}='OH'; % 
fDMS(i)=fDMS(i)-1; fOH(i)=fOH(i)-1; fCH2O(i)=fCH2O(i)+1; fMO2(i)=fMO2(i)+1; fSO2(i)=fSO2(i)+1; % 

i=i+1;
Rnames{i}='DMS+OH=MO2+0.25MSA+0.75SO2';
k(:,i) = GC_DMSOH_acac(8.20e-39, 5376.0, 1.05e-5, 3644.0);
Gstr{i,1}='DMS'; Gstr{i,2}='OH'; % 
fDMS(i)=fDMS(i)-1; fOH(i)=fOH(i)-1; fMO2(i)=fMO2(i)+1; fMSA(i)=fMSA(i)+0.25; fSO2(i)=fSO2(i)+0.75; % 

i=i+1;
Rnames{i}='DMS+NO3=CH2O+HNO3+MO2+SO2';
k(:,i) = GCARR_ac(1.90e-13, 530.0);
Gstr{i,1}='DMS'; Gstr{i,2}='NO3'; % 
fDMS(i)=fDMS(i)-1; fNO3(i)=fNO3(i)-1; fCH2O(i)=fCH2O(i)+1; fHNO3(i)=fHNO3(i)+1; fMO2(i)=fMO2(i)+1; fSO2(i)=fSO2(i)+1; % 

i=i+1;
Rnames{i}='SO2+OH=SO4+HO2';
k(:,i) = GCJPLPR_aba(3.30e-31, 4.3, 1.6e-12, 0.6);
Gstr{i,1}='SO2'; Gstr{i,2}='OH'; % 
fSO2(i)=fSO2(i)-1; fOH(i)=fOH(i)-1; fSO4(i)=fSO4(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='O3+Br=BrO+O2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(1.60e-11, -780.0);
Gstr{i,1}='O3'; Gstr{i,2}='Br'; % 
fO3(i)=fO3(i)-1; fBr(i)=fBr(i)-1; fBrO(i)=fBrO(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='BrO+HO2=HOBr+O2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(4.50e-12, 460.0);
Gstr{i,1}='BrO'; Gstr{i,2}='HO2'; % 
fBrO(i)=fBrO(i)-1; fHO2(i)=fHO2(i)-1; fHOBr(i)=fHOBr(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='Br+HO2=HBr+O2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(4.80e-12, -310.0);
Gstr{i,1}='Br'; Gstr{i,2}='HO2'; % 
fBr(i)=fBr(i)-1; fHO2(i)=fHO2(i)-1; fHBr(i)=fHBr(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='HBr+OH=H2O+Br'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(5.50e-12, 200.0);
Gstr{i,1}='HBr'; Gstr{i,2}='OH'; % 
fHBr(i)=fHBr(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='BrO+BrO=2.0Br+O2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(2.40e-12,  40.0);
Gstr{i,1}='BrO'; Gstr{i,2}='BrO'; % 
fBrO(i)=fBrO(i)-2; fBr(i)=fBr(i)+2.0; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='BrO+BrO=Br2+O2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(2.80e-14, 860.0);
Gstr{i,1}='BrO'; Gstr{i,2}='BrO'; % 
fBrO(i)=fBrO(i)-2; fBr2(i)=fBr2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='BrO+NO=NO2+Br'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(8.80e-12, 260.0);
Gstr{i,1}='BrO'; Gstr{i,2}='NO'; % 
fBrO(i)=fBrO(i)-1; fNO(i)=fNO(i)-1; fNO2(i)=fNO2(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='BrNO3+Br=Br2+NO3'; % 2012/06/07, Parrella2012, JPP
k(:,i) = 4.90e-11;
Gstr{i,1}='BrNO3'; Gstr{i,2}='Br'; % 
fBrNO3(i)=fBrNO3(i)-1; fBr(i)=fBr(i)-1; fBr2(i)=fBr2(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='Br2+OH=HOBr+Br'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(2.10e-11, 240.0);
Gstr{i,1}='Br2'; Gstr{i,2}='OH'; % 
fBr2(i)=fBr2(i)-1; fOH(i)=fOH(i)-1; fHOBr(i)=fHOBr(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='HOBr+O=BrO+OH'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.20e-10, -430.0);
Gstr{i,1}='HOBr'; Gstr{i,2}='O'; % 
fHOBr(i)=fHOBr(i)-1; fO(i)=fO(i)-1; fBrO(i)=fBrO(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='HBr+O=Br+OH'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(5.80e-12, -1500.0);
Gstr{i,1}='HBr'; Gstr{i,2}='O'; % 
fHBr(i)=fHBr(i)-1; fO(i)=fO(i)-1; fBr(i)=fBr(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='BrO+OH=Br+HO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(1.70e-11, 250.0);
Gstr{i,1}='BrO'; Gstr{i,2}='OH'; % 
fBrO(i)=fBrO(i)-1; fOH(i)=fOH(i)-1; fBr(i)=fBr(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='NO3+Br=BrO+NO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = 1.60e-11;
Gstr{i,1}='NO3'; Gstr{i,2}='Br'; % 
fNO3(i)=fNO3(i)-1; fBr(i)=fBr(i)-1; fBrO(i)=fBrO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='CH2O+Br=HBr+CO+HO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(1.70e-11, -800.0);
Gstr{i,1}='CH2O'; Gstr{i,2}='Br'; % 
fCH2O(i)=fCH2O(i)-1; fBr(i)=fBr(i)-1; fHBr(i)=fHBr(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ALD2+Br=HBr+MCO3'; % 2017/07/27, Parrella2012,Fix C creation, SAS,BHH,MJE
k(:,i) = GCARR_ac(1.80e-11, -460.0);
Gstr{i,1}='ALD2'; Gstr{i,2}='Br'; % 
fALD2(i)=fALD2(i)-1; fBr(i)=fBr(i)-1; fHBr(i)=fHBr(i)+1; fMCO3(i)=fMCO3(i)+1; % 

i=i+1;
Rnames{i}='ACET+Br=ATO2+HBr'; % 2017/07/27, Parrella2012,Fix C creation, SAS,BHH,MJE
k(:,i) = GCARR_ac(1.66e-10, -7000.0);
Gstr{i,1}='ACET'; Gstr{i,2}='Br'; % 
fACET(i)=fACET(i)-1; fBr(i)=fBr(i)-1; fATO2(i)=fATO2(i)+1; fHBr(i)=fHBr(i)+1; % 

i=i+1;
Rnames{i}='C2H6+Br=ETO2+HBr'; % 2017/07/27, Parrella2012,Fix C creation, SAS,BHH,MJE
k(:,i) = GCARR_ac(2.36e-10, -6411.0);
Gstr{i,1}='C2H6'; Gstr{i,2}='Br'; % 
fC2H6(i)=fC2H6(i)-1; fBr(i)=fBr(i)-1; fETO2(i)=fETO2(i)+1; fHBr(i)=fHBr(i)+1; % 

i=i+1;
Rnames{i}='C3H8+Br=A3O2+HBr'; % 2017/07/27, Parrella2012,Fix C creation, SAS,BHH,MJE
k(:,i) = GCARR_ac(8.77e-11, -4330.0);
Gstr{i,1}='C3H8'; Gstr{i,2}='Br'; % 
fC3H8(i)=fC3H8(i)-1; fBr(i)=fBr(i)-1; fA3O2(i)=fA3O2(i)+1; fHBr(i)=fHBr(i)+1; % 

i=i+1;
Rnames{i}='NO2+Br=BrNO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCJPLPR_aba(4.20e-31, 2.4, 2.7e-11, 0.6);
Gstr{i,1}='NO2'; Gstr{i,2}='Br'; % 
fNO2(i)=fNO2(i)-1; fBr(i)=fBr(i)-1; fBrNO2(i)=fBrNO2(i)+1; % 

i=i+1;
Rnames{i}='BrO+NO2=BrNO3'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCJPLPR_abab(5.40e-31, 3.1, 6.5e-12, 2.9, 0.6);
Gstr{i,1}='BrO'; Gstr{i,2}='NO2'; % 
fBrO(i)=fBrO(i)-1; fNO2(i)=fNO2(i)-1; fBrNO3(i)=fBrNO3(i)+1; % 

i=i+1;
Rnames{i}='CHBr3+OH=3.0Br'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCARR_ac(9.00e-13, -360.0);
Gstr{i,1}='CHBr3'; Gstr{i,2}='OH'; % 
fCHBr3(i)=fCHBr3(i)-1; fOH(i)=fOH(i)-1; fBr(i)=fBr(i)+3.0; % 

i=i+1;
Rnames{i}='CH2Br2+OH=2.0Br'; % 2012/06/07, Parrella2012, JPP
k(:,i) = GCARR_ac(2.00e-12, -840.0);
Gstr{i,1}='CH2Br2'; Gstr{i,2}='OH'; % 
fCH2Br2(i)=fCH2Br2(i)-1; fOH(i)=fOH(i)-1; fBr(i)=fBr(i)+2.0; % 

i=i+1;
Rnames{i}='CH3Br+OH=H2O+Br+HO2'; % 2017/03/08, JPL 15-10, TS,BHH,MJE
k(:,i) = GCARR_ac(1.42e-12, -1150.0);
Gstr{i,1}='CH3Br'; Gstr{i,2}='OH'; % 
fCH3Br(i)=fCH3Br(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fBr(i)=fBr(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='H2O+O1D=2.0OH'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.63e-10, 60.0);
Gstr{i,1}='H2O'; Gstr{i,2}='O1D'; % 
fH2O(i)=fH2O(i)-1; fO1D(i)=fO1D(i)-1; fOH(i)=fOH(i)+2.0; % 

i=i+1;
Rnames{i}='N2+O1D=N2+O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.15e-11, 110.0);
Gstr{i,1}='N2'; Gstr{i,2}='O1D'; % 
fO1D(i)=fO1D(i)-1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='O1D+O2=O+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(3.30e-11, 55.0);
Gstr{i,1}='O1D'; Gstr{i,2}='O2'; % 
fO1D(i)=fO1D(i)-1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='O1D+H2=H+OH'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.20e-10;
Gstr{i,1}='O1D'; Gstr{i,2}='H2'; % 
fO1D(i)=fO1D(i)-1; fH2(i)=fH2(i)-1; fH(i)=fH(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='N2O+O1D=N2+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(4.63e-11, 20.0);
Gstr{i,1}='N2O'; Gstr{i,2}='O1D'; % 
fN2O(i)=fN2O(i)-1; fO1D(i)=fO1D(i)-1; fN2(i)=fN2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='N2O+O1D=2.0NO'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(7.25e-11, 20.0);
Gstr{i,1}='N2O'; Gstr{i,2}='O1D'; % 
fN2O(i)=fN2O(i)-1; fO1D(i)=fO1D(i)-1; fNO(i)=fNO(i)+2.0; % 

i=i+1;
Rnames{i}='CH4+O1D=MO2+OH'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.31e-10;
Gstr{i,1}='CH4'; Gstr{i,2}='O1D'; % 
fCH4(i)=fCH4(i)-1; fO1D(i)=fO1D(i)-1; fMO2(i)=fMO2(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='CH4+O1D=CH2O+H2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 0.09e-10;
Gstr{i,1}='CH4'; Gstr{i,2}='O1D'; % 
fCH4(i)=fCH4(i)-1; fO1D(i)=fO1D(i)-1; fCH2O(i)=fCH2O(i)+1; fH2(i)=fH2(i)+1; % 

i=i+1;
Rnames{i}='CH4+O1D=CH2O+H+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 0.35e-10;
Gstr{i,1}='CH4'; Gstr{i,2}='O1D'; % 
fCH4(i)=fCH4(i)-1; fO1D(i)=fO1D(i)-1; fCH2O(i)=fCH2O(i)+1; fH(i)=fH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='O+O2=O3'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ab(6.00e-34, 2.4).*NUMDEN;
Gstr{i,1}='O'; Gstr{i,2}='O2'; % 
fO(i)=fO(i)-1; fO2(i)=fO2(i)-1; fO3(i)=fO3(i)+1; % 

i=i+1;
Rnames{i}='O3+O=2.0O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(8.00e-12, -2060.0);
Gstr{i,1}='O3'; Gstr{i,2}='O'; % 
fO3(i)=fO3(i)-1; fO(i)=fO(i)-1; fO2(i)=fO2(i)+2.0; % 

i=i+1;
Rnames{i}='OH+H2=H+H2O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.80e-12, -1800.0);
Gstr{i,1}='OH'; Gstr{i,2}='H2'; % 
fOH(i)=fOH(i)-1; fH2(i)=fH2(i)-1; fH(i)=fH(i)+1; fH2O(i)=fH2O(i)+1; % 

i=i+1;
Rnames{i}='OH+O=H+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.80e-11, 180.0);
Gstr{i,1}='OH'; Gstr{i,2}='O'; % 
fOH(i)=fOH(i)-1; fO(i)=fO(i)-1; fH(i)=fH(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='HO2+O=OH+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(3.00e-11, 200.0);
Gstr{i,1}='HO2'; Gstr{i,2}='O'; % 
fHO2(i)=fHO2(i)-1; fO(i)=fO(i)-1; fOH(i)=fOH(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='O1D+O3=2.0O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.20e-10;
Gstr{i,1}='O1D'; Gstr{i,2}='O3'; % 
fO1D(i)=fO1D(i)-1; fO3(i)=fO3(i)-1; fO2(i)=fO2(i)+2.0; % 

i=i+1;
Rnames{i}='O1D+O3=2.0O+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.20e-10;
Gstr{i,1}='O1D'; Gstr{i,2}='O3'; % 
fO1D(i)=fO1D(i)-1; fO3(i)=fO3(i)-1; fO(i)=fO(i)+2.0; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='OCS+O=SO2+CO'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.10e-11, -2200.0);
Gstr{i,1}='OCS'; Gstr{i,2}='O'; % 
fOCS(i)=fOCS(i)-1; fO(i)=fO(i)-1; fSO2(i)=fSO2(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='OCS+OH=SO2+CO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.10e-13, -1200.0);
Gstr{i,1}='OCS'; Gstr{i,2}='OH'; % 
fOCS(i)=fOCS(i)-1; fOH(i)=fOH(i)-1; fSO2(i)=fSO2(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='NO2+O=NO+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(5.10e-12, 210.0);
Gstr{i,1}='NO2'; Gstr{i,2}='O'; % 
fNO2(i)=fNO2(i)-1; fO(i)=fO(i)-1; fNO(i)=fNO(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='NO3+O=NO2+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.00e-11;
Gstr{i,1}='NO3'; Gstr{i,2}='O'; % 
fNO3(i)=fNO3(i)-1; fO(i)=fO(i)-1; fNO2(i)=fNO2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='NO+O=NO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCJPLPR_aba(9.00e-32, 1.5, 3.0e-11, 0.6);
Gstr{i,1}='NO'; Gstr{i,2}='O'; % 
fNO(i)=fNO(i)-1; fO(i)=fO(i)-1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='NO2+O=NO3'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCJPLPR_abab(2.50e-31, 1.8, 2.2e-11, 0.7, 0.6);
Gstr{i,1}='NO2'; Gstr{i,2}='O'; % 
fNO2(i)=fNO2(i)-1; fO(i)=fO(i)-1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='H2O2+O=OH+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.40e-12, -2000.0);
Gstr{i,1}='H2O2'; Gstr{i,2}='O'; % 
fH2O2(i)=fH2O2(i)-1; fO(i)=fO(i)-1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='H+O2=HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCJPLPR_abab(4.40e-32, 1.3, 7.5e-11, -0.2, 0.6);
Gstr{i,1}='H'; Gstr{i,2}='O2'; % 
fH(i)=fH(i)-1; fO2(i)=fO2(i)-1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='H+O3=OH+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.40e-10, -470.0);
Gstr{i,1}='H'; Gstr{i,2}='O3'; % 
fH(i)=fH(i)-1; fO3(i)=fO3(i)-1; fOH(i)=fOH(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='H+HO2=2.0OH'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 7.20e-11;
Gstr{i,1}='H'; Gstr{i,2}='HO2'; % 
fH(i)=fH(i)-1; fHO2(i)=fHO2(i)-1; fOH(i)=fOH(i)+2.0; % 

i=i+1;
Rnames{i}='H+HO2=H2O+O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.60e-12;
Gstr{i,1}='H'; Gstr{i,2}='HO2'; % 
fH(i)=fH(i)-1; fHO2(i)=fHO2(i)-1; fH2O(i)=fH2O(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='H+HO2=H2+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 6.90e-12;
Gstr{i,1}='H'; Gstr{i,2}='HO2'; % 
fH(i)=fH(i)-1; fHO2(i)=fHO2(i)-1; fH2(i)=fH2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='N+O2=NO+O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.50e-11, -3600.0);
Gstr{i,1}='N'; Gstr{i,2}='O2'; % 
fN(i)=fN(i)-1; fO2(i)=fO2(i)-1; fNO(i)=fNO(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='N+NO=N2+O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.10e-11, 100.0);
Gstr{i,1}='N'; Gstr{i,2}='NO'; % 
fN(i)=fN(i)-1; fNO(i)=fNO(i)-1; fN2(i)=fN2(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='N+NO2=N2O+O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(5.80e-12, 220.0);
Gstr{i,1}='N'; Gstr{i,2}='NO2'; % 
fN(i)=fN(i)-1; fNO2(i)=fNO2(i)-1; fN2O(i)=fN2O(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='BrO+O=Br+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.90e-11, 230.0);
Gstr{i,1}='BrO'; Gstr{i,2}='O'; % 
fBrO(i)=fBrO(i)-1; fO(i)=fO(i)-1; fBr(i)=fBr(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='CH2O+O=CO+OH+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(3.40e-11, -1600.0);
Gstr{i,1}='CH2O'; Gstr{i,2}='O'; % 
fCH2O(i)=fCH2O(i)-1; fO(i)=fO(i)-1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='HCl+O1D=0.24ClO+0.24H+0.09HCl+0.67Cl+0.67OH+0.09O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.50e-10;
Gstr{i,1}='HCl'; Gstr{i,2}='O1D'; % 
fHCl(i)=fHCl(i)-0.910; fO1D(i)=fO1D(i)-1; fHCl(i)=fHCl(i)-0.910; fClO(i)=fClO(i)+0.24; fH(i)=fH(i)+0.24; fCl(i)=fCl(i)+0.67; fOH(i)=fOH(i)+0.67; fO(i)=fO(i)+0.09; % 

i=i+1;
Rnames{i}='HBr+O1D=0.15BrO+0.15H+0.2HBr+0.65Br+0.65OH+0.2O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.50e-10;
Gstr{i,1}='HBr'; Gstr{i,2}='O1D'; % 
fHBr(i)=fHBr(i)-0.800; fO1D(i)=fO1D(i)-1; fHBr(i)=fHBr(i)-0.800; fBrO(i)=fBrO(i)+0.15; fH(i)=fH(i)+0.15; fBr(i)=fBr(i)+0.65; fOH(i)=fOH(i)+0.65; fO(i)=fO(i)+0.2; % 

i=i+1;
Rnames{i}='Cl2+O1D=0.25Cl2+0.75ClO+0.75Cl+0.25O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 2.70e-10;
Gstr{i,1}='Cl2'; Gstr{i,2}='O1D'; % 
fCl2(i)=fCl2(i)-0.750; fO1D(i)=fO1D(i)-1; fCl2(i)=fCl2(i)-0.750; fClO(i)=fClO(i)+0.75; fCl(i)=fCl(i)+0.75; fO(i)=fO(i)+0.25; % 

i=i+1;
Rnames{i}='CCl4+O1D=0.14CCl4+0.86ClO+2.58Cl+0.14O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 3.30e-10;
Gstr{i,1}='CCl4'; Gstr{i,2}='O1D'; % 
fCCl4(i)=fCCl4(i)-0.860; fO1D(i)=fO1D(i)-1; fCCl4(i)=fCCl4(i)-0.860; fClO(i)=fClO(i)+0.86; fCl(i)=fCl(i)+2.58; fO(i)=fO(i)+0.14; % 

i=i+1;
Rnames{i}='CH3Br+O1D=0.44BrO+MO2+0.56Br'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.80e-10;
Gstr{i,1}='CH3Br'; Gstr{i,2}='O1D'; % 
fCH3Br(i)=fCH3Br(i)-1; fO1D(i)=fO1D(i)-1; fBrO(i)=fBrO(i)+0.44; fMO2(i)=fMO2(i)+1; fBr(i)=fBr(i)+0.56; % 

i=i+1;
Rnames{i}='CH2Br2+O1D=0.95BrO+0.05CH2Br2+0.95Br+0.05O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 2.70e-10;
Gstr{i,1}='CH2Br2'; Gstr{i,2}='O1D'; % 
fCH2Br2(i)=fCH2Br2(i)-0.950; fO1D(i)=fO1D(i)-1; fCH2Br2(i)=fCH2Br2(i)-0.950; fBrO(i)=fBrO(i)+0.95; fBr(i)=fBr(i)+0.95; fO(i)=fO(i)+0.05; % 

i=i+1;
Rnames{i}='CHBr3+O1D=0.68BrO+0.32CHBr3+1.36Br+0.32O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 6.60e-10;
Gstr{i,1}='CHBr3'; Gstr{i,2}='O1D'; % 
fCHBr3(i)=fCHBr3(i)-0.680; fO1D(i)=fO1D(i)-1; fCHBr3(i)=fCHBr3(i)-0.680; fBrO(i)=fBrO(i)+0.68; fBr(i)=fBr(i)+1.36; fO(i)=fO(i)+0.32; % 

i=i+1;
Rnames{i}='HCFC22+O1D=0.55ClO+0.28HCFC22+0.17Cl+0.28O'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = 1.02e-10;
Gstr{i,1}='HCFC22'; Gstr{i,2}='O1D'; % 
fHCFC22(i)=fHCFC22(i)-0.720; fO1D(i)=fO1D(i)-1; fHCFC22(i)=fHCFC22(i)-0.720; fClO(i)=fClO(i)+0.55; fCl(i)=fCl(i)+0.17; fO(i)=fO(i)+0.28; % 

i=i+1;
Rnames{i}='CFC11+O1D=0.12CFC11+0.88ClO+1.76Cl+0.12O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 2.30e-10;
Gstr{i,1}='CFC11'; Gstr{i,2}='O1D'; % 
fCFC11(i)=fCFC11(i)-0.880; fO1D(i)=fO1D(i)-1; fCFC11(i)=fCFC11(i)-0.880; fClO(i)=fClO(i)+0.88; fCl(i)=fCl(i)+1.76; fO(i)=fO(i)+0.12; % 

i=i+1;
Rnames{i}='CFC12+O1D=0.14CFC12+0.86ClO+0.86Cl+0.14O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.40e-10;
Gstr{i,1}='CFC12'; Gstr{i,2}='O1D'; % 
fCFC12(i)=fCFC12(i)-0.860; fO1D(i)=fO1D(i)-1; fCFC12(i)=fCFC12(i)-0.860; fClO(i)=fClO(i)+0.86; fCl(i)=fCl(i)+0.86; fO(i)=fO(i)+0.14; % 

i=i+1;
Rnames{i}='H1211+O1D=0.31BrO+0.33ClO+0.36H1211+0.31Cl+0.33Br+0.36O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.50e-10;
Gstr{i,1}='H1211'; Gstr{i,2}='O1D'; % 
fH1211(i)=fH1211(i)-0.640; fO1D(i)=fO1D(i)-1; fH1211(i)=fH1211(i)-0.640; fBrO(i)=fBrO(i)+0.31; fClO(i)=fClO(i)+0.33; fCl(i)=fCl(i)+0.31; fBr(i)=fBr(i)+0.33; fO(i)=fO(i)+0.36; % 

i=i+1;
Rnames{i}='H1301+O1D=0.41BrO+0.59H1301+0.59O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.00e-10;
Gstr{i,1}='H1301'; Gstr{i,2}='O1D'; % 
fH1301(i)=fH1301(i)-0.410; fO1D(i)=fO1D(i)-1; fH1301(i)=fH1301(i)-0.410; fBrO(i)=fBrO(i)+0.41; fO(i)=fO(i)+0.59; % 

i=i+1;
Rnames{i}='HCFC141b+O1D=0.69ClO+0.31HCFC141b+0.69Cl+0.31O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 2.60e-10;
Gstr{i,1}='HCFC141b'; Gstr{i,2}='O1D'; % 
fHCFC141b(i)=fHCFC141b(i)-0.690; fO1D(i)=fO1D(i)-1; fHCFC141b(i)=fHCFC141b(i)-0.690; fClO(i)=fClO(i)+0.69; fCl(i)=fCl(i)+0.69; fO(i)=fO(i)+0.31; % 

i=i+1;
Rnames{i}='HCFC142b+O1D=0.74ClO+0.26HCFC142b+0.26O'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = 2.00e-10;
Gstr{i,1}='HCFC142b'; Gstr{i,2}='O1D'; % 
fHCFC142b(i)=fHCFC142b(i)-0.740; fO1D(i)=fO1D(i)-1; fHCFC142b(i)=fHCFC142b(i)-0.740; fClO(i)=fClO(i)+0.74; fO(i)=fO(i)+0.26; % 

i=i+1;
Rnames{i}='HCFC123+O1D=0.79ClO+0.21HCFC123+0.79Cl+0.21O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 2.00e-10;
Gstr{i,1}='HCFC123'; Gstr{i,2}='O1D'; % 
fHCFC123(i)=fHCFC123(i)-0.790; fO1D(i)=fO1D(i)-1; fHCFC123(i)=fHCFC123(i)-0.790; fClO(i)=fClO(i)+0.79; fCl(i)=fCl(i)+0.79; fO(i)=fO(i)+0.21; % 

i=i+1;
Rnames{i}='CFC113+O1D=0.25CFC113+0.75ClO+1.5Cl+0.25O'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = 2.32e-10;
Gstr{i,1}='CFC113'; Gstr{i,2}='O1D'; % 
fCFC113(i)=fCFC113(i)-0.750; fO1D(i)=fO1D(i)-1; fCFC113(i)=fCFC113(i)-0.750; fClO(i)=fClO(i)+0.75; fCl(i)=fCl(i)+1.5; fO(i)=fO(i)+0.25; % 

i=i+1;
Rnames{i}='CFC114+O1D=0.25CFC114+0.75ClO+0.75Cl+0.25O'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCARR_ac(1.30e-10, -25.0);
Gstr{i,1}='CFC114'; Gstr{i,2}='O1D'; % 
fCFC114(i)=fCFC114(i)-0.750; fO1D(i)=fO1D(i)-1; fCFC114(i)=fCFC114(i)-0.750; fClO(i)=fClO(i)+0.75; fCl(i)=fCl(i)+0.75; fO(i)=fO(i)+0.25; % 

i=i+1;
Rnames{i}='CFC115+O1D=0.7CFC115+0.3ClO+0.7O'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCARR_ac(5.40e-11, -30.0);
Gstr{i,1}='CFC115'; Gstr{i,2}='O1D'; % 
fCFC115(i)=fCFC115(i)-0.300; fO1D(i)=fO1D(i)-1; fCFC115(i)=fCFC115(i)-0.300; fClO(i)=fClO(i)+0.3; fO(i)=fO(i)+0.7; % 

i=i+1;
Rnames{i}='H2402+O1D=0.75BrO+0.25H2402+0.75Br+0.25O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.60e-10, 0.0);
Gstr{i,1}='H2402'; Gstr{i,2}='O1D'; % 
fH2402(i)=fH2402(i)-0.750; fO1D(i)=fO1D(i)-1; fH2402(i)=fH2402(i)-0.750; fBrO(i)=fBrO(i)+0.75; fBr(i)=fBr(i)+0.75; fO(i)=fO(i)+0.25; % 

i=i+1;
Rnames{i}='Cl2+OH=HOCl+Cl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.60e-12, -1100.0);
Gstr{i,1}='Cl2'; Gstr{i,2}='OH'; % 
fCl2(i)=fCl2(i)-1; fOH(i)=fOH(i)-1; fHOCl(i)=fHOCl(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='ClO+MO2=CH2O+ClOO+HO2'; % 2017/03/20, JPL 15-10, TS,BHH,MJE
k(:,i) = GCARR_ac(1.80e-11, -600.0);
Gstr{i,1}='ClO'; Gstr{i,2}='MO2'; % 
fClO(i)=fClO(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+1; fClOO(i)=fClOO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ClO+OH=Cl+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(7.40e-12, 270.0);
Gstr{i,1}='ClO'; Gstr{i,2}='OH'; % 
fClO(i)=fClO(i)-1; fOH(i)=fOH(i)-1; fCl(i)=fCl(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ClO+OH=HCl+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(6.00e-13, 230.0);
Gstr{i,1}='ClO'; Gstr{i,2}='OH'; % 
fClO(i)=fClO(i)-1; fOH(i)=fOH(i)-1; fHCl(i)=fHCl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='OClO+OH=HOCl+O2'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCARR_ac(1.40e-12, 600.0);
Gstr{i,1}='OClO'; Gstr{i,2}='OH'; % 
fOClO(i)=fOClO(i)-1; fOH(i)=fOH(i)-1; fHOCl(i)=fHOCl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='Cl2O2+OH=ClOO+HOCl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(6.00e-13, 670.0);
Gstr{i,1}='Cl2O2'; Gstr{i,2}='OH'; % 
fCl2O2(i)=fCl2O2(i)-1; fOH(i)=fOH(i)-1; fClOO(i)=fClOO(i)+1; fHOCl(i)=fHOCl(i)+1; % 

i=i+1;
Rnames{i}='HCl+OH=H2O+Cl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.80e-12, -250.0);
Gstr{i,1}='HCl'; Gstr{i,2}='OH'; % 
fHCl(i)=fHCl(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='HOCl+OH=ClO+H2O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(3.00e-12, -500.0);
Gstr{i,1}='HOCl'; Gstr{i,2}='OH'; % 
fHOCl(i)=fHOCl(i)-1; fOH(i)=fOH(i)-1; fClO(i)=fClO(i)+1; fH2O(i)=fH2O(i)+1; % 

i=i+1;
Rnames{i}='ClNO2+OH=HOCl+NO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.40e-12, -1250.0);
Gstr{i,1}='ClNO2'; Gstr{i,2}='OH'; % 
fClNO2(i)=fClNO2(i)-1; fOH(i)=fOH(i)-1; fHOCl(i)=fHOCl(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='ClNO3+OH=HOCl+NO3'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.20e-12, -330.0);
Gstr{i,1}='ClNO3'; Gstr{i,2}='OH'; % 
fClNO3(i)=fClNO3(i)-1; fOH(i)=fOH(i)-1; fHOCl(i)=fHOCl(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='CH3Cl+OH=H2O+Cl+HO2'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCARR_ac(1.96e-12, -1200.0);
Gstr{i,1}='CH3Cl'; Gstr{i,2}='OH'; % 
fCH3Cl(i)=fCH3Cl(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fCl(i)=fCl(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='CH2Cl2+OH=2.0Cl+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(2.61e-12, -944.0);
Gstr{i,1}='CH2Cl2'; Gstr{i,2}='OH'; % 
fCH2Cl2(i)=fCH2Cl2(i)-1; fOH(i)=fOH(i)-1; fCl(i)=fCl(i)+2.0; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='CHCl3+OH=3.0Cl+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(4.69e-12, -1134.0);
Gstr{i,1}='CHCl3'; Gstr{i,2}='OH'; % 
fCHCl3(i)=fCHCl3(i)-1; fOH(i)=fOH(i)-1; fCl(i)=fCl(i)+3.0; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='CH3CCl3+OH=H2O+3.0Cl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.64e-12, -1520.0);
Gstr{i,1}='CH3CCl3'; Gstr{i,2}='OH'; % 
fCH3CCl3(i)=fCH3CCl3(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fCl(i)=fCl(i)+3.0; % 

i=i+1;
Rnames{i}='HCFC22+OH=H2O+Cl'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCARR_ac(9.20e-13, -1560.0);
Gstr{i,1}='HCFC22'; Gstr{i,2}='OH'; % 
fHCFC22(i)=fHCFC22(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='HCFC141b+OH=H2O+2.0Cl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.25e-12, -1600.0);
Gstr{i,1}='HCFC141b'; Gstr{i,2}='OH'; % 
fHCFC141b(i)=fHCFC141b(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fCl(i)=fCl(i)+2.0; % 

i=i+1;
Rnames{i}='HCFC142b+OH=H2O+Cl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.30e-12, -1770.0);
Gstr{i,1}='HCFC142b'; Gstr{i,2}='OH'; % 
fHCFC142b(i)=fHCFC142b(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='HCFC123+OH=H2O+2.0Cl'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCARR_ac(7.40e-13, -900.0);
Gstr{i,1}='HCFC123'; Gstr{i,2}='OH'; % 
fHCFC123(i)=fHCFC123(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fCl(i)=fCl(i)+2.0; % 

i=i+1;
Rnames{i}='CH4+Cl=HCl+MO2'; % 2017/03/08, JPL 15-10, TS,BHH,MJE
k(:,i) = GCARR_ac(7.10e-12, -1270.0);
Gstr{i,1}='CH4'; Gstr{i,2}='Cl'; % 
fCH4(i)=fCH4(i)-1; fCl(i)=fCl(i)-1; fHCl(i)=fHCl(i)+1; fMO2(i)=fMO2(i)+1; % 

i=i+1;
Rnames{i}='CH2O+Cl=HCl+CO+HO2'; % 2017/09/22, Sherwen2016b, TS,JAS,SDE
k(:,i) = GCARR_ac(7.32e-11, -30.0);
Gstr{i,1}='CH2O'; Gstr{i,2}='Cl'; % 
fCH2O(i)=fCH2O(i)-1; fCl(i)=fCl(i)-1; fHCl(i)=fHCl(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='O3+Cl=ClO+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.30e-11, -200.0);
Gstr{i,1}='O3'; Gstr{i,2}='Cl'; % 
fO3(i)=fO3(i)-1; fCl(i)=fCl(i)-1; fClO(i)=fClO(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='Cl+H2=H+HCl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(3.05e-11, -2270.0);
Gstr{i,1}='Cl'; Gstr{i,2}='H2'; % 
fCl(i)=fCl(i)-1; fH2(i)=fH2(i)-1; fH(i)=fH(i)+1; fHCl(i)=fHCl(i)+1; % 

i=i+1;
Rnames{i}='H2O2+Cl=HCl+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.10e-11, -980.0);
Gstr{i,1}='H2O2'; Gstr{i,2}='Cl'; % 
fH2O2(i)=fH2O2(i)-1; fCl(i)=fCl(i)-1; fHCl(i)=fHCl(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='Cl+HO2=HCl+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.40e-11, 270.0);
Gstr{i,1}='Cl'; Gstr{i,2}='HO2'; % 
fCl(i)=fCl(i)-1; fHO2(i)=fHO2(i)-1; fHCl(i)=fHCl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='Cl+HO2=ClO+OH'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(3.60e-11, -375.0);
Gstr{i,1}='Cl'; Gstr{i,2}='HO2'; % 
fCl(i)=fCl(i)-1; fHO2(i)=fHO2(i)-1; fClO(i)=fClO(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='ClO+O=Cl+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.80e-11, 85.0);
Gstr{i,1}='ClO'; Gstr{i,2}='O'; % 
fClO(i)=fClO(i)-1; fO(i)=fO(i)-1; fCl(i)=fCl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='ClO+HO2=HOCl+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.60e-12, 290.0);
Gstr{i,1}='ClO'; Gstr{i,2}='HO2'; % 
fClO(i)=fClO(i)-1; fHO2(i)=fHO2(i)-1; fHOCl(i)=fHOCl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='ClO+NO=NO2+Cl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(6.40e-12, 290.0);
Gstr{i,1}='ClO'; Gstr{i,2}='NO'; % 
fClO(i)=fClO(i)-1; fNO(i)=fNO(i)-1; fNO2(i)=fNO2(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='ClO+NO2=ClNO3'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCJPLPR_abab(1.80e-31, 3.4, 1.50e-11, 1.9, 0.6);
Gstr{i,1}='ClO'; Gstr{i,2}='NO2'; % 
fClO(i)=fClO(i)-1; fNO2(i)=fNO2(i)-1; fClNO3(i)=fClNO3(i)+1; % 

i=i+1;
Rnames{i}='ClO+ClO=Cl2+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(1.00e-12, -1590.0);
Gstr{i,1}='ClO'; Gstr{i,2}='ClO'; % 
fClO(i)=fClO(i)-2; fCl2(i)=fCl2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='ClO+ClO=ClOO+Cl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(3.00e-11, -2450.0);
Gstr{i,1}='ClO'; Gstr{i,2}='ClO'; % 
fClO(i)=fClO(i)-2; fClOO(i)=fClOO(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='ClO+ClO=OClO+Cl'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(3.50e-13, -1370.0);
Gstr{i,1}='ClO'; Gstr{i,2}='ClO'; % 
fClO(i)=fClO(i)-2; fOClO(i)=fOClO(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='Cl+O2=ClOO'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCJPLPR_aba(2.20e-33, 3.1, 1.8e-10, 0.6);
Gstr{i,1}='Cl'; Gstr{i,2}='O2'; % 
fCl(i)=fCl(i)-1; fO2(i)=fO2(i)-1; fClOO(i)=fClOO(i)+1; % 

i=i+1;
Rnames{i}='ClOO=Cl+O2'; % JPL 15-10, XW
k(:,i) = GCJPLEQ_acabab(6.60e-25, 2502.0, 2.20e-33, 3.1, 1.8e-10, 0.0, 0.6);
Gstr{i,1}='ClOO'; % 
fClOO(i)=fClOO(i)-1; fCl(i)=fCl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='ClO+ClO=Cl2O2'; % 2017/02/22, JPL 15-10, BHH,MJE
k(:,i) = GCJPLPR_abab(1.90e-32, 3.6, 3.7e-12, 1.6, 0.6);
Gstr{i,1}='ClO'; Gstr{i,2}='ClO'; % 
fClO(i)=fClO(i)-2; fCl2O2(i)=fCl2O2(i)+1; % 

i=i+1;
Rnames{i}='Cl2O2=2.0ClO'; % JPL 15-10, XW
k(:,i) = GCJPLEQ_acabab(2.16e-27, 8537.0, 1.90e-32, 3.6, 3.7e-12, 1.6, 0.6);
Gstr{i,1}='Cl2O2'; % 
fCl2O2(i)=fCl2O2(i)-1; fClO(i)=fClO(i)+2.0; % 

i=i+1;
Rnames{i}='ClOO+Cl=Cl2+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 2.30e-10;
Gstr{i,1}='ClOO'; Gstr{i,2}='Cl'; % 
fClOO(i)=fClOO(i)-1; fCl(i)=fCl(i)-1; fCl2(i)=fCl2(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='ClOO+Cl=2.0ClO'; % 2014/02/03, Eastham2014, SDE
k(:,i) = 1.20e-11;
Gstr{i,1}='ClOO'; Gstr{i,2}='Cl'; % 
fClOO(i)=fClOO(i)-1; fCl(i)=fCl(i)-1; fClO(i)=fClO(i)+2.0; % 

i=i+1;
Rnames{i}='BrO+ClO=OClO+Br'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(9.50e-13, 550.0);
Gstr{i,1}='BrO'; Gstr{i,2}='ClO'; % 
fBrO(i)=fBrO(i)-1; fClO(i)=fClO(i)-1; fOClO(i)=fOClO(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='BrO+ClO=ClOO+Br'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.30e-12, 260.0);
Gstr{i,1}='BrO'; Gstr{i,2}='ClO'; % 
fBrO(i)=fBrO(i)-1; fClO(i)=fClO(i)-1; fClOO(i)=fClOO(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='BrO+ClO=BrCl+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(4.10e-13, 290.0);
Gstr{i,1}='BrO'; Gstr{i,2}='ClO'; % 
fBrO(i)=fBrO(i)-1; fClO(i)=fClO(i)-1; fBrCl(i)=fBrCl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='ClNO3+O=ClO+NO3'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(3.60e-12, -840.0);
Gstr{i,1}='ClNO3'; Gstr{i,2}='O'; % 
fClNO3(i)=fClNO3(i)-1; fO(i)=fO(i)-1; fClO(i)=fClO(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='ClNO3+Cl=Cl2+NO3'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(6.50e-12, 135.0);
Gstr{i,1}='ClNO3'; Gstr{i,2}='Cl'; % 
fClNO3(i)=fClNO3(i)-1; fCl(i)=fCl(i)-1; fCl2(i)=fCl2(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='CH3Cl+Cl=2.0HCl+CO+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = GCARR_ac(2.17e-11, -1130.0);
Gstr{i,1}='CH3Cl'; Gstr{i,2}='Cl'; % 
fCH3Cl(i)=fCH3Cl(i)-1; fCl(i)=fCl(i)-1; fHCl(i)=fHCl(i)+2.0; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='CH2Cl2+Cl=HCl+2.0Cl+CO+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(1.24e-12, -1070.0);
Gstr{i,1}='CH2Cl2'; Gstr{i,2}='Cl'; % 
fCH2Cl2(i)=fCH2Cl2(i)-1; fCl(i)=fCl(i)+1; fHCl(i)=fHCl(i)+1; fCl(i)=fCl(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='CHCl3+Cl=HCl+3.0Cl+CO+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(3.77e-12, -1011.0);
Gstr{i,1}='CHCl3'; Gstr{i,2}='Cl'; % 
fCHCl3(i)=fCHCl3(i)-1; fCl(i)=fCl(i)+2; fHCl(i)=fHCl(i)+1; fCl(i)=fCl(i)+2; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='HCOOH+Cl=H2O+HCl+CO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 2.00e-13;
Gstr{i,1}='HCOOH'; Gstr{i,2}='Cl'; % 
fHCOOH(i)=fHCOOH(i)-1; fCl(i)=fCl(i)-1; fH2O(i)=fH2O(i)+1; fHCl(i)=fHCl(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='MO2+Cl=CH2O+ClO+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 1.60e-10;
Gstr{i,1}='MO2'; Gstr{i,2}='Cl'; % 
fMO2(i)=fMO2(i)-1; fCl(i)=fCl(i)-1; fCH2O(i)=fCH2O(i)+1; fClO(i)=fClO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MP+Cl=HCl+MO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 5.7e-11;
Gstr{i,1}='MP'; Gstr{i,2}='Cl'; % 
fMP(i)=fMP(i)-1; fCl(i)=fCl(i)-1; fHCl(i)=fHCl(i)+1; fMO2(i)=fMO2(i)+1; % 

i=i+1;
Rnames{i}='C2H6+Cl=ETO2+HCl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(7.2e-11, -70.0);
Gstr{i,1}='C2H6'; Gstr{i,2}='Cl'; % 
fC2H6(i)=fC2H6(i)-1; fCl(i)=fCl(i)-1; fETO2(i)=fETO2(i)+1; fHCl(i)=fHCl(i)+1; % 

i=i+1;
Rnames{i}='ETO2+Cl=ALD2+ClO+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 7.4e-11;
Gstr{i,1}='ETO2'; Gstr{i,2}='Cl'; % 
fETO2(i)=fETO2(i)-1; fCl(i)=fCl(i)-1; fALD2(i)=fALD2(i)+1; fClO(i)=fClO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='OTHRO2+Cl=ALD2+ClO+HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = 7.4e-11;
Gstr{i,1}='OTHRO2'; Gstr{i,2}='Cl'; % 
fOTHRO2(i)=fOTHRO2(i)-1; fCl(i)=fCl(i)-1; fALD2(i)=fALD2(i)+1; fClO(i)=fClO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MOH+Cl=CH2O+HCl+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 5.5e-11;
Gstr{i,1}='MOH'; Gstr{i,2}='Cl'; % 
fMOH(i)=fMOH(i)-1; fCl(i)=fCl(i)-1; fCH2O(i)=fCH2O(i)+1; fHCl(i)=fHCl(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='EOH+Cl=ALD2+HCl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 9.6e-11;
Gstr{i,1}='EOH'; Gstr{i,2}='Cl'; % 
fEOH(i)=fEOH(i)-1; fCl(i)=fCl(i)-1; fALD2(i)=fALD2(i)+1; fHCl(i)=fHCl(i)+1; % 

i=i+1;
Rnames{i}='ACTA+Cl=HCl+MO2+CO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 2.8e-14;
Gstr{i,1}='ACTA'; Gstr{i,2}='Cl'; % 
fACTA(i)=fACTA(i)-1; fCl(i)=fCl(i)-1; fHCl(i)=fHCl(i)+1; fMO2(i)=fMO2(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='C3H8+Cl=B3O2+HCl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(6.54e-11, 60.0);
Gstr{i,1}='C3H8'; Gstr{i,2}='Cl'; % 
fC3H8(i)=fC3H8(i)-1; fCl(i)=fCl(i)-1; fB3O2(i)=fB3O2(i)+1; fHCl(i)=fHCl(i)+1; % 

i=i+1;
Rnames{i}='C3H8+Cl=A3O2+HCl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(8.12e-11, -90.0);
Gstr{i,1}='C3H8'; Gstr{i,2}='Cl'; % 
fC3H8(i)=fC3H8(i)-1; fCl(i)=fCl(i)-1; fA3O2(i)=fA3O2(i)+1; fHCl(i)=fHCl(i)+1; % 

i=i+1;
Rnames{i}='ACET+Cl=ATO2+HCl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(7.70e-11, -1000.0);
Gstr{i,1}='ACET'; Gstr{i,2}='Cl'; % 
fACET(i)=fACET(i)-1; fCl(i)=fCl(i)-1; fATO2(i)=fATO2(i)+1; fHCl(i)=fHCl(i)+1; % 

i=i+1;
Rnames{i}='ISOP+Cl=HCl+0.5IHOO1+0.5IHOO4'; % 2019/11/06, Sherwen2016b,KHB,TS,JAS,SDE
k(:,i) = GCARR_ac(7.60e-11, 500.0);
Gstr{i,1}='ISOP'; Gstr{i,2}='Cl'; % 
fISOP(i)=fISOP(i)-1; fCl(i)=fCl(i)-1; fHCl(i)=fHCl(i)+1; fIHOO1(i)=fIHOO1(i)+0.5; fIHOO4(i)=fIHOO4(i)+0.5; % 

i=i+1;
Rnames{i}='ALK4+Cl=HCl+R4O2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 2.05e-10;
Gstr{i,1}='ALK4'; Gstr{i,2}='Cl'; % 
fALK4(i)=fALK4(i)-1; fCl(i)=fCl(i)-1; fHCl(i)=fHCl(i)+1; fR4O2(i)=fR4O2(i)+1; % 

i=i+1;
Rnames{i}='PRPE+Cl=HCl+PO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCJPLPR_aa(4.00e-28, 2.8e-10, 0.6);
Gstr{i,1}='PRPE'; Gstr{i,2}='Cl'; % 
fPRPE(i)=fPRPE(i)-1; fCl(i)=fCl(i)-1; fHCl(i)=fHCl(i)+1; fPO2(i)=fPO2(i)+1; % 

i=i+1;
Rnames{i}='PRPE+Br=HBr+PO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 3.60e-12;
Gstr{i,1}='PRPE'; Gstr{i,2}='Br'; % 
fPRPE(i)=fPRPE(i)-1; fBr(i)=fBr(i)-1; fHBr(i)=fHBr(i)+1; fPO2(i)=fPO2(i)+1; % 

i=i+1;
Rnames{i}='I+NO=INO'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCJPLPR_aba(1.80e-32, 1.0, 1.77e-11, 0.6);
Gstr{i,1}='I'; Gstr{i,2}='NO'; % 
fI(i)=fI(i)-1; fNO(i)=fNO(i)-1; fINO(i)=fINO(i)+1; % 

i=i+1;
Rnames{i}='INO+INO=I2+2.0NO'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(8.40e-11, -2620.0);
Gstr{i,1}='INO'; Gstr{i,2}='INO'; % 
fINO(i)=fINO(i)-2; fI2(i)=fI2(i)+1; fNO(i)=fNO(i)+2.0; % 

i=i+1;
Rnames{i}='I+NO2=IONO'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCJPLPR_aba(3.00e-31, 1.0, 6.6e-11, 0.63);
Gstr{i,1}='I'; Gstr{i,2}='NO2'; % 
fI(i)=fI(i)-1; fNO2(i)=fNO2(i)-1; fIONO(i)=fIONO(i)+1; % 

i=i+1;
Rnames{i}='IONO=I+NO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(9.94e17, -11859.0);
Gstr{i,1}='IONO'; % 
fIONO(i)=fIONO(i)-1; fI(i)=fI(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='IONO+IONO=I2+2.0NO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(2.90e-11, -2600.0);
Gstr{i,1}='IONO'; Gstr{i,2}='IONO'; % 
fIONO(i)=fIONO(i)-2; fI2(i)=fI2(i)+1; fNO2(i)=fNO2(i)+2.0; % 

i=i+1;
Rnames{i}='I2+NO3=I+IONO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 1.50e-12;
Gstr{i,1}='I2'; Gstr{i,2}='NO3'; % 
fI2(i)=fI2(i)-1; fNO3(i)=fNO3(i)-1; fI(i)=fI(i)+1; fIONO2(i)=fIONO2(i)+1; % 

i=i+1;
Rnames{i}='IO+NO2=IONO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCJPLPR_abab(7.50e-31, 3.5, 7.6e-12, 1.5, 0.6);
Gstr{i,1}='IO'; Gstr{i,2}='NO2'; % 
fIO(i)=fIO(i)-1; fNO2(i)=fNO2(i)-1; fIONO2(i)=fIONO2(i)+1; % 

i=i+1;
Rnames{i}='IONO2=IO+NO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(2.10e15, -13670.0);
Gstr{i,1}='IONO2'; % 
fIONO2(i)=fIONO2(i)-1; fIO(i)=fIO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='I+IONO2=I2+NO3'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(9.10e-11, -146.0);
Gstr{i,1}='I'; Gstr{i,2}='IONO2'; % 
fI(i)=fI(i)-1; fIONO2(i)=fIONO2(i)-1; fI2(i)=fI2(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='BrO+I=IO+Br'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 1.20e-11;
Gstr{i,1}='BrO'; Gstr{i,2}='I'; % 
fBrO(i)=fBrO(i)-1; fI(i)=fI(i)-1; fIO(i)=fIO(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='BrO+IO=I+Br+O2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(3.00e-12, 510.0);
Gstr{i,1}='BrO'; Gstr{i,2}='IO'; % 
fBrO(i)=fBrO(i)-1; fIO(i)=fIO(i)-1; fI(i)=fI(i)+1; fBr(i)=fBr(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='BrO+IO=OIO+Br'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(1.20e-11, 510.0);
Gstr{i,1}='BrO'; Gstr{i,2}='IO'; % 
fBrO(i)=fBrO(i)-1; fIO(i)=fIO(i)-1; fOIO(i)=fOIO(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='IO+OIO=I2O3'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 1.00e-10;
Gstr{i,1}='IO'; Gstr{i,2}='OIO'; % 
fIO(i)=fIO(i)-1; fOIO(i)=fOIO(i)-1; fI2O3(i)=fI2O3(i)+1; % 

i=i+1;
Rnames{i}='OIO+OIO=I2O4'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 1.50e-10;
Gstr{i,1}='OIO'; Gstr{i,2}='OIO'; % 
fOIO(i)=fOIO(i)-2; fI2O4(i)=fI2O4(i)+1; % 

i=i+1;
Rnames{i}='I2O4=2.0OIO'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 3.80e-02;
Gstr{i,1}='I2O4'; % 
fI2O4(i)=fI2O4(i)-1; fOIO(i)=fOIO(i)+2.0; % 

i=i+1;
Rnames{i}='NO+OIO=IO+NO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(1.10e-12, 542.0);
Gstr{i,1}='NO'; Gstr{i,2}='OIO'; % 
fNO(i)=fNO(i)-1; fOIO(i)=fOIO(i)-1; fIO(i)=fIO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='ClO+IO=I+OClO'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(5.10e-12, 280.0);
Gstr{i,1}='ClO'; Gstr{i,2}='IO'; % 
fClO(i)=fClO(i)-1; fIO(i)=fIO(i)-1; fI(i)=fI(i)+1; fOClO(i)=fOClO(i)+1; % 

i=i+1;
Rnames{i}='ClO+IO=I+Cl+O2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(2.81e-12, 280.0);
Gstr{i,1}='ClO'; Gstr{i,2}='IO'; % 
fClO(i)=fClO(i)-1; fIO(i)=fIO(i)-1; fI(i)=fI(i)+1; fCl(i)=fCl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='ClO+IO=ICl+O2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(1.02e-12, 280.0);
Gstr{i,1}='ClO'; Gstr{i,2}='IO'; % 
fClO(i)=fClO(i)-1; fIO(i)=fIO(i)-1; fICl(i)=fICl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='I+O3=IO+O2'; % 2017/09/22, Sherwen2017,TS,JAS,SDE
k(:,i) = GCARR_ac(2.30e-11, -870.0);
Gstr{i,1}='I'; Gstr{i,2}='O3'; % 
fI(i)=fI(i)-1; fO3(i)=fO3(i)-1; fIO(i)=fIO(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='I+HO2=HI+O2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(1.50e-11, -1090.0);
Gstr{i,1}='I'; Gstr{i,2}='HO2'; % 
fI(i)=fI(i)-1; fHO2(i)=fHO2(i)-1; fHI(i)=fHI(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='I2+OH=HOI+I'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 1.80e-10;
Gstr{i,1}='I2'; Gstr{i,2}='OH'; % 
fI2(i)=fI2(i)-1; fOH(i)=fOH(i)-1; fHOI(i)=fHOI(i)+1; fI(i)=fI(i)+1; % 

i=i+1;
Rnames{i}='HI+OH=H2O+I'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 3.00e-11;
Gstr{i,1}='HI'; Gstr{i,2}='OH'; % 
fHI(i)=fHI(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fI(i)=fI(i)+1; % 

i=i+1;
Rnames{i}='HOI+OH=H2O+IO'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = 5.00e-12;
Gstr{i,1}='HOI'; Gstr{i,2}='OH'; % 
fHOI(i)=fHOI(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fIO(i)=fIO(i)+1; % 

i=i+1;
Rnames{i}='IO+HO2=HOI+O2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(1.30e-11, 570.0);
Gstr{i,1}='IO'; Gstr{i,2}='HO2'; % 
fIO(i)=fIO(i)-1; fHO2(i)=fHO2(i)-1; fHOI(i)=fHOI(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='IO+NO=I+NO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(9.10e-12, 240.0);
Gstr{i,1}='IO'; Gstr{i,2}='NO'; % 
fIO(i)=fIO(i)-1; fNO(i)=fNO(i)-1; fI(i)=fI(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='IO+IO=I+OIO'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(6.00e-12, 500.0);
Gstr{i,1}='IO'; Gstr{i,2}='IO'; % 
fIO(i)=fIO(i)-2; fI(i)=fI(i)+1; fOIO(i)=fOIO(i)+1; % 

i=i+1;
Rnames{i}='IO+IO=I2O2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(9.00e-12, 500.0);
Gstr{i,1}='IO'; Gstr{i,2}='IO'; % 
fIO(i)=fIO(i)-2; fI2O2(i)=fI2O2(i)+1; % 

i=i+1;
Rnames{i}='I2O2=2.0IO'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(1.00e12, -9770.0);
Gstr{i,1}='I2O2'; % 
fI2O2(i)=fI2O2(i)-1; fIO(i)=fIO(i)+2.0; % 

i=i+1;
Rnames{i}='I2O2=I+OIO'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(2.50e14, -9770.0);
Gstr{i,1}='I2O2'; % 
fI2O2(i)=fI2O2(i)-1; fI(i)=fI(i)+1; fOIO(i)=fOIO(i)+1; % 

i=i+1;
Rnames{i}='CH3I+OH=H2O+I+MO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = GCARR_ac(2.90e-12, -1100.0);
Gstr{i,1}='CH3I'; Gstr{i,2}='OH'; % 
fCH3I(i)=fCH3I(i)-1; fOH(i)=fOH(i)-1; fH2O(i)=fH2O(i)+1; fI(i)=fI(i)+1; fMO2(i)=fMO2(i)+1; % 

i=i+1;
Rnames{i}='ETHLN+OH=CH2O+NO2+CO2'; % 2017/06/15, Marais2016, EAM
k(:,i) = 2.40e-12;
Gstr{i,1}='ETHLN'; Gstr{i,2}='OH'; % 
fETHLN(i)=fETHLN(i)-1; fOH(i)=fOH(i)-1; fCH2O(i)=fCH2O(i)+1; fNO2(i)=fNO2(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='PROPNN+OH=MGLY+NO2'; % 2017/07/14, MCMv3.3, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 6.70e-13;
Gstr{i,1}='PROPNN'; Gstr{i,2}='OH'; % 
fPROPNN(i)=fPROPNN(i)-1; fOH(i)=fOH(i)-1; fMGLY(i)=fMGLY(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='CH2OO+CO=CH2O'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = 1.20e-15;
Gstr{i,1}='CH2OO'; Gstr{i,2}='CO'; % 
fCH2OO(i)=fCH2OO(i)-1; fCO(i)=fCO(i)-1; fCH2O(i)=fCH2O(i)+1; % 

i=i+1;
Rnames{i}='CH2OO+NO=CH2O+NO2'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = 1.00e-14;
Gstr{i,1}='CH2OO'; Gstr{i,2}='NO'; % 
fCH2OO(i)=fCH2OO(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='CH2OO+NO2=CH2O+NO3'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = 1.00e-15;
Gstr{i,1}='CH2OO'; Gstr{i,2}='NO2'; % 
fCH2OO(i)=fCH2OO(i)-1; fNO2(i)=fNO2(i)-1; fCH2O(i)=fCH2O(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='CH2OO+H2O=0.06CH2O+0.06H2O2+0.21HCOOH+0.73HMHP'; % 2019/11/06, Bates2019, KHB
k(:,i) = 1.70e-15;
Gstr{i,1}='CH2OO'; Gstr{i,2}='H2O'; % 
fCH2OO(i)=fCH2OO(i)-1; fH2O(i)=fH2O(i)-1; fCH2O(i)=fCH2O(i)+0.06; fH2O2(i)=fH2O2(i)+0.06; fHCOOH(i)=fHCOOH(i)+0.21; fHMHP(i)=fHMHP(i)+0.73; % 

i=i+1;
Rnames{i}='CH2OO+H2O+H2O=0.06CH2O+0.06H2O2+0.54HCOOH+0.4HMHP'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.88e-35, 1391.0);
Gstr{i,1}='CH2OO'; Gstr{i,2}='H2O'; Gstr{i,3}='H2O'; % 
fCH2OO(i)=fCH2OO(i)-1; fH2O(i)=fH2O(i)-2; fCH2O(i)=fCH2O(i)+0.06; fH2O2(i)=fH2O2(i)+0.06; fHCOOH(i)=fHCOOH(i)+0.54; fHMHP(i)=fHMHP(i)+0.4; % 

i=i+1;
Rnames{i}='CH2OO+O3=CH2O'; % 2019/11/06, Bates2019, KHB
k(:,i) = 1.40e-12;
Gstr{i,1}='CH2OO'; Gstr{i,2}='O3'; % 
fCH2OO(i)=fCH2OO(i)-1; fO3(i)=fO3(i)-1; fCH2O(i)=fCH2O(i)+1; % 

i=i+1;
Rnames{i}='CH2OO+SO2=CH2O+SO4'; % 2019/11/06, Bates2019, KHB
k(:,i) = 3.70e-11;
Gstr{i,1}='CH2OO'; Gstr{i,2}='SO2'; % 
fCH2OO(i)=fCH2OO(i)-1; fSO2(i)=fSO2(i)-1; fCH2O(i)=fCH2O(i)+1; fSO4(i)=fSO4(i)+1; % 

i=i+1;
Rnames{i}='CH3CHOO+CO=ALD2'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = 1.20e-15;
Gstr{i,1}='CH3CHOO'; Gstr{i,2}='CO'; % 
fCH3CHOO(i)=fCH3CHOO(i)-1; fCO(i)=fCO(i)-1; fALD2(i)=fALD2(i)+1; % 

i=i+1;
Rnames{i}='CH3CHOO+NO=ALD2+NO2'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = 1.00e-14;
Gstr{i,1}='CH3CHOO'; Gstr{i,2}='NO'; % 
fCH3CHOO(i)=fCH3CHOO(i)-1; fNO(i)=fNO(i)-1; fALD2(i)=fALD2(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='CH3CHOO+NO2=ALD2+NO3'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = 1.00e-15;
Gstr{i,1}='CH3CHOO'; Gstr{i,2}='NO2'; % 
fCH3CHOO(i)=fCH3CHOO(i)-1; fNO2(i)=fNO2(i)-1; fALD2(i)=fALD2(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='CH3CHOO+SO2=ALD2+SO4'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = 7.00e-14;
Gstr{i,1}='CH3CHOO'; Gstr{i,2}='SO2'; % 
fCH3CHOO(i)=fCH3CHOO(i)-1; fSO2(i)=fSO2(i)-1; fALD2(i)=fALD2(i)+1; fSO4(i)=fSO4(i)+1; % 

i=i+1;
Rnames{i}='CH3CHOO+H2O=ALD2+H2O2'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = 6.00e-18;
Gstr{i,1}='CH3CHOO'; Gstr{i,2}='H2O'; % 
fCH3CHOO(i)=fCH3CHOO(i)-1; fH2O(i)=fH2O(i)-1; fALD2(i)=fALD2(i)+1; fH2O2(i)=fH2O2(i)+1; % 

i=i+1;
Rnames{i}='CH3CHOO+H2O=ACTA'; % 2015/09/25, Millet2015, DBM,EAM
k(:,i) = 1.00e-17;
Gstr{i,1}='CH3CHOO'; Gstr{i,2}='H2O'; % 
fCH3CHOO(i)=fCH3CHOO(i)-1; fH2O(i)=fH2O(i)-1; fACTA(i)=fACTA(i)+1; % 

i=i+1;
Rnames{i}='BENZ+OH=BRO2+1.92CH2O+0.252GLYX+OH'; % 2017/03/23, Fischer2014 , EVF
k(:,i) = GCARR_ac(2.33e-12, -193.0);
Gstr{i,1}='BENZ'; Gstr{i,2}='OH'; % 
fBENZ(i)=fBENZ(i)-1; fBRO2(i)=fBRO2(i)+1; fCH2O(i)=fCH2O(i)+1.92; fGLYX(i)=fGLYX(i)+0.252; % 

i=i+1;
Rnames{i}='TOLU+OH=1.92CH2O+0.26GLYX+0.215MGLY+TRO2+OH'; % 2017/03/23, Fischer2014 , EVF
k(:,i) = GCARR_ac(1.81e-12, 338.0);
Gstr{i,1}='TOLU'; Gstr{i,2}='OH'; % 
fTOLU(i)=fTOLU(i)-1; fCH2O(i)=fCH2O(i)+1.92; fGLYX(i)=fGLYX(i)+0.26; fMGLY(i)=fMGLY(i)+0.215; fTRO2(i)=fTRO2(i)+1; % 

i=i+1;
Rnames{i}='XYLE+OH=1.92CH2O+0.268GLYX+0.463MGLY+XRO2+OH'; % 2017/03/23, Fischer2014 , EVF
k(:,i) = 2.31e-11;
Gstr{i,1}='XYLE'; Gstr{i,2}='OH'; % 
fXYLE(i)=fXYLE(i)-1; fCH2O(i)=fCH2O(i)+1.92; fGLYX(i)=fGLYX(i)+0.268; fMGLY(i)=fMGLY(i)+0.463; fXRO2(i)=fXRO2(i)+1; % 

i=i+1;
Rnames{i}='XYLE+NO3=CO2';
k(:,i) = 2.60e-16;
Gstr{i,1}='XYLE'; Gstr{i,2}='NO3'; % 
fXYLE(i)=fXYLE(i)-1; fNO3(i)=fNO3(i)-1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='BRO2+HO2=LBRO2H';
k(:,i) = GCARR_ac(1.40e-12, 700.0);
Gstr{i,1}='BRO2'; Gstr{i,2}='HO2'; % 
fBRO2(i)=fBRO2(i)-1; fHO2(i)=fHO2(i)-1; fLBRO2H(i)=fLBRO2H(i)+1; % 

i=i+1;
Rnames{i}='BRO2+NO=LBRO2N';
k(:,i) = GCARR_ac(2.60e-12, 350.0);
Gstr{i,1}='BRO2'; Gstr{i,2}='NO'; % 
fBRO2(i)=fBRO2(i)-1; fNO(i)=fNO(i)-1; fLBRO2N(i)=fLBRO2N(i)+1; % 

i=i+1;
Rnames{i}='TRO2+HO2=LTRO2H';
k(:,i) = GCARR_ac(1.40e-12, 700.0);
Gstr{i,1}='TRO2'; Gstr{i,2}='HO2'; % 
fTRO2(i)=fTRO2(i)-1; fHO2(i)=fHO2(i)-1; fLTRO2H(i)=fLTRO2H(i)+1; % 

i=i+1;
Rnames{i}='NO+TRO2=LTRO2N';
k(:,i) = GCARR_ac(2.60e-12, 350.0);
Gstr{i,1}='NO'; Gstr{i,2}='TRO2'; % 
fNO(i)=fNO(i)-1; fTRO2(i)=fTRO2(i)-1; fLTRO2N(i)=fLTRO2N(i)+1; % 

i=i+1;
Rnames{i}='XRO2+HO2=LXRO2H';
k(:,i) = GCARR_ac(1.40e-12, 700.0);
Gstr{i,1}='XRO2'; Gstr{i,2}='HO2'; % 
fXRO2(i)=fXRO2(i)-1; fHO2(i)=fHO2(i)-1; fLXRO2H(i)=fLXRO2H(i)+1; % 

i=i+1;
Rnames{i}='NO+XRO2=LXRO2N';
k(:,i) = GCARR_ac(2.60e-12, 350.0);
Gstr{i,1}='NO'; Gstr{i,2}='XRO2'; % 
fNO(i)=fNO(i)-1; fXRO2(i)=fXRO2(i)-1; fLXRO2N(i)=fLXRO2N(i)+1; % 

i=i+1;
Rnames{i}='MTPA+OH=PIO2'; % 2017/03/23, IUPAC2010, EVF
k(:,i) = GCARR_ac(1.21e-11, 440.0);
Gstr{i,1}='MTPA'; Gstr{i,2}='OH'; % 
fMTPA(i)=fMTPA(i)-1; fOH(i)=fOH(i)-1; fPIO2(i)=fPIO2(i)+1; % 

i=i+1;
Rnames{i}='MTPO+OH=PIO2'; % 2017/03/23, IUPAC2010, EVF
k(:,i) = GCARR_ac(1.21e-11, 440.0);
Gstr{i,1}='MTPO'; Gstr{i,2}='OH'; % 
fMTPO(i)=fMTPO(i)-1; fOH(i)=fOH(i)-1; fPIO2(i)=fPIO2(i)+1; % 

i=i+1;
Rnames{i}='NO+PIO2=0.11ACET+0.23CH2O+0.07HCOOH+0.44MEK+0.12MONITS+0.06MONITU+0.43RCHO+0.82NO2+0.82HO2'; % 2017/07/14, Browne2014, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 4.00e-12;
Gstr{i,1}='NO'; Gstr{i,2}='PIO2'; % 
fNO(i)=fNO(i)-1; fPIO2(i)=fPIO2(i)-1; fACET(i)=fACET(i)+0.11; fCH2O(i)=fCH2O(i)+0.23; fHCOOH(i)=fHCOOH(i)+0.07; fMEK(i)=fMEK(i)+0.44; fMONITS(i)=fMONITS(i)+0.12; fMONITU(i)=fMONITU(i)+0.06; fRCHO(i)=fRCHO(i)+0.43; fNO2(i)=fNO2(i)+0.82; fHO2(i)=fHO2(i)+0.82; % 

i=i+1;
Rnames{i}='PIO2+HO2=PIP'; % 2017/03/23, Roberts1992, EVF
k(:,i) = 1.50e-11;
Gstr{i,1}='PIO2'; Gstr{i,2}='HO2'; % 
fPIO2(i)=fPIO2(i)-1; fHO2(i)=fHO2(i)-1; fPIP(i)=fPIP(i)+1; % 

i=i+1;
Rnames{i}='MO2+PIO2=0.75CH2O+0.75MEK+0.25MOH+0.75RCHO+0.25ROH+HO2'; % 2017/07/14, Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(3.56e-14, 708.0);
Gstr{i,1}='MO2'; Gstr{i,2}='PIO2'; % 
fMO2(i)=fMO2(i)-1; fPIO2(i)=fPIO2(i)-1; fCH2O(i)=fCH2O(i)+0.75; fMEK(i)=fMEK(i)+0.75; fMOH(i)=fMOH(i)+0.25; fRCHO(i)=fRCHO(i)+0.75; fROH(i)=fROH(i)+0.25; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+PIO2=MEK+0.5MO2+RCHO+RCOOH+0.5HO2'; % 2017/03/23, Roberts1992, EVF
k(:,i) = GCARR_ac(7.40e-13, 765.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='PIO2'; % 
fMCO3(i)=fMCO3(i)-1; fPIO2(i)=fPIO2(i)-1; fMEK(i)=fMEK(i)+1; fMO2(i)=fMO2(i)+0.5; fRCHO(i)=fRCHO(i)+1; fRCOOH(i)=fRCOOH(i)+1; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='PIO2+NO3=MEK+RCHO+NO2+HO2'; % 2017/03/23, Roberts1992, EVF
k(:,i) = 1.20e-12;
Gstr{i,1}='PIO2'; Gstr{i,2}='NO3'; % 
fPIO2(i)=fPIO2(i)-1; fNO3(i)=fNO3(i)-1; fMEK(i)=fMEK(i)+1; fRCHO(i)=fRCHO(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MTPA+O3=0.02H2O2+0.62KO2+0.53MEK+0.65RCHO+0.14CO+0.85OH+0.1HO2'; % 2017/07/14, Atkinson2003, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(5.00e-16, -530.0);
Gstr{i,1}='MTPA'; Gstr{i,2}='O3'; % 
fMTPA(i)=fMTPA(i)-1; fO3(i)=fO3(i)-1; fH2O2(i)=fH2O2(i)+0.02; fKO2(i)=fKO2(i)+0.62; fMEK(i)=fMEK(i)+0.53; fRCHO(i)=fRCHO(i)+0.65; fCO(i)=fCO(i)+0.14; fOH(i)=fOH(i)+0.85; fHO2(i)=fHO2(i)+0.1; % 

i=i+1;
Rnames{i}='MTPO+O3=0.02H2O2+0.62KO2+0.53MEK+0.65RCHO+0.14CO+0.85OH+0.1HO2'; % 2017/07/14, Atkinson2003, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(5.00e-16, -530.0);
Gstr{i,1}='MTPO'; Gstr{i,2}='O3'; % 
fMTPO(i)=fMTPO(i)-1; fO3(i)=fO3(i)-1; fH2O2(i)=fH2O2(i)+0.02; fKO2(i)=fKO2(i)+0.62; fMEK(i)=fMEK(i)+0.53; fRCHO(i)=fRCHO(i)+0.65; fCO(i)=fCO(i)+0.14; fOH(i)=fOH(i)+0.85; fHO2(i)=fHO2(i)+0.1; % 

i=i+1;
Rnames{i}='MTPA+NO3=0.9OLND+0.1OLNN'; % 2017/07/14, Fisher2016, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(8.33e-13, 490.0);
Gstr{i,1}='MTPA'; Gstr{i,2}='NO3'; % 
fMTPA(i)=fMTPA(i)-1; fNO3(i)=fNO3(i)-1; fOLND(i)=fOLND(i)+0.9; fOLNN(i)=fOLNN(i)+0.1; % 

i=i+1;
Rnames{i}='MTPO+NO3=0.9OLND+0.1OLNN'; % 2017/07/14, Fisher2016, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(8.33e-13, 490.0);
Gstr{i,1}='MTPO'; Gstr{i,2}='NO3'; % 
fMTPO(i)=fMTPO(i)-1; fNO3(i)=fNO3(i)-1; fOLND(i)=fOLND(i)+0.9; fOLNN(i)=fOLNN(i)+0.1; % 

i=i+1;
Rnames{i}='LIMO+OH=LIMO2'; % 2017/07/14, Gill2002, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(4.20e-11, 401.0);
Gstr{i,1}='LIMO'; Gstr{i,2}='OH'; % 
fLIMO(i)=fLIMO(i)-1; fOH(i)=fOH(i)-1; fLIMO2(i)=fLIMO2(i)+1; % 

i=i+1;
Rnames{i}='LIMO+O3=0.04CH2O+0.02H2O2+0.01HCOOH+0.42KO2+0.79MACR+0.16OTHRO2+0.46PRPE+0.07RCOOH+0.14CO+0.85OH+0.1HO2'; % 2017/07/14, Atkinson2003, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(2.95e-15, -783.0);
Gstr{i,1}='LIMO'; Gstr{i,2}='O3'; % 
fLIMO(i)=fLIMO(i)-1; fO3(i)=fO3(i)-1; fCH2O(i)=fCH2O(i)+0.04; fH2O2(i)=fH2O2(i)+0.02; fHCOOH(i)=fHCOOH(i)+0.01; fKO2(i)=fKO2(i)+0.42; fMACR(i)=fMACR(i)+0.79; fOTHRO2(i)=fOTHRO2(i)+0.16; fPRPE(i)=fPRPE(i)+0.46; fRCOOH(i)=fRCOOH(i)+0.07; fCO(i)=fCO(i)+0.14; fOH(i)=fOH(i)+0.85; fHO2(i)=fHO2(i)+0.1; % 

i=i+1;
Rnames{i}='LIMO+NO3=0.5OLND+0.5OLNN'; % 2017/07/14, Fry2014,Atkinson2003, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 1.22e-11;
Gstr{i,1}='LIMO'; Gstr{i,2}='NO3'; % 
fLIMO(i)=fLIMO(i)-1; fNO3(i)=fNO3(i)-1; fOLND(i)=fOLND(i)+0.5; fOLNN(i)=fOLNN(i)+0.5; % 

i=i+1;
Rnames{i}='LIMO2+NO=0.231CH2O+0.058HAC+0.289MEK+0.22MONITU+0.289PRPE+0.491RCHO+0.78NO2+0.686HO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 4.00e-12;
Gstr{i,1}='LIMO2'; Gstr{i,2}='NO'; % 
fLIMO2(i)=fLIMO2(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+0.231; fHAC(i)=fHAC(i)+0.058; fMEK(i)=fMEK(i)+0.289; fMONITU(i)=fMONITU(i)+0.22; fPRPE(i)=fPRPE(i)+0.289; fRCHO(i)=fRCHO(i)+0.491; fNO2(i)=fNO2(i)+0.78; fHO2(i)=fHO2(i)+0.686; % 

i=i+1;
Rnames{i}='LIMO2+HO2=PIP'; % 2017/07/14, Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 1.50e-11;
Gstr{i,1}='LIMO2'; Gstr{i,2}='HO2'; % 
fLIMO2(i)=fLIMO2(i)-1; fHO2(i)=fHO2(i)-1; fPIP(i)=fPIP(i)+1; % 

i=i+1;
Rnames{i}='LIMO2+MO2=1.04CH2O+0.308MACR+0.25MOH+0.192PRPE+0.25ROH+HO2'; % 2017/07/14, Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(3.56e-14, 708.0);
Gstr{i,1}='LIMO2'; Gstr{i,2}='MO2'; % 
fLIMO2(i)=fLIMO2(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+1.04; fMACR(i)=fMACR(i)+0.308; fMOH(i)=fMOH(i)+0.25; fPRPE(i)=fPRPE(i)+0.192; fROH(i)=fROH(i)+0.25; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='LIMO2+MCO3=0.385CH2O+0.308MACR+0.5MO2+0.192PRPE+0.5RCOOH+0.5HO2'; % 2017/07/14, Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(7.40e-13, 765.0);
Gstr{i,1}='LIMO2'; Gstr{i,2}='MCO3'; % 
fLIMO2(i)=fLIMO2(i)-1; fMCO3(i)=fMCO3(i)-1; fCH2O(i)=fCH2O(i)+0.385; fMACR(i)=fMACR(i)+0.308; fMO2(i)=fMO2(i)+0.5; fPRPE(i)=fPRPE(i)+0.192; fRCOOH(i)=fRCOOH(i)+0.5; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='LIMO2+NO3=0.385CH2O+0.615MACR+0.385PRPE+NO2+HO2'; % 2017/07/14, Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 1.20e-12;
Gstr{i,1}='LIMO2'; Gstr{i,2}='NO3'; % 
fLIMO2(i)=fLIMO2(i)-1; fNO3(i)=fNO3(i)-1; fCH2O(i)=fCH2O(i)+0.385; fMACR(i)=fMACR(i)+0.615; fPRPE(i)=fPRPE(i)+0.385; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='PIP+OH=0.41MEK+0.44R4O2+0.08RCHO+0.49OH'; % 2017/07/14, Goliff2013, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(3.40e-12, 190.0);
Gstr{i,1}='PIP'; Gstr{i,2}='OH'; % 
fPIP(i)=fPIP(i)-1; fOH(i)=fOH(i)-0.510; fOH(i)=fOH(i)-0.510; fMEK(i)=fMEK(i)+0.41; fR4O2(i)=fR4O2(i)+0.44; fRCHO(i)=fRCHO(i)+0.08; % 

i=i+1;
Rnames{i}='NO+OLNN=MONITS+NO2+HO2'; % 2017/07/14, Browne2014,Goliff2013, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 4.00e-12;
Gstr{i,1}='NO'; Gstr{i,2}='OLNN'; % 
fNO(i)=fNO(i)-1; fOLNN(i)=fOLNN(i)-1; fMONITS(i)=fMONITS(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='NO+OLND=0.287CH2O+0.464MEK+1.24RCHO+2.0NO2'; % 2017/07/14, Goliff2013, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 4.00e-12;
Gstr{i,1}='NO'; Gstr{i,2}='OLND'; % 
fNO(i)=fNO(i)-1; fOLND(i)=fOLND(i)-1; fCH2O(i)=fCH2O(i)+0.287; fMEK(i)=fMEK(i)+0.464; fRCHO(i)=fRCHO(i)+1.24; fNO2(i)=fNO2(i)+2.0; % 

i=i+1;
Rnames{i}='OLNN+HO2=0.7MONITS+0.3MONITU'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(1.66e-13, 1300.0);
Gstr{i,1}='OLNN'; Gstr{i,2}='HO2'; % 
fOLNN(i)=fOLNN(i)-1; fHO2(i)=fHO2(i)-1; fMONITS(i)=fMONITS(i)+0.7; fMONITU(i)=fMONITU(i)+0.3; % 

i=i+1;
Rnames{i}='OLND+HO2=0.7MONITS+0.3MONITU'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(1.66e-13, 1300.0);
Gstr{i,1}='OLND'; Gstr{i,2}='HO2'; % 
fOLND(i)=fOLND(i)-1; fHO2(i)=fHO2(i)-1; fMONITS(i)=fMONITS(i)+0.7; fMONITU(i)=fMONITU(i)+0.3; % 

i=i+1;
Rnames{i}='MO2+OLNN=CH2O+0.7MONITS+0.3MONITU+2.0HO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(1.60e-13, 708.0);
Gstr{i,1}='MO2'; Gstr{i,2}='OLNN'; % 
fMO2(i)=fMO2(i)-1; fOLNN(i)=fOLNN(i)-1; fCH2O(i)=fCH2O(i)+1; fMONITS(i)=fMONITS(i)+0.7; fMONITU(i)=fMONITU(i)+0.3; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='MO2+OLND=0.965CH2O+0.348MEK+0.25MOH+0.35MONITS+0.15MONITU+0.93RCHO+0.25ROH+0.5NO2+0.5HO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(9.68e-14, 708.0);
Gstr{i,1}='MO2'; Gstr{i,2}='OLND'; % 
fMO2(i)=fMO2(i)-1; fOLND(i)=fOLND(i)-1; fCH2O(i)=fCH2O(i)+0.965; fMEK(i)=fMEK(i)+0.348; fMOH(i)=fMOH(i)+0.25; fMONITS(i)=fMONITS(i)+0.35; fMONITU(i)=fMONITU(i)+0.15; fRCHO(i)=fRCHO(i)+0.93; fROH(i)=fROH(i)+0.25; fNO2(i)=fNO2(i)+0.5; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='MCO3+OLNN=MO2+0.7MONITS+0.3MONITU+HO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(8.85e-13, 765.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='OLNN'; % 
fMCO3(i)=fMCO3(i)-1; fOLNN(i)=fOLNN(i)-1; fMO2(i)=fMO2(i)+1; fMONITS(i)=fMONITS(i)+0.7; fMONITU(i)=fMONITU(i)+0.3; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MCO3+OLND=0.287CH2O+0.464MEK+0.5MO2+1.24RCHO+0.5RCOOH+NO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(5.37e-13, 765.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='OLND'; % 
fMCO3(i)=fMCO3(i)-1; fOLND(i)=fOLND(i)-1; fCH2O(i)=fCH2O(i)+0.287; fMEK(i)=fMEK(i)+0.464; fMO2(i)=fMO2(i)+0.5; fRCHO(i)=fRCHO(i)+1.24; fRCOOH(i)=fRCOOH(i)+0.5; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='OLNN+NO3=0.7MONITS+0.3MONITU+NO2+HO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 1.20e-12;
Gstr{i,1}='OLNN'; Gstr{i,2}='NO3'; % 
fOLNN(i)=fOLNN(i)-1; fNO3(i)=fNO3(i)-1; fMONITS(i)=fMONITS(i)+0.7; fMONITU(i)=fMONITU(i)+0.3; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='OLND+NO3=0.287CH2O+0.464MEK+1.24RCHO+2.0NO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 1.20e-12;
Gstr{i,1}='OLND'; Gstr{i,2}='NO3'; % 
fOLND(i)=fOLND(i)-1; fNO3(i)=fNO3(i)-1; fCH2O(i)=fCH2O(i)+0.287; fMEK(i)=fMEK(i)+0.464; fRCHO(i)=fRCHO(i)+1.24; fNO2(i)=fNO2(i)+2.0; % 

i=i+1;
Rnames{i}='OLNN+OLNN=1.4MONITS+0.6MONITU+HO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(7.00e-14, 1000.0);
Gstr{i,1}='OLNN'; Gstr{i,2}='OLNN'; % 
fOLNN(i)=fOLNN(i)-2; fMONITS(i)=fMONITS(i)+1.4; fMONITU(i)=fMONITU(i)+0.6; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='OLND+OLNN=0.202CH2O+0.149MEK+1.05MONITS+0.45MONITU+0.64RCHO+0.5NO2+0.5HO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(4.25e-14, 1000.0);
Gstr{i,1}='OLND'; Gstr{i,2}='OLNN'; % 
fOLND(i)=fOLND(i)-1; fOLNN(i)=fOLNN(i)-1; fCH2O(i)=fCH2O(i)+0.202; fMEK(i)=fMEK(i)+0.149; fMONITS(i)=fMONITS(i)+1.05; fMONITU(i)=fMONITU(i)+0.45; fRCHO(i)=fRCHO(i)+0.64; fNO2(i)=fNO2(i)+0.5; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='OLND+OLND=0.504CH2O+0.285MEK+0.7MONITS+0.3MONITU+1.21RCHO+NO2'; % 2017/07/14, Browne2014,Roberts1992, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(2.96e-14, 1000.0);
Gstr{i,1}='OLND'; Gstr{i,2}='OLND'; % 
fOLND(i)=fOLND(i)-2; fCH2O(i)=fCH2O(i)+0.504; fMEK(i)=fMEK(i)+0.285; fMONITS(i)=fMONITS(i)+0.7; fMONITU(i)=fMONITU(i)+0.3; fRCHO(i)=fRCHO(i)+1.21; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='MONITS+OH=HONIT'; % 2017/07/14, Browne2014, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 4.80e-12;
Gstr{i,1}='MONITS'; Gstr{i,2}='OH'; % 
fMONITS(i)=fMONITS(i)-1; fOH(i)=fOH(i)-1; fHONIT(i)=fHONIT(i)+1; % 

i=i+1;
Rnames{i}='MONITU+OH=HONIT'; % 2017/07/14, Browne2014, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 7.29e-11;
Gstr{i,1}='MONITU'; Gstr{i,2}='OH'; % 
fMONITU(i)=fMONITU(i)-1; fOH(i)=fOH(i)-1; fHONIT(i)=fHONIT(i)+1; % 

i=i+1;
Rnames{i}='MONITU+O3=HONIT'; % 2017/07/14, Browne2014, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 1.67e-16;
Gstr{i,1}='MONITU'; Gstr{i,2}='O3'; % 
fMONITU(i)=fMONITU(i)-1; fO3(i)=fO3(i)-1; fHONIT(i)=fHONIT(i)+1; % 

i=i+1;
Rnames{i}='MONITU+NO3=HONIT'; % 2017/07/14, Fisher2016, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(3.15e-13, -448.0);
Gstr{i,1}='MONITU'; Gstr{i,2}='NO3'; % 
fMONITU(i)=fMONITU(i)-1; fNO3(i)=fNO3(i)-1; fHONIT(i)=fHONIT(i)+1; % 

i=i+1;
Rnames{i}='MONITS+NO3=HONIT'; % 2017/07/14, Fisher2016, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GCARR_ac(3.15e-13, -448.0);
Gstr{i,1}='MONITS'; Gstr{i,2}='NO3'; % 
fMONITS(i)=fMONITS(i)-1; fNO3(i)=fNO3(i)-1; fHONIT(i)=fHONIT(i)+1; % 

i=i+1;
Rnames{i}='IONITA=HNO3+INDIOL'; % 2017/07/14, Fisher2016, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 2.78e-04;
Gstr{i,1}='IONITA'; % 
fIONITA(i)=fIONITA(i)-1; fHNO3(i)=fHNO3(i)+1; fINDIOL(i)=fINDIOL(i)+1; % 

i=i+1;
Rnames{i}='MONITA=HNO3+INDIOL'; % 2017/07/14, Fisher2016, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = 2.78e-04;
Gstr{i,1}='MONITA'; % 
fMONITA(i)=fMONITA(i)-1; fHNO3(i)=fHNO3(i)+1; fINDIOL(i)=fINDIOL(i)+1; % 

i=i+1;
Rnames{i}='HONIT+OH=HAC+NO3'; % 2017/07/14, Browne2014, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = GC_OHHNO3_acacac(2.41e-14, 460.0, 2.69e-17, 2199.0, 6.51e-34, 1335.0);
Gstr{i,1}='HONIT'; Gstr{i,2}='OH'; % 
fHONIT(i)=fHONIT(i)-1; fOH(i)=fOH(i)-1; fHAC(i)=fHAC(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='MENO3+OH=CH2O+NO2'; % 2019/05/16, JPL 15-10,Fisher2018, JAF
k(:,i) = GCARR_ac(8.00e-13, -1000.0);
Gstr{i,1}='MENO3'; Gstr{i,2}='OH'; % 
fMENO3(i)=fMENO3(i)-1; fOH(i)=fOH(i)-1; fCH2O(i)=fCH2O(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='ETNO3+OH=ALD2+NO2'; % 2019/05/16, JPL 15-10,Fisher2018, JAF
k(:,i) = GCARR_ac(1.00e-12, -490.0);
Gstr{i,1}='ETNO3'; Gstr{i,2}='OH'; % 
fETNO3(i)=fETNO3(i)-1; fOH(i)=fOH(i)-1; fALD2(i)=fALD2(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='IPRNO3+OH=ACET+NO2'; % 2019/05/16, JPL 15-10,Fisher2018, JAF
k(:,i) = GCARR_ac(1.20e-12, -320.0);
Gstr{i,1}='IPRNO3'; Gstr{i,2}='OH'; % 
fIPRNO3(i)=fIPRNO3(i)-1; fOH(i)=fOH(i)-1; fACET(i)=fACET(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='NPRNO3+OH=RCHO+NO2'; % 2019/05/16, JPL 15-10,Fisher2018, JAF
k(:,i) = 7.10e-13;
Gstr{i,1}='NPRNO3'; Gstr{i,2}='OH'; % 
fNPRNO3(i)=fNPRNO3(i)-1; fOH(i)=fOH(i)-1; fRCHO(i)=fRCHO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='ISOP+O3=0.827CH2O+0.58CH2OO+0.013H2O2+0.416MACR+0.407MO2+0.177MVK+0.407CO+0.28OH+0.16HO2+0.407CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 1.3e-17;
Gstr{i,1}='ISOP'; Gstr{i,2}='O3'; % 
fISOP(i)=fISOP(i)-1; fO3(i)=fO3(i)-1; fCH2O(i)=fCH2O(i)+0.827; fCH2OO(i)=fCH2OO(i)+0.58; fH2O2(i)=fH2O2(i)+0.013; fMACR(i)=fMACR(i)+0.416; fMO2(i)=fMO2(i)+0.407; fMVK(i)=fMVK(i)+0.177; fCO(i)=fCO(i)+0.407; fOH(i)=fOH(i)+0.28; fHO2(i)=fHO2(i)+0.16; fCO2(i)=fCO2(i)+0.407; % 

i=i+1;
Rnames{i}='ISOP+OH=IHOO1+LISOPOH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ISO1(1.7e-11, 3.90d2, 9.33e-2, 5.05d15, -1.22d4, 1.79d14, -8.830d3);
Gstr{i,1}='ISOP'; Gstr{i,2}='OH'; % 
fISOP(i)=fISOP(i)-1; fOH(i)=fOH(i)-1; fIHOO1(i)=fIHOO1(i)+1; fLISOPOH(i)=fLISOPOH(i)+1; % 

i=i+1;
Rnames{i}='ISOP+OH=IHOO4+LISOPOH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ISO1(1.0e-11, 3.90d2, 2.26e-1, 2.22d9, -7.160d3, 1.75d14, -9.054d3);
Gstr{i,1}='ISOP'; Gstr{i,2}='OH'; % 
fISOP(i)=fISOP(i)-1; fOH(i)=fOH(i)-1; fIHOO4(i)=fIHOO4(i)+1; fLISOPOH(i)=fLISOPOH(i)+1; % 

i=i+1;
Rnames{i}='ISOP+OH=0.3CH2O+0.25HPALD1+0.15HPALD3+0.3HPETHNL+LISOPOH+0.3MCO3+0.3MGLY+0.6CO+1.5OH+0.4HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ISO2(1.7e-11, 3.90d2, 9.33e-2, 5.05d15, -1.22d4, 1.79d14, -8.830d3);
Gstr{i,1}='ISOP'; Gstr{i,2}='OH'; % 
fISOP(i)=fISOP(i)-1; fOH(i)=fOH(i)+0.500; fCH2O(i)=fCH2O(i)+0.3; fHPALD1(i)=fHPALD1(i)+0.25; fHPALD3(i)=fHPALD3(i)+0.15; fHPETHNL(i)=fHPETHNL(i)+0.3; fLISOPOH(i)=fLISOPOH(i)+1; fMCO3(i)=fMCO3(i)+0.3; fMGLY(i)=fMGLY(i)+0.3; fCO(i)=fCO(i)+0.6; fOH(i)=fOH(i)+0.500; fHO2(i)=fHO2(i)+0.4; % 

i=i+1;
Rnames{i}='ISOP+OH=0.3ATOOH+0.3CH2O+0.25HPALD2+0.15HPALD4+LISOPOH+0.3MGLY+0.9CO+1.5OH+0.7HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ISO2(1.0e-11, 3.90d2, 2.26e-1, 2.22d9, -7.160d3, 1.75d14, -9.054d3);
Gstr{i,1}='ISOP'; Gstr{i,2}='OH'; % 
fISOP(i)=fISOP(i)-1; fOH(i)=fOH(i)+0.500; fATOOH(i)=fATOOH(i)+0.3; fCH2O(i)=fCH2O(i)+0.3; fHPALD2(i)=fHPALD2(i)+0.25; fHPALD4(i)=fHPALD4(i)+0.15; fLISOPOH(i)=fLISOPOH(i)+1; fMGLY(i)=fMGLY(i)+0.3; fCO(i)=fCO(i)+0.9; fOH(i)=fOH(i)+0.500; fHO2(i)=fHO2(i)+0.7; % 

i=i+1;
Rnames{i}='IHOO1+HO2=0.063CH2O+0.063MVK+0.937RIPA+0.063OH+0.063HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_abde(2.12e-13, -1300,  1.1644, -7.0485e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='HO2'; % 
fIHOO1(i)=fIHOO1(i)-1; fHO2(i)=fHO2(i)-0.937; fHO2(i)=fHO2(i)-0.937; fCH2O(i)=fCH2O(i)+0.063; fMVK(i)=fMVK(i)+0.063; fRIPA(i)=fRIPA(i)+0.937; fOH(i)=fOH(i)+0.063; % 

i=i+1;
Rnames{i}='IHOO1+HO2=RIPC'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_abde(2.12e-13, -1300, -0.1644, 7.0485e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='HO2'; % 
fIHOO1(i)=fIHOO1(i)-1; fHO2(i)=fHO2(i)-1; fRIPC(i)=fRIPC(i)+1; % 

i=i+1;
Rnames{i}='IHOO4+HO2=0.063CH2O+0.063MACR+0.937RIPB+0.063OH+0.063HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_abde(2.12e-13, -1300, 1.2038, -9.0435e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='HO2'; % 
fIHOO4(i)=fIHOO4(i)-1; fHO2(i)=fHO2(i)-0.937; fHO2(i)=fHO2(i)-0.937; fCH2O(i)=fCH2O(i)+0.063; fMACR(i)=fMACR(i)+0.063; fRIPB(i)=fRIPB(i)+0.937; fOH(i)=fOH(i)+0.063; % 

i=i+1;
Rnames{i}='IHOO4+HO2=RIPD'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_abde(2.12e-13, -1300, -0.2038, 9.0435e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='HO2'; % 
fIHOO4(i)=fIHOO4(i)-1; fHO2(i)=fHO2(i)-1; fRIPD(i)=fRIPD(i)+1; % 

i=i+1;
Rnames{i}='IHOO1=CH2O+MVK+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_abde(1.04d11, 9.746d3,  1.1644, -7.0485e-4);
Gstr{i,1}='IHOO1'; % 
fIHOO1(i)=fIHOO1(i)-1; fCH2O(i)=fCH2O(i)+1; fMVK(i)=fMVK(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IHOO1=0.3CH2O+0.25HPALD1+0.15HPALD3+0.3HPETHNL+0.3MCO3+0.3MGLY+0.6CO+1.5OH+0.4HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = TUNPLUS_abcde(5.05d15, -1.22d4, 1.0d8, -0.0128, 5.1242e-5);
Gstr{i,1}='IHOO1'; % 
fIHOO1(i)=fIHOO1(i)-1; fCH2O(i)=fCH2O(i)+0.3; fHPALD1(i)=fHPALD1(i)+0.25; fHPALD3(i)=fHPALD3(i)+0.15; fHPETHNL(i)=fHPETHNL(i)+0.3; fMCO3(i)=fMCO3(i)+0.3; fMGLY(i)=fMGLY(i)+0.3; fCO(i)=fCO(i)+0.6; fOH(i)=fOH(i)+1.5; fHO2(i)=fHO2(i)+0.4; % 

i=i+1;
Rnames{i}='IHOO4=CH2O+MACR+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_abde(1.88d11, 9.752d3, 1.2038, -9.0435e-4);
Gstr{i,1}='IHOO4'; % 
fIHOO4(i)=fIHOO4(i)-1; fCH2O(i)=fCH2O(i)+1; fMACR(i)=fMACR(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IHOO4=0.3ATOOH+0.3CH2O+0.25HPALD2+0.15HPALD4+0.3MGLY+0.9CO+1.5OH+0.7HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = TUNPLUS_abcde(2.22d9, -7.160d3, 1.0d8, -0.0306, 1.1346e-4);
Gstr{i,1}='IHOO4'; % 
fIHOO4(i)=fIHOO4(i)-1; fATOOH(i)=fATOOH(i)+0.3; fCH2O(i)=fCH2O(i)+0.3; fHPALD2(i)=fHPALD2(i)+0.25; fHPALD4(i)=fHPALD4(i)+0.15; fMGLY(i)=fMGLY(i)+0.3; fCO(i)=fCO(i)+0.9; fOH(i)=fOH(i)+1.5; fHO2(i)=fHO2(i)+0.7; % 

i=i+1;
Rnames{i}='IHOO1+IHOO1=2.0CH2O+2.0MVK+2.0HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(6.92e-14, 1.1644, -7.0485e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='IHOO1'; % 
fIHOO1(i)=fIHOO1(i)-2; fCH2O(i)=fCH2O(i)+2.0; fMVK(i)=fMVK(i)+2.0; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='IHOO4+IHOO4=2.0CH2O+2.0MACR+2.0HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(5.74e-12, 1.2038, -9.0435e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='IHOO4'; % 
fIHOO4(i)=fIHOO4(i)-2; fCH2O(i)=fCH2O(i)+2.0; fMACR(i)=fMACR(i)+2.0; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='IHOO1+IHOO4=2.0CH2O+MACR+MVK+2.0HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(1.54e-12, 2.3682, -1.6092e-3);
Gstr{i,1}='IHOO1'; Gstr{i,2}='IHOO4'; % 
fIHOO1(i)=fIHOO1(i)-1; fIHOO4(i)=fIHOO4(i)-1; fCH2O(i)=fCH2O(i)+2.0; fMACR(i)=fMACR(i)+1; fMVK(i)=fMVK(i)+1; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='IHOO1+IHOO1=HC5A+MVKHP+CO+OH+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(2.49e-12, -0.1644, 7.0485e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='IHOO1'; % 
fIHOO1(i)=fIHOO1(i)-2; fHC5A(i)=fHC5A(i)+1; fMVKHP(i)=fMVKHP(i)+1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHOO4+IHOO4=HC5A+MCRHP+CO+OH+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(3.94e-12, -0.2038, 9.0435e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='IHOO4'; % 
fIHOO4(i)=fIHOO4(i)-2; fHC5A(i)=fHC5A(i)+1; fMCRHP(i)=fMCRHP(i)+1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHOO1+IHOO4=HC5A+0.5MCRHP+0.5MVKHP+CO+OH+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(1.54e-12, -0.3682, 1.6092e-3);
Gstr{i,1}='IHOO1'; Gstr{i,2}='IHOO4'; % 
fIHOO1(i)=fIHOO1(i)-1; fIHOO4(i)=fIHOO4(i)-1; fHC5A(i)=fHC5A(i)+1; fMCRHP(i)=fMCRHP(i)+0.5; fMVKHP(i)=fMVKHP(i)+0.5; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHOO1+MO2=2.0CH2O+MVK+2.0HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(2.0e-12, 1.1644, -7.0485e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='MO2'; % 
fIHOO1(i)=fIHOO1(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+2.0; fMVK(i)=fMVK(i)+1; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='IHOO1+MO2=CH2O+0.5HC5A+0.5MVKHP+0.5CO+0.5OH+1.5HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(2.0e-12, -0.1644, 7.0485e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='MO2'; % 
fIHOO1(i)=fIHOO1(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+1; fHC5A(i)=fHC5A(i)+0.5; fMVKHP(i)=fMVKHP(i)+0.5; fCO(i)=fCO(i)+0.5; fOH(i)=fOH(i)+0.5; fHO2(i)=fHO2(i)+1.5; % 

i=i+1;
Rnames{i}='IHOO4+MO2=2.0CH2O+MACR+2.0HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(2.0e-12, 1.2038, -9.0435e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='MO2'; % 
fIHOO4(i)=fIHOO4(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+2.0; fMACR(i)=fMACR(i)+1; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='IHOO4+MO2=CH2O+0.5HC5A+0.5MCRHP+0.5CO+0.5OH+1.5HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = ARRPLUS_ade(2.0e-12, -0.2038, 9.0435e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='MO2'; % 
fIHOO4(i)=fIHOO4(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+1; fHC5A(i)=fHC5A(i)+0.5; fMCRHP(i)=fMCRHP(i)+0.5; fCO(i)=fCO(i)+0.5; fOH(i)=fOH(i)+0.5; fHO2(i)=fHO2(i)+1.5; % 

i=i+1;
Rnames{i}='IHOO1+NO=IHN2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 1.19,  6.0, 1.1644, 7.05e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='NO'; % 
fIHOO1(i)=fIHOO1(i)-1; fNO(i)=fNO(i)-1; fIHN2(i)=fIHN2(i)+1; % 

i=i+1;
Rnames{i}='IHOO1+NO=CH2O+MVK+NO2+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 1.19,  6.0, 1.1644, 7.05e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='NO'; % 
fIHOO1(i)=fIHOO1(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+1; fMVK(i)=fMVK(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHOO1+NO=IHN4'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 1.421, 6.0, -0.1644, -7.05e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='NO'; % 
fIHOO1(i)=fIHOO1(i)-1; fNO(i)=fNO(i)-1; fIHN4(i)=fIHN4(i)+1; % 

i=i+1;
Rnames{i}='IHOO1+NO=0.45HC5A+0.55MVKHP+NO2+0.55CO+0.55OH+0.45HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 1.421, 6.0, -0.1644, -7.05e-4);
Gstr{i,1}='IHOO1'; Gstr{i,2}='NO'; % 
fIHOO1(i)=fIHOO1(i)-1; fNO(i)=fNO(i)-1; fHC5A(i)=fHC5A(i)+0.45; fMVKHP(i)=fMVKHP(i)+0.55; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.55; fOH(i)=fOH(i)+0.55; fHO2(i)=fHO2(i)+0.45; % 

i=i+1;
Rnames{i}='IHOO4+NO=IHN3'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 1.297, 6.0, 1.2038, 9.04e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='NO'; % 
fIHOO4(i)=fIHOO4(i)-1; fNO(i)=fNO(i)-1; fIHN3(i)=fIHN3(i)+1; % 

i=i+1;
Rnames{i}='IHOO4+NO=CH2O+MACR+NO2+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 1.297, 6.0, 1.2038, 9.04e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='NO'; % 
fIHOO4(i)=fIHOO4(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+1; fMACR(i)=fMACR(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHOO4+NO=IHN1'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 1.421, 6.0, -0.2038, -9.04e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='NO'; % 
fIHOO4(i)=fIHOO4(i)-1; fNO(i)=fNO(i)-1; fIHN1(i)=fIHN1(i)+1; % 

i=i+1;
Rnames{i}='IHOO4+NO=0.45HC5A+0.55MCRHP+NO2+0.55CO+0.55OH+0.45HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 1.421, 6.0, -0.2038, -9.04e-4);
Gstr{i,1}='IHOO4'; Gstr{i,2}='NO'; % 
fIHOO4(i)=fIHOO4(i)-1; fNO(i)=fNO(i)-1; fHC5A(i)=fHC5A(i)+0.45; fMCRHP(i)=fMCRHP(i)+0.55; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.55; fOH(i)=fOH(i)+0.55; fHO2(i)=fHO2(i)+0.45; % 

i=i+1;
Rnames{i}='HPALD1+OH=0.085CH2O+0.315HPALD1OO+0.085ICHE+0.15IDC+0.085MGLY+0.035MVK+0.33MVKHP+0.45CO+1.085OH+0.085HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.17e-11, 450.0);
Gstr{i,1}='HPALD1'; Gstr{i,2}='OH'; % 
fHPALD1(i)=fHPALD1(i)-1; fOH(i)=fOH(i)+0.085; fCH2O(i)=fCH2O(i)+0.085; fHPALD1OO(i)=fHPALD1OO(i)+0.315; fICHE(i)=fICHE(i)+0.085; fIDC(i)=fIDC(i)+0.15; fMGLY(i)=fMGLY(i)+0.085; fMVK(i)=fMVK(i)+0.035; fMVKHP(i)=fMVKHP(i)+0.33; fCO(i)=fCO(i)+0.45; fOH(i)=fOH(i)+0.085; fHO2(i)=fHO2(i)+0.085; % 

i=i+1;
Rnames{i}='HPALD2+OH=0.165CH2O+0.315HPALD2OO+0.165ICHE+0.15IDC+0.035MACR+0.17MCRHP+0.165MGLY+0.37CO+1.165OH+0.165HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.17e-11, 450.0);
Gstr{i,1}='HPALD2'; Gstr{i,2}='OH'; % 
fHPALD2(i)=fHPALD2(i)-1; fOH(i)=fOH(i)+0.165; fCH2O(i)=fCH2O(i)+0.165; fHPALD2OO(i)=fHPALD2OO(i)+0.315; fICHE(i)=fICHE(i)+0.165; fIDC(i)=fIDC(i)+0.15; fMACR(i)=fMACR(i)+0.035; fMCRHP(i)=fMCRHP(i)+0.17; fMGLY(i)=fMGLY(i)+0.165; fCO(i)=fCO(i)+0.37; fOH(i)=fOH(i)+0.165; fHO2(i)=fHO2(i)+0.165; % 

i=i+1;
Rnames{i}='HPALD3+OH=0.58ICHE+0.23MVK+0.19MVKHP+0.42CO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.20e-11, 390.0);
Gstr{i,1}='HPALD3'; Gstr{i,2}='OH'; % 
fHPALD3(i)=fHPALD3(i)-1; fICHE(i)=fICHE(i)+0.58; fMVK(i)=fMVK(i)+0.23; fMVKHP(i)=fMVKHP(i)+0.19; fCO(i)=fCO(i)+0.42; % 

i=i+1;
Rnames{i}='HPALD4+OH=0.77ICHE+0.14MACR+0.09MCRHP+0.23CO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.50e-11, 390.0);
Gstr{i,1}='HPALD4'; Gstr{i,2}='OH'; % 
fHPALD4(i)=fHPALD4(i)-1; fICHE(i)=fICHE(i)+0.77; fMACR(i)=fMACR(i)+0.14; fMCRHP(i)=fMCRHP(i)+0.09; fCO(i)=fCO(i)+0.23; % 

i=i+1;
Rnames{i}='HC5A+OH=0.294IEPOXAOO+0.068IEPOXBOO+0.158MCRHP+0.355MGLY+0.125MVKHP+0.638CO+1.065OH+0.283HO2+0.355CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(4.64e-12, 650.0);
Gstr{i,1}='HC5A'; Gstr{i,2}='OH'; % 
fHC5A(i)=fHC5A(i)-1; fOH(i)=fOH(i)+0.065; fIEPOXAOO(i)=fIEPOXAOO(i)+0.294; fIEPOXBOO(i)=fIEPOXBOO(i)+0.068; fMCRHP(i)=fMCRHP(i)+0.158; fMGLY(i)=fMGLY(i)+0.355; fMVKHP(i)=fMVKHP(i)+0.125; fCO(i)=fCO(i)+0.638; fOH(i)=fOH(i)+0.065; fHO2(i)=fHO2(i)+0.283; fCO2(i)=fCO2(i)+0.355; % 

i=i+1;
Rnames{i}='ICHE+OH=0.5CH2O+0.5HAC+0.5MGLY+1.5CO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(9.85e-12, 410.0);
Gstr{i,1}='ICHE'; Gstr{i,2}='OH'; % 
fICHE(i)=fICHE(i)-1; fCH2O(i)=fCH2O(i)+0.5; fHAC(i)=fHAC(i)+0.5; fMGLY(i)=fMGLY(i)+0.5; fCO(i)=fCO(i)+1.5; % 

i=i+1;
Rnames{i}='IDC+OH=MVKPC+CO+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.00e-12, 650.0);
Gstr{i,1}='IDC'; Gstr{i,2}='OH'; % 
fIDC(i)=fIDC(i)-1; fOH(i)=fOH(i)-1; fMVKPC(i)=fMVKPC(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='RIPA+OH=0.345IHPOO1+0.655IHPOO3+0.005LVOC'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.47e-12, 390.0);
Gstr{i,1}='RIPA'; Gstr{i,2}='OH'; % 
fRIPA(i)=fRIPA(i)-1; fOH(i)=fOH(i)-1; fIHPOO1(i)=fIHPOO1(i)+0.345; fIHPOO3(i)=fIHPOO3(i)+0.655; fLVOC(i)=fLVOC(i)+0.005; % 

i=i+1;
Rnames{i}='RIPA+OH=0.67IEPOXA+0.33IEPOXB+0.005LVOC+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(1.62e-11, 3.90d2, 4.77e-21);
Gstr{i,1}='RIPA'; Gstr{i,2}='OH'; % 
fRIPA(i)=fRIPA(i)-1; fIEPOXA(i)=fIEPOXA(i)+0.67; fIEPOXB(i)=fIEPOXB(i)+0.33; fLVOC(i)=fLVOC(i)+0.005; % 

i=i+1;
Rnames{i}='RIPB+OH=0.345IHPOO2+0.655IHPOO3+0.005LVOC'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(4.35e-12, 390.0);
Gstr{i,1}='RIPB'; Gstr{i,2}='OH'; % 
fRIPB(i)=fRIPB(i)-1; fOH(i)=fOH(i)-1; fIHPOO2(i)=fIHPOO2(i)+0.345; fIHPOO3(i)=fIHPOO3(i)+0.655; fLVOC(i)=fLVOC(i)+0.005; % 

i=i+1;
Rnames{i}='RIPB+OH=0.68IEPOXA+0.32IEPOXB+0.005LVOC+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(2.85e-11, 390.0, 4.77e-21);
Gstr{i,1}='RIPB'; Gstr{i,2}='OH'; % 
fRIPB(i)=fRIPB(i)-1; fIEPOXA(i)=fIEPOXA(i)+0.68; fIEPOXB(i)=fIEPOXB(i)+0.32; fLVOC(i)=fLVOC(i)+0.005; % 

i=i+1;
Rnames{i}='RIPA+OH=0.75IHOO1+0.005LVOC+0.125MVK+0.125MVKHP+0.25CO+0.25HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(6.10e-12, 200.0);
Gstr{i,1}='RIPA'; Gstr{i,2}='OH'; % 
fRIPA(i)=fRIPA(i)-1; fOH(i)=fOH(i)-1; fIHOO1(i)=fIHOO1(i)+0.75; fLVOC(i)=fLVOC(i)+0.005; fMVK(i)=fMVK(i)+0.125; fMVKHP(i)=fMVKHP(i)+0.125; fCO(i)=fCO(i)+0.25; fHO2(i)=fHO2(i)+0.25; % 

i=i+1;
Rnames{i}='RIPB+OH=0.16ICHOO+0.51IHOO4+0.005LVOC+0.165MACR+0.165MCRHP+0.33CO+0.33HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(4.10e-12, 200.0);
Gstr{i,1}='RIPB'; Gstr{i,2}='OH'; % 
fRIPB(i)=fRIPB(i)-1; fOH(i)=fOH(i)-1; fICHOO(i)=fICHOO(i)+0.16; fIHOO4(i)=fIHOO4(i)+0.51; fLVOC(i)=fLVOC(i)+0.005; fMACR(i)=fMACR(i)+0.165; fMCRHP(i)=fMCRHP(i)+0.165; fCO(i)=fCO(i)+0.33; fHO2(i)=fHO2(i)+0.33; % 

i=i+1;
Rnames{i}='RIPC+OH=0.018CH2O+0.06HC5A+0.015HPALD1+0.009HPALD3+0.018HPETHNL+0.255IEPOXD+0.03IHOO1+0.595IHPOO1+0.005LVOC+0.018MCO3+0.018MGLY+0.036CO+0.405OH+0.024HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.53e-11, 390.0);
Gstr{i,1}='RIPC'; Gstr{i,2}='OH'; % 
fRIPC(i)=fRIPC(i)-1; fOH(i)=fOH(i)-0.595; fOH(i)=fOH(i)-0.595; fCH2O(i)=fCH2O(i)+0.018; fHC5A(i)=fHC5A(i)+0.06; fHPALD1(i)=fHPALD1(i)+0.015; fHPALD3(i)=fHPALD3(i)+0.009; fHPETHNL(i)=fHPETHNL(i)+0.018; fIEPOXD(i)=fIEPOXD(i)+0.255; fIHOO1(i)=fIHOO1(i)+0.03; fIHPOO1(i)=fIHPOO1(i)+0.595; fLVOC(i)=fLVOC(i)+0.005; fMCO3(i)=fMCO3(i)+0.018; fMGLY(i)=fMGLY(i)+0.018; fCO(i)=fCO(i)+0.036; fHO2(i)=fHO2(i)+0.024; % 

i=i+1;
Rnames{i}='RIPD+OH=0.018ATOOH+0.018CH2O+0.06HC5A+0.015HPALD2+0.009HPALD4+0.595IEPOXD+0.03IHOO4+0.255IHPOO2+0.005LVOC+0.018MGLY+0.054CO+0.745OH+0.042HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.53e-11, 390.0);
Gstr{i,1}='RIPD'; Gstr{i,2}='OH'; % 
fRIPD(i)=fRIPD(i)-1; fOH(i)=fOH(i)-0.255; fOH(i)=fOH(i)-0.255; fATOOH(i)=fATOOH(i)+0.018; fCH2O(i)=fCH2O(i)+0.018; fHC5A(i)=fHC5A(i)+0.06; fHPALD2(i)=fHPALD2(i)+0.015; fHPALD4(i)=fHPALD4(i)+0.009; fIEPOXD(i)=fIEPOXD(i)+0.595; fIHOO4(i)=fIHOO4(i)+0.03; fIHPOO2(i)=fIHPOO2(i)+0.255; fLVOC(i)=fLVOC(i)+0.005; fMGLY(i)=fMGLY(i)+0.018; fCO(i)=fCO(i)+0.054; fHO2(i)=fHO2(i)+0.042; % 

i=i+1;
Rnames{i}='IHPOO1=0.176ICPDH+0.824IDHPE+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.59e13, -10000.0);
Gstr{i,1}='IHPOO1'; % 
fIHPOO1(i)=fIHPOO1(i)-1; fICPDH(i)=fICPDH(i)+0.176; fIDHPE(i)=fIDHPE(i)+0.824; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IHPOO1+NO=0.716CH2O+0.284HAC+0.284HPETHNL+0.716MCRHP+NO2+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 2.1, 9.0, 1.0, 0.0);
Gstr{i,1}='IHPOO1'; Gstr{i,2}='NO'; % 
fIHPOO1(i)=fIHPOO1(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+0.716; fHAC(i)=fHAC(i)+0.284; fHPETHNL(i)=fHPETHNL(i)+0.284; fMCRHP(i)=fMCRHP(i)+0.716; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHPOO1+NO=ITHN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 2.1, 9.0, 1.0, 0.0);
Gstr{i,1}='IHPOO1'; Gstr{i,2}='NO'; % 
fIHPOO1(i)=fIHPOO1(i)-1; fNO(i)=fNO(i)-1; fITHN(i)=fITHN(i)+1; % 

i=i+1;
Rnames{i}='IHPOO1+HO2=0.14CH2O+0.135HAC+0.135HPETHNL+0.725IDHDP+0.14MCRHP+0.275OH+0.275HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.47e-13, 1300.0);
Gstr{i,1}='IHPOO1'; Gstr{i,2}='HO2'; % 
fIHPOO1(i)=fIHPOO1(i)-1; fHO2(i)=fHO2(i)-0.725; fHO2(i)=fHO2(i)-0.725; fCH2O(i)=fCH2O(i)+0.14; fHAC(i)=fHAC(i)+0.135; fHPETHNL(i)=fHPETHNL(i)+0.135; fIDHDP(i)=fIDHDP(i)+0.725; fMCRHP(i)=fMCRHP(i)+0.14; fOH(i)=fOH(i)+0.275; % 

i=i+1;
Rnames{i}='IHPOO2=0.548ICPDH+0.452IDHPE+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.91e13, -10000.0);
Gstr{i,1}='IHPOO2'; % 
fIHPOO2(i)=fIHPOO2(i)-1; fICPDH(i)=fICPDH(i)+0.548; fIDHPE(i)=fIDHPE(i)+0.452; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IHPOO2+NO=0.294ATOOH+0.706CH2O+0.294GLYC+0.706MVKHP+NO2+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 2.315, 9.0, 1.0, 0.0);
Gstr{i,1}='IHPOO2'; Gstr{i,2}='NO'; % 
fIHPOO2(i)=fIHPOO2(i)-1; fNO(i)=fNO(i)-1; fATOOH(i)=fATOOH(i)+0.294; fCH2O(i)=fCH2O(i)+0.706; fGLYC(i)=fGLYC(i)+0.294; fMVKHP(i)=fMVKHP(i)+0.706; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHPOO2+NO=ITHN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 2.315, 9.0, 1.0, 0.0);
Gstr{i,1}='IHPOO2'; Gstr{i,2}='NO'; % 
fIHPOO2(i)=fIHPOO2(i)-1; fNO(i)=fNO(i)-1; fITHN(i)=fITHN(i)+1; % 

i=i+1;
Rnames{i}='IHPOO2+HO2=0.135ATOOH+0.14CH2O+0.135GLYC+0.725IDHDP+0.14MVKHP+0.275OH+0.275HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.47e-13,  1300.0);
Gstr{i,1}='IHPOO2'; Gstr{i,2}='HO2'; % 
fIHPOO2(i)=fIHPOO2(i)-1; fHO2(i)=fHO2(i)-0.725; fHO2(i)=fHO2(i)-0.725; fATOOH(i)=fATOOH(i)+0.135; fCH2O(i)=fCH2O(i)+0.14; fGLYC(i)=fGLYC(i)+0.135; fIDHDP(i)=fIDHDP(i)+0.725; fMVKHP(i)=fMVKHP(i)+0.14; fOH(i)=fOH(i)+0.275; % 

i=i+1;
Rnames{i}='IHPOO3=IDHPE'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.875e13, -10000.0);
Gstr{i,1}='IHPOO3'; % 
fIHPOO3(i)=fIHPOO3(i)-1; fIDHPE(i)=fIDHPE(i)+1; % 

i=i+1;
Rnames{i}='IHPOO3+NO=GLYC+HAC+NO2+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 3.079, 9.0, 1.0, 0.0);
Gstr{i,1}='IHPOO3'; Gstr{i,2}='NO'; % 
fIHPOO3(i)=fIHPOO3(i)-1; fNO(i)=fNO(i)-1; fGLYC(i)=fGLYC(i)+1; fHAC(i)=fHAC(i)+1; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IHPOO3+NO=ITHN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 3.079, 9.0, 1.0, 0.0);
Gstr{i,1}='IHPOO3'; Gstr{i,2}='NO'; % 
fIHPOO3(i)=fIHPOO3(i)-1; fNO(i)=fNO(i)-1; fITHN(i)=fITHN(i)+1; % 

i=i+1;
Rnames{i}='IHPOO3+HO2=0.65GLYC+0.65HAC+0.35IDHDP+1.3OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.47e-13, 1300.0);
Gstr{i,1}='IHPOO3'; Gstr{i,2}='HO2'; % 
fIHPOO3(i)=fIHPOO3(i)-1; fHO2(i)=fHO2(i)-1; fGLYC(i)=fGLYC(i)+0.65; fHAC(i)=fHAC(i)+0.65; fIDHDP(i)=fIDHDP(i)+0.35; fOH(i)=fOH(i)+1.3; % 

i=i+1;
Rnames{i}='IEPOXD+OH=0.75ICHE+0.25ICHOO+0.75HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.22e-11, -400.0);
Gstr{i,1}='IEPOXD'; Gstr{i,2}='OH'; % 
fIEPOXD(i)=fIEPOXD(i)-1; fOH(i)=fOH(i)-1; fICHE(i)=fICHE(i)+0.75; fICHOO(i)=fICHOO(i)+0.25; fHO2(i)=fHO2(i)+0.75; % 

i=i+1;
Rnames{i}='IEPOXA+OH=ICHE+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.05e-11, -400.0);
Gstr{i,1}='IEPOXA'; Gstr{i,2}='OH'; % 
fIEPOXA(i)=fIEPOXA(i)-1; fOH(i)=fOH(i)-1; fICHE(i)=fICHE(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IEPOXA+OH=0.67IEPOXAOO+0.33IEPOXBOO'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(5.82e-11, -4.00d2, 1.14e-20);
Gstr{i,1}='IEPOXA'; Gstr{i,2}='OH'; % 
fIEPOXA(i)=fIEPOXA(i)-1; fOH(i)=fOH(i)-1; fIEPOXAOO(i)=fIEPOXAOO(i)+0.67; fIEPOXBOO(i)=fIEPOXBOO(i)+0.33; % 

i=i+1;
Rnames{i}='IEPOXB+OH=ICHE+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(8.25e-12, -400.0);
Gstr{i,1}='IEPOXB'; Gstr{i,2}='OH'; % 
fIEPOXB(i)=fIEPOXB(i)-1; fOH(i)=fOH(i)-1; fICHE(i)=fICHE(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IEPOXB+OH=0.81IEPOXAOO+0.19IEPOXBOO'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(3.75e-11, -4.00d2, 8.91e-21);
Gstr{i,1}='IEPOXB'; Gstr{i,2}='OH'; % 
fIEPOXB(i)=fIEPOXB(i)-1; fOH(i)=fOH(i)-1; fIEPOXAOO(i)=fIEPOXAOO(i)+0.81; fIEPOXBOO(i)=fIEPOXBOO(i)+0.19; % 

i=i+1;
Rnames{i}='IEPOXAOO=IDCHP+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.875e13, -10000.0);
Gstr{i,1}='IEPOXAOO'; % 
fIEPOXAOO(i)=fIEPOXAOO(i)-1; fIDCHP(i)=fIDCHP(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IEPOXAOO=MVKDH+CO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.0e7, -5000.0);
Gstr{i,1}='IEPOXAOO'; % 
fIEPOXAOO(i)=fIEPOXAOO(i)-1; fMVKDH(i)=fMVKDH(i)+1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IEPOXAOO+HO2=0.52GLYC+0.35ICPDH+0.52MGLY+0.13MVKDH+0.13CO+0.65OH+0.65HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.38e-13, 1300.0);
Gstr{i,1}='IEPOXAOO'; Gstr{i,2}='HO2'; % 
fIEPOXAOO(i)=fIEPOXAOO(i)-1; fHO2(i)=fHO2(i)-0.350; fHO2(i)=fHO2(i)-0.350; fGLYC(i)=fGLYC(i)+0.52; fICPDH(i)=fICPDH(i)+0.35; fMGLY(i)=fMGLY(i)+0.52; fMVKDH(i)=fMVKDH(i)+0.13; fCO(i)=fCO(i)+0.13; fOH(i)=fOH(i)+0.65; % 

i=i+1;
Rnames{i}='IEPOXAOO+NO=0.8GLYC+0.8MGLY+0.2MVKDH+NO2+0.2CO+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 13.098, 8.0, 1.0, 0.0);
Gstr{i,1}='IEPOXAOO'; Gstr{i,2}='NO'; % 
fIEPOXAOO(i)=fIEPOXAOO(i)-1; fNO(i)=fNO(i)-1; fGLYC(i)=fGLYC(i)+0.8; fMGLY(i)=fMGLY(i)+0.8; fMVKDH(i)=fMVKDH(i)+0.2; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.2; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IEPOXAOO+NO=ITCN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 13.098, 8.0, 1.0, 0.0);
Gstr{i,1}='IEPOXAOO'; Gstr{i,2}='NO'; % 
fIEPOXAOO(i)=fIEPOXAOO(i)-1; fNO(i)=fNO(i)-1; fITCN(i)=fITCN(i)+1; % 

i=i+1;
Rnames{i}='IEPOXBOO=IDCHP+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.875e13, -10000.0);
Gstr{i,1}='IEPOXBOO'; % 
fIEPOXBOO(i)=fIEPOXBOO(i)-1; fIDCHP(i)=fIDCHP(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IEPOXBOO=MCRDH+CO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.0e7, -5000.0);
Gstr{i,1}='IEPOXBOO'; % 
fIEPOXBOO(i)=fIEPOXBOO(i)-1; fMCRDH(i)=fMCRDH(i)+1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IEPOXBOO+NO=0.8GLYX+0.8HAC+0.2MCRDH+NO2+0.2CO+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 16.463, 8.0, 1.0, 0.0);
Gstr{i,1}='IEPOXBOO'; Gstr{i,2}='NO'; % 
fIEPOXBOO(i)=fIEPOXBOO(i)-1; fNO(i)=fNO(i)-1; fGLYX(i)=fGLYX(i)+0.8; fHAC(i)=fHAC(i)+0.8; fMCRDH(i)=fMCRDH(i)+0.2; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.2; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IEPOXBOO+NO=ITCN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 16.463, 8.0, 1.0, 0.0);
Gstr{i,1}='IEPOXBOO'; Gstr{i,2}='NO'; % 
fIEPOXBOO(i)=fIEPOXBOO(i)-1; fNO(i)=fNO(i)-1; fITCN(i)=fITCN(i)+1; % 

i=i+1;
Rnames{i}='IEPOXBOO+HO2=0.52GLYX+0.52HAC+0.35ICPDH+0.13MCRDH+0.13CO+0.65OH+0.65HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.38e-13, 1300.0);
Gstr{i,1}='IEPOXBOO'; Gstr{i,2}='HO2'; % 
fIEPOXBOO(i)=fIEPOXBOO(i)-1; fHO2(i)=fHO2(i)-0.350; fHO2(i)=fHO2(i)-0.350; fGLYX(i)=fGLYX(i)+0.52; fHAC(i)=fHAC(i)+0.52; fICPDH(i)=fICPDH(i)+0.35; fMCRDH(i)=fMCRDH(i)+0.13; fCO(i)=fCO(i)+0.13; fOH(i)=fOH(i)+0.65; % 

i=i+1;
Rnames{i}='ICHOO+HO2=0.65CH2O+0.52HAC+0.35ICPDH+0.13MVKHC+0.52CO+0.65OH+0.65HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.38e-13, 1300.0);
Gstr{i,1}='ICHOO'; Gstr{i,2}='HO2'; % 
fICHOO(i)=fICHOO(i)-1; fHO2(i)=fHO2(i)-0.350; fHO2(i)=fHO2(i)-0.350; fCH2O(i)=fCH2O(i)+0.65; fHAC(i)=fHAC(i)+0.52; fICPDH(i)=fICPDH(i)+0.35; fMVKHC(i)=fMVKHC(i)+0.13; fCO(i)=fCO(i)+0.52; fOH(i)=fOH(i)+0.65; % 

i=i+1;
Rnames{i}='ICHOO+NO=ITCN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 3.50d2, 13.098, 8.0, 1.0, 0.0);
Gstr{i,1}='ICHOO'; Gstr{i,2}='NO'; % 
fICHOO(i)=fICHOO(i)-1; fNO(i)=fNO(i)-1; fITCN(i)=fITCN(i)+1; % 

i=i+1;
Rnames{i}='ICHOO+NO=CH2O+0.8HAC+0.2MVKHC+NO2+0.8CO+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 3.50d2, 13.098, 8.0, 1.0, 0.0);
Gstr{i,1}='ICHOO'; Gstr{i,2}='NO'; % 
fICHOO(i)=fICHOO(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+1; fHAC(i)=fHAC(i)+0.8; fMVKHC(i)=fMVKHC(i)+0.2; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.8; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ICHOO=HAC+2.0CO+OH+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.875e13, -10000.0);
Gstr{i,1}='ICHOO'; % 
fICHOO(i)=fICHOO(i)-1; fHAC(i)=fHAC(i)+1; fCO(i)=fCO(i)+2.0; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='HPALD1OO+NO=MVK+NO2+OH+CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='HPALD1OO'; Gstr{i,2}='NO'; % 
fHPALD1OO(i)=fHPALD1OO(i)-1; fNO(i)=fNO(i)-1; fMVK(i)=fMVK(i)+1; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='HPALD1OO+HO2=MVK+2OH+CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.38e-13, 1300.0);
Gstr{i,1}='HPALD1OO'; Gstr{i,2}='HO2'; % 
fHPALD1OO(i)=fHPALD1OO(i)-1; fHO2(i)=fHO2(i)-1; fMVK(i)=fMVK(i)+1; fOH(i)=fOH(i)+2; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='HPALD2OO+NO=MACR+NO2+OH+CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='HPALD2OO'; Gstr{i,2}='NO'; % 
fHPALD2OO(i)=fHPALD2OO(i)-1; fNO(i)=fNO(i)-1; fMACR(i)=fMACR(i)+1; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='HPALD2OO+HO2=MACR+2OH+CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.38e-13, 1300.0);
Gstr{i,1}='HPALD2OO'; Gstr{i,2}='HO2'; % 
fHPALD2OO(i)=fHPALD2OO(i)-1; fHO2(i)=fHO2(i)-1; fMACR(i)=fMACR(i)+1; fOH(i)=fOH(i)+2; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='IHN2+OH=ISOPNOO1'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(7.14e-12, 390.0);
Gstr{i,1}='IHN2'; Gstr{i,2}='OH'; % 
fIHN2(i)=fIHN2(i)-1; fOH(i)=fOH(i)-1; fISOPNOO1(i)=fISOPNOO1(i)+1; % 

i=i+1;
Rnames{i}='IHN2+OH=0.67IEPOXA+0.33IEPOXB+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(6.30e-12, 390.0, 1.62e-19);
Gstr{i,1}='IHN2'; Gstr{i,2}='OH'; % 
fIHN2(i)=fIHN2(i)-1; fOH(i)=fOH(i)-1; fIEPOXA(i)=fIEPOXA(i)+0.67; fIEPOXB(i)=fIEPOXB(i)+0.33; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='IHN3+OH=ISOPNOO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.02e-11, 390.0);
Gstr{i,1}='IHN3'; Gstr{i,2}='OH'; % 
fIHN3(i)=fIHN3(i)-1; fOH(i)=fOH(i)-1; fISOPNOO2(i)=fISOPNOO2(i)+1; % 

i=i+1;
Rnames{i}='IHN3+OH=0.67IEPOXA+0.33IEPOXB+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(1.05e-11, 390.0, 2.49e-19);
Gstr{i,1}='IHN3'; Gstr{i,2}='OH'; % 
fIHN3(i)=fIHN3(i)-1; fOH(i)=fOH(i)-1; fIEPOXA(i)=fIEPOXA(i)+0.67; fIEPOXB(i)=fIEPOXB(i)+0.33; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='IHN1+OH=IEPOXD+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(1.55e-11, 390.0, 2.715e-19);
Gstr{i,1}='IHN1'; Gstr{i,2}='OH'; % 
fIHN1(i)=fIHN1(i)-1; fOH(i)=fOH(i)-1; fIEPOXD(i)=fIEPOXD(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='IHN1+OH=IDHNDOO1'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.04e-11, 390.0);
Gstr{i,1}='IHN1'; Gstr{i,2}='OH'; % 
fIHN1(i)=fIHN1(i)-1; fOH(i)=fOH(i)-1; fIDHNDOO1(i)=fIDHNDOO1(i)+1; % 

i=i+1;
Rnames{i}='IHN4+OH=IEPOXD+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(9.52e-12, 390.0, 2.715e-19);
Gstr{i,1}='IHN4'; Gstr{i,2}='OH'; % 
fIHN4(i)=fIHN4(i)-1; fOH(i)=fOH(i)-1; fIEPOXD(i)=fIEPOXD(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='IHN4+OH=IDHNDOO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.95e-11, 390.0);
Gstr{i,1}='IHN4'; Gstr{i,2}='OH'; % 
fIHN4(i)=fIHN4(i)-1; fOH(i)=fOH(i)-1; fIDHNDOO2(i)=fIDHNDOO2(i)+1; % 

i=i+1;
Rnames{i}='IHN1+OH=0.4ICN+0.6MCRHNB+0.6CO+0.6OH+0.4HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(7.5e-12, 20.0);
Gstr{i,1}='IHN1'; Gstr{i,2}='OH'; % 
fIHN1(i)=fIHN1(i)-1; fOH(i)=fOH(i)-0.400; fOH(i)=fOH(i)-0.400; fICN(i)=fICN(i)+0.4; fMCRHNB(i)=fMCRHNB(i)+0.6; fCO(i)=fCO(i)+0.6; fHO2(i)=fHO2(i)+0.4; % 

i=i+1;
Rnames{i}='IHN4+OH=0.4ICN+0.6MVKN+0.6CO+0.6OH+0.4HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(7.5e-12, 20.0);
Gstr{i,1}='IHN4'; Gstr{i,2}='OH'; % 
fIHN4(i)=fIHN4(i)-1; fOH(i)=fOH(i)-0.400; fOH(i)=fOH(i)-0.400; fICN(i)=fICN(i)+0.4; fMVKN(i)=fMVKN(i)+0.6; fCO(i)=fCO(i)+0.6; fHO2(i)=fHO2(i)+0.4; % 

i=i+1;
Rnames{i}='ISOPNOO1=ITCN+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.875e13, -10000.0);
Gstr{i,1}='ISOPNOO1'; % 
fISOPNOO1(i)=fISOPNOO1(i)-1; fITCN(i)=fITCN(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ISOPNOO1+HO2=0.059CH2O+0.459GLYC+0.459HAC+0.482ITHN+0.059MCRHN+0.459NO2+0.518OH+0.059HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.60e-13, 1300.0);
Gstr{i,1}='ISOPNOO1'; Gstr{i,2}='HO2'; % 
fISOPNOO1(i)=fISOPNOO1(i)-1; fHO2(i)=fHO2(i)-0.941; fHO2(i)=fHO2(i)-0.941; fCH2O(i)=fCH2O(i)+0.059; fGLYC(i)=fGLYC(i)+0.459; fHAC(i)=fHAC(i)+0.459; fITHN(i)=fITHN(i)+0.482; fMCRHN(i)=fMCRHN(i)+0.059; fNO2(i)=fNO2(i)+0.459; fOH(i)=fOH(i)+0.518; % 

i=i+1;
Rnames{i}='ISOPNOO1+NO=0.272CH2O+0.728GLYC+0.728HAC+0.272MCRHN+1.728NO2+0.272HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 6.32, 11.0, 1.0, 0.0);
Gstr{i,1}='ISOPNOO1'; Gstr{i,2}='NO'; % 
fISOPNOO1(i)=fISOPNOO1(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+0.272; fGLYC(i)=fGLYC(i)+0.728; fHAC(i)=fHAC(i)+0.728; fMCRHN(i)=fMCRHN(i)+0.272; fNO2(i)=fNO2(i)+1.728; fHO2(i)=fHO2(i)+0.272; % 

i=i+1;
Rnames{i}='ISOPNOO1+NO=IDN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 6.32, 11.0, 1.0, 0.0);
Gstr{i,1}='ISOPNOO1'; Gstr{i,2}='NO'; % 
fISOPNOO1(i)=fISOPNOO1(i)-1; fNO(i)=fNO(i)-1; fIDN(i)=fIDN(i)+1; % 

i=i+1;
Rnames{i}='ISOPNOO2=ITCN+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.875e13, -10000.0);
Gstr{i,1}='ISOPNOO2'; % 
fISOPNOO2(i)=fISOPNOO2(i)-1; fITCN(i)=fITCN(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ISOPNOO2+HO2=0.599CH2O+0.401ITHN+0.599MVKN+0.599OH+0.599HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.60e-13,  1300.0);
Gstr{i,1}='ISOPNOO2'; Gstr{i,2}='HO2'; % 
fISOPNOO2(i)=fISOPNOO2(i)-1; fHO2(i)=fHO2(i)-0.401; fHO2(i)=fHO2(i)-0.401; fCH2O(i)=fCH2O(i)+0.599; fITHN(i)=fITHN(i)+0.401; fMVKN(i)=fMVKN(i)+0.599; fOH(i)=fOH(i)+0.599; % 

i=i+1;
Rnames{i}='ISOPNOO2+NO=CH2O+MVKN+NO2+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 7.941, 11.0, 1.0, 0.0);
Gstr{i,1}='ISOPNOO2'; Gstr{i,2}='NO'; % 
fISOPNOO2(i)=fISOPNOO2(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+1; fMVKN(i)=fMVKN(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ISOPNOO2+NO=IDN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 7.941, 11.0, 1.0, 0.0);
Gstr{i,1}='ISOPNOO2'; Gstr{i,2}='NO'; % 
fISOPNOO2(i)=fISOPNOO2(i)-1; fNO(i)=fNO(i)-1; fIDN(i)=fIDN(i)+1; % 

i=i+1;
Rnames{i}='IDHNDOO1=ITCN+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.256e13, -10000.0);
Gstr{i,1}='IDHNDOO1'; % 
fIDHNDOO1(i)=fIDHNDOO1(i)-1; fITCN(i)=fITCN(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IDHNDOO2=ITCN+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(5.092e12, -10000.0);
Gstr{i,1}='IDHNDOO2'; % 
fIDHNDOO2(i)=fIDHNDOO2(i)-1; fITCN(i)=fITCN(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IDHNDOO1+HO2=0.031CH2O+0.551GLYC+0.418ITHN+0.031MCRHNB+0.551PROPNN+0.582OH+0.582HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.60e-13, 1300.0);
Gstr{i,1}='IDHNDOO1'; Gstr{i,2}='HO2'; % 
fIDHNDOO1(i)=fIDHNDOO1(i)-1; fHO2(i)=fHO2(i)-0.418; fHO2(i)=fHO2(i)-0.418; fCH2O(i)=fCH2O(i)+0.031; fGLYC(i)=fGLYC(i)+0.551; fITHN(i)=fITHN(i)+0.418; fMCRHNB(i)=fMCRHNB(i)+0.031; fPROPNN(i)=fPROPNN(i)+0.551; fOH(i)=fOH(i)+0.582; % 

i=i+1;
Rnames{i}='IDHNDOO1+NO=0.065CH2O+0.935GLYC+0.065MCRHNB+0.935PROPNN+NO2+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 4.712, 11.0, 1.0, 0.0);
Gstr{i,1}='IDHNDOO1'; Gstr{i,2}='NO'; % 
fIDHNDOO1(i)=fIDHNDOO1(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+0.065; fGLYC(i)=fGLYC(i)+0.935; fMCRHNB(i)=fMCRHNB(i)+0.065; fPROPNN(i)=fPROPNN(i)+0.935; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IDHNDOO1+NO=IDN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 4.712, 11.0, 1.0, 0.0);
Gstr{i,1}='IDHNDOO1'; Gstr{i,2}='NO'; % 
fIDHNDOO1(i)=fIDHNDOO1(i)-1; fNO(i)=fNO(i)-1; fIDN(i)=fIDN(i)+1; % 

i=i+1;
Rnames{i}='IDHNDOO2+HO2=0.065CH2O+0.441ETHLN+0.441HAC+0.494ITHN+0.065MVKN+0.506OH+0.506HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.60e-13, 1300.0);
Gstr{i,1}='IDHNDOO2'; Gstr{i,2}='HO2'; % 
fIDHNDOO2(i)=fIDHNDOO2(i)-1; fHO2(i)=fHO2(i)-0.494; fHO2(i)=fHO2(i)-0.494; fCH2O(i)=fCH2O(i)+0.065; fETHLN(i)=fETHLN(i)+0.441; fHAC(i)=fHAC(i)+0.441; fITHN(i)=fITHN(i)+0.494; fMVKN(i)=fMVKN(i)+0.065; fOH(i)=fOH(i)+0.506; % 

i=i+1;
Rnames{i}='IDHNDOO2+NO=0.142CH2O+0.858ETHLN+0.858HAC+0.142MVKN+NO2+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 2.258, 11.0, 1.0, 0.0);
Gstr{i,1}='IDHNDOO2'; Gstr{i,2}='NO'; % 
fIDHNDOO2(i)=fIDHNDOO2(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+0.142; fETHLN(i)=fETHLN(i)+0.858; fHAC(i)=fHAC(i)+0.858; fMVKN(i)=fMVKN(i)+0.142; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IDHNDOO2+NO=IDN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 2.258, 11.0, 1.0, 0.0);
Gstr{i,1}='IDHNDOO2'; Gstr{i,2}='NO'; % 
fIDHNDOO2(i)=fIDHNDOO2(i)-1; fNO(i)=fNO(i)-1; fIDN(i)=fIDN(i)+1; % 

i=i+1;
Rnames{i}='IDHNBOO+HO2=0.104CH2O+0.033ETHLN+0.242GLYC+0.033HAC+0.621ITHN+0.094MCRHNB+0.01MVKN+0.242PROPNN+0.379OH+0.379HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.60e-13, 1300.0);
Gstr{i,1}='IDHNBOO'; Gstr{i,2}='HO2'; % 
fIDHNBOO(i)=fIDHNBOO(i)-1; fHO2(i)=fHO2(i)-0.621; fHO2(i)=fHO2(i)-0.621; fCH2O(i)=fCH2O(i)+0.104; fETHLN(i)=fETHLN(i)+0.033; fGLYC(i)=fGLYC(i)+0.242; fHAC(i)=fHAC(i)+0.033; fITHN(i)=fITHN(i)+0.621; fMCRHNB(i)=fMCRHNB(i)+0.094; fMVKN(i)=fMVKN(i)+0.01; fPROPNN(i)=fPROPNN(i)+0.242; fOH(i)=fOH(i)+0.379; % 

i=i+1;
Rnames{i}='IDHNBOO+NO=0.383CH2O+0.071ETHLN+0.546GLYC+0.071HAC+0.355MCRHNB+0.028MVKN+0.546PROPNN+NO2+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 1.851, 11.0, 1.0, 0.0);
Gstr{i,1}='IDHNBOO'; Gstr{i,2}='NO'; % 
fIDHNBOO(i)=fIDHNBOO(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+0.383; fETHLN(i)=fETHLN(i)+0.071; fGLYC(i)=fGLYC(i)+0.546; fHAC(i)=fHAC(i)+0.071; fMCRHNB(i)=fMCRHNB(i)+0.355; fMVKN(i)=fMVKN(i)+0.028; fPROPNN(i)=fPROPNN(i)+0.546; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IDHNBOO+NO=IDN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 1.851, 11.0, 1.0, 0.0);
Gstr{i,1}='IDHNBOO'; Gstr{i,2}='NO'; % 
fIDHNBOO(i)=fIDHNBOO(i)-1; fNO(i)=fNO(i)-1; fIDN(i)=fIDN(i)+1; % 

i=i+1;
Rnames{i}='ISOP+NO3=0.465INO2B+0.535INO2D+LISOPNO3'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.95e-12, 450.0);
Gstr{i,1}='ISOP'; Gstr{i,2}='NO3'; % 
fISOP(i)=fISOP(i)-1; fNO3(i)=fNO3(i)-1; fINO2B(i)=fINO2B(i)+0.465; fINO2D(i)=fINO2D(i)+0.535; fLISOPNO3(i)=fLISOPNO3(i)+1; % 

i=i+1;
Rnames{i}='INO2B+HO2=0.527CH2O+0.473INPB+0.048MACR+0.479MVK+0.527NO2+0.527OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.47e-13, 1300.0);
Gstr{i,1}='INO2B'; Gstr{i,2}='HO2'; % 
fINO2B(i)=fINO2B(i)-1; fHO2(i)=fHO2(i)-1; fCH2O(i)=fCH2O(i)+0.527; fINPB(i)=fINPB(i)+0.473; fMACR(i)=fMACR(i)+0.048; fMVK(i)=fMVK(i)+0.479; fNO2(i)=fNO2(i)+0.527; fOH(i)=fOH(i)+0.527; % 

i=i+1;
Rnames{i}='INO2D+HO2=INPD'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.47e-13, 1300.0);
Gstr{i,1}='INO2D'; Gstr{i,2}='HO2'; % 
fINO2D(i)=fINO2D(i)-1; fHO2(i)=fHO2(i)-1; fINPD(i)=fINPD(i)+1; % 

i=i+1;
Rnames{i}='INO2B+INO2B=1.86CH2O+0.07ICN+0.07INPB+0.123MACR+1.737MVK+1.86NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 1.61e-12;
Gstr{i,1}='INO2B'; Gstr{i,2}='INO2B'; % 
fINO2B(i)=fINO2B(i)-2; fCH2O(i)=fCH2O(i)+1.86; fICN(i)=fICN(i)+0.07; fINPB(i)=fINPB(i)+0.07; fMACR(i)=fMACR(i)+0.123; fMVK(i)=fMVK(i)+1.737; fNO2(i)=fNO2(i)+1.86; % 

i=i+1;
Rnames{i}='INO2B+INO2D=0.563CH2O+0.532ICN+0.032IHN1+0.474INA+0.399INPB+0.019MACR+0.544MVK+0.563NO2+0.089HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 2.56e-12;
Gstr{i,1}='INO2B'; Gstr{i,2}='INO2D'; % 
fINO2B(i)=fINO2B(i)-1; fINO2D(i)=fINO2D(i)-1; fCH2O(i)=fCH2O(i)+0.563; fICN(i)=fICN(i)+0.532; fIHN1(i)=fIHN1(i)+0.032; fINA(i)=fINA(i)+0.474; fINPB(i)=fINPB(i)+0.399; fMACR(i)=fMACR(i)+0.019; fMVK(i)=fMVK(i)+0.544; fNO2(i)=fNO2(i)+0.563; fHO2(i)=fHO2(i)+0.089; % 

i=i+1;
Rnames{i}='INO2D+INO2D=0.861ICN+0.671IHN1+0.127IHN4+0.34INA+0.064HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 3.71e-12;
Gstr{i,1}='INO2D'; Gstr{i,2}='INO2D'; % 
fINO2D(i)=fINO2D(i)-2; fICN(i)=fICN(i)+0.861; fIHN1(i)=fIHN1(i)+0.671; fIHN4(i)=fIHN4(i)+0.127; fINA(i)=fINA(i)+0.34; fHO2(i)=fHO2(i)+0.064; % 

i=i+1;
Rnames{i}='INO2D+MO2=0.645CH2O+0.401ICN+0.298IHN1+0.057IHN4+0.244INA+0.355MOH+0.336HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 1.18e-12;
Gstr{i,1}='INO2D'; Gstr{i,2}='MO2'; % 
fINO2D(i)=fINO2D(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+0.645; fICN(i)=fICN(i)+0.401; fIHN1(i)=fIHN1(i)+0.298; fIHN4(i)=fIHN4(i)+0.057; fINA(i)=fINA(i)+0.244; fMOH(i)=fMOH(i)+0.355; fHO2(i)=fHO2(i)+0.336; % 

i=i+1;
Rnames{i}='INO2B+MO2=1.577CH2O+0.034ICN+0.355INPB+0.028MACR+0.034MOH+0.583MVK+0.611NO2+0.611HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 2.80e-13;
Gstr{i,1}='INO2B'; Gstr{i,2}='MO2'; % 
fINO2B(i)=fINO2B(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+1.577; fICN(i)=fICN(i)+0.034; fINPB(i)=fINPB(i)+0.355; fMACR(i)=fMACR(i)+0.028; fMOH(i)=fMOH(i)+0.034; fMVK(i)=fMVK(i)+0.583; fNO2(i)=fNO2(i)+0.611; fHO2(i)=fHO2(i)+0.611; % 

i=i+1;
Rnames{i}='INO2B+MCO3=CH2O+0.097MACR+MO2+0.903MVK+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 1.92e-12;
Gstr{i,1}='INO2B'; Gstr{i,2}='MCO3'; % 
fINO2B(i)=fINO2B(i)-1; fMCO3(i)=fMCO3(i)-1; fCH2O(i)=fCH2O(i)+1; fMACR(i)=fMACR(i)+0.097; fMO2(i)=fMO2(i)+1; fMVK(i)=fMVK(i)+0.903; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='INO2D+MCO3=0.159ICN+0.841INA+MO2+0.159HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 7.71e-12;
Gstr{i,1}='INO2D'; Gstr{i,2}='MCO3'; % 
fINO2D(i)=fINO2D(i)-1; fMCO3(i)=fMCO3(i)-1; fICN(i)=fICN(i)+0.159; fINA(i)=fINA(i)+0.841; fMO2(i)=fMO2(i)+1; fHO2(i)=fHO2(i)+0.159; % 

i=i+1;
Rnames{i}='INO2B+NO3=CH2O+0.097MACR+0.903MVK+2.0NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 2.3e-12;
Gstr{i,1}='INO2B'; Gstr{i,2}='NO3'; % 
fINO2B(i)=fINO2B(i)-1; fNO3(i)=fNO3(i)-1; fCH2O(i)=fCH2O(i)+1; fMACR(i)=fMACR(i)+0.097; fMVK(i)=fMVK(i)+0.903; fNO2(i)=fNO2(i)+2.0; % 

i=i+1;
Rnames{i}='INO2D+NO3=0.159ICN+0.841INA+NO2+0.159HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 2.3e-12;
Gstr{i,1}='INO2D'; Gstr{i,2}='NO3'; % 
fINO2D(i)=fINO2D(i)-1; fNO3(i)=fNO3(i)-1; fICN(i)=fICN(i)+0.159; fINA(i)=fINA(i)+0.841; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+0.159; % 

i=i+1;
Rnames{i}='INO2B+NO=CH2O+0.096MACR+0.904MVK+2.0NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 12.915, 9.0, 1.0, 0.0);
Gstr{i,1}='INO2B'; Gstr{i,2}='NO'; % 
fINO2B(i)=fINO2B(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+1; fMACR(i)=fMACR(i)+0.096; fMVK(i)=fMVK(i)+0.904; fNO2(i)=fNO2(i)+2.0; % 

i=i+1;
Rnames{i}='INO2B+NO=IDN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 12.915, 9.0, 1.0, 0.0);
Gstr{i,1}='INO2B'; Gstr{i,2}='NO'; % 
fINO2B(i)=fINO2B(i)-1; fNO(i)=fNO(i)-1; fIDN(i)=fIDN(i)+1; % 

i=i+1;
Rnames{i}='INO2D+NO=0.159ICN+0.841INA+NO2+0.159HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 1.412, 9.0, 1.0, 0.0);
Gstr{i,1}='INO2D'; Gstr{i,2}='NO'; % 
fINO2D(i)=fINO2D(i)-1; fNO(i)=fNO(i)-1; fICN(i)=fICN(i)+0.159; fINA(i)=fINA(i)+0.841; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+0.159; % 

i=i+1;
Rnames{i}='INO2D+NO=IDN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 1.412, 9.0, 1.0, 0.0);
Gstr{i,1}='INO2D'; Gstr{i,2}='NO'; % 
fINO2D(i)=fINO2D(i)-1; fNO(i)=fNO(i)-1; fIDN(i)=fIDN(i)+1; % 

i=i+1;
Rnames{i}='INA+O2=ICN+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.50e-14, -300.0);
Gstr{i,1}='INA'; Gstr{i,2}='O2'; % 
fINA(i)=fINA(i)-1; fO2(i)=fO2(i)-1; fICN(i)=fICN(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='INA=IDHNBOO'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.00e20, -10000.0);
Gstr{i,1}='INA'; % 
fINA(i)=fINA(i)-1; fIDHNBOO(i)=fIDHNBOO(i)+1; % 

i=i+1;
Rnames{i}='INPB+OH=0.33IDHNBOO+0.67IHPNBOO'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(5.88e-12, 390.0);
Gstr{i,1}='INPB'; Gstr{i,2}='OH'; % 
fINPB(i)=fINPB(i)-1; fOH(i)=fOH(i)-1; fIDHNBOO(i)=fIDHNBOO(i)+0.33; fIHPNBOO(i)=fIHPNBOO(i)+0.67; % 

i=i+1;
Rnames{i}='INPD+OH=IHPNDOO'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.61e-11, 390.0);
Gstr{i,1}='INPD'; Gstr{i,2}='OH'; % 
fINPD(i)=fINPD(i)-1; fOH(i)=fOH(i)-1; fIHPNDOO(i)=fIHPNDOO(i)+1; % 

i=i+1;
Rnames{i}='INPB+OH=ITHN+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(4.471e-12, 390.0, 2.28e-20);
Gstr{i,1}='INPB'; Gstr{i,2}='OH'; % 
fINPB(i)=fINPB(i)-1; fITHN(i)=fITHN(i)+1; % 

i=i+1;
Rnames{i}='INPD+OH=ITHN+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(8.77e-12,  390.0, 2.185e-20);
Gstr{i,1}='INPD'; Gstr{i,2}='OH'; % 
fINPD(i)=fINPD(i)-1; fITHN(i)=fITHN(i)+1; % 

i=i+1;
Rnames{i}='INPD+OH=ICHE+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(1.493e-11, 390.0, 2.715e-19);
Gstr{i,1}='INPD'; Gstr{i,2}='OH'; % 
fINPD(i)=fINPD(i)-1; fOH(i)=fOH(i)-1; fICHE(i)=fICHE(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='INPB+OH=INO2B'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.278e-12, 200.0);
Gstr{i,1}='INPB'; Gstr{i,2}='OH'; % 
fINPB(i)=fINPB(i)-1; fOH(i)=fOH(i)-1; fINO2B(i)=fINO2B(i)+1; % 

i=i+1;
Rnames{i}='INPD+OH=INO2D'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.40e-12, 200.0);
Gstr{i,1}='INPD'; Gstr{i,2}='OH'; % 
fINPD(i)=fINPD(i)-1; fOH(i)=fOH(i)-1; fINO2D(i)=fINO2D(i)+1; % 

i=i+1;
Rnames{i}='INPD+OH=ICN+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(7.50e-12, 20.0);
Gstr{i,1}='INPD'; Gstr{i,2}='OH'; % 
fINPD(i)=fINPD(i)-1; fICN(i)=fICN(i)+1; % 

i=i+1;
Rnames{i}='IHPNDOO=ITCN+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(6.55e12, -10000.0);
Gstr{i,1}='IHPNDOO'; % 
fIHPNDOO(i)=fIHPNDOO(i)-1; fITCN(i)=fITCN(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IHPNBOO=0.5ITCN+0.5ITHN+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(8.72e12, -10000.0);
Gstr{i,1}='IHPNBOO'; % 
fIHPNBOO(i)=fIHPNBOO(i)-1; fITCN(i)=fITCN(i)+0.5; fITHN(i)=fITHN(i)+0.5; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IHPNBOO+HO2=0.009ATOOH+0.126CH2O+0.051ETHLN+0.34GLYC+0.042HAC+0.249HPETHNL+0.234ITHN+0.06MCRHNB+0.004MCRHP+0.054MVKHP+0.008MVKN+0.589PROPNN+0.058NO2+1.147OH+0.326HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.64e-13, 1300.0);
Gstr{i,1}='IHPNBOO'; Gstr{i,2}='HO2'; % 
fIHPNBOO(i)=fIHPNBOO(i)-1; fHO2(i)=fHO2(i)-0.674; fHO2(i)=fHO2(i)-0.674; fATOOH(i)=fATOOH(i)+0.009; fCH2O(i)=fCH2O(i)+0.126; fETHLN(i)=fETHLN(i)+0.051; fGLYC(i)=fGLYC(i)+0.34; fHAC(i)=fHAC(i)+0.042; fHPETHNL(i)=fHPETHNL(i)+0.249; fITHN(i)=fITHN(i)+0.234; fMCRHNB(i)=fMCRHNB(i)+0.06; fMCRHP(i)=fMCRHP(i)+0.004; fMVKHP(i)=fMVKHP(i)+0.054; fMVKN(i)=fMVKN(i)+0.008; fPROPNN(i)=fPROPNN(i)+0.589; fNO2(i)=fNO2(i)+0.058; fOH(i)=fOH(i)+1.147; % 

i=i+1;
Rnames{i}='IHPNDOO+HO2=0.054ATOOH+0.088CH2O+0.054ETHLN+0.471HPETHNL+0.387ITHN+0.073MCRHNB+0.015MVKN+0.471PROPNN+0.646OH+0.58HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.64e-13, 1300.0);
Gstr{i,1}='IHPNDOO'; Gstr{i,2}='HO2'; % 
fIHPNDOO(i)=fIHPNDOO(i)-1; fHO2(i)=fHO2(i)-0.420; fHO2(i)=fHO2(i)-0.420; fATOOH(i)=fATOOH(i)+0.054; fCH2O(i)=fCH2O(i)+0.088; fETHLN(i)=fETHLN(i)+0.054; fHPETHNL(i)=fHPETHNL(i)+0.471; fITHN(i)=fITHN(i)+0.387; fMCRHNB(i)=fMCRHNB(i)+0.073; fMVKN(i)=fMVKN(i)+0.015; fPROPNN(i)=fPROPNN(i)+0.471; fOH(i)=fOH(i)+0.646; % 

i=i+1;
Rnames{i}='IHPNBOO+NO=0.013ATOOH+0.249CH2O+0.064ETHLN+0.384GLYC+0.051HAC+0.303HPETHNL+0.17MCRHNB+0.006MCRHP+0.059MVKHP+0.014MVKN+0.687PROPNN+1.065NO2+0.435OH+0.5HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 6.092, 12.0, 1.0, 0.0);
Gstr{i,1}='IHPNBOO'; Gstr{i,2}='NO'; % 
fIHPNBOO(i)=fIHPNBOO(i)-1; fNO(i)=fNO(i)-1; fATOOH(i)=fATOOH(i)+0.013; fCH2O(i)=fCH2O(i)+0.249; fETHLN(i)=fETHLN(i)+0.064; fGLYC(i)=fGLYC(i)+0.384; fHAC(i)=fHAC(i)+0.051; fHPETHNL(i)=fHPETHNL(i)+0.303; fMCRHNB(i)=fMCRHNB(i)+0.17; fMCRHP(i)=fMCRHP(i)+0.006; fMVKHP(i)=fMVKHP(i)+0.059; fMVKN(i)=fMVKN(i)+0.014; fPROPNN(i)=fPROPNN(i)+0.687; fNO2(i)=fNO2(i)+1.065; fOH(i)=fOH(i)+0.435; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='IHPNBOO+NO=IDN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 6.092, 12.0, 1.0, 0.0);
Gstr{i,1}='IHPNBOO'; Gstr{i,2}='NO'; % 
fIHPNBOO(i)=fIHPNBOO(i)-1; fNO(i)=fNO(i)-1; fIDN(i)=fIDN(i)+1; % 

i=i+1;
Rnames{i}='IHPNDOO+NO=0.07ATOOH+0.34CH2O+0.07ETHLN+0.59HPETHNL+0.291MCRHNB+0.049MVKN+0.59PROPNN+NO2+0.096OH+0.904HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 4.383, 12.0, 1.0, 0.0);
Gstr{i,1}='IHPNDOO'; Gstr{i,2}='NO'; % 
fIHPNDOO(i)=fIHPNDOO(i)-1; fNO(i)=fNO(i)-1; fATOOH(i)=fATOOH(i)+0.07; fCH2O(i)=fCH2O(i)+0.34; fETHLN(i)=fETHLN(i)+0.07; fHPETHNL(i)=fHPETHNL(i)+0.59; fMCRHNB(i)=fMCRHNB(i)+0.291; fMVKN(i)=fMVKN(i)+0.049; fPROPNN(i)=fPROPNN(i)+0.59; fNO2(i)=fNO2(i)+1.0; fOH(i)=fOH(i)+0.096; fHO2(i)=fHO2(i)+0.904; % 

i=i+1;
Rnames{i}='IHPNDOO+NO=IDN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 4.383, 12.0, 1.0, 0.0);
Gstr{i,1}='IHPNDOO'; Gstr{i,2}='NO'; % 
fIHPNDOO(i)=fIHPNDOO(i)-1; fNO(i)=fNO(i)-1; fIDN(i)=fIDN(i)+1; % 

i=i+1;
Rnames{i}='ICN+OH=ICHE+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_EPO_a(2.97e-12, 390.0, 2.715e-19);
Gstr{i,1}='ICN'; Gstr{i,2}='OH'; % 
fICN(i)=fICN(i)-1; fOH(i)=fOH(i)-1; fICHE(i)=fICHE(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='ICN+OH=0.461ICNOO+0.378MCRHNB+0.161MVKN+0.539CO+0.244OH+0.295HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(9.35e-12, 390.0);
Gstr{i,1}='ICN'; Gstr{i,2}='OH'; % 
fICN(i)=fICN(i)-1; fOH(i)=fOH(i)-0.756; fOH(i)=fOH(i)-0.756; fICNOO(i)=fICNOO(i)+0.461; fMCRHNB(i)=fMCRHNB(i)+0.378; fMVKN(i)=fMVKN(i)+0.161; fCO(i)=fCO(i)+0.539; fHO2(i)=fHO2(i)+0.295; % 

i=i+1;
Rnames{i}='ICNOO+NO=0.099ETHLN+0.67ICNOO+0.231PROPNN+NO2+0.33CO+0.33HO2+0.33CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='ICNOO'; Gstr{i,2}='NO'; % 
fICNOO(i)=fICNOO(i)-0.330; fNO(i)=fNO(i)-1; fICNOO(i)=fICNOO(i)-0.330; fETHLN(i)=fETHLN(i)+0.099; fPROPNN(i)=fPROPNN(i)+0.231; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.33; fHO2(i)=fHO2(i)+0.33; fCO2(i)=fCO2(i)+0.33; % 

i=i+1;
Rnames{i}='ICNOO+HO2=0.099ETHLN+0.67ICNOO+0.231PROPNN+0.33CO+OH+0.33HO2+0.33CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.54e-13, 1300.0);
Gstr{i,1}='ICNOO'; Gstr{i,2}='HO2'; % 
fICNOO(i)=fICNOO(i)-0.330; fHO2(i)=fHO2(i)-0.670; fICNOO(i)=fICNOO(i)-0.330; fHO2(i)=fHO2(i)-0.670; fETHLN(i)=fETHLN(i)+0.099; fPROPNN(i)=fPROPNN(i)+0.231; fCO(i)=fCO(i)+0.33; fOH(i)=fOH(i)+1; fCO2(i)=fCO2(i)+0.33; % 

i=i+1;
Rnames{i}='IDN+OH=0.435IDNOO+0.565ITHN+0.565NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.00e-11, 0.0);
Gstr{i,1}='IDN'; Gstr{i,2}='OH'; % 
fIDN(i)=fIDN(i)-1; fOH(i)=fOH(i)-1; fIDNOO(i)=fIDNOO(i)+0.435; fITHN(i)=fITHN(i)+0.565; fNO2(i)=fNO2(i)+0.565; % 

i=i+1;
Rnames{i}='IDNOO+NO=0.89ETHLN+0.11GLYC+PROPNN+1.11NO2+0.89HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='IDNOO'; Gstr{i,2}='NO'; % 
fIDNOO(i)=fIDNOO(i)-1; fNO(i)=fNO(i)-1; fETHLN(i)=fETHLN(i)+0.89; fGLYC(i)=fGLYC(i)+0.11; fPROPNN(i)=fPROPNN(i)+1; fNO2(i)=fNO2(i)+1.11; fHO2(i)=fHO2(i)+0.89; % 

i=i+1;
Rnames{i}='IDNOO+HO2=0.73ETHLN+0.09GLYC+0.18IDN+0.82PROPNN+0.09NO2+0.82OH+0.73HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.71e-13, 1300.0);
Gstr{i,1}='IDNOO'; Gstr{i,2}='HO2'; % 
fIDNOO(i)=fIDNOO(i)-1; fHO2(i)=fHO2(i)-0.270; fHO2(i)=fHO2(i)-0.270; fETHLN(i)=fETHLN(i)+0.73; fGLYC(i)=fGLYC(i)+0.09; fIDN(i)=fIDN(i)+0.18; fPROPNN(i)=fPROPNN(i)+0.82; fNO2(i)=fNO2(i)+0.09; fOH(i)=fOH(i)+0.82; % 

i=i+1;
Rnames{i}='MVK+OH=MVKOHOO'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.60e-12, 610.0);
Gstr{i,1}='MVK'; Gstr{i,2}='OH'; % 
fMVK(i)=fMVK(i)-1; fOH(i)=fOH(i)-1; fMVKOHOO(i)=fMVKOHOO(i)+1; % 

i=i+1;
Rnames{i}='MVK+O3=0.6CH2O+0.5CH2OO+0.045H2O2+0.38MCO3+0.545MGLY+0.075PYAC+0.18CO+0.08OH+0.1HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(8.50e-16, -1520.0);
Gstr{i,1}='MVK'; Gstr{i,2}='O3'; % 
fMVK(i)=fMVK(i)-1; fO3(i)=fO3(i)-1; fCH2O(i)=fCH2O(i)+0.6; fCH2OO(i)=fCH2OO(i)+0.5; fH2O2(i)=fH2O2(i)+0.045; fMCO3(i)=fMCO3(i)+0.38; fMGLY(i)=fMGLY(i)+0.545; fPYAC(i)=fPYAC(i)+0.075; fCO(i)=fCO(i)+0.18; fOH(i)=fOH(i)+0.08; fHO2(i)=fHO2(i)+0.1; % 

i=i+1;
Rnames{i}='MACR+OH=0.036ATOOH+0.964MCROHOO+0.036CO+0.036HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(4.40e-12, 380.0);
Gstr{i,1}='MACR'; Gstr{i,2}='OH'; % 
fMACR(i)=fMACR(i)-1; fOH(i)=fOH(i)-1; fATOOH(i)=fATOOH(i)+0.036; fMCROHOO(i)=fMCROHOO(i)+0.964; fCO(i)=fCO(i)+0.036; fHO2(i)=fHO2(i)+0.036; % 

i=i+1;
Rnames{i}='MACR+OH=MACR1OO'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.70e-12, 470.0);
Gstr{i,1}='MACR'; Gstr{i,2}='OH'; % 
fMACR(i)=fMACR(i)-1; fOH(i)=fOH(i)-1; fMACR1OO(i)=fMACR1OO(i)+1; % 

i=i+1;
Rnames{i}='MACR+O3=0.12CH2O+0.88CH2OO+0.12MCO3+0.88MGLY+0.12CO+0.12OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.40e-15, -2100.0);
Gstr{i,1}='MACR'; Gstr{i,2}='O3'; % 
fMACR(i)=fMACR(i)-1; fO3(i)=fO3(i)-1; fCH2O(i)=fCH2O(i)+0.12; fCH2OO(i)=fCH2OO(i)+0.88; fMCO3(i)=fMCO3(i)+0.12; fMGLY(i)=fMGLY(i)+0.88; fCO(i)=fCO(i)+0.12; fOH(i)=fOH(i)+0.12; % 

i=i+1;
Rnames{i}='MACR+NO3=0.32HNO3+0.32MACR1OO+0.68PROPNN+0.68CO+0.68OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.80e-13, -1190.0);
Gstr{i,1}='MACR'; Gstr{i,2}='NO3'; % 
fMACR(i)=fMACR(i)-1; fNO3(i)=fNO3(i)-1; fHNO3(i)=fHNO3(i)+0.32; fMACR1OO(i)=fMACR1OO(i)+0.32; fPROPNN(i)=fPROPNN(i)+0.68; fCO(i)=fCO(i)+0.68; fOH(i)=fOH(i)+0.68; % 

i=i+1;
Rnames{i}='MVKN+OH=0.241CH2O+0.449HCOOH+0.04MCO3+0.449MGLY+0.29MVKHCB+0.241PYAC+0.31NO2+0.69NO3+0.02OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.24e-12, 380.0);
Gstr{i,1}='MVKN'; Gstr{i,2}='OH'; % 
fMVKN(i)=fMVKN(i)-1; fOH(i)=fOH(i)-0.980; fOH(i)=fOH(i)-0.980; fCH2O(i)=fCH2O(i)+0.241; fHCOOH(i)=fHCOOH(i)+0.449; fMCO3(i)=fMCO3(i)+0.04; fMGLY(i)=fMGLY(i)+0.449; fMVKHCB(i)=fMVKHCB(i)+0.29; fPYAC(i)=fPYAC(i)+0.241; fNO2(i)=fNO2(i)+0.31; fNO3(i)=fNO3(i)+0.69; % 

i=i+1;
Rnames{i}='MVKHP+OH=0.53MVKHC+0.47MVKHCB+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = 5.77e-11;
Gstr{i,1}='MVKHP'; Gstr{i,2}='OH'; % 
fMVKHP(i)=fMVKHP(i)-1; fMVKHC(i)=fMVKHC(i)+0.53; fMVKHCB(i)=fMVKHCB(i)+0.47; % 

i=i+1;
Rnames{i}='MCRHP+OH=0.23ATOOH+0.77HAC+0.77CO+OH+0.23CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.70e-12, 470.0);
Gstr{i,1}='MCRHP'; Gstr{i,2}='OH'; % 
fMCRHP(i)=fMCRHP(i)-1; fATOOH(i)=fATOOH(i)+0.23; fHAC(i)=fHAC(i)+0.77; fCO(i)=fCO(i)+0.77; fCO2(i)=fCO2(i)+0.23; % 

i=i+1;
Rnames{i}='MCRHN+OH=MACRNO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.39e-11, 380.0);
Gstr{i,1}='MCRHN'; Gstr{i,2}='OH'; % 
fMCRHN(i)=fMCRHN(i)-1; fOH(i)=fOH(i)-1; fMACRNO2(i)=fMACRNO2(i)+1; % 

i=i+1;
Rnames{i}='MCRHNB+OH=PROPNN+0.25CO+OH+0.75CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.70e-12, 470.0);
Gstr{i,1}='MCRHNB'; Gstr{i,2}='OH'; % 
fMCRHNB(i)=fMCRHNB(i)-1; fPROPNN(i)=fPROPNN(i)+1; fCO(i)=fCO(i)+0.25; fCO2(i)=fCO2(i)+0.75; % 

i=i+1;
Rnames{i}='C4HVP1+NO=MVKOHOO+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='C4HVP1'; Gstr{i,2}='NO'; % 
fC4HVP1(i)=fC4HVP1(i)-1; fNO(i)=fNO(i)-1; fMVKOHOO(i)=fMVKOHOO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='C4HVP1+HO2=MVKOHOO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.93e-13, 1300.0);
Gstr{i,1}='C4HVP1'; Gstr{i,2}='HO2'; % 
fC4HVP1(i)=fC4HVP1(i)-1; fHO2(i)=fHO2(i)-1; fMVKOHOO(i)=fMVKOHOO(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='C4HVP1+NO2=MVKN'; % 2019/11/06, Bates2019, KHB
k(:,i) = 9.00e-12;
Gstr{i,1}='C4HVP1'; Gstr{i,2}='NO2'; % 
fC4HVP1(i)=fC4HVP1(i)-1; fNO2(i)=fNO2(i)-1; fMVKN(i)=fMVKN(i)+1; % 

i=i+1;
Rnames{i}='C4HVP2+NO=MCROHOO+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.70e-12, 350.0);
Gstr{i,1}='C4HVP2'; Gstr{i,2}='NO'; % 
fC4HVP2(i)=fC4HVP2(i)-1; fNO(i)=fNO(i)-1; fMCROHOO(i)=fMCROHOO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='C4HVP2+HO2=MCROHOO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.93e-13, 1300.0);
Gstr{i,1}='C4HVP2'; Gstr{i,2}='HO2'; % 
fC4HVP2(i)=fC4HVP2(i)-1; fHO2(i)=fHO2(i)-1; fMCROHOO(i)=fMCROHOO(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='C4HVP2+NO2=MCRHN'; % 2019/11/06, Bates2019, KHB
k(:,i) = 9.00e-12;
Gstr{i,1}='C4HVP2'; Gstr{i,2}='NO2'; % 
fC4HVP2(i)=fC4HVP2(i)-1; fNO2(i)=fNO2(i)-1; fMCRHN(i)=fMCRHN(i)+1; % 

i=i+1;
Rnames{i}='MCRENOL+OH=0.187HCOOH+0.097MCO3+0.187MGLY+0.063MVKHCB+0.653PYAC+0.75CO+0.285OH+0.715HO2+0.097CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.71e-12, 983.0);
Gstr{i,1}='MCRENOL'; Gstr{i,2}='OH'; % 
fMCRENOL(i)=fMCRENOL(i)-1; fOH(i)=fOH(i)-0.715; fOH(i)=fOH(i)-0.715; fHCOOH(i)=fHCOOH(i)+0.187; fMCO3(i)=fMCO3(i)+0.097; fMGLY(i)=fMGLY(i)+0.187; fMVKHCB(i)=fMVKHCB(i)+0.063; fPYAC(i)=fPYAC(i)+0.653; fCO(i)=fCO(i)+0.75; fHO2(i)=fHO2(i)+0.715; fCO2(i)=fCO2(i)+0.097; % 

i=i+1;
Rnames{i}='MVKPC+OH=MGLY+CO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(5.00e-12, 470.0);
Gstr{i,1}='MVKPC'; Gstr{i,2}='OH'; % 
fMVKPC(i)=fMVKPC(i)-1; fMGLY(i)=fMGLY(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='MVKDH+OH=0.6MVKHC+0.4MVKHCB+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(8.70e-12, 70.0);
Gstr{i,1}='MVKDH'; Gstr{i,2}='OH'; % 
fMVKDH(i)=fMVKDH(i)-1; fOH(i)=fOH(i)-1; fMVKHC(i)=fMVKHC(i)+0.6; fMVKHCB(i)=fMVKHCB(i)+0.4; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MVKHCB+OH=MGLY+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(5.00e-12, 470.0);
Gstr{i,1}='MVKHCB'; Gstr{i,2}='OH'; % 
fMVKHCB(i)=fMVKHCB(i)-1; fMGLY(i)=fMGLY(i)+1; % 

i=i+1;
Rnames{i}='MVKHC+OH=MCO3+2.0CO+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.00e-12, 70.0);
Gstr{i,1}='MVKHC'; Gstr{i,2}='OH'; % 
fMVKHC(i)=fMVKHC(i)-1; fOH(i)=fOH(i)-1; fMCO3(i)=fMCO3(i)+1; fCO(i)=fCO(i)+2.0; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MCRDH+OH=0.84HAC+0.16MVKHCB+0.84CO+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.4e-11, 70.0);
Gstr{i,1}='MCRDH'; Gstr{i,2}='OH'; % 
fMCRDH(i)=fMCRDH(i)-1; fOH(i)=fOH(i)-1; fHAC(i)=fHAC(i)+0.84; fMVKHCB(i)=fMVKHCB(i)+0.16; fCO(i)=fCO(i)+0.84; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MVKOHOO+HO2=0.05CH2O+0.36GLYC+0.36MCO3+0.05MGLY+0.255MVKHC+0.335MVKHP+0.665OH+0.305HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.12e-13, 1300.0);
Gstr{i,1}='MVKOHOO'; Gstr{i,2}='HO2'; % 
fMVKOHOO(i)=fMVKOHOO(i)-1; fHO2(i)=fHO2(i)-0.695; fHO2(i)=fHO2(i)-0.695; fCH2O(i)=fCH2O(i)+0.05; fGLYC(i)=fGLYC(i)+0.36; fMCO3(i)=fMCO3(i)+0.36; fMGLY(i)=fMGLY(i)+0.05; fMVKHC(i)=fMVKHC(i)+0.255; fMVKHP(i)=fMVKHP(i)+0.335; fOH(i)=fOH(i)+0.665; % 

i=i+1;
Rnames{i}='MVKOHOO+NO=0.242CH2O+0.758GLYC+0.758MCO3+0.242MGLY+NO2+0.242HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 4.573, 6.0, 1.0, 0.0);
Gstr{i,1}='MVKOHOO'; Gstr{i,2}='NO'; % 
fMVKOHOO(i)=fMVKOHOO(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+0.242; fGLYC(i)=fGLYC(i)+0.758; fMCO3(i)=fMCO3(i)+0.758; fMGLY(i)=fMGLY(i)+0.242; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+0.242; % 

i=i+1;
Rnames{i}='MVKOHOO+NO=0.438MVKN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 4.573, 6.0, 1.0, 0.0);
Gstr{i,1}='MVKOHOO'; Gstr{i,2}='NO'; % 
fMVKOHOO(i)=fMVKOHOO(i)-1; fNO(i)=fNO(i)-1; fMVKN(i)=fMVKN(i)+0.438; % 

i=i+1;
Rnames{i}='MCROHOO+HO2=0.083CH2O+0.507HAC+0.41MCRHP+0.083MGLY+0.507CO+0.59OH+0.507HO2+0.59O2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.12e-13, 1300.0);
Gstr{i,1}='MCROHOO'; Gstr{i,2}='HO2'; % 
fMCROHOO(i)=fMCROHOO(i)-1; fHO2(i)=fHO2(i)-0.493; fHO2(i)=fHO2(i)-0.493; fCH2O(i)=fCH2O(i)+0.083; fHAC(i)=fHAC(i)+0.507; fMCRHP(i)=fMCRHP(i)+0.41; fMGLY(i)=fMGLY(i)+0.083; fCO(i)=fCO(i)+0.507; fOH(i)=fOH(i)+0.59; fO2(i)=fO2(i)+0.59; % 

i=i+1;
Rnames{i}='MACR1OO+HO2=0.5CH2O+0.5MACR1OOH+0.175MCO3+0.325MO2+0.13O3+0.325CO+0.5OH+0.5CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.14e-12, 580.0);
Gstr{i,1}='MACR1OO'; Gstr{i,2}='HO2'; % 
fMACR1OO(i)=fMACR1OO(i)-1; fHO2(i)=fHO2(i)-1; fCH2O(i)=fCH2O(i)+0.5; fMACR1OOH(i)=fMACR1OOH(i)+0.5; fMCO3(i)=fMCO3(i)+0.175; fMO2(i)=fMO2(i)+0.325; fO3(i)=fO3(i)+0.13; fCO(i)=fCO(i)+0.325; fOH(i)=fOH(i)+0.5; fCO2(i)=fCO2(i)+0.5; % 

i=i+1;
Rnames{i}='MACR1OOH+OH=0.25CH2O+0.488HAC+0.098HMML+0.165MACR1OO+0.087MCO3+0.162MO2+0.488CO+0.585OH+0.415CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 1.66e-11;
Gstr{i,1}='MACR1OOH'; Gstr{i,2}='OH'; % 
fMACR1OOH(i)=fMACR1OOH(i)-1; fOH(i)=fOH(i)-0.415; fOH(i)=fOH(i)-0.415; fCH2O(i)=fCH2O(i)+0.25; fHAC(i)=fHAC(i)+0.488; fHMML(i)=fHMML(i)+0.098; fMACR1OO(i)=fMACR1OO(i)+0.165; fMCO3(i)=fMCO3(i)+0.087; fMO2(i)=fMO2(i)+0.162; fCO(i)=fCO(i)+0.488; fCO2(i)=fCO2(i)+0.415; % 

i=i+1;
Rnames{i}='MCROHOO=HAC+CO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.90e7, -5297.0);
Gstr{i,1}='MCROHOO'; % 
fMCROHOO(i)=fMCROHOO(i)-1; fHAC(i)=fHAC(i)+1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='MCROHOO+NO=0.14CH2O+0.86HAC+0.14MGLY+NO2+0.86CO+0.86HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_ALK(2.7e-12, 350.0, 2.985, 6.0, 1.0, 0.0);
Gstr{i,1}='MCROHOO'; Gstr{i,2}='NO'; % 
fMCROHOO(i)=fMCROHOO(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+0.14; fHAC(i)=fHAC(i)+0.86; fMGLY(i)=fMGLY(i)+0.14; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.86; fHO2(i)=fHO2(i)+0.86; % 

i=i+1;
Rnames{i}='MCROHOO+NO=MCRHN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_NIT(2.7e-12, 350.0, 2.985, 6.0, 1.0, 0.0);
Gstr{i,1}='MCROHOO'; Gstr{i,2}='NO'; % 
fMCROHOO(i)=fMCROHOO(i)-1; fNO(i)=fNO(i)-1; fMCRHN(i)=fMCRHN(i)+1; % 

i=i+1;
Rnames{i}='MACR1OO+NO=CH2O+0.35MCO3+0.65MO2+NO2+0.65CO+CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(8.7e-12, 290.0);
Gstr{i,1}='MACR1OO'; Gstr{i,2}='NO'; % 
fMACR1OO(i)=fMACR1OO(i)-1; fNO(i)=fNO(i)-1; fCH2O(i)=fCH2O(i)+1; fMCO3(i)=fMCO3(i)+0.35; fMO2(i)=fMO2(i)+0.65; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.65; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='MACR1OO+NO2=MPAN'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_PAN_acac(2.591e-28, -6.87, 1.125e-11, -1.105, 0.3);
Gstr{i,1}='MACR1OO'; Gstr{i,2}='NO2'; % 
fMACR1OO(i)=fMACR1OO(i)-1; fNO2(i)=fNO2(i)-1; fMPAN(i)=fMPAN(i)+1; % 

i=i+1;
Rnames{i}='MACRNO2+HO2=0.5HAC+0.37MCRHN+0.13MCRHNB+0.5NO2+0.13O3+0.5OH+0.5CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.14e-12, 580.0);
Gstr{i,1}='MACRNO2'; Gstr{i,2}='HO2'; % 
fMACRNO2(i)=fMACRNO2(i)-1; fHO2(i)=fHO2(i)-1; fHAC(i)=fHAC(i)+0.5; fMCRHN(i)=fMCRHN(i)+0.37; fMCRHNB(i)=fMCRHNB(i)+0.13; fNO2(i)=fNO2(i)+0.5; fO3(i)=fO3(i)+0.13; fOH(i)=fOH(i)+0.5; fCO2(i)=fCO2(i)+0.5; % 

i=i+1;
Rnames{i}='MACRNO2+NO=HAC+2.0NO2+CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(7.50e-12, 290.0);
Gstr{i,1}='MACRNO2'; Gstr{i,2}='NO'; % 
fMACRNO2(i)=fMACRNO2(i)-1; fNO(i)=fNO(i)-1; fHAC(i)=fHAC(i)+1; fNO2(i)=fNO2(i)+2.0; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='MACRNO2+NO2=MPAN+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GC_PAN_acac(2.591e-28, -6.87, 1.125e-11, -1.105, 0.3);
Gstr{i,1}='MACRNO2'; Gstr{i,2}='NO2'; % 
fMACRNO2(i)=fMACRNO2(i)-1; fMPAN(i)=fMPAN(i)+1; % 

i=i+1;
Rnames{i}='MACRNO2+NO3=HAC+2.0NO2+CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 4.00e-12;
Gstr{i,1}='MACRNO2'; Gstr{i,2}='NO3'; % 
fMACRNO2(i)=fMACRNO2(i)-1; fNO3(i)=fNO3(i)-1; fHAC(i)=fHAC(i)+1; fNO2(i)=fNO2(i)+2.0; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='MACRNO2+MO2=CH2O+0.7HAC+0.3MCRHNB+0.7NO2+0.7HO2+0.7CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(2.9e-12, 500.0);
Gstr{i,1}='MACRNO2'; Gstr{i,2}='MO2'; % 
fMACRNO2(i)=fMACRNO2(i)-1; fMO2(i)=fMO2(i)-1; fCH2O(i)=fCH2O(i)+1; fHAC(i)=fHAC(i)+0.7; fMCRHNB(i)=fMCRHNB(i)+0.3; fNO2(i)=fNO2(i)+0.7; fHO2(i)=fHO2(i)+0.7; fCO2(i)=fCO2(i)+0.7; % 

i=i+1;
Rnames{i}='MPAN=MACR1OO+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.58e16, -13500.0);
Gstr{i,1}='MPAN'; % 
fMPAN(i)=fMPAN(i)-1; fMACR1OO(i)=fMACR1OO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='MPAN+OH=0.25HAC+0.75HMML+NO3+0.25CO'; % 2019/11/06, Bates2019, KHB
k(:,i) = 2.90e-11;
Gstr{i,1}='MPAN'; Gstr{i,2}='OH'; % 
fMPAN(i)=fMPAN(i)-1; fOH(i)=fOH(i)-1; fHAC(i)=fHAC(i)+0.25; fHMML(i)=fHMML(i)+0.75; fNO3(i)=fNO3(i)+1; fCO(i)=fCO(i)+0.25; % 

i=i+1;
Rnames{i}='HMML+OH=0.3HCOOH+0.3MCO3+0.7MGLY+0.7OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = 4.33e-12;
Gstr{i,1}='HMML'; Gstr{i,2}='OH'; % 
fHMML(i)=fHMML(i)-1; fOH(i)=fOH(i)-0.300; fOH(i)=fOH(i)-0.300; fHCOOH(i)=fHCOOH(i)+0.3; fMCO3(i)=fMCO3(i)+0.3; fMGLY(i)=fMGLY(i)+0.7; % 

i=i+1;
Rnames{i}='ICPDH+OH=0.15MCRDH+0.5MCRHP+0.35MVKDH+CO+0.5OH+0.5HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 1.00e-11;
Gstr{i,1}='ICPDH'; Gstr{i,2}='OH'; % 
fICPDH(i)=fICPDH(i)-1; fOH(i)=fOH(i)-0.500; fOH(i)=fOH(i)-0.500; fMCRDH(i)=fMCRDH(i)+0.15; fMCRHP(i)=fMCRHP(i)+0.5; fMVKDH(i)=fMVKDH(i)+0.35; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='IDCHP+OH=0.08IEPOXAOO+0.032IEPOXBOO+0.318MVKHC+0.126MVKHCB+0.444MVKPC+0.888CO+0.444OH+0.444HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 2.25e-11;
Gstr{i,1}='IDCHP'; Gstr{i,2}='OH'; % 
fIDCHP(i)=fIDCHP(i)-1; fOH(i)=fOH(i)-0.556; fOH(i)=fOH(i)-0.556; fIEPOXAOO(i)=fIEPOXAOO(i)+0.08; fIEPOXBOO(i)=fIEPOXBOO(i)+0.032; fMVKHC(i)=fMVKHC(i)+0.318; fMVKHCB(i)=fMVKHCB(i)+0.126; fMVKPC(i)=fMVKPC(i)+0.444; fCO(i)=fCO(i)+0.888; fHO2(i)=fHO2(i)+0.444; % 

i=i+1;
Rnames{i}='IDHDP+OH=0.333ICPDH+0.667IDHPE+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = 3.00e-12;
Gstr{i,1}='IDHDP'; Gstr{i,2}='OH'; % 
fIDHDP(i)=fIDHDP(i)-1; fICPDH(i)=fICPDH(i)+0.333; fIDHPE(i)=fIDHPE(i)+0.667; % 

i=i+1;
Rnames{i}='IDHPE+OH=0.571MCRHP+0.429MVKHP+OH+CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 3.00e-12;
Gstr{i,1}='IDHPE'; Gstr{i,2}='OH'; % 
fIDHPE(i)=fIDHPE(i)-1; fMCRHP(i)=fMCRHP(i)+0.571; fMVKHP(i)=fMVKHP(i)+0.429; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='ITCN+OH=0.25MCRHP+0.75MVKHP+NO2+CO'; % 2019/11/06, Bates2019, KHB
k(:,i) = 1.00e-11;
Gstr{i,1}='ITCN'; Gstr{i,2}='OH'; % 
fITCN(i)=fITCN(i)-1; fOH(i)=fOH(i)-1; fMCRHP(i)=fMCRHP(i)+0.25; fMVKHP(i)=fMVKHP(i)+0.75; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='ITHN+OH=0.022CH2O+0.041ICNOO+0.037IDHNBOO+0.92ITCN+0.022MCRENOL+0.022NO2+0.3OH+0.62HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 3.00e-12;
Gstr{i,1}='ITHN'; Gstr{i,2}='OH'; % 
fITHN(i)=fITHN(i)-1; fOH(i)=fOH(i)-0.700; fOH(i)=fOH(i)-0.700; fCH2O(i)=fCH2O(i)+0.022; fICNOO(i)=fICNOO(i)+0.041; fIDHNBOO(i)=fIDHNBOO(i)+0.037; fITCN(i)=fITCN(i)+0.92; fMCRENOL(i)=fMCRENOL(i)+0.022; fNO2(i)=fNO2(i)+0.022; fHO2(i)=fHO2(i)+0.62; % 

i=i+1;
Rnames{i}='ETHLN+NO3=HNO3+MCO3+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.40e-12, -1860.0);
Gstr{i,1}='ETHLN'; Gstr{i,2}='NO3'; % 
fETHLN(i)=fETHLN(i)-1; fNO3(i)=fNO3(i)-1; fHNO3(i)=fHNO3(i)+1; fMCO3(i)=fMCO3(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='PYAC+OH=MCO3+CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = 8.00e-13;
Gstr{i,1}='PYAC'; Gstr{i,2}='OH'; % 
fPYAC(i)=fPYAC(i)-1; fOH(i)=fOH(i)-1; fMCO3(i)=fMCO3(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='HMHP+OH=0.5CH2O+0.5HCOOH+0.5OH+0.5HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.30e-12, 500.0);
Gstr{i,1}='HMHP'; Gstr{i,2}='OH'; % 
fHMHP(i)=fHMHP(i)-1; fOH(i)=fOH(i)-0.500; fOH(i)=fOH(i)-0.500; fCH2O(i)=fCH2O(i)+0.5; fHCOOH(i)=fHCOOH(i)+0.5; fHO2(i)=fHO2(i)+0.5; % 

i=i+1;
Rnames{i}='MCO3+HO2=0.13ACTA+0.37MAP+0.5MO2+0.13O3+0.5OH+0.5CO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(3.14e-12, 580.0);
Gstr{i,1}='MCO3'; Gstr{i,2}='HO2'; % 
fMCO3(i)=fMCO3(i)-1; fHO2(i)=fHO2(i)-1; fACTA(i)=fACTA(i)+0.13; fMAP(i)=fMAP(i)+0.37; fMO2(i)=fMO2(i)+0.5; fO3(i)=fO3(i)+0.13; fOH(i)=fOH(i)+0.5; fCO2(i)=fCO2(i)+0.5; % 

i=i+1;
Rnames{i}='HPETHNL+OH=CH2O+CO+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = GCARR_ac(1.55e-12, 340.0);
Gstr{i,1}='HPETHNL'; Gstr{i,2}='OH'; % 
fHPETHNL(i)=fHPETHNL(i)-1; fCH2O(i)=fCH2O(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='HPETHNL+OH=GLYX+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = 2.91e-11;
Gstr{i,1}='HPETHNL'; Gstr{i,2}='OH'; % 
fHPETHNL(i)=fHPETHNL(i)-1; fGLYX(i)=fGLYX(i)+1; % 

i=i+1;
Rnames{i}='NAP+OH=NRO2+OH'; % 2013/08/12, Pye2010, HOTP
k(:,i) = GCARR_ac(1.56e-11, 117.0);
Gstr{i,1}='NAP'; Gstr{i,2}='OH'; % 
fNAP(i)=fNAP(i)-1; fNRO2(i)=fNRO2(i)+1; % 

i=i+1;
Rnames{i}='NRO2+HO2=LNRO2H+HO2'; % 2013/08/12, Pye2010, HOTP
k(:,i) = GCARR_ac(1.40e-12, 700.0);
Gstr{i,1}='NRO2'; Gstr{i,2}='HO2'; % 
fNRO2(i)=fNRO2(i)-1; fLNRO2H(i)=fLNRO2H(i)+1; % 

i=i+1;
Rnames{i}='NO+NRO2=LNRO2N+NO'; % 2013/08/12, Pye2010, HOTP
k(:,i) = GCARR_ac(2.60e-12, 350.0);
Gstr{i,1}='NO'; Gstr{i,2}='NRO2'; % 
fNRO2(i)=fNRO2(i)-1; fLNRO2N(i)=fLNRO2N(i)+1; % 

i=i+1;
Rnames{i}='O3+hv=O+O2'; % 2013/03/22, Paulot2009, FP,EAM,JMAO,MJE
k(:,i) = PHOTOL(2);
Gstr{i,1}='O3'; % 
fO3(i)=fO3(i)-1; fO(i)=fO(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='O3+hv=O1D+O2';
k(:,i) = PHOTOL(3);
Gstr{i,1}='O3'; % 
fO3(i)=fO3(i)-1; fO1D(i)=fO1D(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='O2+hv=2.0O';
k(:,i) = PHOTOL(1);
Gstr{i,1}='O2'; % 
fO2(i)=fO2(i)-1; fO(i)=fO(i)+2.0; % 

i=i+1;
Rnames{i}='NO2+hv=NO+O'; % 2018/03/16, XW
k(:,i) = PHOTOL(11);
Gstr{i,1}='NO2'; % 
fNO2(i)=fNO2(i)-1; fNO(i)=fNO(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='H2O2+hv=2OH'; % 2018/03/16, XW
k(:,i) = PHOTOL(9);
Gstr{i,1}='H2O2'; % 
fH2O2(i)=fH2O2(i)-1; fOH(i)=fOH(i)+2; % 

i=i+1;
Rnames{i}='MP+hv=CH2O+OH+HO2';
k(:,i) = PHOTOL(10);
Gstr{i,1}='MP'; % 
fMP(i)=fMP(i)-1; fCH2O(i)=fCH2O(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='CH2O+hv=H+CO+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(7);
Gstr{i,1}='CH2O'; % 
fCH2O(i)=fCH2O(i)-1; fH(i)=fH(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='CH2O+hv=CO+H2'; % 2018/10/17, Cloud uptake, CDH
k(:,i) = PHOTOL(8);
Gstr{i,1}='CH2O'; % 
fCH2O(i)=fCH2O(i)-1; fCO(i)=fCO(i)+1; fH2(i)=fH2(i)+1; % 

i=i+1;
Rnames{i}='HNO3+hv=NO2+OH'; % 2018/01/19, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(16);
Gstr{i,1}='HNO3'; % 
fHNO3(i)=fHNO3(i)-1; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='HNO2+hv=NO+OH'; % 2018/01/19, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(15);
Gstr{i,1}='HNO2'; % 
fHNO2(i)=fHNO2(i)-1; fNO(i)=fNO(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='HNO4+hv=NO3+OH'; % 2018/03/12, XW
k(:,i) = PHOTOL(17);
Gstr{i,1}='HNO4'; % 
fHNO4(i)=fHNO4(i)-1; fNO3(i)=fNO3(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='HNO4+hv=NO2+HO2'; % 2018/03/12, XW
k(:,i) = PHOTOL(18);
Gstr{i,1}='HNO4'; % 
fHNO4(i)=fHNO4(i)-1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='NO3+hv=NO2+O'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(12);
Gstr{i,1}='NO3'; % 
fNO3(i)=fNO3(i)-1; fNO2(i)=fNO2(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='NO3+hv=NO+O2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(13);
Gstr{i,1}='NO3'; % 
fNO3(i)=fNO3(i)-1; fNO(i)=fNO(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='N2O5+hv=NO2+NO3'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(14);
Gstr{i,1}='N2O5'; % 
fN2O5(i)=fN2O5(i)-1; fNO2(i)=fNO2(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='ALD2+hv=0.12MCO3+0.88MO2+0.88CO+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(61);
Gstr{i,1}='ALD2'; % 
fALD2(i)=fALD2(i)-1; fMCO3(i)=fMCO3(i)+0.12; fMO2(i)=fMO2(i)+0.88; fCO(i)=fCO(i)+0.88; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ALD2+hv=CH4+CO'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(62);
Gstr{i,1}='ALD2'; % 
fALD2(i)=fALD2(i)-1; fCH4(i)=fCH4(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='PAN+hv=0.7MCO3+0.3MO2+0.7NO2+0.3NO3'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(59);
Gstr{i,1}='PAN'; % 
fPAN(i)=fPAN(i)-1; fMCO3(i)=fMCO3(i)+0.7; fMO2(i)=fMO2(i)+0.3; fNO2(i)=fNO2(i)+0.7; fNO3(i)=fNO3(i)+0.3; % 

i=i+1;
Rnames{i}='RCHO+hv=0.07A3O2+0.27B3O2+0.5OTHRO2+CO+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(70);
Gstr{i,1}='RCHO'; % 
fRCHO(i)=fRCHO(i)-1; fA3O2(i)=fA3O2(i)+0.07; fB3O2(i)=fB3O2(i)+0.27; fOTHRO2(i)=fOTHRO2(i)+0.5; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ACET+hv=MCO3+MO2'; % 2018/01/22, XW
k(:,i) = PHOTOL(76);
Gstr{i,1}='ACET'; % 
fACET(i)=fACET(i)-1; fMCO3(i)=fMCO3(i)+1; fMO2(i)=fMO2(i)+1; % 

i=i+1;
Rnames{i}='ACET+hv=2.0MO2+CO'; % 2018/01/22, XW
k(:,i) = PHOTOL(77);
Gstr{i,1}='ACET'; % 
fACET(i)=fACET(i)-1; fMO2(i)=fMO2(i)+2.0; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='MEK+hv=0.06A3O2+0.23B3O2+0.85MCO3+0.15MO2+0.425OTHRO2+0.15RCO3'; % 2018/01/22, XW
k(:,i) = PHOTOL(69);
Gstr{i,1}='MEK'; % 
fMEK(i)=fMEK(i)-1; fA3O2(i)=fA3O2(i)+0.06; fB3O2(i)=fB3O2(i)+0.23; fMCO3(i)=fMCO3(i)+0.85; fMO2(i)=fMO2(i)+0.15; fOTHRO2(i)=fOTHRO2(i)+0.425; fRCO3(i)=fRCO3(i)+0.15; % 

i=i+1;
Rnames{i}='GLYC+hv=0.9CH2O+0.1MOH+CO+0.07OH+1.73HO2'; % 2018/01/22, XW
k(:,i) = PHOTOL(68);
Gstr{i,1}='GLYC'; % 
fGLYC(i)=fGLYC(i)-1; fCH2O(i)=fCH2O(i)+0.9; fMOH(i)=fMOH(i)+0.1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+0.07; fHO2(i)=fHO2(i)+1.73; % 

i=i+1;
Rnames{i}='GLYX+hv=2.0CO+2.0HO2'; % 2018/01/22, XW
k(:,i) = PHOTOL(72);
Gstr{i,1}='GLYX'; % 
fGLYX(i)=fGLYX(i)-1; fCO(i)=fCO(i)+2.0; fHO2(i)=fHO2(i)+2.0; % 

i=i+1;
Rnames{i}='GLYX+hv=2.0CO+H2'; % 2018/01/22, XW
k(:,i) = PHOTOL(73);
Gstr{i,1}='GLYX'; % 
fGLYX(i)=fGLYX(i)-1; fCO(i)=fCO(i)+2.0; fH2(i)=fH2(i)+1; % 

i=i+1;
Rnames{i}='GLYX+hv=CH2O+CO'; % 2018/01/22, XW
k(:,i) = PHOTOL(74);
Gstr{i,1}='GLYX'; % 
fGLYX(i)=fGLYX(i)-1; fCH2O(i)=fCH2O(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='MGLY+hv=MCO3+CO+HO2'; % 2018/01/22, XW
k(:,i) = PHOTOL(71);
Gstr{i,1}='MGLY'; % 
fMGLY(i)=fMGLY(i)-1; fMCO3(i)=fMCO3(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MVK+hv=PRPE+CO'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(63);
Gstr{i,1}='MVK'; % 
fMVK(i)=fMVK(i)-1; fPRPE(i)=fPRPE(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='MVK+hv=CH2O+MCO3+CO+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(64);
Gstr{i,1}='MVK'; % 
fMVK(i)=fMVK(i)-1; fCH2O(i)=fCH2O(i)+1; fMCO3(i)=fMCO3(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MVK+hv=MO2+RCO3'; % 2018/01/22, XW
k(:,i) = PHOTOL(65);
Gstr{i,1}='MVK'; % 
fMVK(i)=fMVK(i)-1; fMO2(i)=fMO2(i)+1; fRCO3(i)=fRCO3(i)+1; % 

i=i+1;
Rnames{i}='MACR+hv=CH2O+MCO3+CO+HO2'; % 2018/01/22, XW
k(:,i) = PHOTOL(66);
Gstr{i,1}='MACR'; % 
fMACR(i)=fMACR(i)-1; fCH2O(i)=fCH2O(i)+1; fMCO3(i)=fMCO3(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='HAC+hv=CH2O+MCO3+HO2'; % 2018/11/08, XW
k(:,i) = PHOTOL(75);
Gstr{i,1}='HAC'; % 
fHAC(i)=fHAC(i)-1; fCH2O(i)=fCH2O(i)+1; fMCO3(i)=fMCO3(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='PRPN+hv=RCHO+NO2+OH+HO2'; % 2018/11/08, XW
k(:,i) = PHOTOL(79);
Gstr{i,1}='PRPN'; % 
fPRPN(i)=fPRPN(i)-1; fRCHO(i)=fRCHO(i)+1; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ETP+hv=ALD2+OH+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(80);
Gstr{i,1}='ETP'; % 
fETP(i)=fETP(i)-1; fALD2(i)=fALD2(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='RA3P+hv=RCHO+OH+HO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(81);
Gstr{i,1}='RA3P'; % 
fRA3P(i)=fRA3P(i)-1; fRCHO(i)=fRCHO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='RB3P+hv=ACET+OH+HO2'; % 2018/01/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(82);
Gstr{i,1}='RB3P'; % 
fRB3P(i)=fRB3P(i)-1; fACET(i)=fACET(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='R4P+hv=RCHO+OH+HO2'; % 2018/01/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(83);
Gstr{i,1}='R4P'; % 
fR4P(i)=fR4P(i)-1; fRCHO(i)=fRCHO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='PP+hv=ALD2+CH2O+OH+HO2'; % 2017/09/22, Sherwen2017,TS,JAS,SDE
k(:,i) = PHOTOL(84);
Gstr{i,1}='PP'; % 
fPP(i)=fPP(i)-1; fALD2(i)=fALD2(i)+1; fCH2O(i)=fCH2O(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='RP+hv=ALD2+OH+HO2'; % 2017/09/22, Sherwen2017,TS,JAS,SDE
k(:,i) = PHOTOL(85);
Gstr{i,1}='RP'; % 
fRP(i)=fRP(i)-1; fALD2(i)=fALD2(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='R4N2+hv=0.05A3O2+0.32ACET+0.32ALD2+0.18B3O2+0.19MEK+0.18MO2+0.32OTHRO2+0.13RCHO+NO2+0.27HO2'; % 2017/11/15, Chen2017, QJC
k(:,i) = PHOTOL(98);
Gstr{i,1}='R4N2'; % 
fR4N2(i)=fR4N2(i)-1; fA3O2(i)=fA3O2(i)+0.05; fACET(i)=fACET(i)+0.32; fALD2(i)=fALD2(i)+0.32; fB3O2(i)=fB3O2(i)+0.18; fMEK(i)=fMEK(i)+0.19; fMO2(i)=fMO2(i)+0.18; fOTHRO2(i)=fOTHRO2(i)+0.32; fRCHO(i)=fRCHO(i)+0.13; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+0.27; % 

i=i+1;
Rnames{i}='MAP+hv=MO2+OH'; % 2017/11/15, Chen2017, QJC
k(:,i) = PHOTOL(99);
Gstr{i,1}='MAP'; % 
fMAP(i)=fMAP(i)-1; fMO2(i)=fMO2(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='Br2+hv=2.0Br'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(23);
Gstr{i,1}='Br2'; % 
fBr2(i)=fBr2(i)-1; fBr(i)=fBr(i)+2.0; % 

i=i+1;
Rnames{i}='BrO+hv=Br+O'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(28);
Gstr{i,1}='BrO'; % 
fBrO(i)=fBrO(i)-1; fBr(i)=fBr(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='HOBr+hv=Br+OH'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(32);
Gstr{i,1}='HOBr'; % 
fHOBr(i)=fHOBr(i)-1; fBr(i)=fBr(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='BrNO3+hv=NO3+Br'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(29);
Gstr{i,1}='BrNO3'; % 
fBrNO3(i)=fBrNO3(i)-1; fNO3(i)=fNO3(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='BrNO3+hv=BrO+NO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(30);
Gstr{i,1}='BrNO3'; % 
fBrNO3(i)=fBrNO3(i)-1; fBrO(i)=fBrO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='BrNO2+hv=NO2+Br'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(31);
Gstr{i,1}='BrNO2'; % 
fBrNO2(i)=fBrNO2(i)-1; fNO2(i)=fNO2(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='CHBr3+hv=3.0Br'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(56);
Gstr{i,1}='CHBr3'; % 
fCHBr3(i)=fCHBr3(i)-1; fBr(i)=fBr(i)+3.0; % 

i=i+1;
Rnames{i}='CH2Br2+hv=2.0Br'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(55);
Gstr{i,1}='CH2Br2'; % 
fCH2Br2(i)=fCH2Br2(i)-1; fBr(i)=fBr(i)+2.0; % 

i=i+1;
Rnames{i}='CH3Br+hv=MO2+Br'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(50);
Gstr{i,1}='CH3Br'; % 
fCH3Br(i)=fCH3Br(i)-1; fMO2(i)=fMO2(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='CH3Cl+hv=MO2+Cl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(43);
Gstr{i,1}='CH3Cl'; % 
fCH3Cl(i)=fCH3Cl(i)-1; fMO2(i)=fMO2(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='CH2Cl2+hv=2.0Cl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(45);
Gstr{i,1}='CH2Cl2'; % 
fCH2Cl2(i)=fCH2Cl2(i)-1; fCl(i)=fCl(i)+2.0; % 

i=i+1;
Rnames{i}='BrCl+hv=Cl+Br'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(33);
Gstr{i,1}='BrCl'; % 
fBrCl(i)=fBrCl(i)-1; fCl(i)=fCl(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='Cl2+hv=2.0Cl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(22);
Gstr{i,1}='Cl2'; % 
fCl2(i)=fCl2(i)-1; fCl(i)=fCl(i)+2.0; % 

i=i+1;
Rnames{i}='ClO+hv=Cl+O'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(27);
Gstr{i,1}='ClO'; % 
fClO(i)=fClO(i)-1; fCl(i)=fCl(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='OClO+hv=ClO+O'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(25);
Gstr{i,1}='OClO'; % 
fOClO(i)=fOClO(i)-1; fClO(i)=fClO(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='Cl2O2+hv=ClOO+Cl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(26);
Gstr{i,1}='Cl2O2'; % 
fCl2O2(i)=fCl2O2(i)-1; fClOO(i)=fClOO(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='ClNO2+hv=NO2+Cl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(21);
Gstr{i,1}='ClNO2'; % 
fClNO2(i)=fClNO2(i)-1; fNO2(i)=fNO2(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='ClNO3+hv=NO3+Cl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(19);
Gstr{i,1}='ClNO3'; % 
fClNO3(i)=fClNO3(i)-1; fNO3(i)=fNO3(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='ClNO3+hv=ClO+NO2'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(20);
Gstr{i,1}='ClNO3'; % 
fClNO3(i)=fClNO3(i)-1; fClO(i)=fClO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='HOCl+hv=Cl+OH'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(24);
Gstr{i,1}='HOCl'; % 
fHOCl(i)=fHOCl(i)-1; fCl(i)=fCl(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='CH3CCl3+hv=3.0Cl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(44);
Gstr{i,1}='CH3CCl3'; % 
fCH3CCl3(i)=fCH3CCl3(i)-1; fCl(i)=fCl(i)+3.0; % 

i=i+1;
Rnames{i}='CCl4+hv=4.0Cl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(42);
Gstr{i,1}='CCl4'; % 
fCCl4(i)=fCCl4(i)-1; fCl(i)=fCl(i)+4.0; % 

i=i+1;
Rnames{i}='CFC11+hv=3.0Cl'; % 2017/09/22, Sherwen2016b,TS,JAS,SDE
k(:,i) = PHOTOL(37);
Gstr{i,1}='CFC11'; % 
fCFC11(i)=fCFC11(i)-1; fCl(i)=fCl(i)+3.0; % 

i=i+1;
Rnames{i}='CFC12+hv=2.0Cl'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(38);
Gstr{i,1}='CFC12'; % 
fCFC12(i)=fCFC12(i)-1; fCl(i)=fCl(i)+2.0; % 

i=i+1;
Rnames{i}='CFC113+hv=3.0Cl'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(39);
Gstr{i,1}='CFC113'; % 
fCFC113(i)=fCFC113(i)-1; fCl(i)=fCl(i)+3.0; % 

i=i+1;
Rnames{i}='CFC114+hv=2.0Cl'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(40);
Gstr{i,1}='CFC114'; % 
fCFC114(i)=fCFC114(i)-1; fCl(i)=fCl(i)+2.0; % 

i=i+1;
Rnames{i}='CFC115+hv=Cl'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(41);
Gstr{i,1}='CFC115'; % 
fCFC115(i)=fCFC115(i)-1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='HCFC123+hv=2.0Cl'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(47);
Gstr{i,1}='HCFC123'; % 
fHCFC123(i)=fHCFC123(i)-1; fCl(i)=fCl(i)+2.0; % 

i=i+1;
Rnames{i}='HCFC141b+hv=2.0Cl'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(48);
Gstr{i,1}='HCFC141b'; % 
fHCFC141b(i)=fHCFC141b(i)-1; fCl(i)=fCl(i)+2.0; % 

i=i+1;
Rnames{i}='HCFC142b+hv=Cl'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(49);
Gstr{i,1}='HCFC142b'; % 
fHCFC142b(i)=fHCFC142b(i)-1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='HCFC22+hv=Cl'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(46);
Gstr{i,1}='HCFC22'; % 
fHCFC22(i)=fHCFC22(i)-1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='H1301+hv=Br'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(53);
Gstr{i,1}='H1301'; % 
fH1301(i)=fH1301(i)-1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='H1211+hv=Cl+Br'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(51);
Gstr{i,1}='H1211'; % 
fH1211(i)=fH1211(i)-1; fCl(i)=fCl(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='H2402+hv=2.0Br'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(54);
Gstr{i,1}='H2402'; % 
fH2402(i)=fH2402(i)-1; fBr(i)=fBr(i)+2.0; % 

i=i+1;
Rnames{i}='ClOO+hv=Cl+O2'; % 2017/09/22, Sherwen2017,TS,JAS,SDE,XW
k(:,i) = PHOTOL(101);
Gstr{i,1}='ClOO'; % 
fClOO(i)=fClOO(i)-1; fCl(i)=fCl(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='I2+hv=2.0I'; % 2017/06/15, Marais2016, EAM
k(:,i) = PHOTOL(114);
Gstr{i,1}='I2'; % 
fI2(i)=fI2(i)-1; fI(i)=fI(i)+2.0; % 

i=i+1;
Rnames{i}='HOI+hv=I+OH'; % 2017/06/15, Marais2016, EAM
k(:,i) = PHOTOL(115);
Gstr{i,1}='HOI'; % 
fHOI(i)=fHOI(i)-1; fI(i)=fI(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='IO+hv=I+O'; % 2017/06/15, Marais2016, EAM
k(:,i) = PHOTOL(116);
Gstr{i,1}='IO'; % 
fIO(i)=fIO(i)-1; fI(i)=fI(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='OIO+hv=I+O2'; % 2017/06/15, Marais2016, EAM
k(:,i) = PHOTOL(117);
Gstr{i,1}='OIO'; % 
fOIO(i)=fOIO(i)-1; fI(i)=fI(i)+1; fO2(i)=fO2(i)+1; % 

i=i+1;
Rnames{i}='INO+hv=I+NO'; % 2017/06/15, Marais2016, EAM
k(:,i) = PHOTOL(118);
Gstr{i,1}='INO'; % 
fINO(i)=fINO(i)-1; fI(i)=fI(i)+1; fNO(i)=fNO(i)+1; % 

i=i+1;
Rnames{i}='IONO+hv=I+NO2'; % 2017/06/15, Marais2016, EAM
k(:,i) = PHOTOL(119);
Gstr{i,1}='IONO'; % 
fIONO(i)=fIONO(i)-1; fI(i)=fI(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='IONO2+hv=I+NO3'; % 2017/06/15, Marais2016, EAM
k(:,i) = PHOTOL(120);
Gstr{i,1}='IONO2'; % 
fIONO2(i)=fIONO2(i)-1; fI(i)=fI(i)+1; fNO3(i)=fNO3(i)+1; % 

i=i+1;
Rnames{i}='I2O2+hv=I+OIO'; % 2017/06/15, Marais2016, EAM
k(:,i) = PHOTOL(121);
Gstr{i,1}='I2O2'; % 
fI2O2(i)=fI2O2(i)-1; fI(i)=fI(i)+1; fOIO(i)=fOIO(i)+1; % 

i=i+1;
Rnames{i}='CH3I+hv=I'; % 2017/07/14, Fisher2016, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = PHOTOL(122);
Gstr{i,1}='CH3I'; % 
fCH3I(i)=fCH3I(i)-1; fI(i)=fI(i)+1; % 

i=i+1;
Rnames{i}='CH2I2+hv=2.0I'; % 2017/07/14, Fisher2016, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = PHOTOL(123);
Gstr{i,1}='CH2I2'; % 
fCH2I2(i)=fCH2I2(i)-1; fI(i)=fI(i)+2.0; % 

i=i+1;
Rnames{i}='CH2ICl+hv=I+Cl'; % 2017/07/14, Fisher2016, KRT,JAF,CCM,EAM,KHB,RHS
k(:,i) = PHOTOL(124);
Gstr{i,1}='CH2ICl'; % 
fCH2ICl(i)=fCH2ICl(i)-1; fI(i)=fI(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='CH2IBr+hv=I+Br'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(125);
Gstr{i,1}='CH2IBr'; % 
fCH2IBr(i)=fCH2IBr(i)-1; fI(i)=fI(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='I2O4+hv=2.0OIO'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(126);
Gstr{i,1}='I2O4'; % 
fI2O4(i)=fI2O4(i)-1; fOIO(i)=fOIO(i)+2.0; % 

i=i+1;
Rnames{i}='I2O3+hv=IO+OIO'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(127);
Gstr{i,1}='I2O3'; % 
fI2O3(i)=fI2O3(i)-1; fIO(i)=fIO(i)+1; fOIO(i)=fOIO(i)+1; % 

i=i+1;
Rnames{i}='IBr+hv=I+Br'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(128);
Gstr{i,1}='IBr'; % 
fIBr(i)=fIBr(i)-1; fI(i)=fI(i)+1; fBr(i)=fBr(i)+1; % 

i=i+1;
Rnames{i}='ICl+hv=I+Cl'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(129);
Gstr{i,1}='ICl'; % 
fICl(i)=fICl(i)-1; fI(i)=fI(i)+1; fCl(i)=fCl(i)+1; % 

i=i+1;
Rnames{i}='MPN+hv=CH2O+NO3+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(103);
Gstr{i,1}='MPN'; % 
fMPN(i)=fMPN(i)-1; fCH2O(i)=fCH2O(i)+1; fNO3(i)=fNO3(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MPN+hv=MO2+NO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(104);
Gstr{i,1}='MPN'; % 
fMPN(i)=fMPN(i)-1; fMO2(i)=fMO2(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='ATOOH+hv=CH2O+MCO3+OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(97);
Gstr{i,1}='ATOOH'; % 
fATOOH(i)=fATOOH(i)-1; fCH2O(i)=fCH2O(i)+1; fMCO3(i)=fMCO3(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='N2O+hv=N2+O1D'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(36);
Gstr{i,1}='N2O'; % 
fN2O(i)=fN2O(i)-1; fN2(i)=fN2(i)+1; fO1D(i)=fO1D(i)+1; % 

i=i+1;
Rnames{i}='OCS+hv=SO2+CO'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(34);
Gstr{i,1}='OCS'; % 
fOCS(i)=fOCS(i)-1; fSO2(i)=fSO2(i)+1; fCO(i)=fCO(i)+1; % 

i=i+1;
Rnames{i}='SO4+hv=SO2+2.0OH'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(100);
Gstr{i,1}='SO4'; % 
fSO4(i)=fSO4(i)-1; fSO2(i)=fSO2(i)+1; fOH(i)=fOH(i)+2.0; % 

i=i+1;
Rnames{i}='NO+hv=N+O'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(6);
Gstr{i,1}='NO'; % 
fNO(i)=fNO(i)-1; fN(i)=fN(i)+1; fO(i)=fO(i)+1; % 

i=i+1;
Rnames{i}='PIP+hv=RCHO+OH+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(105);
Gstr{i,1}='PIP'; % 
fPIP(i)=fPIP(i)-1; fRCHO(i)=fRCHO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ETHLN+hv=CH2O+NO2+CO+HO2'; % 2019/11/06, Bates2019, KHB
k(:,i) = PHOTOL(107);
Gstr{i,1}='ETHLN'; % 
fETHLN(i)=fETHLN(i)-1; fCH2O(i)=fCH2O(i)+1; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MONITS+hv=MEK+NO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(111);
Gstr{i,1}='MONITS'; % 
fMONITS(i)=fMONITS(i)-1; fMEK(i)=fMEK(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='MONITU+hv=RCHO+NO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(112);
Gstr{i,1}='MONITU'; % 
fMONITU(i)=fMONITU(i)-1; fRCHO(i)=fRCHO(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='HONIT+hv=HAC+NO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(113);
Gstr{i,1}='HONIT'; % 
fHONIT(i)=fHONIT(i)-1; fHAC(i)=fHAC(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='NITs+hv=HNO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(130);
Gstr{i,1}='NITs'; % 
fNITs(i)=fNITs(i)-1; fHNO2(i)=fHNO2(i)+1; % 

i=i+1;
Rnames{i}='NITs+hv=NO2';
k(:,i) = PHOTOL(131);
Gstr{i,1}='NITs'; % 
fNITs(i)=fNITs(i)-1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='NIT+hv=HNO2';
k(:,i) = PHOTOL(132);
Gstr{i,1}='NIT'; % 
fNIT(i)=fNIT(i)-1; fHNO2(i)=fHNO2(i)+1; % 

i=i+1;
Rnames{i}='NIT+hv=NO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(133);
Gstr{i,1}='NIT'; % 
fNIT(i)=fNIT(i)-1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='MENO3+hv=CH2O+NO2+HO2';
k(:,i) = PHOTOL(134);
Gstr{i,1}='MENO3'; % 
fMENO3(i)=fMENO3(i)-1; fCH2O(i)=fCH2O(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='ETNO3+hv=ALD2+NO2+HO2';
k(:,i) = PHOTOL(135);
Gstr{i,1}='ETNO3'; % 
fETNO3(i)=fETNO3(i)-1; fALD2(i)=fALD2(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IPRNO3+hv=ACET+NO2+HO2';
k(:,i) = PHOTOL(136);
Gstr{i,1}='IPRNO3'; % 
fIPRNO3(i)=fIPRNO3(i)-1; fACET(i)=fACET(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='NPRNO3+hv=RCHO+NO2+HO2';
k(:,i) = PHOTOL(137);
Gstr{i,1}='NPRNO3'; % 
fNPRNO3(i)=fNPRNO3(i)-1; fRCHO(i)=fRCHO(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='HMHP+hv=CH2O+2.0OH';
k(:,i) = PHOTOL(86);
Gstr{i,1}='HMHP'; % 
fHMHP(i)=fHMHP(i)-1; fCH2O(i)=fCH2O(i)+1; fOH(i)=fOH(i)+2.0; % 

i=i+1;
Rnames{i}='HPETHNL+hv=CH2O+CO+OH+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(87);
Gstr{i,1}='HPETHNL'; % 
fHPETHNL(i)=fHPETHNL(i)-1; fCH2O(i)=fCH2O(i)+1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='PYAC+hv=MCO3+HO2+CO2';
k(:,i) = PHOTOL(88);
Gstr{i,1}='PYAC'; % 
fPYAC(i)=fPYAC(i)-1; fMCO3(i)=fMCO3(i)+1; fHO2(i)=fHO2(i)+1; fCO2(i)=fCO2(i)+1; % 

i=i+1;
Rnames{i}='PROPNN+hv=CH2O+MCO3+NO2';
k(:,i) = PHOTOL(89);
Gstr{i,1}='PROPNN'; % 
fPROPNN(i)=fPROPNN(i)-1; fCH2O(i)=fCH2O(i)+1; fMCO3(i)=fMCO3(i)+1; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='MVKHC+hv=CH2O+MCO3+CO+HO2'; % 2014/12/19, FAST-JX v7.0 fix, JMAO
k(:,i) = PHOTOL(90);
Gstr{i,1}='MVKHC'; % 
fMVKHC(i)=fMVKHC(i)-1; fCH2O(i)=fCH2O(i)+1; fMCO3(i)=fMCO3(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MVKHCB+hv=0.5GLYX+0.5MCO3+0.5MGLY+0.5CO+1.5HO2';
k(:,i) = PHOTOL(91);
Gstr{i,1}='MVKHCB'; % 
fMVKHCB(i)=fMVKHCB(i)-1; fGLYX(i)=fGLYX(i)+0.5; fMCO3(i)=fMCO3(i)+0.5; fMGLY(i)=fMGLY(i)+0.5; fCO(i)=fCO(i)+0.5; fHO2(i)=fHO2(i)+1.5; % 

i=i+1;
Rnames{i}='MVKHP+hv=0.47CH2O+0.53GLYC+0.53MCO3+0.47MGLY+OH+0.47HO2'; % 2014/05/23, Eastham2014, JMAO,SDE
k(:,i) = PHOTOL(92);
Gstr{i,1}='MVKHP'; % 
fMVKHP(i)=fMVKHP(i)-1; fCH2O(i)=fCH2O(i)+0.47; fGLYC(i)=fGLYC(i)+0.53; fMCO3(i)=fMCO3(i)+0.53; fMGLY(i)=fMGLY(i)+0.47; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+0.47; % 

i=i+1;
Rnames{i}='MVKPC+hv=0.429GLYX+0.429MCO3+0.571MGLY+0.571CO+OH+0.571HO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = PHOTOL(93);
Gstr{i,1}='MVKPC'; % 
fMVKPC(i)=fMVKPC(i)-1; fGLYX(i)=fGLYX(i)+0.429; fMCO3(i)=fMCO3(i)+0.429; fMGLY(i)=fMGLY(i)+0.571; fCO(i)=fCO(i)+0.571; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+0.571; % 

i=i+1;
Rnames{i}='MCRENOL+hv=0.125GLYX+0.125MCO3+0.125MGLY+0.75PYAC+0.875CO+1.75OH+0.125HO2';
k(:,i) = PHOTOL(94);
Gstr{i,1}='MCRENOL'; % 
fMCRENOL(i)=fMCRENOL(i)-1; fGLYX(i)=fGLYX(i)+0.125; fMCO3(i)=fMCO3(i)+0.125; fMGLY(i)=fMGLY(i)+0.125; fPYAC(i)=fPYAC(i)+0.75; fCO(i)=fCO(i)+0.875; fOH(i)=fOH(i)+1.75; fHO2(i)=fHO2(i)+0.125; % 

i=i+1;
Rnames{i}='MCRHP+hv=0.23CH2O+0.77HAC+0.23MGLY+0.77CO+OH+HO2';
k(:,i) = PHOTOL(95);
Gstr{i,1}='MCRHP'; % 
fMCRHP(i)=fMCRHP(i)-1; fCH2O(i)=fCH2O(i)+0.23; fHAC(i)=fHAC(i)+0.77; fMGLY(i)=fMGLY(i)+0.23; fCO(i)=fCO(i)+0.77; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MACR1OOH+hv=0.75CH2O+0.25MACR1OOH+0.262MCO3+0.488MO2+0.75OH+1.238CO2'; % 2019/05/10, Fisher2018, JAF
k(:,i) = PHOTOL(96);
Gstr{i,1}='MACR1OOH'; % 
fMACR1OOH(i)=fMACR1OOH(i)-0.750; fMACR1OOH(i)=fMACR1OOH(i)-0.750; fCH2O(i)=fCH2O(i)+0.75; fMCO3(i)=fMCO3(i)+0.262; fMO2(i)=fMO2(i)+0.488; fOH(i)=fOH(i)+0.75; fCO2(i)=fCO2(i)+1.238; % 

i=i+1;
Rnames{i}='MVKN+hv=0.3ETHLN+0.69GLYC+1.01MCO3+0.7NO2+0.01OH+0.29HO2'; % 2014/05/23, Eastham2014, JMAO,SDE
k(:,i) = PHOTOL(108);
Gstr{i,1}='MVKN'; % 
fMVKN(i)=fMVKN(i)-1; fETHLN(i)=fETHLN(i)+0.3; fGLYC(i)=fGLYC(i)+0.69; fMCO3(i)=fMCO3(i)+1.01; fNO2(i)=fNO2(i)+0.7; fOH(i)=fOH(i)+0.01; fHO2(i)=fHO2(i)+0.29; % 

i=i+1;
Rnames{i}='MCRHN+hv=HAC+NO2+CO+HO2';
k(:,i) = PHOTOL(109);
Gstr{i,1}='MCRHN'; % 
fMCRHN(i)=fMCRHN(i)-1; fHAC(i)=fHAC(i)+1; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='MCRHNB+hv=PROPNN+CO+OH+HO2';
k(:,i) = PHOTOL(110);
Gstr{i,1}='MCRHNB'; % 
fMCRHNB(i)=fMCRHNB(i)-1; fPROPNN(i)=fPROPNN(i)+1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='RIPA+hv=CH2O+MVK+OH+HO2';
k(:,i) = PHOTOL(138);
Gstr{i,1}='RIPA'; % 
fRIPA(i)=fRIPA(i)-1; fCH2O(i)=fCH2O(i)+1; fMVK(i)=fMVK(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='RIPB+hv=CH2O+MACR+OH+HO2';
k(:,i) = PHOTOL(139);
Gstr{i,1}='RIPB'; % 
fRIPB(i)=fRIPB(i)-1; fCH2O(i)=fCH2O(i)+1; fMACR(i)=fMACR(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='RIPC+hv=HC5A+OH+HO2';
k(:,i) = PHOTOL(140);
Gstr{i,1}='RIPC'; % 
fRIPC(i)=fRIPC(i)-1; fHC5A(i)=fHC5A(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='RIPD+hv=HC5A+OH+HO2';
k(:,i) = PHOTOL(141);
Gstr{i,1}='RIPD'; % 
fRIPD(i)=fRIPD(i)-1; fHC5A(i)=fHC5A(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='HPALD1+hv=0.224C4HVP1+0.112IDC+0.552MCRENOL+0.112MVKPC+0.888CO+1.662OH+0.112HO2'; % 2014/05/23, Eastham2014, JMAO,SDE
k(:,i) = PHOTOL(142);
Gstr{i,1}='HPALD1'; % 
fHPALD1(i)=fHPALD1(i)-1; fC4HVP1(i)=fC4HVP1(i)+0.224; fIDC(i)=fIDC(i)+0.112; fMCRENOL(i)=fMCRENOL(i)+0.552; fMVKPC(i)=fMVKPC(i)+0.112; fCO(i)=fCO(i)+0.888; fOH(i)=fOH(i)+1.662; fHO2(i)=fHO2(i)+0.112; % 

i=i+1;
Rnames{i}='HPALD2+hv=0.182C4HVP2+0.182IDC+0.455MCRENOL+0.182MVKPC+0.818CO+1.637OH+0.182HO2'; % 2014/05/23, Eastham2014, JMAO,SDE
k(:,i) = PHOTOL(143);
Gstr{i,1}='HPALD2'; % 
fHPALD2(i)=fHPALD2(i)-1; fC4HVP2(i)=fC4HVP2(i)+0.182; fIDC(i)=fIDC(i)+0.182; fMCRENOL(i)=fMCRENOL(i)+0.455; fMVKPC(i)=fMVKPC(i)+0.182; fCO(i)=fCO(i)+0.818; fOH(i)=fOH(i)+1.637; fHO2(i)=fHO2(i)+0.182; % 

i=i+1;
Rnames{i}='HPALD3+hv=MVK+CO+OH+HO2';
k(:,i) = PHOTOL(144);
Gstr{i,1}='HPALD3'; % 
fHPALD3(i)=fHPALD3(i)-1; fMVK(i)=fMVK(i)+1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='HPALD4+hv=MACR+CO+OH+HO2';
k(:,i) = PHOTOL(145);
Gstr{i,1}='HPALD4'; % 
fHPALD4(i)=fHPALD4(i)-1; fMACR(i)=fMACR(i)+1; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHN1+hv=0.45HC5A+0.55MVKHP+NO2+0.55CO+0.55OH+0.45HO2';
k(:,i) = PHOTOL(146);
Gstr{i,1}='IHN1'; % 
fIHN1(i)=fIHN1(i)-1; fHC5A(i)=fHC5A(i)+0.45; fMVKHP(i)=fMVKHP(i)+0.55; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.55; fOH(i)=fOH(i)+0.55; fHO2(i)=fHO2(i)+0.45; % 

i=i+1;
Rnames{i}='IHN2+hv=CH2O+MVK+NO2+HO2';
k(:,i) = PHOTOL(147);
Gstr{i,1}='IHN2'; % 
fIHN2(i)=fIHN2(i)-1; fCH2O(i)=fCH2O(i)+1; fMVK(i)=fMVK(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHN3+hv=CH2O+MACR+NO2+HO2';
k(:,i) = PHOTOL(148);
Gstr{i,1}='IHN3'; % 
fIHN3(i)=fIHN3(i)-1; fCH2O(i)=fCH2O(i)+1; fMACR(i)=fMACR(i)+1; fNO2(i)=fNO2(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IHN4+hv=0.45HC5A+0.55MCRHP+NO2+0.55CO+0.55OH+0.45HO2';
k(:,i) = PHOTOL(149);
Gstr{i,1}='IHN4'; % 
fIHN4(i)=fIHN4(i)-1; fHC5A(i)=fHC5A(i)+0.45; fMCRHP(i)=fMCRHP(i)+0.55; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.55; fOH(i)=fOH(i)+0.55; fHO2(i)=fHO2(i)+0.45; % 

i=i+1;
Rnames{i}='INPB+hv=CH2O+0.097MACR+0.903MVK+NO2+0.67OH+0.33HO2';
k(:,i) = PHOTOL(150);
Gstr{i,1}='INPB'; % 
fINPB(i)=fINPB(i)-1; fCH2O(i)=fCH2O(i)+1; fMACR(i)=fMACR(i)+0.097; fMVK(i)=fMVK(i)+0.903; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+0.67; fHO2(i)=fHO2(i)+0.33; % 

i=i+1;
Rnames{i}='INPD+hv=0.159ICN+0.841INA+OH+0.159HO2';
k(:,i) = PHOTOL(151);
Gstr{i,1}='INPD'; % 
fINPD(i)=fINPD(i)-1; fICN(i)=fICN(i)+0.159; fINA(i)=fINA(i)+0.841; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+0.159; % 

i=i+1;
Rnames{i}='INPD+hv=0.841IHOO1+0.159IHOO4+NO2';
k(:,i) = PHOTOL(152);
Gstr{i,1}='INPD'; % 
fINPD(i)=fINPD(i)-1; fIHOO1(i)=fIHOO1(i)+0.841; fIHOO4(i)=fIHOO4(i)+0.159; fNO2(i)=fNO2(i)+1; % 

i=i+1;
Rnames{i}='ICN+hv=0.068C4HVP1+0.128C4HVP2+0.161IDC+0.481MCRENOL+0.162MVKPC+NO2+0.839CO+0.645OH+0.161HO2';
k(:,i) = PHOTOL(106);
Gstr{i,1}='ICN'; % 
fICN(i)=fICN(i)-1; fC4HVP1(i)=fC4HVP1(i)+0.068; fC4HVP2(i)=fC4HVP2(i)+0.128; fIDC(i)=fIDC(i)+0.161; fMCRENOL(i)=fMCRENOL(i)+0.481; fMVKPC(i)=fMVKPC(i)+0.162; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+0.839; fOH(i)=fOH(i)+0.645; fHO2(i)=fHO2(i)+0.161; % 

i=i+1;
Rnames{i}='IDN+hv=0.055CH2O+0.5GLYC+0.5HAC+0.228ICN+0.227INA+0.005MACR+0.05MVK+1.555NO2+0.228HO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = PHOTOL(78);
Gstr{i,1}='IDN'; % 
fIDN(i)=fIDN(i)-1; fCH2O(i)=fCH2O(i)+0.055; fGLYC(i)=fGLYC(i)+0.5; fHAC(i)=fHAC(i)+0.5; fICN(i)=fICN(i)+0.228; fINA(i)=fINA(i)+0.227; fMACR(i)=fMACR(i)+0.005; fMVK(i)=fMVK(i)+0.05; fNO2(i)=fNO2(i)+1.555; fHO2(i)=fHO2(i)+0.228; % 

i=i+1;
Rnames{i}='ICPDH+hv=0.15MCRDH+0.5MCRHP+0.35MVKDH+CO+0.5OH+1.5HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(153);
Gstr{i,1}='ICPDH'; % 
fICPDH(i)=fICPDH(i)-1; fMCRDH(i)=fMCRDH(i)+0.15; fMCRHP(i)=fMCRHP(i)+0.5; fMVKDH(i)=fMVKDH(i)+0.35; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+0.5; fHO2(i)=fHO2(i)+1.5; % 

i=i+1;
Rnames{i}='ICPDH+hv=0.1CH2O+0.088GLYC+0.438GLYX+0.438HAC+0.122MCRDH+0.088MGLY+0.1MVKHCB+0.122CO+OH+HO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = PHOTOL(154);
Gstr{i,1}='ICPDH'; % 
fICPDH(i)=fICPDH(i)-1; fCH2O(i)=fCH2O(i)+0.1; fGLYC(i)=fGLYC(i)+0.088; fGLYX(i)=fGLYX(i)+0.438; fHAC(i)=fHAC(i)+0.438; fMCRDH(i)=fMCRDH(i)+0.122; fMGLY(i)=fMGLY(i)+0.088; fMVKHCB(i)=fMVKHCB(i)+0.1; fCO(i)=fCO(i)+0.122; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IDHDP+hv=0.25GLYC+0.25HAC+0.75ICPDH+1.25OH+0.75HO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = PHOTOL(155);
Gstr{i,1}='IDHDP'; % 
fIDHDP(i)=fIDHDP(i)-1; fGLYC(i)=fGLYC(i)+0.25; fHAC(i)=fHAC(i)+0.25; fICPDH(i)=fICPDH(i)+0.75; fOH(i)=fOH(i)+1.25; fHO2(i)=fHO2(i)+0.75; % 

i=i+1;
Rnames{i}='IDHPE+hv=0.429GLYC+0.571GLYX+0.571HAC+0.429MGLY+OH+HO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = PHOTOL(156);
Gstr{i,1}='IDHPE'; % 
fIDHPE(i)=fIDHPE(i)-1; fGLYC(i)=fGLYC(i)+0.429; fGLYX(i)=fGLYX(i)+0.571; fHAC(i)=fHAC(i)+0.571; fMGLY(i)=fMGLY(i)+0.429; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+1; % 

i=i+1;
Rnames{i}='IDCHP+hv=0.391MVKHC+0.155MVKHCB+0.454MVKPC+CO+0.546OH+1.454HO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = PHOTOL(157);
Gstr{i,1}='IDCHP'; % 
fIDCHP(i)=fIDCHP(i)-1; fMVKHC(i)=fMVKHC(i)+0.391; fMVKHCB(i)=fMVKHCB(i)+0.155; fMVKPC(i)=fMVKPC(i)+0.454; fCO(i)=fCO(i)+1; fOH(i)=fOH(i)+0.546; fHO2(i)=fHO2(i)+1.454; % 

i=i+1;
Rnames{i}='ITHN+hv=0.55CH2O+0.15ETHLN+0.3GLYC+0.45HAC+0.5MCRHN+0.05MVKN+0.3NO2+OH+0.7HO2'; % 2012/06/07, Parrella2012, JPP
k(:,i) = PHOTOL(158);
Gstr{i,1}='ITHN'; % 
fITHN(i)=fITHN(i)-1; fCH2O(i)=fCH2O(i)+0.55; fETHLN(i)=fETHLN(i)+0.15; fGLYC(i)=fGLYC(i)+0.3; fHAC(i)=fHAC(i)+0.45; fMCRHN(i)=fMCRHN(i)+0.5; fMVKN(i)=fMVKN(i)+0.05; fNO2(i)=fNO2(i)+0.3; fOH(i)=fOH(i)+1; fHO2(i)=fHO2(i)+0.7; % 

i=i+1;
Rnames{i}='ITHN+hv=0.05ATOOH+0.15CH2O+0.35GLYC+0.8HAC+0.5HPETHNL+0.15MCRHP+NO2+0.3OH+0.7HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(159);
Gstr{i,1}='ITHN'; % 
fITHN(i)=fITHN(i)-1; fATOOH(i)=fATOOH(i)+0.05; fCH2O(i)=fCH2O(i)+0.15; fGLYC(i)=fGLYC(i)+0.35; fHAC(i)=fHAC(i)+0.8; fHPETHNL(i)=fHPETHNL(i)+0.5; fMCRHP(i)=fMCRHP(i)+0.15; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+0.3; fHO2(i)=fHO2(i)+0.7; % 

i=i+1;
Rnames{i}='ITCN+hv=GLYC+MGLY+NO2+OH'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(160);
Gstr{i,1}='ITCN'; % 
fITCN(i)=fITCN(i)-1; fGLYC(i)=fGLYC(i)+1; fMGLY(i)=fMGLY(i)+1; fNO2(i)=fNO2(i)+1; fOH(i)=fOH(i)+1; % 

i=i+1;
Rnames{i}='ITCN+hv=0.5MCRHP+0.5MVKHP+NO2+CO+HO2'; % 2014/02/03, Eastham2014, SDE
k(:,i) = PHOTOL(161);
Gstr{i,1}='ITCN'; % 
fITCN(i)=fITCN(i)-1; fMCRHP(i)=fMCRHP(i)+0.5; fMVKHP(i)=fMVKHP(i)+0.5; fNO2(i)=fNO2(i)+1; fCO(i)=fCO(i)+1; fHO2(i)=fHO2(i)+1; % 


