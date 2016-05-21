************************************************************************************
************************************************************************************
**                                                                                **
**                                      41LUT14nm.sp                                   **
**                                                                                **
************************************************************************************
************************************************************************************
************************************************************************************
** Author: Mohan Krishna Gopi Krishna
** Email: mohankrishna.gopikrishna@knights.ucf.edu
************************************************************************************
** This SPICE file demonstrates the operation of a Look Up Table (LUT)
************************************************************************************

************************************************************************************
***                              Libraries                                       ***
************************************************************************************
.inc './CMOS_lib/modelfiles/lstp/14nfet.pm'
.inc './CMOS_lib/modelfiles/lstp/14pfet.pm'
.hdl './mtj_libs_encoded/needsmtj_1_0_0b.va'

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
.param vdd=0.7
.param vdd2='vdd/6'
.param tr=10p
.param tf=10p

vdd vdd 0 'vdd'

**********************************************************************
***                     Initial Conditions                         ***
**********************************************************************
.ic V(th11) AP                        
.ic V(ph11) PinL
.ic V(th12) P
.ic V(ph12) PinL
.ic V(th13) P					   
.ic V(ph13) PinL
.ic V(th14) P
.ic V(ph14) PinL
.ic V(th15) P
.ic V(ph15) PinL
.ic V(th16) P						
.ic V(ph16) PinL
.ic V(th17) P                        
.ic V(ph17) PinL
.ic V(th18) P
.ic V(ph18) PinL
.ic V(th19) P					   
.ic V(ph19) PinL
.ic V(th110) P
.ic V(ph110) PinL
.ic V(th111) P
.ic V(ph111) PinL
.ic V(th112) P						
.ic V(ph112) PinL
.ic V(th113) P                        
.ic V(ph113) PinL
.ic V(th114) P
.ic V(ph114) PinL
.ic V(th115) P					   
.ic V(ph115) PinL
.ic V(th116) P
.ic V(ph116) PinL

.ic V(th120) P						*Reference
.ic V(ph120) PinL
*.ic V(th117) P
*.ic V(ph117) PinL
*.ic V(th118) AP
*.ic V(ph118) PinL
*.ic V(th119) P
*.ic V(ph119) PinL

**********************************************************************
***                           Netlist                              ***
**********************************************************************
V_HAX hax 0 '0.0'
V_HAY hay 0 '0.0'
V_HAZ haz 0 '0.0'

.SUBCKT INV_X1 IN OP VSS VDD 
M_i_0 OP IN VSS VSS nfet W=150n L=14n
M_i_1 OP IN VDD VDD pfet W=300n L=14n
.ENDS 

Vclk clk 0 pulse (0 vdd 1ns 1ps 1ps 5ns 10ns)

Va A 0 0
Vb B 0 0 
Vc C 0 0
Vd D 0 0

Xinv1 A Abar 0 vdd INV_X1 
Xinv2 B Bbar 0 vdd INV_X1 
Xinv3 C Cbar 0 vdd INV_X1 
Xinv4 D Dbar 0 vdd INV_X1

* CMOS transistors Read circuit for Sense Amplifier
*NMOS
MN1 Qbar Q SL1 0 nfet W=150n L=14n
MN2 Q Qbar SLref 0 nfet W=150n L=14n
MN3 MTret clk 0 0 nfet W=150n L=14n

*PMOS
MP1 Qbar clk vdd vdd pfet W=300n L=14n
MP2 Qbar Q vdd vdd pfet W=300n L=14n
MP3 Q Qbar vdd vdd pfet W=300n L=14n
MP4 Q clk vdd vdd pfet W=300n L=14n

*Select Tree
MN4 SL1 Abar SL2 0 nfet W=150n L=14n
MN5 SL1 A SL3 0 nfet W=150n L=14n
MN6 SL2 Bbar SL4 0 nfet W=150n L=14n
MN7 SL2 B SL5 0 nfet W=150n L=14n
MN8 SL3 Bbar SL6 0 nfet W=150n L=14n
MN9 SL3 B SL7 0 nfet W=150n L=14n
MN10 SL4 Cbar SL8 0 nfet W=150n L=14n
MN11 SL4 C SL9 0 nfet W=150n L=14n
MN12 SL5 Cbar SL10 0 nfet W=150n L=14n
MN13 SL5 C SL11 0 nfet W=150n L=14n
MN14 SL6 Cbar SL12 0 nfet W=150n L=14n
MN15 SL6 C SL13 0 nfet W=150n L=14n
MN16 SL7 Cbar SL14 0 nfet W=150n L=14n
MN17 SL7 C SL15 0 nfet W=150n L=14n
MN18 SL8 Dbar MT1 0 nfet W=150n L=14n
MN19 SL8 D MT2 0 nfet W=150n L=14n
MN20 SL9 Dbar MT3 0 nfet W=150n L=14n
MN21 SL9 D MT4 0 nfet W=150n L=14n
MN22 SL10 Dbar MT5 0 nfet W=150n L=14n
MN23 SL10 D MT6 0 nfet W=150n L=14n
MN24 SL11 Dbar MT7 0 nfet W=150n L=14n
MN25 SL11 D MT8 0 nfet W=150n L=14n
MN26 SL12 Dbar MT9 0 nfet W=150n L=14n
MN27 SL12 D MT10 0 nfet W=150n L=14n
MN28 SL13 Dbar MT11 0 nfet W=150n L=14n
MN29 SL13 D MT12 0 nfet W=150n L=14n
MN30 SL14 Dbar MT13 0 nfet W=150n L=14n
MN31 SL14 D MT14 0 nfet W=150n L=14n
MN32 SL15 Dbar MT15 0 nfet W=150n L=14n
MN33 SL15 D MT16 0 nfet W=150n L=14n

*Reference Tree
MN34 SLref vdd SLref1 0 nfet W=150n L=14n
MN35 SLref1 vdd SLref2 0 nfet W=150n L=14n
MN36 SLref2 vdd SLref3 0 nfet W=150n L=14n
*MN37 SLref3 vdd SLref4 0 nfet W=150n L=14n
MN38 SLref3 vdd MTref 0 nfet W=150n L=14n

*MTJ
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

XMTJ20 MTref MTret hax hay haz th120 ph120 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

*XMTJ17 MTref1 MTret hax hay haz th117 ph117 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
*+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
*+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

*XMTJ18 MTref MTref2 hax hay haz th118 ph118 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
*+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
*+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

*XMTJ19 MTref2 MTret hax hay haz th119 ph119 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
*+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
*+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

**********************************************************************
***                           Analysis                             ***
**********************************************************************
.tran 1p 20n START=1e-14 uic

.print tran v(MT1,MTret)

.option runlvl=5

.end
