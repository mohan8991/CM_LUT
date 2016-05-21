************************************************************************************
************************************************************************************
**                                                                                **
**                                      M_LUT.sp                                   **
**                                                                                **
************************************************************************************
************************************************************************************
************************************************************************************
** Author: Mohan Krishna Gopi Krishna
** Email: mohankrishna.gopikrishna@knights.ucf.edu
************************************************************************************
** This SPICE file demonstrates the operation of a Look Up Table (LUT) with CMOS
************************************************************************************

************************************************************************************
***                              Libraries                                       ***
************************************************************************************
.hdl './mtj_libs_encoded/needsmtj_1_0_0b.va'
.LIB './CMOS_lib/_45nm_nominal_bulkCMOS.pm' CMOS_MODELS 
.inc './CMOS_lib/NangateOpenCellLibrary_supply.sp'
**********************************************************************
***                            Options                             ***
**********************************************************************
.option post=1
.option probe=0
.option runlvl=6
.option ingold=2
.option accurate=1
.option method=bdf
.option bdfrtol=1e-8
.option bdfatol=1e-9
.option numdgt=10
.option brief
.option measfile=1
.option lis_new=1
.option vaopts=str('-G')
.save

*.option RELTOL = 0.01
*.option ABSTOL = 1.0e-9
*.option VNTOL  = 1.0e-4
*.option LVLTIM = 1
*.option METHOD = GEAR
*.option MAXORD = 2
*.option TNUM   = 100
*.option ITL4   = 100



**********************************************************************
***                    Parameters/Definitions                      ***
**********************************************************************
.param pi='4*atan(1)'
.param kB='1.3806503e-23'
.param Temperature='25'
.param Ms='700'
.param alpha='0.028'
.param W='25e-9'
.param L='pi*25e-9'
.param Tm='1.4e-9'
.param Ea='56*kB*(300)*1e7'
.param Volume='W*L*Tm*1e6'
.param K='(Ea/Volume)'
.param P_L='0.8'
.param P_R='0.3'
.param Lambda_L='2'
.param Lambda_R='2'

.param P='0.1*pi/180'
.param AP='179.9*pi/180'
.param PinL='0.0*pi/180'
.param vdd=1.1



vdd vdd 0 'vdd'

**********************************************************************
***                     Initial Conditions                         ***
**********************************************************************
.ic V(th11) AP                        
.ic V(ph11) PinL
.ic V(th12) P
.ic V(ph12) PinL
.ic V(th13) AP					   
.ic V(ph13) PinL
.ic V(th14) P
.ic V(ph14) PinL
.ic V(th15) AP
.ic V(ph15) PinL
.ic V(th16) P						
.ic V(ph16) PinL
.ic V(th17) AP                        
.ic V(ph17) PinL
.ic V(th18) P
.ic V(ph18) PinL
.ic V(th19) AP					   
.ic V(ph19) PinL
.ic V(th110) P
.ic V(ph110) PinL
.ic V(th111) AP
.ic V(ph111) PinL
.ic V(th112) P						
.ic V(ph112) PinL
.ic V(th113) AP                        
.ic V(ph113) PinL
.ic V(th114) P
.ic V(ph114) PinL
.ic V(th115) AP					   
.ic V(ph115) PinL
.ic V(th116) P
.ic V(ph116) PinL

.ic V(th120) AP						*Reference
.ic V(ph120) PinL
.ic V(th117) P
.ic V(ph117) PinL
.ic V(th118) AP
.ic V(ph118) PinL
.ic V(th119) P
.ic V(ph119) PinL


**********************************************************************
***                           Netlist                              ***
**********************************************************************
V_HAX hax 0 '0.0'
V_HAY hay 0 '0.0'
V_HAZ haz 0 '0.0'

* Input Voltages

Vclk CLK 0 pulse (0 vdd 0.5ns 1ps 1ps 0.5ns 1ns)

Va A 0 pulse (0 vdd 1ns 1ps 1ps 5ns 10ns)
Vb B 0 pulse (0 vdd 1ns 1ps 1ps 5ns 10ns)
Vc C 0 pulse (0 vdd 1ns 1ps 1ps 5ns 10ns)
Vd D 0 pulse (0 vdd 1ns 1ps 1ps 5ns 10ns)

Vbl BL 0 0

Vwl1 WL1 0 0
Vwl2 WL2 0 0
Vwl3 WL3 0 0
Vwl4 WL4 0 0
Vwl5 WL5 0 0
Vwl6 WL6 0 0
Vwl7 WL7 0 0
Vwl8 WL8 0 0
Vwl9 WL9 0 0
Vwl10 WL10 0 0
Vwl11 WL11 0 0
Vwl12 WL12 0 0
Vwl13 WL13 0 0
Vwl14 WL14 0 0
Vwl15 WL15 0 0
Vwl16 WL16 0 0

VWe WE 0 0

.SUBCKT TR_INV WL IN OP VSS VDD 
M_i_0 WLbar WL VSS VSS NMOS_VTL W=0.415000U L=0.050000U
M_i_1 WLbar WL VDD VDD PMOS_VTL W=0.630000U L=0.050000U

M_i_2 OP WL IN VSS NMOS_VTL W=0.900000U L=0.050000U
M_i_3 OP WLbar IN VDD PMOS_VTL W=1.800000U L=0.050000U
.ENDS 

*XlutBlock CLK 0 B C D WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15 WL16 WE BL
*+ MT1 MT2 MT3 MT4 MT5 MT6 MT7 MT8 MT9 MT10 MT11 MT12 MT13 MT14 MT15 MT16 MTref MTret Q Qbar vdd SA_selT_wr

*Xlut4x1 A B C D CLK BL WL0 WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15 WE Q Qbar vdd SAMTJ_Wr_X1
*Xlut4x11 0 0 0 0 CLK 0 WL0 WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15 WE Q1 Qbar1 vdd SAMTJ_Wr_X1

*Sense Amplifer with clock tree

*.SUBCKT SAMTJ_Wr_X1 A B C D CLK BL WL0 WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15 WE Q Qbar vdd
*Pininfo MT1: Reading MTJ; MT2: Reference MTJ; MTret: Return path for both MTJs; CLK: Input Clock; In: Write Input; EN: Write Enable; Q: Output Q; Qbar: Output Qbar; VSS: ground; vdd: Supply;

*.subckt SA_selT_wr CLK A B C D WL1 WL2 WL3 WL4 WL5 WL6 WL7 WL8 WL9 WL10 WL11 WL12 WL13 WL14 WL15 WL16 WE BL
*+ MT1 MT2 MT3 MT4 MT5 MT6 MT7 MT8 MT9 MT10 MT11 MT12 MT13 MT14 MT15 MT16 MTref MTret Q Qbar vdd

Xinv1 A Abar 0 vdd INV_X1 
Xinv2 B Bbar 0 vdd INV_X1 
Xinv3 C Cbar 0 vdd INV_X1 
Xinv4 D Dbar 0 vdd INV_X1 
Xinv6 WE WEbar 0 vdd INV_X1 

* CMOS transistors
*NMOS
MN1 Qbar Q SL1 0 NMOS_VTL W=0.415000U L=0.050000U
MN2 Q Qbar SLref 0 NMOS_VTL W=0.415000U L=0.050000U
MNwr MTret WEbar MTret1 0 NMOS_VTL W=0.415000U L=0.050000U
MN3 MTret1 CLK 0 0 NMOS_VTL W=0.415000U L=0.050000U

*PMOS
MP1 Qbar CLK vdd vdd PMOS_VTL W=0.630000U L=0.050000U
MP2 Qbar Q vdd vdd PMOS_VTL W=0.630000U L=0.050000U
MP3 Q Qbar vdd vdd PMOS_VTL W=0.630000U L=0.050000U
MP4 Q CLK vdd vdd PMOS_VTL W=0.630000U L=0.050000U

*Select Tree

MN4 SL1 Abar SL2 0 NMOS_VTL W=0.415000U L=0.050000U
MN5 SL1 A SL3 0 NMOS_VTL W=0.415000U L=0.050000U
MN6 SL2 Bbar SL4 0 NMOS_VTL W=0.415000U L=0.050000U
MN7 SL2 B SL5 0 NMOS_VTL W=0.415000U L=0.050000U
MN8 SL3 Bbar SL6 0 NMOS_VTL W=0.415000U L=0.050000U
MN9 SL3 B SL7 0 NMOS_VTL W=0.415000U L=0.050000U
MN10 SL4 Cbar SL8 0 NMOS_VTL W=0.415000U L=0.050000U
MN11 SL4 C SL9 0 NMOS_VTL W=0.415000U L=0.050000U
MN12 SL5 Cbar SL10 0 NMOS_VTL W=0.415000U L=0.050000U
MN13 SL5 C SL11 0 NMOS_VTL W=0.415000U L=0.050000U
MN14 SL6 Cbar SL12 0 NMOS_VTL W=0.415000U L=0.050000U
MN15 SL6 C SL13 0 NMOS_VTL W=0.415000U L=0.050000U
MN16 SL7 Cbar SL14 0 NMOS_VTL W=0.415000U L=0.050000U
MN17 SL7 C SL15 0 NMOS_VTL W=0.415000U L=0.050000U
MN18 SL8 Dbar MT1 0 NMOS_VTL W=0.415000U L=0.050000U
MN19 SL8 D MT2 0 NMOS_VTL W=0.415000U L=0.050000U
MN20 SL9 Dbar MT3 0 NMOS_VTL W=0.415000U L=0.050000U
MN21 SL9 D MT4 0 NMOS_VTL W=0.415000U L=0.050000U
MN22 SL10 Dbar MT5 0 NMOS_VTL W=0.415000U L=0.050000U
MN23 SL10 D MT6 0 NMOS_VTL W=0.415000U L=0.050000U
MN24 SL11 Dbar MT7 0 NMOS_VTL W=0.415000U L=0.050000U
MN25 SL11 D MT8 0 NMOS_VTL W=0.415000U L=0.050000U
MN26 SL12 Dbar MT9 0 NMOS_VTL W=0.415000U L=0.050000U
MN27 SL12 D MT10 0 NMOS_VTL W=0.415000U L=0.050000U
MN28 SL13 Dbar MT11 0 NMOS_VTL W=0.415000U L=0.050000U
MN29 SL13 D MT12 0 NMOS_VTL W=0.415000U L=0.050000U
MN30 SL14 Dbar MT13 0 NMOS_VTL W=0.415000U L=0.050000U
MN31 SL14 D MT14 0 NMOS_VTL W=0.415000U L=0.050000U
MN32 SL15 Dbar MT15 0 NMOS_VTL W=0.415000U L=0.050000U
MN33 SL15 D MT16 0 NMOS_VTL W=0.415000U L=0.050000U

*Reference Tree

MN34 SLref vdd SLref1 0 NMOS_VTL W=0.415000U L=0.050000U
MN35 SLref1 vdd SLref2 0 NMOS_VTL W=0.415000U L=0.050000U
MN36 SLref2 vdd SLref3 0 NMOS_VTL W=0.415000U L=0.050000U
MN37 SLref3 vdd MTref 0 NMOS_VTL W=0.415000U L=0.050000U

* Write Circuit
Xinv5 BL BLbar 0 vdda INV_X1

Xwl1 WL1 BL MT1 0 vdda TR_INV
Xwl2 WL2 BL MT2 0 vdd TR_INV
Xwl3 WL3 BL MT3 0 vdd TR_INV
Xwl4 WL4 BL MT4 0 vdd TR_INV
Xwl5 WL5 BL MT5 0 vdd TR_INV
Xwl6 WL6 BL MT6 0 vdd TR_INV
Xwl7 WL7 BL MT7 0 vdd TR_INV
Xwl8 WL8 BL MT8 0 vdd TR_INV
Xwl9 WL9 BL MT9 0 vdd TR_INV
Xwl10 WL10 BL MT10 0 vdd TR_INV
Xwl11 WL11 BL MT11 0 vdd TR_INV
Xwl12 WL12 BL MT12 0 vdd TR_INV
Xwl13 WL13 BL MT13 0 vdd TR_INV
Xwl14 WL14 BL MT14 0 vdd TR_INV
Xwl15 WL15 BL MT15 0 vdd TR_INV
Xwl16 WL16 BL MT16 0 vdd TR_INV

Xwe WE BLbar MTret 0 vdda TR_INV

*.ends

XMTJ1 MT1 MTret hax hay haz th11 ph11 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ2 MT2 MTret hax hay haz th12 ph12 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'			
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ3 MT3 MTret hax hay haz th13 ph13 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ4 MT4 MTret hax hay haz th14 ph14 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ5 MT5 MTret hax hay haz th15 ph15 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ6 MT6 MTret hax hay haz th16 ph16 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ7 MT7 MTret hax hay haz th17 ph17 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ8 MT8 MTret hax hay haz th18 ph18 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ9 MT9 MTret hax hay haz th19 ph19 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ10 MT10 MTret hax hay haz th110 ph110 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ11 MT11 MTret hax hay haz th111 ph111 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ12 MT12 MTret hax hay haz th112 ph112 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ13 MT13 MTret hax hay haz th113 ph113 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ14 MT14 MTret hax hay haz th114 ph114 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ15 MT15 MTret hax hay haz th115 ph115 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ16 MT16 MTret hax hay haz th116 ph116 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Bit 16
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

*Reference

XMTJ20 MTref MTref1 hax hay haz th120 ph120 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ17 MTref1 MTret hax hay haz th117 ph117 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ18 MTref MTref2 hax hay haz th118 ph118 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ19 MTref2 MTret hax hay haz th119 ph119 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

**********************************************************************
***                           Analysis                     
**********************************************************************
.tran 1p 2.5n

.option runlvl=6

.MEASURE TRAN pow AVG POWER FROM=0.5n TO=1.5n

.print tran v(MT1,MTret)

.end
